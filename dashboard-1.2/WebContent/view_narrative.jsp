<%@page import="database.GenerateDashboardData"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="jsonutils.DataUtil"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.shiro.*"%>
<%@page import="org.apache.shiro.subject.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
		 <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.bundle.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
 <link rel="stylesheet" href="style.css">
 <!--  <link rel="stylesheet" href="modal1.css"> -->
 <script src="js/scores.js"></script>
  <style>
  #wrappper{
  
  background-color:white;
  	color:black;
    height:800px;
  }
  hr {
    overflow: visible; /* For IE */
    height: 30px;
    border-style: solid;
    border-color: black;
    border-width: 1px 0 0 0;
    border-radius: 20px;
}
hr:before { /* Not really supposed to work, but does */
    display: block;
    content: "";
    height: 30px;
    margin-top: -31px;
    border-style: solid;
    border-color: black;
    border-width: 0 0 1px 0;
    border-radius: 20px;
}
  #geninfo {
  clear:left;
}
#narrative {
 /* border-style: solid;
  border-color:grey; */
  	background-color:white;
  	color:black;
  	font:white;
    margin-right: auto;
    margin-top: 20 px;
    box-shadow: #254C58 1px 0px;
    border: # 3 C7D91 5 px double;
    padding: 10 px 10 px 10 px 10 px;
    overflow-y: scroll;
   width:35%;
     float:right;
     clear:right;
}
#audio {
 /* border-style: solid; */
 /*  border-color: grey; */
color:black;
    margin-right: auto;
    margin-top: 20 px;
    box-shadow: #254C58 1px 0px;
    border: # 3 C7D91 5 px double;
    padding: 10 px 10 px 10 px 10 px;
    overflow-y: scroll;
  width:35%;
     float:right;
     clear:right;
}
#questions{
background-color:white;
 border-style:groove; 
  border-color:white;
width:65%;
float:left;
clear:left;
}
::-webkit-scrollbar {
width: 8px;
height: 12px;
}

::-webkit-scrollbar-track {
 box-shadow: inset 0 0 10px lightgrey;
border-radius: 10px;
}

::-webkit-scrollbar-thumb {
border-radius: 10px;
background: lightgrey; 
box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
}

th{
background-color:white;
color:black;
word-break:break-all;

}
td.q1{
text-align:center;
}
label{
background-color:white;
color:black;
font-size:15;/* 
width:500px;  */
}
#label1{
text-align:center;
}
  </style>
 
 
</head>
<body>
<%
String res=null;
if(request.getParameter("res")!=null)
 res=request.getParameter("res");	
%>
		<script>
		var res="<%=res%>";
		if(res==1){
		 alert("scores appended successfully...");
		}
		</script>
		
<script>
function toJSONString( form ) {
	var obj = {};
	var elements = form.querySelectorAll( "input, select, textarea, radio" );
	for( var i = 0; i < elements.length; ++i ) {
		var element = elements[i];
		var name = element.name;
		var value = element.value;

		if( name ) {
			obj[ name ] = value;
		}
	}
    alert(JSON.stringify( obj ));
	return JSON.stringify( obj );
}

</script>

<%
DataUtil du=new DataUtil();
String deathId=null;
if(request.getParameter("deathId")!=null){
 	deathId=request.getParameter("deathId");
}

String query="select summary from narrative where deathid="+deathId+"";
String query11="select * from selected_narrative";;

/* String rescodQuery="select d.assignedto surveyor,a.deathId,d.areaId areaId,concat(age_value,' ',age_unit)age,sex,Date(a.starttime) interview_date,timediff(f.timelog,a.starttime) duration_of_interview,na.summary narrative,ps.summary positive_symptoms 
 ,if(f.deathId is not null,'complete','pending') interview_status, if(b.deathId is not null ,
 cCod,if(ne.deathId is not null ,respodentThinkCod,aRespCod)) rescod,if(b.deathId is not null ,
 "child",if(ne.deathId is not null ,"neonate","adult")) type1
 from  deathDetail a left join va_child  b on a.deathId=b.deathId left join 
va_neonate ne on a.deathId=ne.deathId left join va_adult ad on a.deathId=ad.deathId
 left join death d on a.deathId
=d.deathId left join narrative na on a.deathId=na.deathId left join positiveSymptoms ps on a.deathId=ps.deathId
 left join feedback f on a.deathId=f.deathId   where na.deathId is not null and areaId <700 ;

 */
  GenerateDashboardData gd=new GenerateDashboardData();
 gd.datasource="partner";
 GenerateDashboardData.confirgPath=request.getRealPath("/")+"/dashboards";
 // doing left join with selected narrative table instead right join no problem because we have where  condition death=''
  String query2="select * from narrative_review n left join surveyor s on n.surveyor=s.id left join selected_narrative sn on n.deathId=sn.deathId where n.deathId="+deathId+""; 
JSONObject obj=gd.getReportData("data",query2);
 
 //JSONObject obj11=gd.getReportData("data",query11);
 //System.out.println("obj11---"+obj);
 //System.out.println("obj1s1111---"+obj11);
 
 String narrative=du.getObjectValue(obj,"narrative");
 String areaId=du.getObjectValue(obj, "areaId");
 String areaName=du.getObjectValue(obj, "area_name");
 String surveyor=du.getObjectValue(obj, "username");
 String age=du.getObjectValue(obj, "age");
 String type=du.getObjectValue(obj, "type1");
 String sex=du.getObjectValue(obj, "sex");
 String interviewDate=du.getObjectValue(obj, "interview_date");
 String ps=du.getObjectValue(obj, "positive_symptoms");
 String physician_keywords=du.getObjectValue(obj, "physician_keywords");
 String phy1="NA";
 String phy2="NA";
 if(!physician_keywords.equals("")){
 //System.out.println("physician_keywords ------"+physician_keywords);
 String keywords[]=physician_keywords.split("@#");
 int len=keywords.length;
 
 
 if(len==2){
 phy1=keywords[0];
 phy2=keywords[1];
 }
 else{
	 phy1=keywords[0];
	 phy2="NA";
 }
 
 if(phy1.length()==0)
	 phy1="NA";
 if(phy2.length()==0)
	 phy2="NA";
 }
 JSONArray psJ= new JSONArray(ps);
 int totalPS=psJ.length();
 String rescod=du.getObjectValue(obj, "rescod");
 String popsym="";
 for(int i=0;i<psJ.length();i++){
	popsym+="<br>"+psJ.getString(i); 
 }
 String matching_status="";
		 if(obj.getJSONArray("values").getJSONObject(0).has("matching_status")){
			 matching_status=du.getObjectValue(obj,"matching_status");
		 }
System.out.println("-------matching_status--------"+matching_status);		 
 String chronology="";
		 if(obj.getJSONArray("values").getJSONObject(0).has("chronology")){
			 chronology=du.getObjectValue(obj,"chronology");
		 }		 
		 System.out.println("-----chronology----------"+chronology);	
 String feedback="";
		 if(obj.getJSONArray("values").getJSONObject(0).has("feedback")){
			 feedback=du.getObjectValue(obj,"feedback");
		 }
		
String quality_of_narrative="";
		 if(obj.getJSONArray("values").getJSONObject(0).has("quality_of_narrative")){
			 quality_of_narrative=du.getObjectValue(obj,"quality_of_narrative");
		 }		 
		 System.out.println("-----quality_of_narrative----------"+quality_of_narrative);
String pos_sym_in_narrative="";
if(obj.getJSONArray("values").getJSONObject(0).has("pos_sym_in_narrative")){
	pos_sym_in_narrative=du.getObjectValue(obj,"pos_sym_in_narrative");
}
System.out.println("-------pos_sym_in_narrative--------"+pos_sym_in_narrative);		 
String neg_sym_in_narrative="";
if(obj.getJSONArray("values").getJSONObject(0).has("neg_sym_in_narrative")){
	neg_sym_in_narrative=du.getObjectValue(obj,"neg_sym_in_narrative");
}
System.out.println("-------neg_sym_in_narrative--------"+neg_sym_in_narrative);		 
String other_medical_info="";
if(obj.getJSONArray("values").getJSONObject(0).has("other_medical_info")){
	other_medical_info=du.getObjectValue(obj,"other_medical_info");
}
System.out.println("-------other_medical_info--------"+other_medical_info);		 
String enable_ICD="";
if(obj.getJSONArray("values").getJSONObject(0).has("enable_ICD")){
	enable_ICD=du.getObjectValue(obj,"enable_ICD");
}
System.out.println("-------enable_ICD--------"+enable_ICD);		 
String review_all_audio="";
if(obj.getJSONArray("values").getJSONObject(0).has("review_all_audio")){
	review_all_audio=du.getObjectValue(obj,"review_all_audio");
}
System.out.println("-------review_all_audio--------"+review_all_audio);		 
String duration_of_interview="";
if(obj.getJSONArray("values").getJSONObject(0).has("duration_of_interview")){
	duration_of_interview=du.getObjectValue(obj,"duration_of_interview");
}
System.out.println("-------duration_of_interview--------"+duration_of_interview);		 
String probing="";
probing=du.getObjectValue(obj,"probing");
JSONObject probingObj=new JSONObject();

if(probing!=null && !probing.equals(""))
		probingObj=new JSONObject(probing);

//System.out.println("probingObj--"+probingObj+"-----probing---"+probing);
String probing_feedback="";
if(obj.getJSONArray("values").getJSONObject(0).has("probing_feedback")){
	probing_feedback=du.getObjectValue(obj,"probing_feedback");
}


String score="";String narrFeedback="";
String audioquality="";
JSONObject scores=new JSONObject();
if(obj.getJSONArray("values").getJSONObject(0).has("scores")){
	score=du.getObjectValue(obj,"scores");
	scores=new JSONObject(score);
/* if(scores.has("narr_fb"))
narrFeedback=scores.getString("narr_fb"); */

}
if(obj.getJSONArray("values").getJSONObject(0).has("narr_fb")){

	narrFeedback=du.getObjectValue(obj,"narr_fb");
}

if(obj.getJSONArray("values").getJSONObject(0).has("audio_quality")){

	audioquality=du.getObjectValue(obj,"audio_quality");
}
String supervisor_feedback="";
System.out.println("qualityaudio----"+audioquality);
if(obj.getJSONArray("values").getJSONObject(0).has("supervisor_feedback")){
	supervisor_feedback=du.getObjectValue(obj,"supervisor_feedback");
}
%>

<%
Subject subj=SecurityUtils.getSubject();
String user=subj.getPrincipal().toString();
System.out.println("subj----"+subj.hasRole("reviewer"));
%>


<div id="geninfo" class="container" >
<table >
   <tr>
   
      <td align=left> <a id="backbtn" href="survey_monitoring_dashboard.jsp?tabs=reports" class=" btn  btn-info navbar-btn">Back</a></td>
   
       </tr></table>	

<table id="table" class='table table-striped'>
<tr><th colspan="9" style="text-align:center"><label id="heading" style="font-size:40px; background-color:red;color:white">Narrative Quality Review</label></th>
<tr><th >Surveyor</th><th>Area</th><th>Area ID</th><th>Age</th><th>Questionnaire</th><th>Sex</th><th>Interview Date</th><th>Respondent COD</th><th>Interview Duration</th></tr>
<tr><td><%=surveyor%></td><td><%=areaName%></td><td><%=areaId%></td><td><%=age%></td><td><%=type%></td><td><%=sex%></td><td><%=interviewDate%></td><td><%=rescod%></td><td><%=duration_of_interview%> mins</td></tr>
</table>
<table id="table1" class='table table-striped'>
<tr><th style="text-align:center" colspan=2>Physician Keywords</th></tr>
<tr><th>Phy-1</th><th>Phy-2</th></tr>
<tr><td style="word-wrap:break-word;"><%=phy1%></td><td style="word-wrap:break-word;"><%=phy2%></td></tr>
</table>
<hr></hr>
</div>
 
 <div id=wrappper class="container" >

<div id="narrative" class="container" align="center">
<br>
<p style="font-size:15px;color:black;background-color:lightgrey;" class="form-group" for="narrative"><b>Narrative</b></p>
<p align="right"><%=narrative%></p>
</div>

  
<div id="questions" class="container" align="center" class="border border-primary">
<form action="crudoperations.jsp" method="post" name="narrform">
<input type="hidden" name="deathId" id="deathId" value="<%=deathId%>">
<input type="hidden" name="positivesymptoms" id="positivesymptoms" value='<%=ps%>'>
<input type="hidden" name="included" id="included">
<input type="hidden" name="missing" id="missing">
<table id="table0"  border=2 style="border:5px" class='table table-striped' name=table0><tr><th>
<!-- <p align="center"><label style="font-size:15px;align:center; color:white;background-color:pink" class="form-group" for="posy">Questions</label></p><br> -->
<label  class="form-group" for="posy">Q1 Does the narrative have positive key symptoms?</label></th><td>
<input  type="radio" class="radio-inline" name="posy" value="yes" required> Yes &nbsp;&nbsp;<input type="radio" class="radio-inline" name="posy" value="no"  required> No<br>
<br></td></tr></table>

<table id="posytable"  border=2 style="border:5px" class='table table-striped' name=positivesymptom >
<tr><th colspan="3"><label  style="text-align:left" class="form-group" for="q2" >Q2 Has each key symptom been thoroughly probed?</label></th></tr>
</table><br>

<!-- <table id="probingfeedback"  border=2 style="border:5px" class='table table-striped' name=probingfeedback>
<tr><th><label  class="form-group" for="probingfeedback">was positive symptoms probed properly?</label></th><td >
<input  type="radio" class="radio-inline" name="profeedback" value="yes" required> Yes &nbsp;&nbsp;<input type="radio" class="radio-inline" name="profeedback" value="partially" required > Partially &nbsp;&nbsp;<input type="radio" class="radio-inline" name="profeedback" value="no" required> No<br>
</td></tr>
</table> -->


<!-- <span style="font-size:15px;float:left" class="btn btn-default"  id="opentable" onclick="diplayQuestion2Table()"> Click to open and fill the table</span><br> -->
<!-- <span class="btn btn-warning"  style="display:none" id="closetable" onclick="closeQuestion2Table()"> Close table</span><br> -->
<table id="table1"  border=2 style="border:5px" class='table table-striped' name=table1>
<tr><th>
<label class="form-group" for="chronology">Q3 Did the surveyor write the narrative in clear chronological order?</label>
</th>
<td>
<input type="radio" class="radio-inline" name="chronology" value="yes"  required> Yes &nbsp;&nbsp;<input type="radio" class="radio-inline" name="chronology" value="partially"   required > Partially &nbsp;&nbsp;<input type="radio" class="radio-inline" name="chronology" value="no" id="chronologyno"  onclick="getscore(this.id)" required > No<br>
</td></tr>
<tr>
<th>
<label  class="form-group" for="negsym">Q4 Were the negative symptoms stated in the narrative?</label>
</th>
<td>
<input type="radio" class="radio-inline" name="negsym" value="yes" required > Yes &nbsp;&nbsp;<input type="radio" name="negsym" class="radio-inline" value="partially" required> Partially &nbsp;&nbsp;<input type="radio" class="radio-inline" name="negsym" value="no" required> No<br>
<br>
</td></tr><tr>
<th>
<label  class="form-group" for="medinfo">Q5 Was extra medical information captured?</label></th>
<td>
<input type="radio" class="radio-inline" name="medinfo" value="yes" required> Yes &nbsp;&nbsp;<input type="radio" name="medinfo" class="radio-inline" value="partially" required> Partially &nbsp;&nbsp;<input type="radio" class="radio-inline" name="medinfo" value="no"  required > No<br>
<br></td></tr><tr>
<th>
<label  class="form-group" for="icd">Q6 Does the narrative enable appropriate assignment of the COD?</label></th>
<td>
<input type="radio" class="radio-inline" name="icd" value="yes"  required> Yes &nbsp;&nbsp;<input type="radio" class="radio-inline" name="icd" value="no" required> No<br>
<br></td></tr><tr><th >
<label  class="form-group" for="audioreview">Q7 Do the audio files match the narrative?</label></th><td>
<input type="radio" class="radio-inline" name="audioreview" value="yes" required> Yes &nbsp;&nbsp;<input type="radio" name="audioreview"  class="radio-inline" value="no" required> No<br>
<br></td></tr></table>
<table id="totalscore"  border=2 style="border:5px" class='table table-striped' name="totalscore">
<tr><th colspan="8"><label  class="form-group" for="totalscore">You have given this narrative the following score. Would you like to add any additional feedback?</label></th></tr>
<tr><th>Q1</th><th>Q2</th><th>Q3</th><th>Q4</th><th>Q5</th><th>Q6</th><th>Q7</th><th>Total Score</th></tr>

<tr><td id="q1"><b><%=scores.optInt("q1")%></b></td><td id="q2"><b><%=scores.optInt("q2")%></b></td><td id="q3"><b><%=scores.optInt("q3")%></b></td><td id="q4"><b><%=scores.optInt("q4")%></b></td><td id="q5"><b><%=scores.optInt("q5")%></b></td><td id="q6"><b><%=scores.optInt("q6")%></b></td><td id="q7"><b><%=scores.optInt("q7")%></b></td><td><b><%=scores.optInt("totalscore")%></b></td></tr>
<tr><th colspan="2"><label  class="form-group" for="feedback">Feedback:</label></th>
<td colspan="6" style="text-align:center"> <span class="border border-primary"><b><%=narrFeedback%></b></span><br></td></tr>
</table>
<table id="feedbacktabble"  border=2 style="border:5px" class='table table-striped' name="feedbacktabble"><tr>
<th><label  class="form-group" for="audiorating">How do you rate quality of the audio?</label></th>
<td  style="text-align:center">
<input type="radio" class="radio-inline" name="audioquality" value="good"  required> Good &nbsp;&nbsp;
<input type="radio" class="radio-inline" name="audioquality" value="poor"   required > Poor </td>
<tr>
 <th><label  class="form-group" for="feedback">Additional Feedback</label></th><td  style="text-align:center">
<textarea name="feedback" id="feedback" rows="3" cols="50"   placeholder="Add details that will help the surveyor improve their work. If you think this narrative would be useful for training purposes (good and bad narratives), Please write For Training"></textarea>
</td></tr>
<%

if(subj.hasRole("supervisor")||subj.hasRole("reviewer")||subj.hasRole("admin")){

%>
<tr>
 <th><label  class="form-group" for="supervisorfeedback">Supervisor Feedback</label></th><td  style="text-align:center">
<textarea name="supervisor_feedback" id="supervisor_feedback" rows="3" cols="50"   placeholder="please write feedback"></textarea>
</td></tr>
<%
}
%>
<%-- <th><label  class="form-group" for="feedback">Feedback</label></th>
<td> <span><b><%=narrFeedback%></b></span><br></td>
 --%>
<tr><td colspan="3" style="text-align:right">
<input type="submit" class="btn btn-info" name="submit" value="submit"></td></tr>

  </table>
</form>
 <!-- <button class="btn btn-info" id="myBtn">Open Modal</button> -->

</div>
<div id="audio" class="container" align="center">
<br>

<input type="hidden" name="deathId" id="deathId" value="<%=deathId%>">
 
 <p style="font-size:15px;color:black;background-color:lightgrey;" class="form-group" for="audio"><b>Audio</b></p>

    <!--Add buttons to initiate auth sequence and sign out-->
    <button class="btn btn-warning" id="authorize_button" style="display: none;">Authorize</button>
    <button class="btn btn-warning" id="signout_button" style="display: none;">Sign Out</button>

    <div id="content" style="white-space: pre-wrap;"></div>
 <br>
 
 </div>

  </div> 
    
  <br>
  
  <script>
  
  <%
  if(request.getParameter("param")!=null)
	    {
  %>

//alert(param);
//if(param!=null){
	document.getElementById("questions").style.display="none";
	 document.getElementById("narrative").style.width="100%";
	document.getElementById("audio").style.width="100%";
	document.getElementById("heading").innerHTML="View Narrative and Audio";
	document.getElementById("backbtn").href="survey_monitoring_dashboard.jsp?tabs=training";
//}

<%
  }
%>

</script>
 <script>
//document.getElementById("totalscore").display='none';
function setValue(name,value)
{
var idx=0;
var ctrls=document.forms[0].elements[name];
//alert(name+"------"+value);
for(var i=0; i<ctrls.length;i++)
	{
	//alert(ctrls[i].value)
	if(ctrls[i].value==value)
		ctrls[i].checked=true;
	}
	
}

	var tableSize=<%=totalPS%>;
	var data=<%=psJ%>;
	var str=document.getElementById("posytable").innerHTML;
	//contenteditable='true' for td to make editable
	str+="<tr><th align='center'>Positive Key Symptoms</th><th align='center'>Was the symptom probed well?</th><th align='center'>Was the duration included?</th></tr>";
	for(var i=0;i<data.length;i++){
		
		/* str+="<tr><td>"+data[i]+"</td><td align='right'><input type='radio' class='radio-inline' name='"+data[i]+"include' value='yes' required>&nbsp;Included&nbsp;&nbsp;<input align='right' type='radio' class='radio-inline' name='"+data[i]+"include' value='partially' required>&nbsp;partially&nbsp;&nbsp;<input align='right' type='radio' class='radio-inline' name='"+data[i]+"include' value='no' required>&nbsp;Missing&nbsp;&nbsp;&nbsp;</td></tr>" */
		/* str+="<tr><td>"+data[i]+"</td><td align='center'><textarea align='center'  name='"+data[i]+"include' id='"+data[i]+"include' rows='2' cols='20' required></textarea></td><td><textarea align='center'  name='"+data[i]+"missing' id='"+data[i]+"missing' rows='2' cols='20' required></textarea></td></tr>" */
		str+="<tr><td>"+data[i].toUpperCase()+"</td><td><input type='radio' class='radio-inline' name='"+data[i]+"probed'  value='yes'  required>&nbsp;yes&nbsp;&nbsp;&nbsp;<input align='right' type='radio' class='radio-inline' name='"+data[i]+"probed'  value='no'  required>&nbsp;&nbsp;no&nbsp;&nbsp;</td><td><input type='radio' class='radio-inline' name='"+data[i]+"duration'   value='yes'  required>&nbsp;&nbsp;yes&nbsp;&nbsp;<input align='right' type='radio' class='radio-inline' name='"+data[i]+"duration'   value='no'  required>&nbsp;&nbsp;no</td></tr>";
	}
	/* str+="<tr><th>Was symptoms probed properly?</th><td> <input type='radio' class='radio-inline' name='probfeedback' value='yes' required> Yes</td><td> <input type='radio' class='radio-inline' name='probfeedback' value='partially' required > Partially </td><td><input type='radio' class='radio-inline' name='probfeedback' value='no' required > No</td></tr>" */
	document.getElementById("posytable").innerHTML=str;	
	//alert(JSON.stringify(str));
	/* document.getElementById("opentable").style.display="none"; */
	



</script>

<script>


var selected;


var probingScores=[];

function narrFeedback(){
	
}

//document.getElementById("first").innerHTML=narrative;

/* var ms=document.getElementById("matchingstatus");
generateSelectTag(ms,matching_status,"matchingstatus");


var qofn=document.getElementById("qualityofnarrative");
generateSelectTag(ms,quality_of_narrative,"qualityofnarrative");
 */

//function to display select tag with value fetching from database
function generateSelectTag(data,variable,id){
	var str="";
	var len=data.length;
	for(var i=0;i<len;i++){
		if(variable==data[i].value)
			selected="selected";
		
		else
			selected="";
		
		str+="<option "+selected+">"+data[i].value+"</option>";
	}
	document.getElementById(id).innerHTML=str;

}
 /* function getscores(f){
		var question=scoreQuestions.questions;
	alert("question-----"+JSON.stringify(question));
	for(obj in question){
		
		q=document.getElementById(obj).innerHTML;
		alert(obj)
		alert(q);
		document.getElementById(obj).innerHTML=q;
	}	
} */
function getscore(name,id){
		//alert(id);
		//alert(name);
	var val=document.getElementById(id).value;
	//alert(id);
	//alert(val)
	
	
	var question=scoreQuestions.questions;
	//alert(question.name.yes);
	
	for(obj in question){
		//alert("obj---"+JSON.stringify(obj.id));
		
	}
	
	/* alert(q);
	document.getElementById(obj).innerHTML=q; */
}	

 

//document.getElementById("chronology").innerHTML=chronology;
 //document.getElementById("feedback").innerHTML=feedback;
 <%-- var narrative="<%=narrative%>"; --%>
 var feedback="<%=feedback%>";
 var pos_sym_in_narrative="<%=pos_sym_in_narrative%>";
 var neg_sym_in_narrative="<%=neg_sym_in_narrative%>";
var other_medical_info="<%=other_medical_info%>"; 
var chronology="<%=chronology%>";
var enable_ICD="<%=enable_ICD%>";
var review_all_audio="<%=review_all_audio%>";
var duration_of_interview="<%=duration_of_interview%>";
var psObj=<%=psJ%>
var probing=<%=probingObj%>;
var probing_feedback="<%=probing_feedback%>";
var audio_quality="<%=audioquality%>";

var supervisor_feedback="<%=supervisor_feedback%>";

setValue("posy",pos_sym_in_narrative);
setValue("negsym",neg_sym_in_narrative);
setValue("medinfo",other_medical_info);
setValue("chronology",chronology);
setValue("icd",enable_ICD);
setValue("audioreview",review_all_audio);
setValue("audioquality",audio_quality);

//setValue("profeedback",probing_feedback);
var included=0;
var missing=0;
if(probing !=null)
	{
	//alert(JSON.stringify(probing));
for(var i=0;i<psObj.length;i++)
{
	var fld=psObj[i]+"probed";
	var fld1=psObj[i]+"duration";
	console.log(fld);
	console.log("probing."+psObj[i]);
	console.log(eval("probing."+psObj[i]));
	
	//setValue(fld,eval("probing."+psObj[i]+".probing.included"));
	//var probedVal=eval("probing."+psObj[i]+".probed");
	//var durationVal=eval("probing."+psObj[i]+".duration");
	
	//document.getElementById(fld).value=probedVal;
	//document.getElementById(fld1).value=durationVal;
	//alert(eval("probing."+psObj[i]+".probed"));
	setValue(fld,eval("probing."+psObj[i]+".probed"));
	
	setValue(fld1,eval("probing."+psObj[i]+".duration"));
	
	//setValue(fld1,eval("probing."+psObj[i]+".probing.missing"));
	}
	}	
	//alert(included+"--"+missing);
//document.getElementById("included").value=included;
//document.getElementById("missing").value=missing;
//alert(document.getElementById("feedback"));
document.getElementById("feedback").value=feedback;
document.getElementById("supervisor_feedback").value=supervisor_feedback;

//getscores(0);
</script>
<script>

</script>

 <script type="text/javascript">
      // Client ID and API key from the Developer Console
      var CLIENT_ID = '28982321693-0kavr7jou4u5tve867ue13su23gckq8a.apps.googleusercontent.com';
      var API_KEY = 'AIzaSyCy_TfHl52tsnytW90iR1b8U1Dl-iOB6eY';

      // Array of API discovery doc URLs for APIs used by the quickstart
      var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/drive/v3/rest"];

      // Authorization scopes required by the API; multiple scopes can be
      // included, separated by spaces.
      var SCOPES = 'https://www.googleapis.com/auth/drive.metadata.readonly';

      var authorizeButton = document.getElementById('authorize_button');
      var signoutButton = document.getElementById('signout_button');

      /**
       *  On load, called to load the auth2 library and API client library.
       */
      function handleClientLoad() {
        gapi.load('client:auth2', initClient);
      }

      /**
       *  Initializes the API client library and sets up sign-in state
       *  listeners.
       */
      function initClient() {
        gapi.client.init({
          apiKey: API_KEY,
          clientId: CLIENT_ID,
          discoveryDocs: DISCOVERY_DOCS,
          scope: SCOPES
        }).then(function () {
          // Listen for sign-in state changes.
          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);

          // Handle the initial sign-in state.
          updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
          authorizeButton.onclick = handleAuthClick;
          signoutButton.onclick = handleSignoutClick;
        }, function(error) {
          appendPre(JSON.stringify(error, null, 2));
        });
      }

      /**
       *  Called when the signed in status changes, to update the UI
       *  appropriately. After a sign-in, the API is called.
       */
      function updateSigninStatus(isSignedIn) {
        if (isSignedIn) {
          authorizeButton.style.display = 'none';
          signoutButton.style.display = 'block';
          listFiles();
        } else {
          authorizeButton.style.display = 'block';
          signoutButton.style.display = 'none';
        }
      }

      /**
       *  Sign in the user upon button click.
       */
      function handleAuthClick(event) {
        gapi.auth2.getAuthInstance().signIn();
      }

      /**
       *  Sign out the user upon button click.
       */
      function handleSignoutClick(event) {
        gapi.auth2.getAuthInstance().signOut();
      }
      
      
      
      
      
      /**
       * Append a pre element to the body containing the given message
       * as its text node. Used to display the results of the API call.
       *
       * @param {string} message Text to be placed in pre element.
       */
      function appendPre(message) {
var str=content.innerHTML;
str+="<br>"+message;
       // var pre = document.getElementById('content');
        //var textContent = document.createTextNode(message + '\n');
       // pre.appendChild(textContent);
content.innerHTML=str;
      }
       
       function appendPre1(message) {
    	   var str=content.innerHTML;
    	   str+="<br>"+message;
    	          // var pre = document.getElementById('content');
    	           //var textContent = document.createTextNode(message + '\n');
    	          // pre.appendChild(textContent);
    	   content.innerHTML=str;
    	         }
      /**
       * Print files.
       */
      function listFiles() {
        gapi.client.drive.files.list({
          'pageSize': 100,
q:"name contains '<%=deathId%>'",
          'fields': "nextPageToken, files(id, name)"
        }).then(function(response) {
          appendPre('Files:');
          var files = response.result.files;
          if (files && files.length > 0) {
            for (var i = 0; i < files.length; i++) {
              var file = files[i];
             if(file.name.split("\.")[1]=="wav")
            	 var name=file.name.split("\.")[0];
             var filename=name.split("_")[1];
              appendPre(filename + '   <iframe src="https://drive.google.com/file/d/'+file.id+'/preview" width="300" height="50"></iframe>');
            }
          } else {
            appendPre('No files found.');
          }
        });
      }

    </script>


 <script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>
    
 
</body>
</html>