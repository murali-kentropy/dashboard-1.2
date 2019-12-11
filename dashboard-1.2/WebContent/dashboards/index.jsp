<%@page import="database.GenerateDashboardData"%>
<%@page import="jsonutils.DataUtil"%>

<%@page import="org.json.JSONTokener"%>
<%@page import="org.json.JSONObject,java.io.*"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.shiro.*"%>
<%@page import="org.apache.shiro.subject.*"%>
<%@ include file="include.jsp" %>
<%
Subject subj=SecurityUtils.getSubject();
String user=subj.getPrincipal().toString();
if(subj.hasRole("admin"))
{
session.setAttribute("role","admin");
response.sendRedirect("admin-index.jsp");

}
else
if(subj.hasRole("surveyor"))
{
GenerateDashboardData gdd = new GenerateDashboardData();
GenerateDashboardData.confirgPath=request.getRealPath("/")+"/config";
session.setAttribute("role","surveyor");
String surveyor=new DataUtil().getObjectValue(gdd.getReportData("test","select * from user where username='"+user+"'"),"id");
out.println(surveyor);
session.setAttribute("surveyor",surveyor);


response.sendRedirect("surveyor-index.jsp");

}
else
if(subj.hasRole("reviewer"))
{
session.setAttribute("role","reviewer");
response.sendRedirect("reviewer-index.jsp");

}


//out.println(subj.hasRole("surveyor"));

%>

You are not authorised!

<a href="logout"> Click here </a>