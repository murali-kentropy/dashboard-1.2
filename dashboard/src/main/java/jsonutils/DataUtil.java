package jsonutils;

import org.json.JSONArray;
import org.json.JSONObject;

public class DataUtil {
	public String getObjectValue(JSONObject obj, String field)
	{
		JSONArray ja=obj.getJSONArray("values");
		if(ja.length()==0)
			return "";
		JSONObject valObj=ja.getJSONObject(0);
		return valObj.optString(field);
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
