<%@page import="org.json.JSONTokener"%>
<%@page import="org.json.JSONObject,java.io.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script src="Chart.min.js"></script>

<link rel="text/html" href="Chart.css"/>
<style>
/* .box1{
border:0px solid black ;
 box-shadow: 5px 10px #d5d5d5;
 /* border-style: groove;
   border: 2px light black;
  border-radius: 5px;
  border-style: ridge; */
} */
td:nth-child(2) {
    border-right: 10px solid transparent;
    -webkit-background-clip: padding;
    -moz-background-clip: padding;
    background-clip: padding-box;
}
</style>
<%
String file= request.getRealPath("/")+"/dashboards/ESL.json";
JSONObject jo = new JSONObject(new JSONTokener(new FileInputStream(file)));


//JSONObject jo = new JSONObject(new JSONTokener(new FileInputStream("/D:/data/sl_monitoring_dashboard.json")));


%>
<script>
var data=<%=jo.getJSONArray("charts")%>;        
  function getLabels(dt)
  {var labels=[];
	  for(name in dt)
		  {
		  if(name!="variable")
			  labels.push(name);
		  
		  }
	  
	  return labels
  }
  function getValues(dt)
  {var values=[];
	  for(name in dt)
		  {
		  if(name!="variable")
			  values.push(dt[name]);
		  
		  }
	  
	  return values
  }


function getChartData( idx)
{
	

var cdata={};	
    cdata.labels=getLabels(data[idx]);
  //  cdata.options.title.text= data[idx].variable;
   cdata.datasets= [{
        label: data[idx].variable.name,
        data: getValues(data[idx]),
        backgroundColor: [
                          'rgba(220, 20, 60, 0.4)',
                          'rgba(0, 255, 255, 0.4)',
                          'rgba(255, 255, 0, 0.4)',
                          'rgba(0, 255, 127, 0.4)',
                          'rgba(65, 105, 255, 0.4)',
                          'rgba(255, 165, 0, 0.4)',
                          'rgba(255, 0, 255, 0.4)',
                          'rgba(138, 43, 226, 0.4)',
                          'rgba(0, 255, 0, 0.4)',
                          'rgba(154, 205, 50, 0.4)'

                      ],
                      borderColor: [
                          'rgba(255, 99, 132, 1)',
                          'rgba(54, 162, 235, 1)',
                          'rgba(255, 206, 86, 1)',
                          'rgba(75, 192, 192, 1)',
                          'rgba(153, 102, 255, 1)',
                          'rgba(255, 159, 64, 1)',
                          'rgba(75, 192, 192, 0.2)',
                          'rgba(153, 102, 255, 0.2)',
                          'rgba(255, 159, 64, 0.2)',
                          'rgba(111, 155, 64, 0.2)'

                      ],
                      borderWidth: 1
   }]
   
	return cdata;
	}
	
	function setType(idx,type)
	{
		document.getElementById("myTable"+idx).style.display="none";
		document.getElementById("myChart"+idx).style.display="block";
		myCharts[idx].destroy();
		var chart;
		if(type=="pie")
		chart=getPieChart(idx);
		else
			chart=getBarChart(idx);
		myCharts[idx]=chart;//.config.type=type;
		//myCharts[idx].update();
		
	}
	function getTable(idx)
	{
		
		var str="<table width=100% border=1>";
		var labels=getLabels(data[idx]);
		var values=getValues(data[idx]);
		
		str+="<tr><th>Labels</th><th>Values</th></tr>";
		for(var i=0; i< labels.length;i++)
			{
			str+="<tr><td>"+labels[i]+"</td><td>"+values[i]+"</td></tr>";
			}
		str+="</table>"
		
		document.getElementById("myTable"+idx).innerHTML=str;
		document.getElementById("myChart"+idx).style.display="none";
		
		document.getElementById("myTable"+idx).style.display="block";
	}
	function setLayout()
	{
		var size=data.length;
		var cols=1;
		var tdsize=parseInt(100/cols);
		//var tdsize=100;
		var idx=0;
		//var str="<div class='container'>"
		var str="<table width=100% >";
	    //str+="<table width=100% >";
		for(var i=0; i< size;i++)
			{
if(i%cols==0)
	{
if(i>0)
	str+="</tr>"
	str+="<tr>"
	
	}
	str+="<td width="+tdsize+"%>"
		str+="<div class='panel panel-success'><div class='panel-body'><div class='box1' ><div><button class='btn btn-info' onclick=setType("+i+",\"bar\")> Bar Chart</button >&nbsp;<button class='btn btn-primary'%nbsp; onclick='setType("+i+",\"pie\")'>Pie Chart</button>&nbsp;	<button class='btn btn-warning'onclick=getTable("+i+")>Data</button ></div><div id='myTable"+i+"'></div><canvas  id='myChart"+i+"' width1='400' height='200'></canvas></div></div></div></div>"
str+="</td>";	
	
	
	}

			
			
		str+="</table>";
		//str+="</div>";
		layout.innerHTML=str;
	}
</script>
</head>
<body>
<div class="jumbotron ">
  <div class="container text-center">
    <!-- <h1>COMSA STUDY MONITORING DASHBOARD</h1> -->
    <h3>COMSA DASHBOARD</h3>      
    <p> ESL </p>
  </div>
</div>
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <!-- <a class="navbar-brand" href="#">Logo</a> -->
      
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li><a class="btn btn-default navbar-btn" href="testboot.jsp">Survey Dashboard</a></li>
        <li><a class="btn btn-default navbar-btn" href="todays_progress.jsp">Today's Progress</a></li>
        <li><a class="btn btn-default navbar-btn" href="ESL.jsp">ESL</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><span class="glyphicon glyphicon-user"></span> </a></li>
      </ul>
    </div>
  </div>
</nav>
 
<br>
<br>


<div id="layout"></div>
<footer class="container-fluid text-center">
  <p style=color:grey>comsa study monitoring dashboards</p>  
  
</footer>
<script>

function getBarChart(idx)
{
	
	var ctype="bar";
	var ctx = document.getElementById("myChart"+idx).getContext('2d');
var chart=new Chart(ctx, {
    type: ctype,
    
    data: getChartData(idx),
    
    options: {
    	
    	title: {
    	    display: true,
    	    text:data[idx].variable.title,
    	    
    	    position:"bottom"
    	},
        scales: {
        	
            xAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }],
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }
            
            ]
        }


        
    }
});
return chart;

	}
	
function getPieChart(idx)
{
	
	var ctype="pie";
	var ctx = document.getElementById("myChart"+idx).getContext('2d');
var chart=new Chart(ctx, {
    type: ctype,
    
    data: getChartData(idx),
    
    options: {
    	
    	title: {
    	    display: true,
    	    text:data[idx].variable.title,
    	    
    	    position:"bottom"
    	},
    	legend:{
    		  display: true,
    		  labels:{
    		boxWidth:20,
    		fontSize:12
    		  },
    		position:"left"
    	}
    	
    	
        


        
    }
});
return chart;

	}


var myCharts =[];
setLayout();

for(var i=0; i<data.length;i++)
	{
	var ctype="bar";
	var ctx = document.getElementById('myChart'+i).getContext('2d');
myCharts.push(getBarChart(i));
	}
</script>
</div>

</body>
</html>