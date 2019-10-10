<%@page import="database.GenerateDashboardData"%>
<%@page import="org.json.JSONTokener"%>
<%@page import="org.json.JSONObject,java.io.*"%>
<%@page import="org.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
		 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script src="Chart.min.js"></script>

<link rel="text/html" href="Chart.css"/>
<script src="js/sld.js"></script>
<style>
/* .box1{
border:0px solid black ;
 box-shadow: 5px 10px #d5d5d5;
 /* border-style: groove;
   border: 2px light black;
  border-radius: 5px;
  border-style: ridge; */
} */
.
 .jumbotron {
      margin-bottom: 0;
      padding: 10.5px 10.6px;
   min-height: 200px;
    }
   
td:nth-child(2) {
    border-right: 10px solid transparent;
    -webkit-background-clip: padding;
    -moz-background-clip: padding;
    background-clip: padding-box;
}
</style>
<script>
function myColor(){
	var color=document.getElementById("colInt");
	var num=color.options[color.selectedIndex].value;
	//alert(color);
	displaycharts(num);
}

function myCol(){
	var ele=document.getElementById("colNum");
	cols=ele.options[ele.selectedIndex].value;
	//setLayout();
	myColor();
	//alert(color);
	//
	//displaycharts(num);
}
//document.getElementById("va").style=
</script>

<%/* 
String file= request.getRealPath("/")+"/dashboards/variable.json";
JSONObject jo = new JSONObject(new JSONTokener(new FileInputStream(file)));
String file2= request.getRealPath("/")+"/dashboards/surveyor.json";
JSONObject jo2 = new JSONObject(new JSONTokener(new FileInputStream(file))); */

String dashboard=request.getParameter("dashboard");//"va_monitoring";
if(dashboard==null)
{
	dashboard="va_monitoring";
	
}
// css button style

//String datafile= request.getRealPath("/")+"/dashboards/"+dashboard+"_data.json";
//JSONObject joData = new JSONObject(new JSONTokener(new FileInputStream(datafile)));
GenerateDashboardData.confirgPath=request.getRealPath("/")+"/dashboards";
String configfile= request.getRealPath("/")+"/dashboards/"+dashboard+"_dashboard_config.json";
FileInputStream fin=new FileInputStream(configfile);
JSONObject joConfig = new JSONObject(new JSONTokener(fin));
fin.close();
//passing array to getdata method , 
JSONArray arr = new GenerateDashboardData().getData(joConfig.getJSONArray("charts"));
JSONObject joData=new JSONObject();
joData.put("charts",arr);

JSONArray ja=joConfig.getJSONArray("charts");
for(int i=0; i< ja.length();i++)		
{
	ja.getJSONObject(i).remove("query");
}
//JSONObject jo = new JSONObject(new JSONTokener(new FileInputStream("/D:/data/sl_monitoring_dashboard.json")));
%>
<script>
var data=<%=joData.getJSONArray("charts")%>;
//alert(JSON.stringify(data));
var config=<%=joConfig.getJSONArray("charts")%>;


</script>
</head>
<%@ include file="include.jsp" %>
<body onload="displaycharts(1.0)">
<div class="container">
 <nav class="navbar navbar-default navbar-top ">


<table width=100%>
   <tr>
   
     <td align=left> <a  href="index.jsp"><span class=" btn  btn-danger navbar-btn">COMSA Study Dashboards</span></a></td>
    
      
        
   
   
   <td align=right>
      Hello <shiro:principal></shiro:principal>&nbsp;<a  class="btn  btn-default navbar-btn " href="logout"> Logout </a>

        
              
            
        
        </td>
       </tr></table>
   

</nav> 

<!-- <div class="jumbotron text-center">

    <h1>COMSA STUDY MONITORING DASHBOARD</h1>
    <h3>MONITORING DASHBOARDS</h3>      
    

</div> -->



<%@ include file="navbar.html" %>


<script>
// Add active class to the current button (highlight it)
function setTab(dashboard)
{
	//console.log("dashboard "+dashboard +document.getElementById(dashboard+"_tab").className)
	document.getElementById(dashboard+"_tab").className="btn  btn-default navbar-btn b1tn2 active";
}
	
	
setTab("<%=dashboard%>");	
	
</script>


</div>
</body>
</html>