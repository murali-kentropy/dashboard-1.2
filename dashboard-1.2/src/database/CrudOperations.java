package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mysql.jdbc.ResultSetMetaData;

public class CrudOperations {
	
/**
 * @param fieldsObj is a jsonobject passed from called method curdoperation.jsp contains fields to be updated
 * @return
 */
	
	
	/* String narrative_view_query = select d.assignedto surveyor,a.deathId,d.areaId areaId,concat(age_value,' ',age_unit)age,sex,Date(a.starttime) interview_date,time_to_sec(timediff(f.timelog,a.starttime))/60 duration_of_interview,na.summary narrative,ps.summary positive_symptoms 
 ,if(f.deathId is not null,'complete','pending') interview_status, if(b.deathId is not null ,
 cCod,if(ne.deathId is not null ,respodentThinkCod,aRespCod)) rescod,if(b.deathId is not null ,
 "child",if(ne.deathId is not null ,"neonate","adult")) type1
 from  deathDetail a left join va_child  b on a.deathId=b.deathId left join 
va_neonate ne on a.deathId=ne.deathId left join va_adult ad on a.deathId=ad.deathId
 left join death d on a.deathId
=d.deathId left join narrative na on a.deathId=na.deathId left join positiveSymptoms ps on a.deathId=ps.deathId
 left join feedback f on a.deathId=f.deathId   where na.deathId is not null and areaId <700 ;



*/
	
	
public int updateNarrativeScore(JSONObject fieldsObj){
	int i=0;
	Connection con;
	Date dt=new Date();
	java.text.SimpleDateFormat sdf = 
		     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Subject currentUser = SecurityUtils.getSubject();
	System.out.println("cup---"+currentUser.getPrincipal());
		String currentTime = sdf.format(dt);
	//System.out.println("fieldsObj---"+fieldsObj);
		String deathId=fieldsObj.getString("deathId");
	String query="update narrative_review set pos_sym_in_narrative=?,neg_sym_in_narrative=?,chronology=?,other_medical_info=?,enable_ICD=?,review_all_audio=?,review_date=?,reviewer_name=?,feedback=?,audio_quality=?,review_status=? where deathId="+deathId+"";
	try {
		con = Supporting.getConnection("partner");
		//Statement st = con.createStatement();
	
		  PreparedStatement preparedStmt = con.prepareStatement(query);
	      preparedStmt.setString(1,fieldsObj.getString("pos_sym_in_narrative"));
	      preparedStmt.setString(2,fieldsObj.getString("neg_sym_in_narrative"));
	      preparedStmt.setString(3,fieldsObj.getString("chronology"));
	      preparedStmt.setString(4,fieldsObj.getString("other_medical_info"));
	      preparedStmt.setString(5,fieldsObj.getString("enable_ICD"));
	      preparedStmt.setString(6,fieldsObj.getString("review_all_audio"));
	      preparedStmt.setString(7,currentTime);
	      preparedStmt.setString(8, (String) currentUser.getPrincipal());
	      preparedStmt.setString(9,fieldsObj.getString("feedback"));
	      preparedStmt.setString(10,fieldsObj.getString("audio_quality"));
	      preparedStmt.setString(11,"Reviewed");
	      
	      // execute the java preparedstatement
	   i=  preparedStmt.executeUpdate();
	  System.out.println("i==="+i);
		System.out.println(i+"----Records updated");
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return i;
	
	
}

// to find score for indivisual question
public int score(String value, JSONObject scale)
{
	if(value.equals(""))
	{
		return 0;
	}
	return scale.getInt(value);
}
// function to calculate total score for the probing table
public int scoreProbing(JSONObject probing,JSONArray ps )
{
	JSONObject scale= new JSONObject("{'yes':1,'no':0}"); 
	int totscore=0;
	if(ps.length()==0)return 0;
	for (int i = 0; i < ps.length(); i++) {
		JSONObject symp=probing.getJSONObject(ps.getString(i));
		
		int probingScore= score(symp.getString("probed"),scale);
		int durationScore= score(symp.getString("duration"),scale);
		
		int score=probingScore+durationScore;
		totscore+=score;
		//System.out.println("total--"+totscore);
	}
	
	
	return Math.round(totscore/ps.length());
}


public int updatePositiveSymptoms(JSONObject posymObj){
	Connection con;
	int j=0;
	try {
		con = Supporting.getConnection("partner");
		String deathId=posymObj.getString("deathId");
		String query="update narrative_review set probing=?,total_included=?,total_missing=?,scores=?,narr_fb=? where deathId="+deathId+"";
		PreparedStatement pst=con.prepareStatement(query);
		pst.setString(1, posymObj.getString("probing"));
		pst.setString(2, posymObj.getString("included"));
		pst.setString(3, posymObj.getString("missing"));
		pst.setString(4, posymObj.getString("scores"));
		pst.setString(5, posymObj.getString("narr_fb"));
		  j=  pst.executeUpdate();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return j;
}


// function to insert asset, prevHistory  is dummy 
public boolean saveAsset(String type, String name, String assignedto,String serialno,String verified,String status,String location,int asset_no,JSONObject prevHistory,String  model){
	
	JSONObject  curObj=new JSONObject();
	JSONObject  prevObj=new JSONObject();
	curObj.put("asset_no",asset_no);
	curObj.put("type",type);
	curObj.put("name",name);
	curObj.put("assignedto",assignedto);
	curObj.put("serial_no",serialno);
	curObj.put("verified",verified);
	curObj.put("status",status);
	curObj.put("location",location);
	// history will be always empty for current obj
	curObj.put("history","");
	curObj.put("model", model);
	JSONArray  curArr=new JSONArray();
	
	curArr.put(curObj);
	JSONObject curHistory=new JSONObject();
	//StringBuilder curHistory= new StringBuilder();
	JSONObject editedFieldsObj=new JSONObject();
	JSONArray  finalHistory=new JSONArray();
	//StringBuilder editedFieldsStr=new StringBuilder();
	Connection con;
	boolean j = false;
	int updateRes=0;
	int upd_his_res=0;
	
	try{
		con = Supporting.getConnection("partner");
		if(asset_no !=0){
			prevObj=getByAssset_no(asset_no);
			editedFieldsObj=compareFields(curObj, prevObj);
			String ph=prevObj.getString("history");
			/// current history is the fields in the editedFieldObj
			curHistory=editedFieldsObj;
			System.out.println("curHistory--"+curHistory+"----prevHistory----"+prevObj);
			if(ph.length()>0)
			finalHistory.put(ph);
			
			if(curHistory.length()>0)
			finalHistory.put(curHistory);
			
			System.out.println("finalhistory="+finalHistory);
			//update along with history
			// updateRes=updateAsset(curObj,asset_no);
			 updateRes= updateData1(curArr, "partner", "assets", "asset_no");
			 if(updateRes==0)return false;
			 JSONObject saveObj= new JSONObject();
			 JSONArray arr=new JSONArray();
			
			 saveObj.put("asset_no", asset_no);
			 saveObj.put("history", curHistory.toString());
			 arr.put(saveObj);
			 
			 System.out.println(saveObj.getString("history")+"---saveOBJ");
			 if(!saveObj.getString("history").equals("{}")){
			 updateRes+=insertData1(arr,"partner","asset_data_history");
			 }
			 else
				 return false;
			 
			 if(updateRes==0)return false;
			 
			 
				 return true;
				 
		}
		else{
		String query="insert into assets(type,name,assignedto,serial_no,verified,status,location,model)values(?,?,?,?,?,?,?,?)";
		//PreparedStatement pst=con.prepareStatement(query);
		/*pst.setString(1, type);
		pst.setString(2, name);
		pst.setString(3, assignedto);
		pst.setString(4, serialno);
		pst.setString(5, verified);
		pst.setString(6, status);
		pst.setString(7, location);
		pst.setString(8, model);*/
		
		updateRes=insertData1(curArr, "partner", "assets");
		if(updateRes==0)return false;
	   }
	}catch(Exception e){
		e.printStackTrace();
		 
	}
	return true;
}




public  int updateAsset(JSONObject curObj,int asset_no) {
	// TODO Auto-generated method stub
	Connection con;
	int j=0;
	
	try{
		
		con = Supporting.getConnection("partner");
		String query="update assets set type=?,name=?,assignedto=?,serial_no=?,verified=?,status=?,location=?,model=? where asset_no="+asset_no+" ";
		PreparedStatement pst=con.prepareStatement(query);
		pst.setString(1, curObj.getString("type"));
		pst.setString(2, curObj.getString("name"));
		pst.setString(3, curObj.getString("assignedto"));
		pst.setString(4, curObj.getString("serial_no"));
		pst.setString(5, curObj.getString("verified"));
		pst.setString(6, curObj.getString("status"));
		pst.setString(7, curObj.getString("location"));
		/*//if(history.getString("history"))
		*/
		//pst.setString(8, history.toString());
		pst.setString(8, curObj.getString("model"));
		
        
		
		j =  pst.executeUpdate();
	}catch(Exception e){
		e.printStackTrace();
	}
	return j;
}
//function to compare fields to get field history

public static JSONObject compareFields(JSONObject curObj,JSONObject prevObj)
{
	//System.out.println("aaaaaaa---"+curObj);
	//System.out.println("bbbbb----"+prevObj);
	//List<String> editedFields=new ArrayList<String>();
	//System.out.println("colnames----"+colNames);
	JSONObject editedFields=new JSONObject();
	StringBuilder sb=new StringBuilder();
	for(int i=0;i<colNames.size();i++){
		
		if(!colNames.get(i).equals("asset_no") && !colNames.get(i).equals("history")){
			if(!prevObj.has(colNames.get(i)))prevObj.put(colNames.get(i), "");
			if(!curObj.has(colNames.get(i)))curObj.put(colNames.get(i), "");
		if(!curObj.getString(colNames.get(i)).equals(prevObj.getString(colNames.get(i)))){
			 editedFields.put(colNames.get(i),prevObj.getString(colNames.get(i)));
			
			
		}
		}
	}
	return editedFields;
}

static List<String> colNames=new ArrayList<String>();
// function to get asset by asset no
public JSONObject getByAssset_no(int asset_no){
	Connection con;
	JSONArray arr=new JSONArray();	JSONObject obj=new JSONObject();
	try{
	con = Supporting.getConnection("partner");
	String query="select * from assets where asset_no="+asset_no+" ";
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery(query);
	
	ResultSetMetaData md=(ResultSetMetaData) rs.getMetaData();
	int colCount=md.getColumnCount();
	System.out.println("colcount-----"+colCount);
	for(int i=1;i<=colCount;i++){
		System.out.println("colname-----"+md.getColumnName(i));
		colNames.add(md.getColumnName(i));
	}
	while(rs.next()){
		obj.put("asset_no", rs.getString("asset_no"));
		obj.put("type", rs.getString("type"));
		obj.put("name", rs.getString("name"));
		obj.put("assignedto", rs.getString("assignedto"));
		obj.put("serial_no", rs.getString("serial_no"));
		obj.put("verified", rs.getString("verified"));
		obj.put("status", rs.getString("status"));
		obj.put("location", rs.getString("location"));
		
		if(rs.getString("history")!=null)
		obj.put("history",rs.getString("history"));
		else
		obj.put("history","");
		obj.put("model",rs.getString("model"));
		
	}
	}catch(Exception e){
		e.printStackTrace();
	}
	return obj;
}
public void insertData(JSONObject data,String datasource,String table) throws Exception{
	Connection con;

	
		con = Supporting.getConnection(datasource);
	synchronized(con)
	{
		JSONArray values=data.getJSONArray("values");
		
		
		for(int i=0;i<values.length();i++)
		{ JSONObject first=values.getJSONObject(i);
		JSONArray names=first.names();
		String fields=names.join(",");
		String values1=first.toJSONArray(names).join(",");
			String query ="insert into "+table +" ("+fields.replaceAll("\"", "")+") "+" values("+values1+")";
			System.out.println(query);
			try {
				Statement stmt=con.createStatement();
				stmt.execute(query);
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}
		
		
	
}

public int insertData1(JSONArray data,String datasource,String table) throws Exception{
	Connection con;

	int inserts=0;
		con = Supporting.getConnection(datasource);
	synchronized(con)
	{
		JSONArray values=data;//data.getJSONArray("values");
		
		
		for(int i=0;i<values.length();i++)
		{ JSONObject first=values.getJSONObject(i);
		JSONArray names=first.names();
		String fields=names.join(",");
		String values1=first.toJSONArray(names).join(",");
			String query ="insert into "+table +" ("+fields.replaceAll("\"", "")+") "+" values("+values1+")";
			System.out.println(query);
			try {
				Statement stmt=con.createStatement();
				stmt.execute(query);
				stmt.close();
				inserts++;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}
		
	return inserts;
		
	
}


public String getUpdateQuery(JSONArray fields, JSONArray values)
{
	String setStr="Set ";
	
	System.out.println(fields);
	System.out.println(values);
	
	
	JSONArray merged= new JSONArray();
	for(int i=0;i< fields.length();i++)
	{
		
		String tt= fields.getString(i)+"='"+values.get(i)+"'";
		merged.put(tt);
		
	}
	
return	merged.join(",").replaceAll("\"", "");
}

public int updateData1(JSONArray data,String datasource,String table,String keyFld) throws Exception{
	Connection con;

	int updates=0;
		con = Supporting.getConnection(datasource);
	synchronized(con)
	{
		JSONArray values=data;//data.getJSONArray("values");
		
		
		for(int i=0;i<values.length();i++)
		{ JSONObject first=values.getJSONObject(i);
		JSONArray names=first.names();
		String fields=names.join(",");
		JSONArray values1=first.toJSONArray(names);
		
			String query ="update "+table+" set "+getUpdateQuery(names, values1)+" where "+keyFld+"='"+first.get(keyFld)+"'";
			System.out.println(query);
			try {
				Statement stmt=con.createStatement();
				stmt.execute(query);
				stmt.close();
				updates++;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}
	return updates;
		
		
	
}


public void addcoloum(){
	Connection con;
	try{
	con = Supporting.getConnection("partner");
	String query="alter table narrative_review ADD COLUMN audio_quality VARCHAR(15) AFTER review_all_audio";
	Statement st = con.createStatement();
	int rs = st.executeUpdate(query);
	System.out.println("rs---add coloum--"+rs);
	}catch(Exception e){
		e.printStackTrace();
	}
}
public void selectAll(){
	Connection con;
	try{
	con = Supporting.getConnection("partner");
	String query="select * from selected_narrative";
	Statement st = con.createStatement();
ResultSet rs = st.executeQuery(query);
ResultSetMetaData rsmd = (ResultSetMetaData) rs.getMetaData();
int columnsNumber = rsmd.getColumnCount();
while (rs.next()) {
    for (int i = 1; i <= columnsNumber; i++) {
        if (i > 1) System.out.print(",  ");
        String columnValue = rs.getString(i);
       // System.out.print("columnValue----"+columnValue + "------columnname---- " + rsmd.getColumnName(i));
        System.out.print("rs.getString(i)"+rs.getString(i));
    }
    System.out.println("");
}
	System.out.println("rs---add coloum--"+rs);
	}catch(Exception e){
		e.printStackTrace();
	}
}

public ResultSet getResultSet(String query,String dataSource){
	Connection con;
	ResultSet rs = null;
	try{
	con = Supporting.getConnection(dataSource);
	Statement st = con.createStatement();
     rs = st.executeQuery(query);
    /*while(rs.next()){
    	System.out.println("rs=="+rs.getString("history"));;
    }*/
	}catch(Exception e){
		e.printStackTrace();
	}
	return rs;
}
public static void main(String args[]){
	CrudOperations co=new CrudOperations();
	//co.updateNarrativeScore();
	//co.addcoloum();
	//co.selectAll();
	String dataSource="partner";
	int asset_no=1;
	String query="select * from asset_data_history where asset_no='"+asset_no+"' ";
	//co.getResultSet(query, dataSource);
}
}
