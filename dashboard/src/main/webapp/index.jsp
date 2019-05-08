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

<nav class="navbar navbar-default navbar-fixed-top">

  <div class="container-fluid">
    <div class="navbar-header">

    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#"><span class="label label-danger">COMSA Study Dashboards</span></a>
    </div>
</div>
</nav>
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