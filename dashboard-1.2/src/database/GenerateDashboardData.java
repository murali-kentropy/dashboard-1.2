package database;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import dashboard.ChartData;
import utils.sql.SQLQueryBuilder;


public class GenerateDashboardData extends Supporting{
	
	static public JSONObject surveyors;//=new JSONArray();
	static public JSONArray surveyors1,areas1;
	static public String vaDb,enumDb,surveyorDb;
	
	static JSONArray srArr=new JSONArray();
	//getsurveyor method which is used to get all the surveyors stored in database table 
	/**
	 * Gets the surveyor dimension, name contains  id value contains  the name of the surveyor
	 * @return a JSONArray
	 */
	public static JSONArray getSurveyors()
	{
		JSONArray srArr=new JSONArray();
		try {
			
			Connection con=getConnection("partner");
			String query="select a.id id,name from surveyor a left join teamuser b  on a.id=b.userId where b.userId is not null and b.teamId NOT IN (6)";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			while(rs.next()){
				String name= rs.getString("id");
				String value= rs.getString("name");
				//JSONObject obj=new JSONObject();
				srArr.put(new JSONObject("{name:'"+name+"',value:'"+value.toUpperCase()+"'}"));
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
	/**
	 * Gets the staff dimension, name contains  id value contains  the name of the staff
	 * @return a JSONArray
	 */
	public static JSONArray getStaff()
	{
		JSONArray srArr=new JSONArray();
		try {
			
			Connection con=getConnection("partner");
			String query="select id,name from staff";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			while(rs.next()){
				String name= rs.getString("id");
				String value= rs.getString("name");
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
	/**used by the various date related dimension to gernrate a range of dates
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static JSONArray getDates(Date startDate, Date endDate)
	{
	//	JSONArray ja= new JSONArray();
		
		JSONArray srArr=new JSONArray();
		try {
			SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
			ArrayList<Date> dates= new ArrayList<Date>();
		
			Calendar start=Calendar.getInstance();
			start.setTime(startDate);
			JSONObject jo = new JSONObject();
			String dtStr=sdf.format(start.getTime());
			jo.put("name", dtStr);
			jo.put("value", dtStr);
			srArr.put(jo);
			//srArr.put(sdf.format(startDate));
			int count=0;
	
			while(start.getTime().before(endDate))
			{
				start.add(Calendar.DATE,1);
				 jo = new JSONObject();
				 dtStr=sdf.format(start.getTime());
				jo.put("name", dtStr);
				jo.put("value", dtStr);
				srArr.put(jo);
				//srArr.put(obj);
			}
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return srArr;
	}
	
	/**
	 * Returns the Area dimension values 
	 * name contains areaid value contains name of the area
	 * @return
	 */
	public static JSONArray getAreas()
	{  JSONArray srArr=new JSONArray();
		try {
		
			Connection con=getConnection("va");
			String query="select areaId,name from area where areaid<700";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			while(rs.next()){
				String name= rs.getString("areaId");
				String value= rs.getString("name");
				System.out.println("{name:'"+name+"',value:\""+value+"\"}");
				//JSONObject obj=new JSONObject();
				srArr.put(new JSONObject("{name:'"+name+"',value:\""+value+"\"}"));
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
	
	/**
	 * Returns the age type dimension values 
	 * name contains age type value contains name of the type
	 * @return
	 */
	public static JSONArray getAgeType()
	{  JSONArray srArr=new JSONArray();
		try {
		
			
				srArr.put(new JSONObject("{name:'neonate',value:'neonate'}"));
				srArr.put(new JSONObject("{name:'child',value:'child'}"));
				srArr.put(new JSONObject("{name:'adult',value:'adult'}"));
				srArr.put(new JSONObject("{name:'maternal',value:'maternal'}"));
				
			}
			
		
		 catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return srArr;
	}
	
	/**
	 Gets the physicians dimension, name contains name value contains  the name of the physicians
	 * @return a JSONArray
	 */
	public static JSONArray getPhysician()
	{ 
		JSONArray srArr=new JSONArray();
	try {
		
		Connection con=getConnection("cme");
		String query="select id,name from physician where id is not null";
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		while(rs.next()){
			String name= rs.getString("id");
			String value= rs.getString("name");
			//System.out.println("{name:'"+name+"',value:\""+value+"\"}");
			//JSONObject obj=new JSONObject();
			srArr.put(new JSONObject("{name:'"+name+"',value:\""+value+"\"}"));
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
	
	public static JSONArray getLocations()
	{
		JSONArray srArr=new JSONArray();
		try {
			
			Connection con=getConnection("partner");
			String query="select name id,name from org_unit";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			while(rs.next()){
				String name= rs.getString("id");
				String value= rs.getString("name");
				//System.out.println("{name:'"+name+"',value:\""+value+"\"}");
				//JSONObject obj=new JSONObject();
				srArr.put(new JSONObject("{name:'"+name+"',value:\""+value+"\"}"));
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
	// get asset type from database for  type dropdown in assetform
	public static JSONArray getAssetType()
	{
		JSONArray srArr=new JSONArray();
		try {
			
			Connection con=getConnection("partner");
			String query="select id,type from asset_type where id is not null";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			while(rs.next()){
				String name= rs.getString("type");
				String value= rs.getString("id");
				//System.out.println("{name:'"+name+"',value:\""+value+"\"}");
				//JSONObject obj=new JSONObject();
				srArr.put(new JSONObject("{name:'"+name+"',value:\""+value+"\"}"));
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
	
	
	/**Gets data by surveyor dimensiob to be used by queries which are groued by surveyor id
	 * sets a value for each surveyor , if not present in the query result sets value to 0, can be sorted by either name of value
	 * @param var
	 * @param query
	 * @param sort
	 * @return
	 * @throws Exception
	 */
	/**
	 * @param var
	 * @param query
	 * @param sort
	 * @return
	 * @throws Exception
	 */
	public JSONObject getSurveyorData(String var,String query,JSONObject sort) throws Exception {
		// TODO Auto-generated method stub
		// DriverManager dr;
		ChartData cd = new ChartData();
		/*String query = "select  count(*) /(max(date(timelog)) -min(date(timelog)) +1) avg_death_per_day ,"
				+ "surveyor from cod_save.death group by surveyor";*/
		
		//Get the surveyor dimension
		return getDataByDimension(getSurveyors(),var,query,sort);
				
		
		
	}
	/**Gets data by surveyor dimensiob to be used by queries which are groued by surveyor id
	 * sets a value for each surveyor , if not present in the query result sets value to 0, can be sorted by either name of value
	 * @param var
	 * @param query
	 * @param sort
	 * @return
	 * @throws Exception
	 */
	/**
	 * @param var
	 * @param query
	 * @param sort
	 * @return
	 * @throws Exception
	 */
	public JSONObject getPhysicianData(String var,String query,JSONObject sort) throws Exception {
		// TODO Auto-generated method stub
		// DriverManager dr;
		ChartData cd = new ChartData();
		/*String query = "select  count(*) /(max(date(timelog)) -min(date(timelog)) +1) avg_death_per_day ,"
				+ "surveyor from cod_save.death group by surveyor";*/
		
		//Get the surveyor dimension
		return getDataByDimension(getPhysician(),var,query,sort);
				
		
		
	}
	
	/**Gets data by area dimensiob to be used by queries which are groued by area id
	 * sets a value for each area , if not present in the query result sets value to 0, can be sorted by either name of value
	 * @param var
	 * @param query
	 * @param sort
	 * @return
	 * @throws Exception
	 */
	public JSONObject getAreaData(String var, String query, JSONObject sort) throws Exception {
		// TODO Auto-generated method stub
		// DriverManager dr;
		ChartData cd = new ChartData();
		/*
		 * String query =
		 * "select  count(*) /(max(date(timelog)) -min(date(timelog)) +1) avg_death_per_day ,"
		 * + "surveyor from cod_save.death group by surveyor";
		 */

		// Get the surveyor dimension
		return getDataByDimension(getAreas(), var, query, sort);

	}
	
	
	/**Gets data by 30day date dimension (previous 30 days) dimensiob to be used by queries which are groued by date
	 * sets a value for each date , if not present in the query result sets value to 0, can be sorted by either name of value
	 * @param var
	 * @param query
	 * @param sort
	 * @return
	 * @throws Exception
	 */
	public JSONObject get30DaysData(String var,String query,JSONObject sort) throws Exception {
		// TODO Auto-generated method stub
		// DriverManager dr;
		ChartData cd = new ChartData();
		/*String query = "select  count(*) /(max(date(timelog)) -min(date(timelog)) +1) avg_death_per_day ,"
				+ "surveyor from cod_save.death group by surveyor";*/
	Calendar cal=	Calendar.getInstance();
	cal.add(Calendar.DATE,-30);
		Date dt=cal.getTime();
		//Get the surveyor dimension
		return getDataByDimension(getDates(dt,new Date()),var,query,sort);
				
		
		
	}
	
	
	
	/**To  be used when the query contains everything and has to be displayed as it is ie without using dimension Eg time based queries
	 * @param var
	 * @param query
	 * @param sort
	 * @return
	 * @throws Exception
	 */
	public JSONObject getPlainData(String var,String query,JSONObject sort) throws Exception {
		// TODO Auto-generated method stub
		// DriverManager dr;
		ChartData cd = new ChartData();
		/*String query = "select  count(*) /(max(date(timelog)) -min(date(timelog)) +1) avg_death_per_day ,"
				+ "surveyor from cod_save.death group by surveyor";*/
		
		//Get the surveyor dimension
		return getDataByDimension(new JSONArray(),var,query,sort);
				
		
		
	}
	
	
	
	/**
	 * Generalised function to fetch data using the dimension specified used by all functions that fetch data by a dimension 
	 * @param dim
	 * @param var
	 * @param query
	 * @param sort
	 * @return
	 * @throws Exception
	 */
	public JSONObject getDataByDimension(JSONArray dim,String var,String query,JSONObject sort) throws Exception
	{ChartData cd= new ChartData();
		
		
//		surveyors1=getSurveyors();
		System.out.println(query);
		// String query="select * from variable";
	Connection con=getConnection(datasource);
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		JSONObject obj = new JSONObject();
	
		
	ResultSetMetaData rsMetaData = rs.getMetaData();
	    int numberOfColumns = rsMetaData.getColumnCount();
	    ArrayList<String> colList=new ArrayList<String>();
	    if(numberOfColumns>1)
	    {
	    	
	    	System.err.println(dim);
	    cd.initObj(obj,dim);
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
	      //  System.out.println("colname="+columnName);
	        colList.add(columnName);
	      }
	    for(int j=0;j<colList.size();j++){
	    	//System.out.println("collist - "+j+"--"+colList.get(j));
	    }
	    
		while (rs.next()) {
           // System.out.println("1st result  "+rs.getString(1));
			try {
				//if(master!=null){
				//if(!master.equals("surveyors")){	
				
				if(colList.size()==1 ){
					//cd.putInObj(obj, "completed", rs.getString(colList.get(0)));
					cd.putInObj(obj, new JSONObject("{name:'completed',value:\""+ rs.getString(colList.get(0))+"\"}"));
					//obj.put("completed",rs.getString(colList.get(0)));
				}
				else
					if(dim.length()==0 ){
						//cd.putInObj(obj, "completed", rs.getString(colList.get(0)));
						cd.putInObj(obj, new JSONObject("{name:\""+rs.getString(colList.get(1))+"\",value:\""+ rs.getString(colList.get(0))+"\"}"));
						//obj.put("completed",rs.getString(colList.get(0)));
					}
				else
				
				{
				//System.out.println(" The lookup value "+rs.getString(colList.get(1)));
				//cd.putInObj(obj, cd.lookup(surveyors,rs.getString(colList.get(1))), rs.getString(colList.get(0)));
				if(colList.size()==2)
					
				{
				JSONObject valObj=new JSONObject("{name:\""+cd.lookup(dim,rs.getString(colList.get(1)))+"\",value:\""+ rs.getString(colList.get(0))+"\"}");
				cd.putInObj(obj, valObj);
				}
if(colList.size()>2)					
				{
	
				JSONObject valObj=new JSONObject();
				valObj.put("name",cd.lookup(dim,rs.getString(colList.get(colList.size()-1))));
				JSONArray ja=new JSONArray();
				for(int i=0; i< colList.size()-1;i++)					
				{
					ja.put(rs.getString(colList.get(i)));
				}
				valObj.put("value", ja);
				//"{name:\""+cd.lookup()+"\",value:\""+ rs.getString(colList.get(0))+"\"}");
				cd.putInObj(obj, valObj);
				}
				
				}
				//}
				
				//obj.put(surveyors.getString(rs.getString(colList.get(1))), rs.getString(colList.get(0)));
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		System.out.println(query);
		//obj.put("variable",var);
		cd.putVariableName(obj, var);
		if(sort!=null)
		{
		JSONArray sortedValues=cd.sortJSONArray(obj.getJSONArray("values"), sort.getString("field"),sort.getString("type"),sort.getString("order"));
			
		//System.out.println("Sorted Values "+sortedValues.toString(2));
		
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
	
	
	
	
	/**Used when a table report has to be created rather than a chart ie all the processing thats done for charts is ignored for now 
	 * @param var
	 * @param query
	 * @return
	 * @throws Exception
	 */
	public JSONObject getReportData(String var,String query) throws Exception {
		// TODO Auto-generated method stub
		// DriverManager dr;
		
		
		System.out.println(query);
		// String query="select * from variable";
	Connection con=getConnection(datasource);
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		JSONObject obj = new JSONObject();
	obj.put("values", new JSONArray());
		
	ResultSetMetaData rsMetaData = rs.getMetaData();
	    int numberOfColumns = rsMetaData.getColumnCount();
	    ArrayList<String> colList=new ArrayList<String>();
	   
	    
	    for (int i = 1; i < numberOfColumns + 1; i++) {
	    	
	        String columnName = rsMetaData.getColumnName(i);
	      //  String tableName = rsMetaData.getTableName(i);
	        // for storing all coloums 
	      //  System.out.println("colname="+columnName);
	        colList.add(columnName);
	      }
	    
	    for(int j=0;j<colList.size();j++){
	    //	System.out.println("collist - "+j+"--"+colList.get(j));
	    }
	    
		while (rs.next()) {
          // System.out.println("1st result  "+rs.getString(1));
			try {
				//if(master!=null){
				//if(!master.equals("surveyors")){	
				JSONObject valObj=new JSONObject();
				//cd.putInObj(obj, cd.lookup(surveyors,rs.getString(colList.get(1))), rs.getString(colList.get(0)));
				for(String col:colList)
				{
				
				valObj.put(col, rs.getString(col));
				
				
				}
				obj.getJSONArray("values").put(valObj);
				
				//obj.put(surveyors.getString(rs.getString(colList.get(1))), rs.getString(colList.get(0)));
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		obj.put("variable",var);
		
		
	
			
		
		return obj;
	}
	public String datasource="va";
	public JSONArray getData(JSONArray variables)
	{
		//System.out.println(variables);
		JSONArray filterValues=new JSONArray();
		return getData(variables,filterValues);
	}
	
	
	public String getQuery(JSONObject jo)
	{
		String query="";
		if(jo.has("query"))
			query=jo.getString("query");
		else
			if(jo.has("queryStruct"))
				query=new SQLQueryBuilder().buildSQL(jo.getJSONObject("queryStruct"),new JSONArray());
		return query;
		
	}
	public String getQuery(JSONObject jo,JSONArray filterValues)
	{
		String query="";
		if(jo.has("query"))
			query=jo.getString("query");
		else
			if(jo.has("queryStruct"))
				query=new SQLQueryBuilder().buildSQL(jo.getJSONObject("queryStruct"),filterValues);
		return query;
		
	}
	public JSONArray getData(JSONArray variables,JSONArray filterValues)
	{
	JSONArray arr= new JSONArray();
	for(int i=0; i< variables.length();i++)
	{
		JSONObject data=new JSONObject();
		try {
			if(variables.getJSONObject(i).has("datasource"))
			{
				datasource=variables.getJSONObject(i).getString("datasource");
			}
			else
				datasource="va";
			if(variables.getJSONObject(i).getJSONArray("types").getString(0).equals("table"))
			{
				data= getReportData(variables.getJSONObject(i).getString("name"),getQuery(variables.getJSONObject(i),filterValues));
			}
			else{
			System.out.println("variables--"+variables);
			JSONObject sort=null;
			if(variables.getJSONObject(i).has("sort"))
			{
				sort=variables.getJSONObject(i).getJSONObject("sort");
			}
			if(variables.getJSONObject(i).has("queryFilters")){
			//System.out.println("array--"+variables.getJSONObject(i).getJSONArray("queryFilters"));
			}
			
			String var1=variables.getJSONObject(i).getString("name");
			String dim="surveyor";
			if(variables.getJSONObject(i).has("dimension"))
			{
				dim=variables.getJSONObject(i).getString("dimension");
			
			if(dim.equals("area"))
{
			data = getAreaData(var1,getQuery(variables.getJSONObject(i)),sort);
}
			else if(dim.equals("physician"))
			{
				data = getPhysicianData(var1,getQuery(variables.getJSONObject(i)),sort);
	}
			else
				if(dim.equals("nodim"))
				{
							data = getPlainData(var1,getQuery(variables.getJSONObject(i)),sort);
				}
				else
					if(dim.equals("30day"))
					{
								data = get30DaysData(var1,getQuery(variables.getJSONObject(i)),sort);
					}
			
			}
else	
	data = getSurveyorData(var1,getQuery(variables.getJSONObject(i)),sort);
			}
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
	
	public static JSONArray getKeys(String query,String keyFld)
	{
		JSONArray srArr=new JSONArray();
		try {
			
			Connection con=getConnection("surveyor");
			//String query="select a.id id,username from user a left join teamuser b  on a.id=b.userId where b.userId is not null and b.teamId NOT IN (6,7) ";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			while(rs.next()){
				String keyVal= rs.getString(keyFld);
				//String value= rs.getString("username");
				//JSONObject obj=new JSONObject();
				srArr.put(keyVal);
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

	
public static void main(String[] args) throws Exception{
	GenerateDashboardData gdd=new GenerateDashboardData();
	//JSONObject res=gdd.getReportData("test", "select * from user");
	gdd.datasource="partner";
	//JSONObject res=gdd.getReportData("test", "select * from organisation");
	JSONArray res=gdd.getSurveyors();
	//JSONArray res=gdd.getAreas();
	System.out.println(res.toString(2));
	System.out.println(getDates(new Date("7/1/2019"),new Date()));
	
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
	/*
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
	   */
}
}