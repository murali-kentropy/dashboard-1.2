package database;

import java.io.File;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Hashtable;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

public class Supporting {
	
		
	public static  String confirgPath=".";
	
	public static JSONObject vconfig;
	public static String vconfigFile="server_config.json";
	
	public void saveJson(JSONObject obj,String jsonfile){
		File file=new File("C:/Users/INTEL/workspace/sierra_leone_dashboards/WebContent/dashboards/"+jsonfile);
		try {
			FileWriter out=new FileWriter(file);

			out.write(obj.toString());
		    out.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		}
	
	static void loadConfig() throws JSONException, IOException
	{
		FileInputStream fis=new FileInputStream("C:/Users/INTEL/workspace/dashboard-1.2/WebContent/dashboards/server_config.json");
	//FileInputStream fis=new FileInputStream(confirgPath+"/"+vconfigFile);
		
		vconfig=new JSONObject(new JSONTokener(fis));
		fis.close();
	}
static Hashtable<String,Connection> conns=new Hashtable<String, Connection>();
	


	public static Connection getConnection(String type) throws Exception {

		Connection con = conns.get(type);

		if (con != null && con.isValid(100))
			return con;
		else

		{

			String uname = "";
			String pass = "";
			String url = "";
			loadConfig();
			String envKey = vconfig.getString("current_environment");
			JSONObject env = vconfig.getJSONObject("environments").getJSONObject(envKey);
			JSONObject dbConfig = env.getJSONObject(type);
			uname = dbConfig.getString("uname");
			pass = dbConfig.getString("pass");
			url = dbConfig.getString("url");
			con = DriverManager.getConnection(url, uname, pass);
			conns.put(type, con);
			return con;
		}

	}

}

