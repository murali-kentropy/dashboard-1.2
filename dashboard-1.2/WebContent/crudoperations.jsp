<%@page import="database.CrudOperations"%>
<%@page import="database.GenerateDashboardData"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.PreparedStatement" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
 CrudOperations op=new CrudOperations();
 GenerateDashboardData gd=new GenerateDashboardData();
 gd.datasource="partner";
 
 GenerateDashboardData.confirgPath=request.getRealPath("/")+"/dashboards";
Object username=request.getAttribute("user");
 System.out.println("username---"+request.getAttribute("shiroLoginFailure"));
 JSONObject fieldsObj = new JSONObject();
 JSONObject posymObj = new JSONObject();
 //request.getAttribute("shiroLoginFailure"); 
 String deathId=request.getParameter("deathId").toString();
 Object date=new Date().getDate();
	fieldsObj.put("deathId", request.getParameter("deathId"));
	fieldsObj.put("pos_sym_in_narrative",request.getParameter("posy"));
	fieldsObj.put("neg_sym_in_narrative",request.getParameter("negsym"));
	fieldsObj.put("chronology", request.getParameter("chronology"));
	fieldsObj.put("other_medical_info", request.getParameter("medinfo"));
	fieldsObj.put("enable_ICD", request.getParameter("icd"));
	fieldsObj.put("review_all_audio", request.getParameter("audioreview"));
	fieldsObj.put("duration_of_interview", request.getParameter("duration"));
	fieldsObj.put("audio_quality", request.getParameter("audioquality"));
	//System.out.println("request.getParameter()"+request.getParameter("audioquality"));
	fieldsObj.put("feedback", request.getParameter("feedback"));
	fieldsObj.put("reviewer",username);
	fieldsObj.put("supervisor_feedback",request.getParameter("supervisor_feedback"));
	//fieldsObj.put("probing_feedback", request.getParameter("profb"));
	JSONArray ja= new JSONArray(request.getParameter("positivesymptoms"));
	JSONObject str=new JSONObject();
	JSONObject probing = new JSONObject();
	int included=0;
	int missing=0;
	for(int i=0;i<ja.length();i++){
		String symp=ja.getString(i);
		String probedValue=request.getParameter(symp+"probed");
		String durationValue=request.getParameter(symp+"duration");
		JSONObject probedObj = new JSONObject();
		
		//str.put(symp,value);
		//probing.put(symp,probed);
		probedObj.put("probed","");
		
		probedObj.put("duration","");
			 if(probedValue!=null && !probedValue.equals("") ){
				 probedObj.put("probed",probedValue);
		included++;
			 }
		
			if(durationValue!=null && !durationValue.equals("")){
				probedObj.put("duration",durationValue);
			missing++; }
			probing.put(symp,probedObj);
		
	}
	
	posymObj.put("deathId", request.getParameter("deathId"));
	posymObj.put("probing",probing.toString());
	posymObj.put("included",included+"");
	posymObj.put("missing", missing+"");
	
	
	System.out.println("---positivesymptoms------"+posymObj);
	
	int totalProbingScore=0;
try{
	totalProbingScore=op.scoreProbing(probing,ja);


}
catch(Exception e)
{
e.printStackTrace();
}
	JSONObject scale_yn=new JSONObject("{'yes':2,'no':0}");
	JSONObject scale_ynp=new JSONObject("{'yes':2,'partially':1,'no':0}");
	int q1score=op.score(fieldsObj.getString("pos_sym_in_narrative"),scale_yn );
	
	int q3score=op.score(fieldsObj.getString("chronology"),scale_ynp );
	int q4score=op.score(fieldsObj.getString("neg_sym_in_narrative"),scale_ynp);
	int q5score=op.score(fieldsObj.getString("other_medical_info"),scale_ynp);
	
	int q6score=op.score(fieldsObj.getString("enable_ICD"),scale_ynp);
	int q7score=op.score(fieldsObj.getString("review_all_audio"),scale_ynp);
	int totalScore= q1score+totalProbingScore+q3score+q4score+q5score+q6score+q7score;
	
	
	String narrFeedback="";
	if(totalScore >=0 && totalScore <= 5)
		narrFeedback="Unacceptable";
	if(totalScore >=6 && totalScore <=9)
		narrFeedback="Weak";
	if(totalScore >=10 && totalScore <=12)
		narrFeedback="Good but need improvement";;
	if(totalScore >=13 && totalScore <=14)
		narrFeedback="Excellent";
	
	JSONObject scoresObj=new JSONObject();
	scoresObj.put("q1",q1score);scoresObj.put("q2", totalProbingScore);scoresObj.put("q3",q3score);
	scoresObj.put("q4",q4score);scoresObj.put("q5",q5score);scoresObj.put("q6",q6score);scoresObj.put("q7",q7score);
	scoresObj.put("totalscore",totalScore);//scoresObj.put("narr_fb", narrFeedback);
	String scores=scoresObj.toString();
	posymObj.put("scores", scores);
	posymObj.put("narr_fb", narrFeedback);
	
	int j=op.updatePositiveSymptoms(posymObj);
	int i=op.updateNarrativeScore(fieldsObj);
	
	if(i==1 & j==1){
		int res=1;
		%>
		<script>
		
		window.open("view_narrative.jsp?deathId=<%=deathId%>&res=<%=res%>","_self");
		</script>
		<%
	}
	

%>

</body>
</html>