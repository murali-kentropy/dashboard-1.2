<%--
  ~ Licensed to the Apache Software Foundation (ASF) under one
  ~ or more contributor license agreements.  See the NOTICE file
  ~ distributed with this work for additional information
  ~ regarding copyright ownership.  The ASF licenses this file
  ~ to you under the Apache License, Version 2.0 (the
  ~ "License"); you may not use this file except in compliance
  ~ with the License.  You may obtain a copy of the License at
  ~
  ~     http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>
<%@ include file="include.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<html>
<head>
    <link type="text/css" rel="stylesheet" <%-- href="<c:url value="/style.css"/>" --%>/>
</head>
<body>



<shiro:guest>
<!--     <p>Here are a few sample accounts to play with in the default text-based Realm (used for this
        demo and test installs only). Do you remember the movie these names came from? ;)</p>
 -->

    <style type="text/css">
        table.sample {
            border-width: 1px;
            border-style: outset;
            border-color: blue;
            border-collapse: separate;
            background-color: rgb(255, 255, 240);
        }

        table.sample th {
            border-width: 1px;
            padding: 1px;
            border-style: none;
            border-color: blue;
            background-color: rgb(255, 255, 240);
        }

        table.sample td {
            border-width: 1px;
            padding: 1px;
            border-style: none;
            border-color: blue;
            background-color: rgb(255, 255, 240);
        }
    </style>


    <!-- <table class="sample">
        <thead>
        <tr>
            <th>Username</th>
            <th>Password</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>root</td>
            <td>secret</td>
        </tr>
        <tr>
            <td>presidentskroob</td>
            <td>12345</td>
        </tr>
        <tr>
            <td>darkhelmet</td>
            <td>ludicrousspeed</td>
        </tr>
        <tr>
            <td>lonestarr</td>
            <td>vespa</td>
        </tr>
        </tbody>
    </table> -->
    <br/><br/>
</shiro:guest>
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
<div class="container" align="center">

	<h1 style="color:brown"> Login </h1>
	<br />
<form  class="form-horizontal" name="loginform" action="" method="post">
 <div class="form-group">
		<label class="control-label col-sm-offset-3 col-sm-2" style="color:blue">Username:</label>
		<div class="col-sm-3"> 
		  <input type="text" class="form-control" id="username" name="username" required>
		</div>
	  </div>  
	  <div class="form-group">
		<label class="control-label col-sm-offset-3 col-sm-2" style="color:blue">Password:</label>
		<div class="col-sm-3"> 
		  <input type="password" class="form-control" id="password" name="password" required>
		</div>
	  </div>
	  <br>	  
	 
	 
	   <button class="btn btn-primary"> Login </button>
	 
</form>

</div>
</body>
</html>