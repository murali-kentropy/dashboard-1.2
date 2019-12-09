package database;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.net.UnknownHostException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;



public class GenerateSurveyorJson extends Supporting{

	static{
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void main(String[] args)  {
		GenerateSurveyorJson gsj=new GenerateSurveyorJson();
		String configfile="C:/Users/INTEL/workspace/sierra_leone_dashboards/WebContent/dashboards/va_monitoring_dashboard_config.json";
		JSONObject joConfig;
		try {
			joConfig = new JSONObject(new JSONTokener(new FileInputStream(configfile)));
			JSONArray arr= gsj.getData(joConfig.getJSONArray("charts"));
			System.out.println("aray="+arr);
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//gsj.getSurveyorData(joConfig);
		
	}	
	
	Connection con;
	
	public Connection getConnection() throws SQLException
	{
		if(con!=null)
		return con;
		else
			
		{
			
			String uname = "root";
			String pass = "root";
			String url = "jdbc:mysql://localhost/sld";
			con = DriverManager.getConnection(url, uname, pass);
			return con;
		}
 
	}
		
		
	public JSONObject getSurveyorData(String var) throws SQLException, JSONException {
		// TODO Auto-generated method stub
		// DriverManager dr;
		System.out.println(var);
		String query = "select * from surveyor where variable='"+var+"'";
		
		System.out.println(query);
		// String query="select * from variable";
	Connection con=getConnection();
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);

		JSONObject obj = new JSONObject();
		
		while (rs.next()) {

			try {
				obj.put(rs.getString("name"), rs.getString("value"));
				//con.close();

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			finally
			{
		//		con.close();
			}

		}
		obj.put("variable",var);
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
			data = getSurveyorData(variables.getJSONObject(i).getString("name"));
			arr.put(data);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	
	
	
		//saveJson(, "surveyor.json");
		//System.out.println("jsonobj-" + obj);
		// String file=
		// request.getRealPath("/")+"/dashboards/sl_monitoring_dashboard.json";

	}
	return arr;
}}
