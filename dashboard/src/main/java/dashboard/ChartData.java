package dashboard;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class ChartData {
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	
public String lookup(JSONObject masterList, String key )
{
	if(key==null)		
		return "null";
	try {
		return masterList.getString(key);
	} catch (JSONException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		System.err.println(key);
	}
	return null;
}
public String lookup(JSONArray masterList, String key )
{
	if(key==null)		
		return "null";
	try {
		for (int i = 0; i < masterList.length(); i++) {
			JSONObject jo=masterList.getJSONObject(i);
		if(jo.getString("name").equals(key))
			return jo.getString("value");
			
		}
		//return masterList.getString(key);
	} catch (JSONException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		System.err.println(key);
		
	}
	return null;
}
	
	public void initObj(JSONObject obj,JSONObject masterList) throws JSONException
	{
	JSONArray itr=masterList.names();
	//obj.put("values", new JSONArray());
	obj.put("values", new JSONObject());
	if(itr!=null)
	{
		for(int i=0; i<itr.length();i++)
		{
		String key=itr.getString(i)+"";//surveyors.getString(i+"");
		String val= masterList.getString(key);
		//obj.put(val, "0");
		putInObj(obj,val,"0");
		//System.out.println(obj);
		
		}
		
	}
		//System.out.println(obj);
	}
	
	public JSONArray sortJSONArray(JSONArray arr, String field,String type,String order) throws JSONException
	{
		JSONArray outarr= new JSONArray(arr.toString());
	
		Object [] tt= new Object [arr.length()];
		ArrayList<String>  tt1= new ArrayList<String>  ();
		List<JSONObject> myJsonArrayAsList = new ArrayList<JSONObject>();
		for (int i = 0; i < arr.length(); i++)
		    myJsonArrayAsList.add(arr.getJSONObject(i));
		   
		final String key=field;
		final String fldType=type;
		final String sortOrder=order;

		Collections.sort(myJsonArrayAsList, new Comparator<JSONObject>() {
		    @Override
		    public int compare(JSONObject jsonObjectA, JSONObject jsonObjectB) {
		        int compare = 0;
		        try
		        {
		        	if(fldType.equals("int"))
		        		
		        	{
		            int keyA = jsonObjectA.getInt(key);
		            int keyB = jsonObjectB.getInt(key);
		            compare = Integer.compare(keyA, keyB);
		        	}
		        	else
		        	{
		        		 String keyA = jsonObjectA.getString(key);
				            String keyB = jsonObjectB.getString(key);
				            compare = keyA.compareTo( keyB);
				     
		        		
		        	}
		        	
		        	if(sortOrder.equals("desc"))
		        		compare=0-compare;
		        }
		        catch(JSONException e)
		        {
		            e.printStackTrace();
		        }
		        return compare;
		    }
		});
		
		
	
	outarr= new JSONArray(myJsonArrayAsList);
		/*
		for (int i = 0; i < arr.length(); i++) {
			
			if(type.equals("int"))
			{
				tt[i]=arr.getJSONObject(i).getInt(field)+":"+arr.getJSONObject(i).toString();
				
			}
			tt[i]=arr.getJSONObject(i).getString(field)+":"+arr.getJSONObject(i).toString();
			tt1.add(tt[i]);
		}
	
		Arrays.sort(tt);
		
		
		for (int i = 0; i < tt.length; i++) {
			
			int idx= tt1.indexOf(tt[i]);
			
			outarr.put(i,arr.getJSONObject(idx));
			
		}*/
		
		return outarr;
		
		
		
		
		
	}
	
	public void initObj(JSONObject obj,JSONArray masterList) throws JSONException
	{
	JSONArray itr=masterList;
	//obj.put("values", new JSONArray());
	obj.put("values", new JSONArray());
	if(itr!=null)
	{
		for(int i=0; i<itr.length();i++)
		{
			JSONObject entry=itr.getJSONObject(i);
			JSONObject valObj=new JSONObject();
		//String key=valObj.getString("value"))+"";//surveyors.getString(i+"");
		String val= entry.getString("value");
		valObj.put("name", val);
		
		valObj.put("value", "0");
		//obj.put(val, "0");
		putInObj(obj,valObj);
		//System.out.println(obj);
		
		}
		
	}
		//System.out.println(obj);
	}
	public void putInObj(JSONObject obj,String name ,String value) throws JSONException
	{
	//obj.put(name, value);
	try{
	JSONObject values= obj.getJSONObject("values");
    values.put(name, value);
	}
	catch(Exception e)
	{
		e.printStackTrace();
		System.err.println(e);
		System.err.println(name+" "+ value);
	}
	
	//obj.put("name", name);
		//obj.put("value", value);
	}
	public void putInObj(JSONObject obj,JSONObject valObj) throws JSONException
	{
	//obj.put(name, value);
	try{
	JSONArray values= obj.getJSONArray("values");
	for (int i = 0; i < values.length(); i++) {
		if(values.getJSONObject(i).getString("name").equals(valObj.getString("name")))
		{
			values.put(i,valObj);
			return;
		}
	}
    values.put(valObj);
	}
	catch(Exception e)
	{
		
		e.printStackTrace();
		System.err.println(e);
		System.err.println(valObj);
	}
	
	//obj.put("name", name);
		//obj.put("value", value);
	}
	public void putVariableName(JSONObject obj,String variableName) throws JSONException
	{
	obj.put("variable", variableName);
	
	//JSONObject values= obj.getJSONObject("values");
	//values.put(name, value);
	
	//obj.put("name", name);
		//obj.put("value", value);
	}
}
