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


<nav class="navbar navbar-default navbar-top">


<table width=100%>
   <tr>
   
     <td align=left> <a  href="#"><span class=" btn  btn-danger navbar-btn">COMSA Study Dashboards</span></a></td>
    
      
        
   
   
   <td align="right">
      Hello <shiro:principal></shiro:principal>&nbsp;<a  class="btn  btn-default navbar-btn " href="logout"> Logout</a>

        
              
            
        
        </td>
       </tr></table>
   

</nav> 
<br><br>

<h4>

Select one of the dashboards listed below to proceed :
</h4>
<br><br>
<a class="btn btn-default " href="dashboard_surveyors.jsp">PROGRESS</a>
<br>
<br>
<a class="btn btn-default " href="">PERFORMANCE</a>
</div>

</body>
</html>