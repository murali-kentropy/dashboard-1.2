package utils.sql;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
//import java.util.function.Consumer;
import java.util.*;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import database.GenerateDashboardData;

/**
 * @author USER
 * Generates an sql from a JSON structure Allows for adding templates for filters in where conditions 
 * Eg $filter1 gets replaced by the value of filter1 . A condition need not have filters but if it does the condition is used only when at least one filter value is applied
 *Each of the where, group having gets evaluated only when there is a value or they return an empty String.
 */
public class SQLQueryBuilder {

	/**String fields; The fields to be queried
	String from; The from part of the quesry Eg from t1 a left join t2 on t1.id=t2.id
	String where ;The where condition gets evaluated by an array of conditions each with or without filters
	String group="";The group part of the query
	String having=""; having part of a query with a group part 
	 * 
	 */
	String fields;
	String from;
	String where;
	String order1;
	String group="";
	String having="";
	String limit="";
	
	/**Builds an sql string from the JSONObject jo using the array of filters
	 * @param jo
	 * @param filters
	 * @return
	 */
	public String buildSQL(JSONObject jo,JSONArray filters)
	{
		
		fields(jo);
		from(jo);
		where(jo,filters);
		order1(jo);
		group(jo);
		having(jo,filters);
		limit(jo);
		
		
		
		
		return "select "+fields+" from "+from+" "+where +" "+group +" "+order1+" "+having+" "+limit;
	}
	
	public void order1(JSONObject jo)
	{
		
		if(jo.has("order1"))
		order1 =" order by "+jo.getString("order1");
		
	}
	public void limit(JSONObject jo)
	{
		
		if(jo.has("limit"))
		order1 =" limit "+jo.getString("limit");
		
	}
	/**
	 * Get the list of fields as a comma seprated string
	 * @param jo
	 */
	public void fields(JSONObject jo)
	{
		fields =jo.getString("fields");
		
	}
	/**
	 * Get the source from where the data will be queried
	 * @param jo
	 */
	public void from(JSONObject jo)
	{
		from =jo.getString("from");
		
	}
	
	/**
	 * Get the group part of the statement and construct a string if found.
	 * @param jo
	 */
	public void group(JSONObject jo)
	{	if(jo.has("group"))
		group =" group by " +jo.getString("group");
		
	}
	/**
	 * Get the having condition of the group if applicable and construct a string if present
	 * @param jo
	 */
	
	public void having(JSONObject jo,JSONArray filterValues)
	{		if(!jo.has("having"))
	{
				having= "";
				return;
	}
	
	String having1="";
	JSONArray ja= jo.getJSONArray("having");
	for (int i = 0; i < ja.length(); i++) {
		String cond=ja.getString(i);
		cond =applyFilterValues(cond,filterValues);
		if(cond !=null)
		{
		if(having1.length()>0)
			having1+=" and ";
		having1+=cond;
		}
		
	}
	having =having1.length()==0?"":(" where "+having1);

	}
	/**
	 * Evaluate the where part of the sql statement from an array of conditions after applying all the filter value of each condition
	 * if no condition results set an empty string otherwise set it to where + resultant condition
	 * @param jo
	 */
	/**
	 * @param jo
	 * @param filterValues
	 */
	public void where (JSONObject jo,JSONArray filterValues)
	{
		String where1="";
		System.out.println(" Filters ="+filterValues);
		if(!jo.has("where"))
		{
			where= "";
			
		return;	
		}
		JSONArray ja= jo.getJSONArray("where");
		for (int i = 0; i < ja.length(); i++) {
			String cond=ja.getString(i);
			cond =applyFilterValues(cond,filterValues);
			if(cond !=null)
			{
			if(where1.length()>0)
				where1+=" and ";
			where1+=cond;
			}
			
		}
		where =where1.length()==0?"":(" where "+where1);
		
	}

	/**
	 * Apply all filter values on a condition if the condition is a template which includes filter values as $filterName replaces it with the corresponding filterValue
	 * If there are no filter ariables the condition is returned as is . Otherwise if none of the filter values get applied the condition is ignored
	 * @param cond 
	 * @param filterValues
	 * @return
	 */
	private String applyFilterValues(String cond ,JSONArray filterValues) {
		// TODO Auto-generated method stub
boolean replaced=false;
if(cond.indexOf('$')<0)
return cond;
else
{
	for(int i =0; i<filterValues.length();i++)
		{
		JSONObject filterValue=	filterValues.getJSONObject(i);
		System.out.println(" filter Value "+filterValue+ " "+(cond.indexOf("$"+filterValue.getString("field"))));
		if(cond.indexOf("$"+filterValue.getString("field"))>=0)
				{
			cond =cond.replaceAll("\\$"+filterValue.getString("field"), filterValue.getString("value"));
			replaced=true;
				}
			
		}
		if(replaced)
			return cond;
		else
			return null;
}
		
	}
	
	public JSONObject  lookup(String symptom,JSONArray list)
	{
		for (int i = 0; i < list.length(); i++) {
			JSONObject jo = list.getJSONObject(i);
			if(jo.getString("symptom").equals(symptom))
			{
				return jo;
			}
		}
		
	
			return null;
		
	}
	
	public String  lookup(String var1,JSONObject vaObj)
	{
	JSONArray names=vaObj.names();
	
	for(int i=0;i<names.length();i++)
		{
		String key=names.getString(i);
		
			JSONObject jo = vaObj.optJSONObject(key);;
			if(jo!=null)
			{
				//System.out.println(jo);
			JSONObject val= jo.getJSONArray("values").optJSONObject(0);
			//System.out.println(val);
			if(val!=null && val.has(var1))
			{
				return val.getString(var1);
			}
			}
		}
		
	
			return null;
		
	}
	
	
	public void summarize(JSONObject jo) throws FileNotFoundException
	{
		
		FileInputStream fin = new FileInputStream("d:/cghr/slwork/child_symptom.json");
		JSONArray childSymptoms= new JSONArray(new JSONTokener(fin));
	
		JSONObject pos= jo.getJSONObject("positiveSymptoms");
		System.out.println(pos);
		JSONArray summary1=new JSONArray();
		JSONArray summ=new JSONArray(pos.getJSONArray("values").getJSONObject(0).getString("summary"));
		for (int i = 0; i < summ.length(); i++) {
			//System.out.println(summ.getString(i));
			String symptom= summ.getString(i);
			JSONObject symps= lookup(summ.getString(i),childSymptoms);
			//System.out.println("---->"+symps);
			//jo.getJSONObject(symps.getString("table"));
			
			String variable=symps.getString("variable");
			//System.out.println(">"+variable);
			String [] vs= variable.split(",");
			for (int j = 0; j < vs.length; j++) {
			String var1=	vs[j];
			//System.out.println(var1);
			String sympVal =lookup(var1,jo);
				//System.out.println(sympVal);
				//JSONObject values=sympObj.getJSONArray("values").optJSONObject(0);
				System.out.println(">>"+symps+" "+var1+" "+sympVal);
	
			}
			//System.out.println(jo.getJSONObject(symps.getString("table")));
			
		}
		
		System.out.println();
	}
	
	public boolean isDurationField(String fld)
	{		String [] duration = {"cIllBeforeDeath",
			"cFeverLastDays",
			"cStiffNeckDur",
			"cPainNeckDur",
			"cCoughLastDays",
			"cBreathingLastDays",
			"cFastBreathingLast",
			"cBreathlessnessDays",
			"cChestPainDur",
			"cLooseStoolDur",
			"cStoolsPerDay",
			"cStoolsStartDays",
			"cAbdPainDur",
			"cMoreProtBellyDur",
			"cMassBellyDur",
			"cDurDiffSwallow",
			"cUnconsciousStart",
			"cConvulsionDur",
			"cUlcerFootOoze",
			"cSkinRashDur",
			"cPuffyFaceDur",
			"cSwollenLegDur",
			"cDurYellowDis",
			"cDurStopSuckle",
			"cFatalIlleness",
			"cBirthWeight",
			"cDeathAfterDelivery",
			"cPregLength",
			"cTotalBirthsMother"};
	
	List durL=Arrays.asList(duration);
	if(!fld.contains("_"))
		return false;
	String fld1= fld.split("_")[0];
	return  durL.contains(fld1);
	
		
	}
	public JSONObject getObj(String table,JSONArray struct)
	{
		for (int i=0; i<struct.length();i++)
		{
			if(struct.getJSONObject(i).get("table").equals(table))
			{
				return struct.getJSONObject(i);
			}
		}
		return null;
	}
	public void summarize1(JSONObject jo,JSONArray struct) throws FileNotFoundException
	{
		String[] tt={
				"injury","fever","cough","breathing","chestPain","diarrhoea",
				"vomit","abdominalPain","consciousness","convulsions","urinary","skin","weight","oedema","lumps","paralysis","jaundice"};


	
		
		FileInputStream fin = new FileInputStream("d:/cghr/slwork/child_symptom.json");
		JSONArray childSymptoms= new JSONArray(new JSONTokener(fin));
	
		JSONObject pos= jo.getJSONObject("positiveSymptoms");
		//System.out.println(pos);
		JSONArray summary1=new JSONArray();
		JSONArray summ=new JSONArray(pos.getJSONArray("values").getJSONObject(0).getString("summary"));
		for (int i = 0; i < tt.length; i++) {
			String symptable = tt[i];
//			//System.out.println(var1);
		
			JSONObject symptoms=jo.getJSONObject(symptable).getJSONArray("values").optJSONObject(0);
			//System.out.println(symptoms);
			//System.out.println(">>");
			JSONObject tableObj= getObj(symptable, struct);
			//String text="";
			JSONArray text= new JSONArray();
			//for(int j=0;j<symptoms.names().length();j++)
			String [] fields=tableObj.getString("flds").split(",");
			List compl= new ArrayList();
			for(int j=0;j<fields.length;j++)	
			{
				System.out.println();
				
				String symp=fields[j];//symptoms.names().getString(j);
				String val=symptoms.optString(symp);
				if(val==null)
					continue;
				if(isDurationField(symp) )
				{
					String baseFld=symp.split("_")[0];
					System.err.println(baseFld);
					
						if( !compl.contains(baseFld))
				{
							compl.add(baseFld);
					String val1=symptoms.optString(baseFld+"_value");
					String val2=symptoms.optString(baseFld+"_unit");
					if(val1!=null&& val1.length()>0)
					text.put(baseFld.substring(1,baseFld.length())+" " +val1+val2.charAt(0));
			
						System.out.println(symp);
						System.out.println(compl);
						
					
					//compl.add(baseFld);
				} 
					continue;
				}
				
				if(val.toLowerCase().equals("yes"))
				{
					
					text.put(symp.substring(1,symp.length()));
				}	
				else
				if(!val.toLowerCase().equals("no") && !val.equals("") && !val.toLowerCase().equals("does not know") )
				{
					
				text.put(""+symp.substring(1,symp.length())+" " +val);
				
				}
	
			}
			if(text.length()>0)//equals(""))
			{
				JSONObject sumItem=new JSONObject();
			sumItem.put(symptable, text);
			summary1.put(sumItem);
			}
			//System.out.println();
			//System.out.println("<<");
			//System.out.println(jo.getJSONObject(symps.getString("table")));
			
		}
		
		System.out.println(summary1.toString(2));
		jo.put("cme_summary",summary1);
	}
	
	public JSONArray getStructData(JSONArray struct, String keyFld, String keyQuery) throws Exception
	{
	//	"select deathID from va_child"
		JSONArray out= new JSONArray();
		GenerateDashboardData gdd=new GenerateDashboardData();
		JSONArray ja=gdd.getKeys(keyQuery, keyFld);
		
		for(int i=0;i<ja.length();i++)
		{
			String keyVal=ja.getString(i);
			JSONObject jout= new JSONObject();
			jout.put(keyFld, keyVal);
			for (int j = 0; j <struct.length(); j++) {
				JSONObject jo= struct.getJSONObject(j);
				String table =jo.getString("table");
				String flds =jo.getString("flds");
				String query="select "+flds+" from "+table+" where "+keyFld+"='"+keyVal+"'"; 
				JSONObject jo1= gdd.getReportData(table,query);
				jout.put(table,jo1);
				
				
			}
			//System.out.println(jout.toString(2));
			summarize1(jout,struct);
			out.put(jout);
		
		}
		
		return out;
		
	}
	
	public static void main(String[] args) throws Exception
	{
	JSONObject query=new JSONObject("	{"
			+ "			fields:'*',"
			+ "			from:'test a left join test1 b',"
			+ "			where:[\"yy >789\",\" tt='1' \",\"tt2='$x'\",\"tt3>'$from'\",\" tt3<'$to'\" ],group:'ttt' , having:'count(*)>1'"
			
			+ "		}	");
		
		//JSONArray filter=new JSONArray("[{field:'x',value:'110'},{field:'from',value:'1/1/2001'},{field:'to',value:'1/1/2010'}]");
		//System.out.println(new SQLQueryBuilder().buildSQL(query, filter));
	
	FileInputStream fin = new FileInputStream("d:/cghr/slwork/child_struct.json");
	JSONArray ja= new JSONArray(new JSONTokener(fin));
	
	JSONArray out=new SQLQueryBuilder().getStructData(ja, "deathId","select a.deathId from va_child a join death b on a.deathId=b.deathId where areaId<700 limit 10");
	//out.write(new FileWriter("child_out.json"));
	
	FileOutputStream fout = new FileOutputStream("child_out.json");
	fout.write(out.toString(2).getBytes());
	fout.close();
	//System.out.println(out.toString(2));
	
	
		
	}
	
	

}
