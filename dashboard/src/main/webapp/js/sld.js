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
    	    text:getTitle(data[idx]),//.variable),
    	    //text:"demo2",
    	    
    	    position:"bottom"
    	},
    	legend:{
    		  display: true,
    		  labels:{
    		boxWidth:20,
    		fontSize:12
    		  },
    		position:"right"
    	}
    }
});
return chart;
}
function getLineChart(idx)
{
	
	var ctype="line";
	var ctx = document.getElementById("myChart"+idx).getContext('2d');
	var chartInfo={
		    type: ctype,
		    
		    data: getChartData(idx),
		    
		    options: {
		    	
		    	line:{
		    	fill:false
		    	
		    	},
		    	title: {
		    	    display: true,
		    	    text:getTitle(data[idx]),//.variable),
		    	    //text:"demo2",
		    	    
		    	    position:"bottom"
		    	},
		    	legend:{
		    		  display: true,
		    		  labels:{
		    		boxWidth:20,
		    		fontSize:12
		    		  },
		    		//position:"left"
		    	}
		    }
	};

	
	chartInfo.data.datasets[0].fill=false;
	
	chartInfo.data.datasets[0].lineTension=0;
var chart=new Chart(ctx, 
chartInfo);



return chart;
}
function getPieChart1(data1)
{
	
	var ctype="pie";
	var ctx = document.getElementById("myChart"+idx).getContext('2d');
var chart=new Chart(ctx, {
    type: ctype,
    
    data: getChartData(idx),
    
    options: {
    	
    	title: {
    	    display: true,
    	    text:getTitle(data[idx]),//.variable),
    	    //text:"demo2",
    	    
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


function getTitle(dt)
{
	var variable=getVariable(dt);
	
	for(var i=0; i<config.length;i++)
		{
		
		if(config[i].name==variable)
			
			return  config[i].title;
		
		}
return "";

}

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
    	    text:getTitle(data[idx]),//.variable),
    	   // text:"demo1",
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

function setType(idx,type)
{
	document.getElementById("myTable"+idx).style.display="none";
	document.getElementById("myChart"+idx).style.display="block";
	myCharts[idx].destroy();
	var chart;
	/*if(type=="pie")
	chart=getPieChart(idx);
	else if(type=="bar"){
		chart=getBarChart(idx);
	}
	else if(type=="line")
		chart=getLineChart(idx);
	*/
	chart= getChart(type,idx);
	myCharts[idx]=chart;//.config.type=type;
	//myCharts[idx].update();
	
}

function getTable0(idx)
{
	//var str="<div class='container'>";
	var str="<table class='table table-striped' width=100% >";
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
function getTable(idx)
{
	var str="<h5  align='center'>"+getTitle(data[idx])+"</h5>"
	//var str="<div class='container'>";
	 str+="<table class='table table-striped' width=100% >";
	var labels=getLabels1(data[idx]);
	var values=getValues1(data[idx]);
	
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

function getValues(dt)
{var values=[];
var vals=dt.values;
	  for(name in vals)
		  {
		  if(name!="variable")
			  values.push(vals[name]);
		  
		  }
	 
	  return values
}
function getValues1(dt)

{
	
	var values=[];
	  for(var i=0; i< dt.values.length;i++)
		  {
		//  if(dts[i].name!="variable")
			  values.push(dt.values[i].value);
		
		  }
	 
	  return values
}

function getVariable(dt)
{	 
	
	  return dt.variable;
}


function getVariable1(dt)
{
	  for(var i=0; i< dt.length;i++)
		  {
		  if(dts[i].name=="variable")
			  return dt[i].name;
		  
		  }
	 
	  return "";
}

function getLabels1(dt)
{var names=[];
	  for(var i=0; i< dt.values.length;i++)
		  {
	//	  if(dts[i].name!="variable")
			  names.push(dt.values[i].name);
		  
		  }
	 
	  return names
}

function getLabels(dt)

{
	
	var labels=[];
	var vals=dt.values;
	  for(name in vals)
		  {
		  if(name!="variable")
			  labels.push(name);
		  
		  }
	 
	  return labels
}

var colors=[
	"128,0,0",
	"139,0,0",
	"165,42,42",
	"178,34,34",
	"220,20,60",
	"255,0,0",
	"255,99,71",
	"255,127,80",
	"205,92,92",
	"255,69,0",
	"255,140,0",
	"255,165,0",
	"255,215,0",
	"184,134,11",
	"218,165,32",
	"128,128,0",
	"255,255,0",
	"154,205,50",
	"85,107,47",
	"107,142,35",
	"124,252,0",
	"127,255,0",
	"173,255,47",
	"0,100,0",
	"0,128,0",
	"34,139,34",
	"0,255,0",
	"50,205,50",
	"0,250,154",
	"0,255,127",
	"46,139,87",
	"47,79,79",
	"0,128,128",
	"0,139,139",
	"0,255,255",
	"0,255,255",
	"0,206,209",
	"0,191,255",
	"25,25,112",
	"0,0,128",
	"0,0,139",
	"0,0,205",
	"0,0,255",
	"138,43,226",
	"75,0,130",
	"72,61,139",
	"106,90,205",
	"139,0,139",
	"148,0,211",
	"153,50,204",
	"186,85,211",
	"128,0,128",
	"255,0,255",
	"199,21,133",
	"255,20,147",
	"139,69,19",
	"160,82,45",
	"210,105,30",
	"205,133,63",
	"244,164,96",
	"0,0,0"];

function getColors(num,colorNum){
	var colors1=[];
	for(var i=0; i< num;i++)
		{
		colors1.push("rgba("+colors[Math.floor(Math.random() * 61) ]+","+colorNum+")");
		}
	
	return colors1;
}
function getChartData( idx)
{
	
var colorNum=color.num;
var cdata={};	
    cdata.labels=getLabels1(data[idx]);
  //  cdata.options.title.text= data[idx].variable;
   cdata.datasets= [{
        label: getVariable(data[idx]),//data[idx].variable,
	   //label: "demo",
        data: getValues1(data[idx]),
        backgroundColor:getColors(cdata.labels.length,colorNum) 
        /*[
                          'rgba(220, 20, 60,'+colorNum+')',
                          'rgba(0, 255, 255,'+colorNum+')',
                          'rgba(255, 255, 0, '+colorNum+')',
                          'rgba(0, 255, 127, '+colorNum+')',
                          'rgba(65, 105, 255, '+colorNum+')',
                          'rgba(255, 165, 0, '+colorNum+')',
                          'rgba(255, 0, 255, '+colorNum+')',
                          'rgba(138, 43, 226, '+colorNum+')',
                          'rgba(0, 255, 0, '+colorNum+')',
                          'rgba(154, 205, 50, '+colorNum+')',
                          'rgba(220, 20, 60,'+colorNum+')',
                          'rgba(0, 255, 255,'+colorNum+')',
                          'rgba(255, 255, 0, '+colorNum+')',
                          'rgba(0, 255, 127, '+colorNum+')',
                          'rgba(65, 105, 255, '+colorNum+')',
                          'rgba(255, 165, 0, '+colorNum+')',
                          'rgba(255, 0, 255, '+colorNum+')',
                          'rgba(138, 43, 226, '+colorNum+')',
                          'rgba(0, 255, 0, '+colorNum+')',
                          'rgba(154, 205, 50, '+colorNum+')',
                          'rgba(220, 20, 60,'+colorNum+')',
                          'rgba(0, 255, 255,'+colorNum+')',
                          'rgba(255, 255, 0, '+colorNum+')',
                          'rgba(0, 255, 127, '+colorNum+')',
                          'rgba(65, 105, 255, '+colorNum+')',
                          'rgba(255, 165, 0, '+colorNum+')',
                          'rgba(255, 0, 255, '+colorNum+')',
                          'rgba(138, 43, 226, '+colorNum+')',
                          'rgba(0, 255, 0, '+colorNum+')',
                          'rgba(154, 205, 50, '+colorNum+')'
                          

                      ],*/,
                      borderColor: [
                          'rgba(255, 99, 132, 1)',
                          'rgba(54, 162, 235, 1)',
                          'rgba(255, 206, 86, 1)',
                          'rgba(75, 192, 192, 1)',
                          'rgba(153, 102, 255, 1)',
                          'rgba(255, 159, 64, 1)',
                          'rgba(75, 192, 192, 1)',
                          'rgba(153, 102, 255, 1)',
                          'rgba(255, 159, 64, 1)',
                          'rgba(111, 155, 64, 1)'

                      ],
                      borderWidth: 1
   }]
   
	return cdata;
	}
function showCal(idx,filter){
	alert("This is calender");
}
function getSurveyorFilter(idx,curVal){
	
   var str="<select  id='surveyor_"+idx+"' name='surveyor_"+idx+"'  style='width:300px;color:black'>"

   str+=	"<option value=0>---Choose surveyor-";//+surveyors[i].value;
   for(var i=0;i<surveyors.length;i++){
		if(curVal==surveyors[i].name)
	str+=	"<option value='"+surveyors[i].name+"' selected>"+surveyors[i].value;
		else
			str+=	"<option value='"+surveyors[i].name+"'>"+surveyors[i].value;
	}
	str+="</select>";
	return str;
}


function getPeriodFilter(idx,curVal)
{
	var str="<label style='font-size:15px; color:blue'> Date-From: </label><input style='background-color:white;width:80px' id='datefrom_"+idx+"' name='datefrom_"+idx+"'  type='text'  value='"+curVal[0]+"'  onchange='settoAll()' readonly>" ;
	 str  += "<label style='font-size:15px; color:blue'> Date-To: </label><input style='background-color:white;width:80px' id='dateto_"+idx+"' name='dateto_"+idx+"'  type='text' value='"+curVal[1]+"' onchange='settoAll()' readonly>";	
return str;
}

function getPanelButtons(idx)
{
	var types=config[idx].types;
	var filter=config[idx].filters;
	
	var str="";
	
	for(var i=0;i<types.length;i++){
		if(types[i]!='table')
		str+="<button class='btn btn-info' onclick=setType("+idx+",'"+types[i]+"')> "+types[i]+ " chart</button >&nbsp;";
		
	}
	
	str+="<button class='btn btn-warning'id='data' onclick=getTable("+idx+")>Data</button >&nbsp";
	
	str+="<form name='filterform_"+idx+"' name='filterform_"+idx+"' onsubmit='survey_monitoring_dashboard.jsp'> ";
	str+="<input type=hidden name=tabs value="+tabName+"> <input type=hidden name=dashboard value="+dashboard+"> "
	for(var i=0;i<filter.length;i++){
		
		if(filter[i]=="surveyors")
			str+="<br><label style='font-size:15px; color:blue'> Surveyors: </label>  "+getSurveyorFilter(idx,filterValues[idx].surveyor)+"";
		else
			if(filter[i]=="period")
				str+="<br>"+getPeriodFilter(idx,filterValues[idx].period);//"<label style='font-size:15px; color:blue'> Date-From: </label><input style='background-color:white;width:80px' id='datefrom' name='datefrom'  type='text'  value='01/01/2018' onchange='settoAll()' readonly>" +
						//"<label style='font-size:15px; color:blue'> Date-To: </label><input style='background-color:white;width:80px' id='dateto' name='dateto'  type='text' value='02/02/2018' onchange='settoAll()' readonly>"; 
		/*<br><b>Filters:</b>Start :<input style='width:50px' > End: <input style='width:50px'>  Surveyor "+getSurveyorFilter(0)+"*/
			else
		str+="";//&nbsp; <button class='btn btn-primary' style1='margin-left:100px' onclick=showCal("+idx+",'"+filter[i]+"')> "+filter[i]+ "</button >&nbsp;";
		
		
		
}
	str+="<button class='btn btn-warning' onclick='filterform_"+idx+".submit()'> Go </button >&nbsp";
	str+="</form>";
	
		return "<div class='panel-body'><div class='box1' ><div>"+str+"</div><div id='myTable"+idx+"'></div><canvas id='myChart"+idx+"' width1='400' height='200'></canvas></div></div></div>";
	
}
var cols=2;
function setLayout()
{
	var size=data.length;
	
	var tdsize=parseInt(100/cols);
	//var tdsize=100;
	
	var str="<div class='container'>";
	 str+="<div class='row'>";
	
	
	/* str+="<div class='panel panel-primary'>";
	str+="<div class='panel-heading'>BLACK FRIDAY DEAL</div>"; */
	/* str+="<div class='panel-body'><img src='https://placehold.it/150x80?text=IMAGE' class='img-responsive' style='width:100%' alt='Image'></div>";
	str+=" <div class='panel-footer'>Buy 50 mobiles and get a gift card</div>"; */
	/* str+="</div>";
		str+="</div>";
			str+="</div>"; */
	//var str="<table width=100% >";
	/*str+="<div  onclick="calender();">"+filters+"</div>";*/
   str+="<table class='container' width=800 >";
	for(var i=0; i< size;i++)
		{
if(i%cols==0)
{
if(i>0)
str+="</tr>"
	
str+="<tr>"

}

str+="<td  valign='top' width="+tdsize+"%>"

	str+="<div class='panel panel-info'>"+getPanelButtons(i)+"</div>"
str+="</td>";	
str+="<td>";
str+="</td>";

}
	str+="</table>";
	//str+="</div>";
	layout.innerHTML=str;
}
//function to display table 
function getTableReport(idx){
	
	var str="<h5  align='center'>"+getTitle(data[idx])+"</h5>"
	//var str="<div class='container'>";
	 str+="<table class='table table-striped' width=100% >";
	var labels=getLabels1(data[idx]);
	var values=getValues1(data[idx]);
	
	//str+="<tr><th>coloums</th><th>columns2</th></tr>";
	str+="<tr>";
	for(var i=0;i<config[idx].columns.length;i++){
		str+="<th>"+config[idx].columns[i]+"</th>";
	}
	str+="</tr>"
	if(config[idx].hasOwnProperty('rowHeadings')){	
	for(var i=0; i<config[idx].rowHeadings.length;i++)
		{
		
		str+="<tr><td>"+config[idx].rowHeadings[i]+"</td><td>1</td><td>2</td></tr>";
		}
	}
	str+="</table>"
		
	document.getElementById("myTable"+idx).innerHTML=str;
	document.getElementById("myChart"+idx).style.display="none";
	
	document.getElementById("myTable"+idx).style.display="block";
	document.getElementById("data").style.display="none";
}
function getChart(type,idx)
{
	

if(type=="bar")
	return getBarChart(idx);
else
	if(type=="pie")
		return getPieChart(idx);
	else
		if(type=="line")
			return getLineChart(idx);

		else
			if(type=="table")
				return getTableReport(idx);
	else
		
		return getBarChart(idx);
}

function getFilters(idx)
{
	var filters=config[idx].filters;
	
	if(filters!=null)
		{
		return filters;
		}
	
	return " No filters";
}

function getDefaultChart(idx)
{
	var types= config[idx].types;
	
	return getChart(types[0],idx)

}

var myCharts =[];

var color={};
function displaycharts(colorNum){
	Chart.defaults.line.fill = false;	
	color.num=colorNum;
setLayout();


for(var i=0; i<data.length;i++)
	{
	var ctype="bar";
	var ctx = document.getElementById('myChart'+i).getContext('2d');
myCharts.push(getDefaultChart(i));
	}
}


