package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class GenerateVariableJson extends Supporting{

	public static void main(String[] args)  {
		GenerateVariableJson gvj=new GenerateVariableJson();
		try {
			gvj.getVariabledata();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
				//DriverManager dr;
	public void getVariabledata() throws SQLException{
				String uname="root";
				String pass="root";
				String url="jdbc:mysql://localhost/sld";
				
				String query="select * from variable";
				Connection con=DriverManager.getConnection(url,uname,pass);
				Statement st=con.createStatement();
				ResultSet rs=st.executeQuery(query);
				
				JSONObject obj=new JSONObject();
				JSONArray arr=new JSONArray();
				JSONObject chart=new JSONObject();
				try {
					obj.put("charts",chart);
				} catch (JSONException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
				while(rs.next()){
					
				try {
					
					JSONObject obj1=new JSONObject();
					obj1.put(rs.getString("name"), rs.getString("title"));
					arr.put(obj1);
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
				}
				st.close();
				con.close();
				saveJson(obj,"variable.json");
				System.out.println("jsonobj-"+obj);
				
				
			}
}