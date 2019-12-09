
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.min.js"></script>
		 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>  
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>multi charts</title>
<script src="js/sld_charts.js"></script>
</head>
<body>
<%@page import="org.json.JSONObject" %>
<%@page import="org.json.JSONException" %>
<%@page import="org.json.JSONArray" %>
<%
 JSONObject obj = new JSONObject();
JSONArray dataArr=new JSONArray();
String str="[{aaa:23,bbb:21,ccc:45,ddd:67,eee:45},{aaa:98,bbb:90,ccc:87,ddd:87,eee:67},{aaa:54,bbb:76,ccc:66,ddd:55,eee:22}]";
//String data=request.getParameter("data");
dataArr=new JSONArray(str);
/* for(int i=0;i<dataArr.length();i++){
	obj=dataArr.getJSONObject(i);
	
} */

%>
<canvas id="myChart" ></canvas>
<script>
var canvas = document.getElementById('myChart')
var ctx = document.getElementById("myChart");
var arr=<%=dataArr%>;
getMultiCharts(ctx,arr);
</script>
</body>
</html>