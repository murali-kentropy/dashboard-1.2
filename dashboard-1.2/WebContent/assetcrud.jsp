<%@page import="org.json.JSONObject"%>
<%@page import="database.CrudOperations"%>
<%@page import="database.GenerateDashboardData"%>
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
 String type="";String name="";String assignedto="";String serialno="";
String verified="";String status="";String location="";String history="";String model=""; 
GenerateDashboardData gd= new GenerateDashboardData();
CrudOperations crop=new CrudOperations();
gd.datasource="partner";
GenerateDashboardData.confirgPath=request.getRealPath("/")+"/dashboards";
//update asset
int asset_no=0;
String data="";

if(request.getParameter("data")!=null)
data=request.getParameter("data");

if(request.getParameter("history")!=null)
history=request.getParameter("history");

if(request.getParameter("asset_no")!=null)
asset_no=Integer.parseInt(request.getParameter("asset_no"));



JSONObject dataObj=new  JSONObject(data);
System.out.println("dataObj==="+dataObj);

	/* if(request.getParameter("asset_no")!=null){
		
		asset_no=Integer.parseInt(request.getParameter("asset_no"));
		//Boolean insert=crop.saveAsset(type,name,assignedto,serialno,verified,status,location);
	}
if(request.getParameter("type")!=null)
	type=request.getParameter("type");

if(request.getParameter("name")!=null)
	name=request.getParameter("name");

if(request.getParameter("assignedto")!=null)
	assignedto=request.getParameter("assignedto");

if(request.getParameter("serialno")!=null)
    serialno=request.getParameter("serialno");

if(request.getParameter("model")!=null)
    model=request.getParameter("model");

if(request.getParameter("verified")!=null);
    verified=request.getParameter("verified");
    
if(request.getParameter("status2")!=null)
   status=request.getParameter("status2");

if(request.getParameter("location")!=null)
   location=request.getParameter("location");

if(request.getParameter("history")!=null)
	   history=request.getParameter("history");
 */
 
 
 
 
JSONObject prevHistory=new JSONObject();
 /* Boolean insert=crop.saveAsset(type,name,assignedto,serialno,verified,status,location,asset_no,prevHistory,model);

	response.sendRedirect("assetform.jsp?res="+insert+" ");
 */
 if(dataObj.has("type"))
 type=dataObj.getString("type");
 
 if(dataObj.has("name"))
 name=dataObj.getString("name");
 
 if(dataObj.has("assignedto"))
 assignedto=dataObj.getString("assignedto");
 
 if(dataObj.has("serial_no"))
 serialno=dataObj.getString("serial_no");
 
 if(dataObj.has("verified"))
 verified=dataObj.getString("verified");
 
 if(dataObj.has("status"))
 status=dataObj.getString("status");
 
 if(dataObj.has("location"))
 location=dataObj.getString("location");
 
 if(dataObj.has("asset_no"))
 asset_no=Integer.parseInt(dataObj.getString("asset_no"));
 
 if(dataObj.has("model"))
 model=dataObj.getString("model");
 
 
 if(data!="")
	 crop.saveAsset(type,name,assignedto,serialno,verified,status,location,asset_no,prevHistory,model);
 
%>
</body>
</html>