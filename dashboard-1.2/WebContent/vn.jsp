<%@page import="database.GenerateDashboardData"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="jsonutils.DataUtil"%>
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
  <style>
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
  clear:both;
}
#first {
  	background-color:white;
  	color:grey;
  	font:white;
    height:200px;
    margin-right: auto;
    margin-top: 20 px;
    box-shadow: #254C58 1px 0px;
    border: # 3 C7D91 5 px double;
    padding: 10 px 10 px 10 px 10 px;
    overflow-y: scroll;

}
::-webkit-scrollbar {
width: 8px;
height: 12px;
}

::-webkit-scrollbar-track {
box-shadow: inset 0 0 10px olivedrab;
border-radius: 10px;
}

::-webkit-scrollbar-thumb {
border-radius: 10px;
background: grey; 
box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
}
#second {
  background-color:white;
 /*  width:40%;
  float:right; */
}
#posym {
  background-color:white;
 /*  width:30%;
  float:left; */
}
#list{
background-color:white;
 /*  width:30%;*/
 
  align:center; 
}
#ch{
background-color:white;
 /*  width:30%;*/
  float:right; 
}
#fb{
background-color:white;
 /*  width:30%;*/
  float:right; 
}
th{
background-color:pink;
color:black;
word-break:break-all;
}
  </style>
 
 
</head>
<body>
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
String query11="select * from narrative_review";;

/* String rescodQuery="select d.assignedto,a.deathId,Date(a.starttime) interview_date,na.summary narrative,"+
"ps.summary positive_symptoms ,if(f.deathId is not null,'complete','pending') interview_status, if(b.deathId is not null ,cCod,"+
		"if(ne.deathId is not null ,respodentThinkCod,aRespCod)) rescod,if(b.deathId is not null ,"+
			"	'child',if(ne.deathId is not null ,'neonate','adult')) type1"+
"from  deathDetail a left join va_child  b on a.deathId=b.deathId left join "+
"va_neonate ne on a.deathId=ne.deathId left join va_adult ad on a.deathId=ad.deathId left join death d on a.deathId"+
"=d.deathId left join narrative na on a.deathId=na.deathId left join positiveSymptoms ps on a.deathId=ps.deathId"+
"left join feedback f on a.deathId=f.deathId   where na.deathId is not null and areaId <700  and a.deathId='"+deathId+"'";
 */
  GenerateDashboardData gd=new GenerateDashboardData();
 gd.datasource="partner";
 GenerateDashboardData.confirgPath=request.getRealPath("/")+"/dashboards";
 String query2="select * from narrative_review n left join surveyor s on n.surveyor=s.id where deathId="+deathId+"";
 JSONObject obj=gd.getReportData("data",query2);
 //JSONObject obj11=gd.getReportData("data",query11);
 System.out.println("obj11---"+obj);
 
 String narrative=du.getObjectValue(obj,"narrative");
 String areaId=du.getObjectValue(obj, "areaId");
 String surveyor=du.getObjectValue(obj, "username");
 String age=du.getObjectValue(obj, "age");
 String sex=du.getObjectValue(obj, "sex");
 String interviewDate=du.getObjectValue(obj, "interview_date");
 String ps=du.getObjectValue(obj, "positive_symptoms");
 JSONArray psJ= new JSONArray(ps);
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
/* String query1="select summary from positiveSymptoms where deathId="+deathId+"";

JSONObject narrObj=new GenerateDashboardData().getReportData("narrative",query);
String narrative=du.getObjectValue(narrObj,"summary");
JSONObject posymObj=new GenerateDashboardData().getReportData("possitiveSymptoms",query1); */

//JSONObject resCodObj=new GenerateDashboardData().getReportData("rescod",rescodQuery);
/* String resCod=du.getObjectValue(resCodObj, "rescod");
*/


//String positiveSymptoms=du.getObjectValue(posymObj,"summary");
//System.out.println("positiveSymptoms---"+positiveSymptoms);
//System.out.println("narrative--"+narrObj.getJSONArray("values").getJSONObject(0).getString("summary"));
//String narrative=narrObj.getJSONArray("values").getJSONObject(0).getString("summary");
//String positiveSymptoms=posymObj.getJSONArray("values").getJSONObject(0).getString("summary");

%>
<!-- <frameset cols="30%,*">
<frame src="">
<frame src="">
</frameset>	 -->
<div id="geninfo" class="container"  align="center">
<table width=100%>
   <tr>
   
     <td align=left> <a  href="survey_monitoring_dashboard.jsp?tabs=reports" class=" btn  btn-info navbar-btn">Back</a></td>
   
       </tr></table>
<label style="font-size:40px; color:red">View and score Narrative</label><br>


<table id="table" class='table table-striped'>
<tr><th >Surveyor</th><th>AreaId</th><th>Age</th><th>Sex</th><th>Interview Date</th><th>Respondent COD</th><th>Positive Symptoms</th></tr>
<tr><td><%=surveyor%></td><td><%=areaId%></td><td><%=age%></td><td><%=sex%></td><td><%=interviewDate%></td><td><%=rescod%></td><td><%=popsym%></td></tr>
</table>
<hr></hr>
<p style="font-size:15px;color:black;background-color:pink;" class="form-group" for="narrative"><b>Narrative</b></p>
<div id="first" class="container"><p id="hh"> </p></div>

<div id="second" class="container" align="center">
<br><br>
<form action="curdoperations.jsp" method="get" name="narrform">
<input type="hidden" name="deathId" id="deathId" value="<%=deathId%>">
 
 <p style="font-size:15px;color:black;background-color:pink;" class="form-group" for="audio"><b>Audio</b></p>

    <!--Add buttons to initiate auth sequence and sign out-->
    <button class="btn btn-warning" id="authorize_button" style="display: none;">Authorize</button>
    <button class="btn btn-warning" id="signout_button" style="display: none;">Sign Out</button>

    <div id="content" style="white-space: pre-wrap;"></div>
 

<br>
<br><br>
<!-- questions -->
<div id="list" align="left">

<label style="font-size:15px;float:left; color:black" class="form-group" for="posy">Q1 Does the narrative have positive key symptoms?</label><br>
<input type="radio" name="posy" value="yes" checked> Yes &nbsp;&nbsp;<input type="radio" name="posy" value="no"> No<br>
<label style="font-size:15px;float:left; color:black" class="form-group" for="q2">Q2 Please complete the table below.</label><br>
<table id="innerposy" border=2 style=border:5px class='table table-striped'>
<tr><th>Positive Key Symptoms</th><th>Probing included</th><th>Probing missing</th></tr>
<tr><td></td><td></td><td></td></tr><tr><td></td><td></td><td></td></tr><tr><td></td><td></td><td></td></tr>
</table>
<label style="font-size:15px; color:black" class="form-group" for="chronology">Q3 Did the surveyor write the narrative in clear chronological order?</label><br>
<input type="radio" name="chronology" value="yes" checked> Yes &nbsp;&nbsp;<input type="radio" name="chronology" value="partially"> Partially &nbsp;&nbsp;<input type="radio" name="chronology" value="no"> No<br>

<label style="font-size:15px; color:black" class="form-group" for="negsym">Q4 Were the negative symptoms stated in the narrative?</label><br>
<input type="radio" name="negsym" value="yes" checked> Yes &nbsp;&nbsp;<input type="radio" name="negsym" value="partially"> Partially &nbsp;&nbsp;<input type="radio" name="negsym" value="no"> No<br>

<label style="font-size:15px; color:black" class="form-group" for="medinfo">Q5 Was any extra medical information captured?</label><br>
<input type="radio" name="medinfo" value="yes" checked> Yes &nbsp;&nbsp;<input type="radio" name="medinfo" value="partially"> Partially &nbsp;&nbsp;<input type="radio" name="medinfo" value="no"> No<br>

<label style="font-size:15px; color:black" class="form-group" for="icd">Q6 Narratives collected enable appropriate assignment of ICD?</label><br>
<input type="radio" name="icd" value="yes" checked> Yes &nbsp;&nbsp;<input type="radio" name="icd" value="no"> No<br>

<label style="font-size:15px; color:black" class="form-group" for="audioreview">Q7 Review all audio files for matching with narrative?</label><br>
<input type="radio" name="audioreview" value="yes" checked> Yes &nbsp;&nbsp;<input type="radio" name="audioreview" value="no"> No<br>

<label style="font-size:15px; color:black" class="form-group" for="intduration">Q8 Review all audio files for matching with narrative?</label><br>
<input type="text" name="duration" value="duration" disabled>


</div>




 <%-- <div id="list">
 <br><br>
 <table  style=border:5px class='table table-striped'> <tr><th>
<label style="font-size:15px;float:left;color:black" class="form-group" for="matchingstatus">Matching Status:</label>
</th>
<th><label style="font-size:15px;float:left; color:black" class="form-group" for="qualityofnarrative">Quality Of Narrative:</label></th>
<th><label style="font-size:15px; color:black" class="form-group" for="chofsy">Chronology of Symptoms:</label></th>
<th> <label style="font-size:15px; color:black" for="feedback">Feedback</label><br></th>
<th><label style="font-size:15px; color:black" for="button"></label><br></th></th>
</tr>
<tr><td>
  <select style="font-size:15px;float:left;color:black"class="form-group" name="matchingstatus" id="matchingstatus" value=<%=matching_status%>>
    <option >1</option>
    <option >2</option>
    <option >3</option>
    <option >4</option>
  </select>
  </td>
  <td>
  <select style="font-size:15px;float:left;color:black" class="form-group" name="qualityofnarrative" id="qualityofnarrative" value=<%=quality_of_narrative%>>
    <option >1</option>
    <option >2</option>
    <option >3</option>
    <option >4</option>
  </select>
  </td>
  <td><textarea style="word-break:break-all" rows="4" cols="60" name="chronology" id="chronology" value=<%=feedback%>></textarea><br> </td>
 
  <td><textarea style="word-break:break-all" rows="4" cols="60" name="feedback" id="feedback" value=<%=feedback%>></textarea><br><br></td>
  <td><input type="submit" class="btn btn-info" name="submit" value="submit"></td>
  </tr>
  </table>
   
 
   
 </div> --%>
 <div id="fb">
   
    
    
  </div><br>
  
 <!-- <button name="button" value="submit">submit</button> -->
</form>
</div></div>
<script>
var narrative="<%=narrative%>";
 var matching_status=<%=matching_status%>
 var quality_of_narrative=<%=quality_of_narrative%>
var feedback="<%=feedback%>" 
var chronology=<%=chronology%>
var selected;
document.getElementById("first").innerHTML=narrative;

var ms=document.getElementById("matchingstatus");
generateSelectTag(ms,matching_status,"matchingstatus");


var qofn=document.getElementById("qualityofnarrative");
generateSelectTag(ms,quality_of_narrative,"qualityofnarrative");


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

 

document.getElementById("chronology").innerHTML=chronology;
 document.getElementById("feedback").innerHTML=feedback;
<%-- var positiveSymptoms=<%=positiveSymptoms%>;
var rescod="<%=resCod%>";
var age="<%=age%>";
var sex="<%=sex%>";
var intdate="<%=inteviewDate%>";

document.getElementById("posym").innerHTML=positiveSymptoms;
document.getElementById("rescod").innerHTML=rescod;
document.getElementById("age").innerHTML=age;
document.getElementById("sex").innerHTML=sex;
document.getElementById("intdate").innerHTML=intdate;
 --%>
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