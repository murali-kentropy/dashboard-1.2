package integration;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang3.text.WordUtils;
import org.json.JSONArray;
import org.json.JSONObject;

public abstract class VAtoCMME25Base implements VAToCME {
	
	public double getDeathAgeINYears(String age , String ageUnit)
	{
		if(ageUnit.toLowerCase().equals("years"))
		{
			return Double.parseDouble(age);
		}
		else
			if(ageUnit.toLowerCase().equals("months"))
			{
				return Double.parseDouble(age)/12;
			}
			else
				if(ageUnit.toLowerCase().equals("days"))
				{
					return Double.parseDouble(age)/365;
				}
		
else{
			System.out.println("Error "+age+" "+ageUnit);
}
		return 0;
		
	}
	
	public String getObjectValue(JSONObject obj, String field)
	{
		JSONArray ja=obj.getJSONArray("values");
		if(ja.length()==0)
			return "";
		JSONObject valObj=ja.getJSONObject(0);
		return valObj.optString(field);
	}
	
	public String getDate(JSONObject jo,String field)
	{
		String day=getObjectValue(jo,field+"_day");
		String month=getObjectValue(jo,field+"_month");
		String year=getObjectValue(jo,field+"_year");
		String d=year+"-"+month+"-"+day;
		String d1="";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date dt=sdf.parse(d);
			SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MMM-yyyy");
			d1=sdf1.format(dt);
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return d1;
	}
	
	public String getDuration1(JSONObject jo,String field)
	{
		String val=getObjectValue(jo,field+"_value");
		String unit=getObjectValue(jo,field+"_unit");;	
		
		if(val.equals(""))
			return "";
			else
				return val+""+unit.charAt(0);
	}
	public String getDuration(JSONObject jo,String field)
	{
		String val=getObjectValue(jo,field+"_value");
		String unit=getObjectValue(jo,field+"_unit");;	
		
		if(val.equals(""))
			return "";
			else
				return val+" "+unit;
	}
	public abstract boolean isDurationField(String fld);
	
	
	String sep="@#$%^";
	
	
	@Override
	public String generateCMErecord(String study, JSONObject data) throws Exception {
		// TODO Auto-generated method stub
		String uniqno= getUniqueNo(study , data);
		JSONObject va= new JSONObject();
		JSONObject cmeData= new JSONObject();
		va.put(uniqno, cmeData);
		cmeData.put("gi", getGI(data));
		cmeData.put("info1", getStatements(data));
		cmeData.put("pmh", getPMH(data));
		cmeData.put("report", getReportData(data));
		cmeData.put("sickness", getSickness(data));
		//cmeData.put("type", "CHILD");
		return serialize(uniqno,va,sep);
		

	}

	
	@Override
	public void generateCMEImages(String study, JSONObject data, String outputPath)
			throws Exception {
		
		String narrative=WordUtils.wrap(getNarrative(data),80);
		String respondentCod=getRespondentCod(data);
		String uniqno=getUniqueNo(study, data);
		String firstPage=uniqno+"_0_blank.png";
		String narrativePage=uniqno+"_1_blank.png";
		String rCodImage=uniqno+"_cod.png";
		generateFirstPage("",data, outputPath, firstPage);;
		String header="Narrative Page "+uniqno;
		generateNarrativePage(header,narrative, outputPath, narrativePage);
        generateRespondentCodImage(respondentCod, outputPath, rCodImage);
		
	}
	
	
	public abstract String getNarrative(JSONObject data);
	
	public abstract String getRespondentCod(JSONObject data);
	
	public abstract void  generateFirstPage(String header,JSONObject data,String outputPath,String fileName);
	public abstract void  generateNarrativePage(String header,String narrative,String outputPath,String fileName);
	
	public abstract void  generateRespondentCodImage(String respondentCod,String outputPath,String fileName);
	
	public String  serialize(String uniqno,JSONObject cmeRecord,String sep)
	{
		String path="/va/"+uniqno+"/";
		JSONObject data=cmeRecord.getJSONObject(uniqno);
		String [] names= data.getNames(data);
		
		String str="";
		for(int i=0; i<names.length;i++)
		{
			String tt1=path+names[i]+"/";
			JSONArray ja= data.getJSONArray(names[i]);
			for (int j = 0; j < ja.length(); j++) {
			   JSONObject jo = ja.getJSONObject(j);
			   String key=jo.getString("key");
			   String value=jo.getString("value");
				String tt2=tt1+key+"="+value+sep;
				str+=tt2;
			}
		}
		str+=path+"type=CHILD";
		
		return str;
	}
	
	public abstract String getUniqueNo(String study,JSONObject data);
	
	public abstract JSONArray getGI(JSONObject data);
	public abstract JSONArray getReportData(JSONObject data);
	public abstract JSONArray getStatements(JSONObject data);
	public abstract  JSONArray getPMH(JSONObject data);
	public abstract JSONArray getSickness(JSONObject data);

}
