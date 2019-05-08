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
</head>
<body>
<div class="container text-center">
<br>
<br>
<br>
<br>
<br><br>
<br>
<br>
<br>
<br>
<shiro:user>

<h4>Welcome 
<shiro:principal>
</shiro:principal>
</shiro:user>
</h4>
<br><br>
<a class="btn btn-success" href="survey_monitoring_dashboard.jsp">COMSA monitoring dashboards</a>
</div>
<%
System.out.println("usernanemc-"+request.getParameter("username"));
%>
</body>
</html>