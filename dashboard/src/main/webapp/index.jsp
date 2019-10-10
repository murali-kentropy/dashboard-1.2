<%@ include file="include.jsp" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
		 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <style>
.dashicon{
 width:170px;
 
height:100px
}
</style>
</head>
<body>
<div class="container text-center">


<nav class="navbar navbar-default navbar-top">


<table width=100%>
   <tr>
   
     <td align=left> <a  href="#"><span class=" btn  btn-danger navbar-btn">COMSA Study Dashboards</span></a></td>
    
      
        
   
   
  <%--  <td align="right">
      Hello <shiro:principal></shiro:principal>&nbsp;<a  class="btn  btn-default navbar-btn " href="logout"> Logout</a>

        
              
            
        
        </td> --%>
       </tr></table>
   

</nav> 
<br><br>	
<h3>Welcome to the COMSA Study Dashboards site.</h3><br><br>
<h4>

Select one of the dashboards listed below to proceed :
</h4>
<br><br>

<table class="container  text-center table" width=850 border=1 cell-padding=10>
<tr> <td colspan=1> <h4>Management</h4></td>
<td> <a class="btn btn-default"  title="The listing of personnel of different roles in the system" href="survey_monitoring_dashboard.jsp?tabs=personnel">  <img class=" rounded-circle dashicon" src="img/personnel.jpg"><br>Personnel</a><td><a class="btn btn-default" href="survey_monitoring_dashboard.jsp?tabs=support"> <img class="rounded-circle dashicon" src="img/support.jpg"><br>Support </a></td>

<!--  tr> <td> <h4>Survey</h4></td></tr>-->

<tr> <td colspan=1> <h4>Progress</h4></td>
<td> <a class="btn btn-default" align=center href="survey_monitoring_dashboard.jsp?tabs=progress"> <img class="rounded-circle  dashicon" src="img/charts.jpg"> <br>Charts</a><td><a class="btn btn-default"  href="survey_monitoring_dashboard.jsp?tabs=reports"> <img class="rounded-circle dashicon" src="img/reports.png"><br>Reports </a></td></tr>

<tr> <td colspan=1><h4>Data</h4> </td>
<td> <a class="btn btn-default" href="survey_monitoring_dashboard.jsp?tabs=enumeration"> <img class="rounded-circle  dashicon" src="img/enum.jpg"><br> Enumeration</a><td><a class="btn btn-default" href="survey_monitoring_dashboard.jsp?tabs=va"> <img class="rounded-circle  dashicon" src="img/va2.jpg"><br>VA </a></td></tr>
<tr> <td colspan=1><h4> Quality</h4></td>
<td> <a class="btn   btn-default" href="survey_monitoring_dashboard.jsp?tabs=qualityanalysis"> <img class="rounded-circle  dashicon" src="img/qa.png"><br>VA  Quality Analysis</a></td><td><a class="btn btn-default"href="survey_monitoring_dashboard.jsp?tabs=resampling"><br><img class="rounded-circle  dashicon" src="img/resampling.jpg"><br>Ressampling </a></td></tr>


<tr> <td colspan=1> <h4>Logistics and Others</h4></td>
<td> <a class="btn  btn-default" href="survey_monitoring_dashboard.jsp?tabs=assetmanagement"> <img class="rounded-circle  dashicon" src="img/assetmgmt.jpg"><br>Asset management</a></td><td><a class="btn  btn-default" href="survey_monitoring_dashboard.jsp?tabs=consentform"> <img class="rounded-circle  dashicon" src="img/consent.jpg"><br>Consent Form</a></td></tr>
<tr> <td colspan=1> <h4>Training</h4></td>
<td> <a class="btn  btn-default" href="survey_monitoring_dashboard.jsp?tabs=training"> <img class="rounded-circle  dashicon" src="img/training.jpg"><br>Training Resources</a></td><td></td></tr>







</table>
<br>

<a class=" btn btn-primary text-white shadow" href="progress_performance.jsp">Monitoring dashboards</a>
</div>

</body>
</html>