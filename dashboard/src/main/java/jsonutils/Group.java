package jsonutils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

public class Group {
	
	public JSONObject groupBy(JSONArray ja, String field)
	{
		JSONObject out = new JSONObject();
		
		for (int i = 0; i < ja.length(); i++) {
			JSONObject jo=ja.getJSONObject(i);
			String val= jo.getString(field);
			JSONArray group=out.optJSONArray(val);
			if(group==null)
			{
				group= new JSONArray();
				out.put(val, group);
				
			}
			group.put(jo);
			
		}
			return out;
		}
		
		
	


	public static void main(String[] args) throws Exception, FileNotFoundException {
		// TODO Auto-generated method stub
		
		//JSONArray ja = new JSONArray("[{sym:'test',test:'one'},{sym:'test',test:'two'},{sym:'test1',test:'three'},{sym:'test1',test:'four'}]");
JSONArray ja = new JSONArray(new JSONTokener(new FileInputStream("symptom_map.json")));
		System.out.println(new Group().groupBy(ja, "main_symptom").toString(2));
	}

}
