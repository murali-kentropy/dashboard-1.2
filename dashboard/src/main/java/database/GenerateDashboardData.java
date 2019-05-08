package database;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import dashboard.ChartData;


public class GenerateDashboardData extends Supporting{
	
	static public JSONObject surveyors;//=new JSONArray();
	static public JSONArray surveyors1;
	static public String vaDb,enumDb,surveyorDb;
	
	static JSONArray srArr=new JSONArray();
	//getsurveyor method which is used to get all the surveyors stored in database table 
	public static JSONArray getSurveyors()
	{
		try {
			Connection con=getConnection("va");
			String query="select id,username from user";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			while(rs.next()){
				String name= rs.getString("id");
				String value= rs.getString("username");
				//JSONObject obj=new JSONObject();
				srArr.put(new JSONObject("{name:'"+name+"',value:'"+value+"'}"));
				//srArr.put(obj);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new JSONArray();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return srArr;
	}
	static{
		try {
			Class.forName("com.mysql.jdbc.Driver");
	
			vaDb="cod_save";
			enumDb="cod_save";
			surveyorDb="sr_database";
			
			surveyors1=new JSONArray();
			surveyors1.put(new JSONObject("{name:'101',value:'darshan'}"));
			surveyors1.put(new JSONObject("{name:'102',value:'gobind'}"));
			surveyors1.put(new JSONObject("{name:'103',value:'sandeep'}"));
			surveyors1.put(new JSONObject("{name:'104',value:'sanjeev'}"));
			surveyors1.put(new JSONObject("{name:'105',value:'amrit'}"));
			surveyors1.put(new JSONObject("{name:'106',value:'devinder'}"));
			surveyors1.put(new JSONObject("{name:'107',value:'sameer'}"));			
			surveyors1.put(new JSONObject("{name:'108',value:'harjeet'}"));	
			surveyors1.put(new JSONObject("{name:'109',value:'charanjit'}"));	
			surveyors1.put(new JSONObject("{name:'110',value:'deeksha'}"));	
			
			surveyors=new JSONObject();
			surveyors.put("101","a");
			surveyors.put("102","b");
			surveyors.put("103","c");
			surveyors.put("104","d");
			surveyors.put("105","e");
			surveyors.put("106","f");
			surveyors.put("107","g");
			surveyors.put("108","i");
			surveyors.put("109","j");
			surveyors.put("110","k");
			JSONObject jo= new JSONObject("{'one':'0','five':'0','seven':'0','two':'0','three':'0','four':'0','six':'0'}");
			System.out.println(jo);
			
			System.out.println(jo.toJSONArray(null));
			System.out.println(surveyors);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public JSONObject getSurveyorData(String var,String query,JSONObject sort ) throws Exception {
		// TODO Auto-generated method stub
		// DriverManager dr;
		ChartData cd = new ChartData();
		/*String query = "select  count(*) /(max(date(timelog)) -min(date(timelog)) +1) avg_death_per_day ,"
				+ "surveyor from cod_save.death group by surveyor";*/
		
		
		surveyors1=getSurveyors();
		System.out.println(query);
		// String query="select * from variable";
	Connection con=getConnection("va");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		JSONObject obj = new JSONObject();
	
		
	ResultSetMetaData rsMetaData = rs.getMetaData();
	    int numberOfColumns = rsMetaData.getColumnCount();
	    ArrayList<String> colList=new ArrayList<String>();
	    if(numberOfColumns>1)
	    {
	    	
	    	System.err.println(surveyors1);
	    cd.initObj(obj,surveyors1);
	    }
	    else
	    {
	    //cd.initObj(obj,new JSONObject());
	    cd.initObj(obj,new JSONArray());
	    }
	    
	    for (int i = 1; i < numberOfColumns + 1; i++) {
	    	
	        String columnName = rsMetaData.getColumnName(i);
	      //  String tableName = rsMetaData.getTableName(i);
	        // for storing all coloums 
	        System.out.println("colname="+columnName);
	        colList.add(columnName);
	      }
	    for(int j=0;j<colList.size();j++){
	    	System.out.println("collist - "+j+"--"+colList.get(j));
	    }
		while (rs.next()) {
            System.out.println("1st result  "+rs.getString(1));
			try {
				if(colList.size()==1){
					//cd.putInObj(obj, "completed", rs.getString(colList.get(0)));
					cd.putInObj(obj, new JSONObject("{name:'completed',value:'"+ rs.getString(colList.get(0))+"'}"));
					//obj.put("completed",rs.getString(colList.get(0)));
				}
				else
				
				{
				System.out.println(" The lookup value "+rs.getString(colList.get(1)));
				//cd.putInObj(obj, cd.lookup(surveyors,rs.getString(colList.get(1))), rs.getString(colList.get(0)));
				
				JSONObject valObj=new JSONObject("{name:'"+cd.lookup(surveyors1,rs.getString(colList.get(1)))+"',value:'"+ rs.getString(colList.get(0))+"'}");
				cd.putInObj(obj, valObj);
				
				}
				
				
				//obj.put(surveyors.getString(rs.getString(colList.get(1))), rs.getString(colList.get(0)));
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		//obj.put("variable",var);
		cd.putVariableName(obj, var);
		if(sort!=null)
		{
		JSONArray sortedValues=cd.sortJSONArray(obj.getJSONArray("values"), sort.getString("field"),sort.getString("type"),sort.getString("order"));
			
		System.out.println("Sorted Values "+sortedValues.toString(2));
		
		obj.put("values", sortedValues);
		
		}
		
	
			
		//finally
			{
				//rs.close();
			//	st.close();
		//		con.close();
			}
		
		return obj;
	}
	public JSONArray getData(JSONArray variables)
	{
		System.out.println(variables);
	JSONArray arr= new JSONArray();
	for(int i=0; i< variables.length();i++)
	{
		JSONObject data;
		try {
			System.out.println(variables.getJSONObject(i));
			JSONObject sort=null;
			if(variables.getJSONObject(i).has("sort"))
			{
				sort=variables.getJSONObject(i).getJSONObject("sort");
			}
			data = getSurveyorData(variables.getJSONObject(i).getString("name"),variables.getJSONObject(i).getString("query"),sort);
			arr.put(data);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	return arr;
}
	
public static void main(String[] args) throws Exception{
	GenerateDashboardData gdd=new GenerateDashboardData();
	
	/*String configfile="C:/Users/INTEL/workspace/sierra_leone_dashboards/WebContent/dashboards/va_monitoring_dashboard_config.json";
	JSONObject joConfig;
	try {
		joConfig = new JSONObject(new JSONTokener(new FileInputStream(configfile)));
		JSONArray arr= gdd.getData(joConfig.getJSONArray("charts"));
		System.out.println("aray="+arr);
		
		//saveJson(obj);
	} catch (FileNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (JSONException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}*/
	String query="select *  from Houses where  DATE(timelog) = DATE(NOW()) group by surveyor";
	Connection con=getConnection("va");
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery(query);
	   ResultSetMetaData rsmd = rs.getMetaData();
	   System.out.println("");
	   int columnsNumber = rsmd.getColumnCount();
	   while (rs.next()) {
	       for (int i = 1; i <= columnsNumber; i++) {
	           if (i > 1) System.out.print(",  ");
	           String columnValue = rs.getString(i);
	           System.out.print(columnValue + " " + rsmd.getColumnName(i));
	       }
	       System.out.println("");
	   }
}
}