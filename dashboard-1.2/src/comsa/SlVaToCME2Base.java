package comsa;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

public abstract class SlVaToCME2Base extends VAtoCMME25Base {

	@Override
	public String getNarrative(JSONObject data) {
		// TODO Auto-generated method stub
		JSONObject narrative=data.getJSONObject("narrative");
		JSONArray ja=narrative.getJSONArray("values");
		return ja.getJSONObject(0).getString("summary");
		
	}

	

	@Override
	public void generateFirstPage(String header,JSONObject data, String outputPath, String fileName) {
		// TODO Auto-generated method stub
		TextToPNG.creatBlankImage(outputPath+"/"+fileName, "No first Page",755,297);

	}

	@Override
	public void generateNarrativePage(String header,String narrative, String outputPath, String fileName) {
		// TODO Auto-generated method stub
		TextToPNG.convertToPNG(narrative, outputPath+"/"+fileName, header);
	}

	@Override
	public void generateRespondentCodImage(String respondentCod, String outputPath, String fileName) {
		// TODO Auto-generated method stub
		TextToPNG.creatBlankImage(outputPath+"/"+fileName, respondentCod,755,297);
	}

	@Override
	public String getUniqueNo(String study, JSONObject data) {
		// TODO Auto-generated method stub
		JSONObject death=data.getJSONObject("death");
		JSONArray ja=death.getJSONArray("values");
		return "01_"+study+"_"+ja.getJSONObject(0).getString("deathId");
		//return null;
	}
	
	
	public JSONObject getKeyValue(String key, String value)
	{
		JSONObject keyValObj= new JSONObject();
		keyValObj.put("key", key);
		keyValObj.put("value", value);
		return keyValObj;
		
	}

	
	



	
	
	

	String getSymptomSummary(JSONArray map,JSONObject data)
	{
		String tt="";
		for (int i = 0; i < map.length(); i++) {
			
			JSONObject item= map.getJSONObject(i);
			String term= item.getString("Term");
			String table=item.getString("table");
			String field=item.getString("field");
		JSONObject obj=	data.getJSONObject(table);
		String val=null;
	
		if(isDurationField(field))
		{
			val=getDuration1(obj, field);
		}
		else
			val=getObjectValue(obj, field);
		
		if(!val.equals("")&&!val.equals("No") && !val.startsWith("None") && !val.startsWith("Does") && !val.contains("Unknown"))
		
		{
			if(val.equals("Yes"))
				tt+=term+", ";
				else
					tt+=term+" "+val+", ";
		}
		
	
			
			
			
		}
		return tt;
	}
	JSONObject symptomMap=null;
	JSONArray dd=null;
	List durationFields= new ArrayList();
	public void init() throws JSONException, FileNotFoundException
	{
		
		JSONArray ja = new JSONArray(new JSONTokener(new FileInputStream("symptom_map.json")));
	    symptomMap=	new Group().groupBy(ja, "main_symptom");
		
	}
	public boolean isDurationField(String fld)
	{
return durationFields.contains(fld);
	}
	public void getDurationFields()
	{
		JSONObject byType=new Group().groupBy(dd, "type");
		JSONArray durationObjs= byType.getJSONArray("select_text");
		for (int i = 0; i < durationObjs.length(); i++) {
			durationFields.add(durationObjs.getJSONObject(i).getString("field"));
		}
		
		System.out.println(durationFields);
	}
	public SlVaToCME2Base() throws JSONException, FileNotFoundException {
		// TODO Auto-generated constructor stub
		super();
		//init();
		
	}
	

	public static void main(String[] args) throws JSONException, Exception {
		// TODO Auto-generated method stub

		
	}

	@Override
	public String generateVAForm(String study, JSONObject data,String outputPath) throws Exception {
		// TODO Auto-generated method stub
		//FileInputStream fin= new FileInputStream(dd);
		//JSONArray ja= new JSONArray(new JSONTokener(fin));
		JSONArray ja=dd;
		String tb="<table border=1><tr><th>Question</th><th>Answer</th></tr>";
		String str="";
		String section=null;
		
		for (int i = 0; i < ja.length(); i++) {
			JSONObject jo=ja.getJSONObject(i);
			JSONObject data1=data.getJSONObject(jo.getString("table"));
			 String tmpsection=jo.getString("Section");
			if(section == null)
			{
				str+="<h3>"+tmpsection+"</h3>"+tb;
				section=tmpsection;
			}
			else
			{
				 if(! tmpsection.equals(section))
				 {
					 str+="</table><h3>"+tmpsection+"</h3>"+tb;
					 section=tmpsection;
				 }
					 
			}
			String q=jo.getString("Question");
			String val=getObjectValue(data1, jo.getString("field"));
			//System.out.println(q+":"+val);
			str+="<tr><td>"+q+"</td><td>"+val+"</td></tr>";
		}
		return str+"</table>";
	}

}
