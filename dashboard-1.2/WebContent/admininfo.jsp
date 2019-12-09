<%@ include file="include.jsp" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
</head>
<body>
<div class="container text-center">


<br><br>	

<br><br>
 <div class="row slideanim">
    <div class="col-sm-4">
      <!-- <span class="glyphicon glyphicon-user logo-small"></span> -->
       <img class="img-profile rounded-circle" style="width:50%" src="img/surve.png"><br>
      <h4><a  class="btn btn-primary"href="survey_monitoring_dashboard.jsp?dashboard=admin">Surveyors</a></h4>
      
    </div>
    <div class="col-sm-4">
      <!-- <span class="glyphicon glyphicon-heart logo-small"></span> --><br>
       <img  class="img-profile rounded-circle" style="width:50%" src="img/manager1.jpg"><br>
      <h4><a  class="btn btn-primary" href="survey_monitoring_dashboard.jsp?dashboard=admin">Managers</a></h4>
    </div>
    <div class="col-sm-4">
     <!--  <span class="glyphicon glyphicon-lock logo-small"></span> --><br>
     <img  class="img-profile rounded-circle" style="width:50%" src="img/partner1.png"><br><br>
      <h4><a  class="btn btn-primary"href="partner.jsp">Partners</a></h4>
    </div>
  </div>

</div>
<!-- <a class=" btn btn-primary text-white shadow" onclick="surveyor" href="#">Surveyor Info</a>
<a class=" btn btn-primary text-white shadow" onclick="manager" href="#">Manager Info</a>
<a class=" btn btn-primary text-white shadow" onclick="patner" href="#">Partner Info</a> -->

</body>
</html>