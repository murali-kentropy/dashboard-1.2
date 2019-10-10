package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mysql.jdbc.ResultSetMetaData;

import dashboard.ChartData;
import utils.sql.SQLQueryBuilder;
import database.Supporting;

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
	String query="update narrative_review set pos_sym_in_narrative=?,neg_sym_in_narrative=?,chronology=?,other_medical_info=?,enable_ICD=?,review_all_audio=?,review_date=?,reviewer_name=?,feedback=? where deathId="+deathId+"";
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
	      
	      // execute the java preparedstatement
	   i=  preparedStmt.executeUpdate();
	  
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
		String query="update narrative_review set probing=?,total_included=?,total_missing=?,scores=? where deathId="+deathId+"";
		PreparedStatement pst=con.prepareStatement(query);
		pst.setString(1, posymObj.getString("probing"));
		pst.setString(2, posymObj.getString("included"));
		pst.setString(3, posymObj.getString("missing"));
		pst.setString(4, posymObj.getString("scores"));
		  j=  pst.executeUpdate();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return j;
}
public static void main(String args[]){
	CrudOperations co=new CrudOperations();
	//co.updateNarrativeScore();
}
}
