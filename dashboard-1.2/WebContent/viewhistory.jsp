<%@page import="database.CrudOperations"%>
<%@page import="database.GenerateDashboardData"%>
<%@page import="org.json.JSONTokener"%>
<%@page import="org.json.JSONObject,java.io.*"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Supporting"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement" %>
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
<title>View History</title>
<script src="Chart.min.js"></script>

<link rel="text/html" href="Chart.css"/>
<link rel="text/html" href="modal.css"/>

<link rel="stylesheet" href="style.css">
<style>
hisdiv{

}
</style>
</head>
<body>
<%

%>
<div class="container" align="center">
 <nav class="navbar navbar-top ">

 
<table width=100%>
   <tr>
   
     <td align=left> <a  href="index.jsp" class=" btn  btn-danger navbar-btn">COMSA Study Dashboards</a></td>
    
      
        
   
   
   <td align=right>
     <b style="color:red"> Hello <shiro:principal></shiro:principal></b>&nbsp;<a  class="btn  btn-info navbar-btn " href="logout"> Logout </a>
</td>
     
       </tr></table>
   

</nav>
</div>
<%
String dashboard="";;
GenerateDashboardData.confirgPath=request.getRealPath("/")+"/dashboards";
int asset_no=0;
if(request.getParameter("asset_no")!=null){
	asset_no=Integer.parseInt(request.getParameter("asset_no"));
}
String dataSource="partner";
String query="select * from asset_data_history where asset_no='"+asset_no+"' ";
CrudOperations crud=new CrudOperations();

ResultSet rs=crud.getResultSet(query,dataSource);
/* while(rs.next()){
	System.out.println("rs="+rs.getString("history"));
} */

%>

<div id="hisdiv" class="container" align="center">
<a style="float:left" href="survey_monitoring_dashboard.jsp?dashboard=assetmanagement&tabs=assetmanagement" type="button" class="btn btn-info"  >Back</a>
<br><br>
<table class="table table-striped">
<tr><th>Asset No</th><th>History</th></</tr>
<%
while(rs.next()){

	%>
  <tr><td><%=asset_no%></td><td><%=rs.getString("history")%><td></td>

<%	
}

%>
</table>
</div>
</body>
</html>