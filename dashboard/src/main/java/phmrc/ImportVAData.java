package phmrc;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Hashtable;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
//import org.json.JSONObject;
import org.json.JSONTokener;

public class ImportVAData {
	
	JSONArray keyVals= new JSONArray("[{type:'sex',1:'Male', 2:'Female'}]");
	public String resolveKey(String type, String key)
	{
		for (int i = 0; i < keyVals.length(); i++) {
			if(keyVals.getJSONObject(i).getString("type").equals(type))
			{
				System.out.println(" Lookup Value "+type +" "+keyVals.getJSONObject(i)+ " "+key+" "+i);
				return keyVals.getJSONObject(i).getString(key+"");
				
			}
		}
		
		return key;
		
	}
	
	public String serialize(JSONArray ja,String sep)
	{
		String tt="";
		for (int i = 0; i < ja.length(); i++) {
			JSONObject jo=ja.getJSONObject(i);
			String txt=jo.getString("key1")+"="+jo.getString("value1")+(i==(ja.length()-1)?"":sep);
			tt+=txt;
		}
		return tt;
	}
	
	public JSONArray getChildMappings(JSONObject inp,String uniqno)
	{
	JSONArray out1= new JSONArray();
	String [] mapping={"gi/deceased_sex,deceased_sex",
			"gi/language,language",
			"report/age,DEATH_AGE_IN_YEARS",
			"report/sex,deceased_sex",
			"gi/death_age,DEATH_AGE_IN_YEARS",
			"info1/stmt1,stmt1",
			"info1/stmt2,stmt2",
			"info1/stmt3,stmt3",
			"info1/stmt4,stmt4",
			"type,type"
			
	}

;
			for (int i = 0; i < mapping.length; i++) {
				JSONObject jo= new JSONObject();
				String []tt=mapping[i].split(",");
				jo.put("key1","/va/"+uniqno+"/"+tt[0]);
				jo.put("value1",  inp.getString(tt[1]));
				out1.put(jo);
			}

			return out1;
	}
	JSONArray errors= new JSONArray();
	public JSONArray generateCMERecords(JSONArray phmrcData)
	{
		String sep="@#$%";
		
		JSONArray cmeData= new JSONArray();
		for (int i = 0; i < phmrcData.length(); i++) {
			try{
			JSONObject jo= phmrcData.getJSONObject(i);
			JSONObject out1= new JSONObject();
			String stateCode="01";
			String uniqno=stateCode+"_PHMRC_"+jo.get("cghr_id");
			out1.put("study","PHMRC");
		out1.put("uniqno",uniqno);
		out1.put("DEATH_AGE_IN_YEARS",getDeathAgeINYears(jo)+"");
		out1.put("language","English");
		out1.put("deceased_sex",resolveKey("sex", jo.get("sex")+""));
		out1.put("stmt1","English");
		out1.put("stmt2",getStmt2(jo));
		out1.put("stmt3",getStmt3(jo));
		out1.put("stmt4",getStmt4(jo));
		out1.put("type",jo.getString("module"));
		System.out.println(out1);
		 sep="@#$%^";
		cmeData.put(createOutputCMERecords(getChildMappings(out1, uniqno),uniqno));
			}
			catch(Exception e )
			{
				JSONObject jo = new JSONObject();
				jo.put("index", i );jo.put("error", e.getMessage());
				e.printStackTrace();
			}
			//String []fields="age_value","age_unit","sex");
			
			
		}
		System.out.println(cmeData);
		return cmeData;
		
		
		
	}
	public String getStmt2(JSONObject jo)
	{
		if(!jo.get("age_years").equals(""))
		{
			return jo.get("age_years")+" Years "+resolveKey("sex",jo.getInt("sex")+"");
		}
		else
			if(!jo.get("age_months").equals(""))
			{
				return jo.get("age_months")+" Months "+resolveKey("sex",jo.getInt("sex")+"");
			}
		return  jo.get("age_days")+" Days "+resolveKey("sex",jo.getInt("sex")+"");
		
	}
	public String getStmt3(JSONObject jo)
	{
		
		return  "Health facility";
		
	}
	public String getStmt4(JSONObject jo)
	{
		
		return  "-";
		
	}
	public double getDeathAgeINYears(JSONObject jo)
	{
		if(!jo.get("age_years").equals(""))
		{
			return jo.getDouble("age_years");
		}
		else
			if(!jo.get("age_months").equals(""))
			{
				return jo.getDouble("age_months")/12;
			}
			else
		if(!jo.get("age_days").equals(""))
		return jo.getDouble("age_days")/365;
		else
			System.out.println("Error "+jo);
		return 0;
		
	}
	
	public JSONObject createOutputCMERecords(JSONArray jaIn,String uniqno)
	{	String sep="@#$%^";
		//JSONArray jaOut = new JSONArray();
		
			//JSONArray jaIn = ja.getJSONArray(i);
			JSONObject joOut = new JSONObject();
			joOut.put("uniqno", uniqno);
			joOut.put("value1", serialize(jaIn,sep));
			//jaOut.put(joOut);
		
		return joOut;
	}
	
	public static void main(String[] args) throws JSONException, FileNotFoundException {
		// TODO Auto-generated method stub
		String sep="@#$%^";
JSONArray jaTest=new JSONArray("[{"
		+ "cghr_id: 'A7639','module': 'Child','sex': 1,'age_years': 1, "
		+"'age_months': '','age_days': '',"
	//	+ "    'open_response': \"my son died due to pneumonia fever. we treated him at [HOSPITAL]. they did not treat him properly there and they we admitted him in [HOSPITAL2]. there we was treated properly. but he died because his pneumonia increased.\""
		+ "}]");
ImportVAData imv=new ImportVAData();
JSONArray ja=new JSONArray(new JSONTokener(new FileInputStream("d:/cghr/PHMRC_narratives1.json")));
JSONArray jaOut=imv.generateCMERecords(ja);

//jaOut=new ImportVAData().createOutputCMERecords(jaOut, uniqno);
System.out.println(jaOut);
System.out.println(imv.errors);
  //));
	}

}
