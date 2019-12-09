<%@page import="database.GenerateDashboardData"%>
<%@page import="org.json.JSONTokener"%>
<%@page import="org.json.JSONObject,java.io.*"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.*"%>
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
<title>Insert title here</title>
<script src="Chart.min.js"></script>

<link rel="text/html" href="Chart.css"/>
<link rel="text/html" href="modal.css"/>

<link rel="stylesheet" href="style.css">
<!-- <script src="js/sld.js"></script> -->
<!--script data-main="js/sld_new?2.0" src="scripts/require.js"></script-->
<script src="js/sld_new.js"></script>

<script src="js/calendar.js"></script>
<scripT>
function openLink(link)
{
alert('test '+link);
window.open(link);
}
</scripT>
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
 <style>
		.table-responsive2 {
		    height: 310px;
			overflow-y: auto;
		}		
		 .table-responsive2 table {
		    table-layout: fixed;
		}
			
		.tooltip-arrow,
        .red-tooltip + .tooltip > .tooltip-inner {background-color: #700;}
         .bs-tooltip-auto[x-placement^=bottom] .arrow::before,
  .bs-tooltip-bottom .arrow::before {
    border-bottom-color: #f00;
    /* Red */
  }
        .tooltip-main {
  width: 215px;
  height: 85px;
  border-radius: 50%;
  font-weight: 700;
  background: #f3f3f3;
  border: 1px solid #737373;
  color: #737373;
  margin: 4px 121px 0 5px;
  float: right;
  text-align: left !important;
}

.tooltip-qm {
  float: left;
   background: blue;
  font-size: 12px;
}

.tooltip-inner {
  max-width: 1000px !important;
  height: 250px;
  font-size: 12px;
  padding: 10px 15px 10px 20px;
  background: black;
 
  border: 1px solid #737373;
  text-align: left;
}

.tooltip.show {
  opacity: 1;
}

.bs-tooltip-auto[x-placement^=bottom] .arrow::before,
.bs-tooltip-bottom .arrow::before {
  border-bottom-color: #f00;
  /* Red */
}

   </style>



<script>
function myColor(){
	var color=document.getElementById("colInt");
	var num=color.options[color.selectedIndex].value;
	//alert(color);
	displaycharts(num,colNum);
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

<%
String tabs="progress";
if(request.getParameter("tabs")!=null)
{
	tabs=request.getParameter("tabs");
}
String tabPath=request.getRealPath("/")+"/tabs";
String tabfile= request.getRealPath("/")+"/tabs/"+tabs+".json";
FileInputStream fin1=new FileInputStream(tabfile);
JSONArray tabJSON = new JSONArray(new JSONTokener(fin1));
fin1.close();
	
%>
<script>
var tabName="<%=tabs%>";
</script>
<script>
var tabs=<%=tabJSON.toString(2)%>
</script>
<%
/* 
String file= request.getRealPath("/")+"/dashboards/variable.json";
JSONObject jo = new JSONObject(new JSONTokener(new FileInputStream(file)));
String file2= request.getRealPath("/")+"/dashboards/surveyor.json";
JSONObject jo2 = new JSONObject(new JSONTokener(new FileInputStream(file))); */
String dashboard=null;
if(request.getParameter("dashboard")!=null){
	
     dashboard=request.getParameter("dashboard");//"va_monitoring";
}
else
	dashboard=tabJSON.getJSONObject(0).getString("name");
/* String dashboard=request.getParameter("dashboard");//"va_monitoring";
if(dashboard==null)
{
	dashboard="va_monitoring";
	
} */
// css button style

//String datafile= request.getRealPath("/")+"/dashboards/"+dashboard+"_data.json";
//JSONObject joData = new JSONObject(new JSONTokener(new FileInputStream(datafile)));
/*String dashboardPath="";
if(request.getParameter("dashboardPath")!=null)
{
dashboardPath="/"+request.getParameter("dashboardPath");
}*/
GenerateDashboardData.confirgPath=request.getRealPath("/")+"/dashboards";
String configfile= request.getRealPath("/")+"/dashboards/"+dashboard+"_dashboard_config.json";
FileInputStream fin=new FileInputStream(configfile);
JSONObject joConfig = new JSONObject(new JSONTokener(fin));
fin.close();
//passing array to getdata method , 

JSONArray filters=new JSONArray();
Enumeration params=request.getParameterNames();
List<String> filterNames=new ArrayList<String>();
filterNames.add("surveyor");
filterNames.add("datefrom");

filterNames.add("dateto");

filterNames.add("area");
filterNames.add("type");
filterNames.add("physician");

String [] renderedFilters= new String[0];

if(request.getParameter("fld_renderedFilters")!=null)
{
	renderedFilters=request.getParameter("fld_renderedFilters").split(",");
}
//while(params.hasMoreElements())
	//for(String param : renderedFilters)
		
		for(int i=0; i< joConfig.getJSONArray("charts").length();i++)
	{
	
	//String param =(String)params.nextElement();
	JSONObject chartObj=joConfig.getJSONArray("charts").getJSONObject(i);
	
	JSONArray filters1=chartObj.has("filters")?chartObj.getJSONArray("filters"):new JSONArray();
	for(int j=0; j< filters1.length();j++)
		
	{
		String filterName=filters1.getString(j);
		
		if(filterName.equals("surveyors"))
			filterName="surveyor";
			if (filterName.equals("areas"))
			filterName="area";
			if (filterName.equals("ageType"))
				filterName="type";
			if (filterName.equals("physicians"))
				filterName="physician";
			
	String param=filterName+"_"+i;	
	
	String value=request.getParameter(param);
	System.out.println(" Filter Param "+param);
	
//for(String s:filterNames)
//{

//	if(param.startsWith(s)  )
	//{
		System.out.println(" JSP "+ value +" "+param+" "+(value!=null &&  !value.equals("") && !value.startsWith("--")));
		if(value!=null && !value.equals("") && !value.startsWith("--") )
		{
	JSONObject filter = new JSONObject();
	filter.put("field",param);
		filter.put("value",	value);
	filters.put(filter);
		}
		else
		{
			System.out.println("else");	
			JSONObject filter = new JSONObject();
			filter.put("field","null_condition_"+param);
				filter.put("value",	"null");
			filters.put(filter);
			System.out.println(" JSP else "+filters.toString(2));
		}
			
	//break;
	//}
	}
	}

//}



System.out.println(" JSP "+filters.toString(2));

JSONArray arr = new GenerateDashboardData().getData(joConfig.getJSONArray("charts"),filters);
JSONObject joData=new JSONObject();
joData.put("charts",arr);

JSONArray ja=joConfig.getJSONArray("charts");
String ncols="1.0";
if(joConfig.has("config"))
{

JSONObject dconfig=joConfig.optJSONObject("config");
ncols=dconfig.getString("columns");
}
JSONArray filterValues= new JSONArray();
for(int i=0; i< ja.length();i++)		
{
	ja.getJSONObject(i).remove("query");
	
	JSONArray dateFilter=new JSONArray();
	if(request.getParameter("datefrom_"+i )!=null)
	{
		dateFilter.put(request.getParameter("datefrom_"+i ));
		dateFilter.put(request.getParameter("dateto_"+i ));
		
	}
	else
	{
		dateFilter.put("");
		dateFilter.put("");
		
	}
		
	JSONArray surveyorFilter=new JSONArray();
	if(request.getParameter("surveyor_"+i )!=null)
	{
		surveyorFilter.put(request.getParameter("surveyor_"+i ));
		//dateFilter.add(request.getParameter("dateto_"+i ));
		
	}
	else
		surveyorFilter.put("");
	
	JSONArray areaFilter=new JSONArray();
	if(request.getParameter("area_"+i )!=null)
	{
		areaFilter.put(request.getParameter("area_"+i ));
		//dateFilter.add(request.getParameter("dateto_"+i ));
		
	}
	else
		areaFilter.put("");
	
	JSONArray typeFilter=new JSONArray();
	if(request.getParameter("type_"+i )!=null)
	{
		typeFilter.put(request.getParameter("type_"+i ));
		//dateFilter.add(request.getParameter("dateto_"+i ));
		
	}
	else
		typeFilter.put("");
	
	JSONArray physicianFilter=new JSONArray();
	if(request.getParameter("physician_"+i )!=null)
	{
		physicianFilter.put(request.getParameter("physician_"+i ));
		//dateFilter.add(request.getParameter("dateto_"+i ));
		
	}
	else
		physicianFilter.put("");

	JSONObject jo=new JSONObject();
	jo.put("period",dateFilter);
	jo.put("surveyor",surveyorFilter);
	jo.put("area",areaFilter);
	jo.put("type",typeFilter);
	jo.put("physician",physicianFilter);
	filterValues.put(jo);
}

JSONArray surveyors=GenerateDashboardData.getSurveyors();
JSONArray areas=GenerateDashboardData.getAreas();
JSONArray ageType=GenerateDashboardData.getAgeType();
JSONArray physician=GenerateDashboardData.getPhysician();
//JSONObject jo = new JSONObject(new JSONTokener(new FileInputStream("/D:/data/sl_monitoring_dashboard.json")));
%>
<script>

var filterValues=<%=filterValues%>;
var dashboard='<%=dashboard%>';
var data=<%=joData.getJSONArray("charts")%>;
//alert(JSON.stringify(data));
var config=<%=joConfig.getJSONArray("charts")%>;
var surveyors=<%=surveyors%>;
var areas=<%=areas%>;
var ageType=<%=ageType%>;
var physician=<%=physician%>

</script>
</head>
<%@ include file="include.jsp" %>
<body onload="displaycharts(1.0)">

<form id="filterform"  method="post" name="filterform" onsubmit="survyer_monitoring_dashboard">
<input type="hidden" name="fld_renderedFilters" id="fld_renderedFilters">
<div class="container">
 <nav class="navbar navbar-top ">

 
<table width=100%>
   <tr>
   
     <td align=left> <a  href="index.jsp" class=" btn  btn-danger navbar-btn">COMSA Study Dashboards</a></td>
    
      
        
   
   
   <td align=right>
     <b style="color:red"> Hello <shiro:principal></shiro:principal></b>&nbsp;<a  class="btn  btn-info navbar-btn " href="logout"> Logout </a>
</td>
     
       </tr></table>
   

</nav> 

<!-- <div class="jumbotron text-center">

    <h1>COMSA STUDY MONITORING DASHBOARD</h1>
    <h3>MONITORING DASHBOARDS</h3>      
    

</div> -->



<%@ include file="navbar.jsp" %>


<script>
// Add active class to the current button (highlight it)
function setTab(dashboard)
{
	//console.log("dashboard "+dashboard +document.getElementById(dashboard+"_tab").className)
	document.getElementById(dashboard+"_tab").className="btn  btn-default navbar-btn b1tn2 active";
}
	
	
setTab("<%=dashboard%>");	
	
</script>
<script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();  
   // $('.btn-warning').tooltip({title: "Header", content: "Blabla", placement: "bottom"}); 
});
</script>


<script>	
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#tr_0 tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});
</script>
</div>
</form>



<!-- The Modal -->

<!--  script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script-->
		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
		<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/start/jquery-ui.css" rel="Stylesheet" type="text/css" />			
		
</body>
</html>