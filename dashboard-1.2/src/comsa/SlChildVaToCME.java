package comsa;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import integration.VAtoCMME25Base;
import jsonutils.Group;
import utils.image.TextToPNG;

public class SlChildVaToCME extends SlVaToCME2Base {

	/*@Override
	public String getNarrative(JSONObject data) {
		// TODO Auto-generated method stub
		JSONObject narrative=data.getJSONObject("narrative");
		JSONArray ja=narrative.getJSONArray("values");
		return ja.getJSONObject(0).getString("summary");
		
	}*/

	@Override
	public String getRespondentCod(JSONObject data) {
		// TODO Auto-generated method stub
		JSONObject vaChild=data.getJSONObject("va_child");
		JSONArray ja=vaChild.getJSONArray("values");
		return ja.getJSONObject(0).getString("cCod");
		
	}

	@Override
	public void generateFirstPage(String header,JSONObject data, String outputPath, String fileName) {
		// TODO Auto-generated method stub
		TextToPNG.creatBlankImage(outputPath+"/"+fileName, "No first Page",755,297);

	}

	

	
	
	@Override
	public JSONArray getGI(JSONObject data) {
		// TODO Auto-generated method stub
		JSONObject deathDetail=data.getJSONObject("deathDetail");
		
		JSONObject childExtra=data.getJSONObject("va_child_extra");
		
		JSONObject death=data.getJSONObject("death");
		JSONObject injuryObj=data.getJSONObject("injury");
		JSONArray ja=death.getJSONArray("values");
		JSONObject valObj=ja.getJSONObject(0);
		JSONArray out= new JSONArray();
		String age= valObj.getString("age_value")+" "+valObj.getString("age_unit");
		String sex=valObj.getString("sex");
		String language="English";
		String dod=getDate(deathDetail, "dod");
		String deathPlace=getObjectValue(deathDetail,"deathSite");
		String resRelation=getObjectValue(deathDetail,"adultResRelation");
		String injury=getObjectValue(injuryObj,"cInjury");
		double deathAgeInYears=getDeathAgeINYears(valObj.getString("age_value"), valObj.getString("age_unit"));
		out.put(getKeyValue("deceased_sex",sex));
		out.put(getKeyValue("language",language));
		out.put(getKeyValue("death_age",deathAgeInYears+""));
		out.put(getKeyValue("02 res_relation",resRelation));
		out.put(getKeyValue("03 death_date","Death date: "+dod));
		out.put(getKeyValue("04 death_place","Death place: "+deathPlace));
		out.put(getKeyValue("06 injury",injury));
		out.put(getKeyValue("death_date",dod));
		out.put(getKeyValue("death_place",deathPlace));
		
		
		
		
		return out;
	}
	
	

	@Override
	public JSONArray getReportData(JSONObject data) {
		// TODO Auto-generated method stub
		JSONObject death=data.getJSONObject("death");
		JSONArray ja=death.getJSONArray("values");
		JSONObject valObj=ja.getJSONObject(0);
		JSONArray out= new JSONArray();
		String age= valObj.getString("age_value")+" "+valObj.getString("age_unit");
		String sex=valObj.getString("sex");
		String language="English";
		double deathAgeInYears=getDeathAgeINYears(valObj.getString("age_value"), valObj.getString("age_unit"));
		out.put(getKeyValue("sex",sex));
		out.put(getKeyValue("age",deathAgeInYears+""));
		
		return out;
	}

	



	@Override
	public JSONArray getStatements(JSONObject data) {
		// TODO Auto-generated method stub
		JSONObject death=data.getJSONObject("death");
		JSONObject childExtra=data.getJSONObject("va_child_extra");
		//String deathPlace=getObjectValue(childExtra,"deathSite");//cDeathSite
		JSONObject deathDetail=data.getJSONObject("deathDetail");
		String deathPlace=getObjectValue(deathDetail,"deathSite");//cDeathSite
		String resRelation=getObjectValue(deathDetail,"resRelation");
		
		
		JSONArray ja=death.getJSONArray("values");
		JSONObject valObj=ja.getJSONObject(0);
		JSONArray out= new JSONArray();
		String age= valObj.getString("age_value")+" "+valObj.getString("age_unit");
		String sex=valObj.getString("sex");
		String language="English";
		String dod=getDate(deathDetail, "dod");
		double deathAgeInYears=getDeathAgeINYears(valObj.getString("age_value"), valObj.getString("age_unit"));
		out.put(getKeyValue("stmt2",language));
		out.put(getKeyValue("stmt1",age +" "+sex));
		out.put(getKeyValue("stmt3","Death place: "+deathPlace));
		out.put(getKeyValue("stmt4","Death date: "+dod));
		
		return out;
	}

	@Override
	public JSONArray getPMH(JSONObject data) {
		// TODO Auto-generated method stub
		JSONObject vaChild=data.getJSONObject("va_child");
		JSONObject bd=data.getJSONObject("birthDetails");
		JSONObject pregHist=data.getJSONObject("pregnancyHistory");
		String usual=getObjectValue(bd,"cBabySize");
		String small=getObjectValue(bd,"cSmallerUsual");
		String verySmall=getObjectValue(bd,"cVerySmallUsual");
		String large=getObjectValue(bd,"cLargerUsual");
		
		String size="";
		if(large.equals("Yes"))
			size="Large";
		else
		if(usual.equals("Yes"))
			size="Usual";
		else
		if(small.equals("Yes"))
			size="Small";
		else
		if(verySmall.equals("Yes"))
			size="Very Small";
		
		
		JSONArray out= new JSONArray();
		if(size!=null&&!size.equals(""))
		out.put(getKeyValue("01 Size", size));
		
		String pregDur=getDuration(pregHist, "cPregLength");
		if(pregDur!=null&&!pregDur.equals(""))
		out.put(getKeyValue("02 Pregnancy", pregDur));
		String healthDiagnosis=getObjectValue(vaChild,"cHealthDiagnosis");
		if(!healthDiagnosis.startsWith("None"))
		out.put(getKeyValue("04 Health Diagnosis", healthDiagnosis));
		String hivTest=getObjectValue(vaChild,"cHivTest");
		if(hivTest.equals("Yes"))
		{
			out.put(getKeyValue("05 Health Test", "Positive"));
			
		}

		return out;
	}
	/*
	@Override
	public boolean isDurationField(String fld)
	{
		String [] duration = {"cIllBeforeDeath",
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
		return durL.contains(fld);
	}
*/
	
	//JSONObject symptomMap=null;
	public void init() throws JSONException, FileNotFoundException
	{
		
		JSONArray ja = new JSONArray(new JSONTokener(new FileInputStream("d:/cghr/child_dd.json")));
		dd=ja;
	    symptomMap=	new Group().groupBy(ja, "Main symptom");
	    getDurationFields();
		
	}
	public SlChildVaToCME() throws JSONException, FileNotFoundException {
		// TODO Auto-generated constructor stub
		super();
		init();
		
	}
	@Override
	public JSONArray getSickness(JSONObject data) {
		// TODO Auto-generated method stub
		JSONArray out= new JSONArray();
	
			
			JSONObject ps= data.getJSONObject("positiveSymptoms");
			String ps1=getObjectValue(ps, "summary");
			JSONArray syms=new JSONArray(ps1);
			for(int i=0; i<syms.length();i++)
			{	String prefix= i<9?("0"+(i+1)):((i+1)+"");
				String mainSymtom=syms.getString(i);
				JSONArray map=symptomMap.getJSONArray(mainSymtom);
			out.put(getKeyValue(prefix+" "+mainSymtom, getSymptomSummary(map, data)))	;
				;
			}
			return out;
		
	

	}

	public static void main(String[] args) throws JSONException, Exception {
		// TODO Auto-generated method stub
FileInputStream fin = new FileInputStream("child_out.json");
JSONArray ja= new JSONArray(new JSONTokener(fin));
SlChildVaToCME conv=new SlChildVaToCME();

for(int i=0; i< 10;i++)
{
JSONObject data=ja.getJSONObject(i);
System.out.println("\""+conv.getUniqueNo("bchs", data)+"\",\""+conv.generateCMErecord("bchs",data )+"\"");
conv.generateCMEImages("bchs", data, "./");
FileOutputStream fout=new FileOutputStream(conv.getUniqueNo("bchs", data)+".html");
fout.write(conv.generateVAForm("bchs", data,"./").getBytes());
fout.close();
}
		
	}

	

}
