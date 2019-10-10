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
// function to display data in tables, sync with data button
function getTable(idx)
{
	var str="<h5  align='center'>"+getTitle(data[idx])+"</h5>"
	
	str+="<div class='table-responsive2'>";
	 str+="<table class='table table-striped'>";
	
	var labels=getLabels1(data[idx]);
	var values=getValues1(data[idx]);
	 
	str+="<tr><th>Labels</th><th>Values</th></tr>";
	for(var i=0; i< labels.length;i++)
		{
		str+="<tr><td>"+labels[i]+"</td><td>"+values[i]+"</td></tr>";
		}
	str+="</table></div></div>"
		
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
	
   var str="<select class='btn btn-dasboard dropdown-toggle' data-toggle='dropdown' id='surveyor_"+idx+"' name='surveyor_"+idx+"'  style='width:300px;color:black'>"
   renderedFilters.push("surveyor_"+idx);
   str+=	"<option >---Choose surveyor-";//+surveyors[i].value;
   for(var i=0;i<surveyors.length;i++){
		if(curVal==surveyors[i].name)
	str+=	"<option value='"+surveyors[i].name+"' selected>"+surveyors[i].value;
		else
			str+=	"<option value='"+surveyors[i].name+"'>"+surveyors[i].value;
	}
	str+="</select>";
	return str;
}
function getAreaFilter(idx,curVal){
	
	   var str="<select class='btn btn-dasboard dropdown-toggle' data-toggle='dropdown' id='area_"+idx+"' name='area_"+idx+"'  style='width:300px;color:black'>"
	   renderedFilters.push("area_"+idx);
	   
	   str+=	"<option >---Choose area-";//+surveyors[i].value;
	   for(var i=0;i<areas.length;i++){
			if(curVal==areas[i].name)
		str+=	"<option value='"+areas[i].name+"' selected>"+areas[i].value;
			else
				str+=	"<option value='"+areas[i].name+"'>"+areas[i].value;
		}
		str+="</select>";
		return str;
	}
function getAgeTypeFilter(idx,curVal){
	
	   var str="<select class='btn btn-dasboard dropdown-toggle' data-toggle='dropdown' id='type_"+idx+"' name='type_"+idx+"'  style='width:300px;color:black'>"
	   renderedFilters.push("type_"+idx);
	   str+=	"<option >---Choose age type-";//+surveyors[i].value;
	   
	  
	   for(var i=0;i<ageType.length;i++){
			if(curVal==ageType[i].name)
		str+=	"<option value='"+ageType[i].name+"' selected>"+ageType[i].value;
			else
				str+=	"<option value='"+ageType[i].name+"'>"+ageType[i].value;
		}
		str+="</select>";
		return str;
	}
var renderedFilters=[];
function getPeriodFilter(idx,curVal)
{
	var str="<label style='font-size:15px; color:blue'> Date-From: </label><input style='background-color:white;width:80px' id='datefrom_"+idx+"' name='datefrom_"+idx+"'  type='text'  value='"+curVal[0]+"'  onchange='settoAll()' readonly>" ;
	renderedFilters.push("datefrom_"+idx);
	 str  += "<label style='font-size:15px; color:blue'> Date-To: </label><input style='background-color:white;width:80px' id='dateto_"+idx+"' name='dateto_"+idx+"'  type='text' value='"+curVal[1]+"' onchange='settoAll()' readonly>";
	renderedFilters.push("dateto_"+idx);
return str;
}

function getPanelButtons(idx)
{
	var types=config[idx].types;
	var filter=config[idx].filters;
	
	var str="";
	
	if(types[0]!="table")
{
	for(var i=0;i<types.length;i++){
		if(types[i]!='table')
		str+="<button type='button' class='btn btn-info' onclick=setType("+idx+",'"+types[i]+"')> "+types[i]+ " chart</button >&nbsp;";
		//str+="<button type='button' class='btn btn-warning'id='data' onclick=getTable("+idx+")>Data</button >&nbsp";
	}
	
	str+="<button type='button' class='btn btn-warning'id='data' onclick=getTable("+idx+")>Data</button >&nbsp";
}	
	//str+="<form name='filterform_"+idx+"' name='filterform_"+idx+"' onsubmit='survey_monitoring_dashboard.jsp'> ";
	str+="<input type=hidden name=tabs value="+tabName+"> <input type=hidden name=dashboard value="+dashboard+"> ";
	
if(filter!=null)
{
	for(var i=0;i<filter.length;i++){
		
		if(filter[i]=="surveyors")
			str+="<br><label style='font-size:15px; color:black'> Surveyors: </label>  "+getSurveyorFilter(idx,filterValues[idx].surveyor)+"";
		else
			if(filter[i]=="areas"){
				
				str+="<br><label style='font-size:15px; color:black'> Areas	: </label>  "+getAreaFilter(idx,filterValues[idx].area)+"";
			}
			else
				if(filter[i]=="ageType"){
					str+="<br><label style='font-size:15px; color:black'> Age Type	: </label>  "+getAgeTypeFilter(idx,filterValues[idx].type)+"";
				}
		
		else
			if(filter[i]=="period")
				str+="<br>"+getPeriodFilter(idx,filterValues[idx].period);//"<label style='font-size:15px; color:blue'> Date-From: </label><input style='background-color:white;width:80px' id='datefrom' name='datefrom'  type='text'  value='01/01/2018' onchange='settoAll()' readonly>" +
						//"<label style='font-size:15px; color:blue'> Date-To: </label><input style='background-color:white;width:80px' id='dateto' name='dateto'  type='text' value='02/02/2018' onchange='settoAll()' readonly>"; 
		/*<br><b>Filters:</b>Start :<input style='width:50px' > End: <input style='width:50px'>  Surveyor "+getSurveyorFilter(0)+"*/
			else
		str+="";//&nbsp; <button class='btn btn-primary' style1='margin-left:100px' onclick=showCal("+idx+",'"+filter[i]+"')> "+filter[i]+ "</button >&nbsp;";
		
		
		
}
	
	fld_renderedFilters.value=renderedFilters.join(",");
///str+="<button class='btn btn-warning' onclick='filterform_"+idx+".submit()'> Go </button >&nbsp";
str+="&nbsp<button class='btn btn-warning' onclick='filterform.submit()'> Go </button >&nbsp";
}
	
	//str+="</form>";
	
		return "<div class='panel-body'><div class='box1' ><div>"+str+"</div><div id='myTable"+idx+"'></div><canvas id='myChart"+idx+"' width1='400' height='200'></canvas></div></div></div>";
	
}
var cols=1;
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

	str+="<div class='panel panel-danger'><div class='panel-body'>"+getPanelButtons(i)+"</div></div>"
str+="</td>";	
str+="<td>";
str+="</td>";

}
	str+="</table>";
	//str+="</div>";
	layout.innerHTML=str;
}


function hideAllPage(idx,total)
{
	
	var tableId="tr_"+idx;
	for(var i=0; i<total;i++)
		{
		var rowId=tableId+"_"+i;
		document.getElementById(rowId).style.display="none";
		}
	
}

function displayPage(pgno,idx,pageSize,noOfPages)
{
	hideAllPage(idx,data[idx].values.length);
	//alert("pgno-"+pgno);alert("idx---"+idx);alert("pagesize--"+pageSize);;alert("noofpagess---"+noOfPages);
	var tableId="tr_"+idx;
	for(var i=0; i<pageSize;i++)
	{
	var rowId=tableId+"_"+(i+(pgno*pageSize));
	//document.getElementById(rowId).className="btn  btn-default active";
	document.getElementById(rowId).style.display="table-row";
	}
	return false;
}
// function to display pagination buttons
//total is total number of records
// pagesize is records per page
function getPageCtrls(total, pageSize,idx)
{
	
	var str="";
	//find quotient
	var moreRecords=~~(total/pageSize);
	var butPerPage=total/pageSize;
		// button of pagination
		for(var i=0; i<total/pageSize; i++)
			{
			
				str+="<a class='btn btn-default' onclick='displayPage("+i+","+idx+","+pageSize+","+(total/pageSize)+")'><span class='btn btn-info'>"+(i+1)+"</span></a>";
			
		
		
	
			}		
	
	
	return str;
}
//function to display table 
function getTableReport(idx){
	/*var str="<div class='container'><div class='row'><div class='table-responsive2'>"*/
	var str="<h5  align='center'>"+getTitle(data[idx])+"</h5>"
	 //str+="<div class='container'>";
	var tableId="tr_"+idx;	
	var pageSize=10;
	if(config[idx].pageSize!=null)
		pageSize=config[idx].pageSize;
	
	var links=config.links;
	
	str+="<div class='table-responsive2'>";
	/*str+="<input class='form-control' id='myInput' type='text' placeholder='search...'><br>";*/

	 str+="<table id='"+tableId+"' class='table table-striped'>";
	 //str+="<table id='"+tableId+"'  class='table table-striped' width=100% >";
	var labels=getLabels1(data[idx]);
	var values=getValues1(data[idx]);
	
	//str+="<tr><th>coloums</th><th>columns2</th></tr>";
	
	str+="<tr>";
	if(config[idx].hasOwnProperty('colHeadings')){
		str+="<tr>";
		for(var i=0; i<config[idx].colHeadings.length;i++)
			{
			str+="<td style='word-break:break-all'>"+config[idx].colHeadings[i]+"</td>";
			}
		str+="</tr>";
		}
	for(var i=0;i<config[idx].columns.length;i++){
		str+="<th style='word-break:break-all'>"+config[idx].columns[i]+"</th>";
	}
	str+="</tr></table>"
	//	str+="<div class='table-responsive2'>";
		 str+="<table id='"+tableId+"' class='table table-striped'>";
	if(config[idx].hasOwnProperty('rowHeadings')){	
	for(var i=0; i<config[idx].rowHeadings.length;i++)
		{
		
		
		
		str+="<tr><td style='word-break:break-all'>"+config[idx].rowHeadings[i]+"</td></tr>";
		}
	}
	
for(var i=0; i<data[idx].values.length;i++)
		{
	var rowId=tableId+"_"+i;
	var style="";
	if(i>=pageSize)
		style="display:none"
	
			str+="<tr  id='"+rowId+"' style='"+style+"'>"
for(var j=0; j<config[idx].columns2.length;j++){
	
	//if(data[idx].values[i][config[idx].columns2[j]]!=null){
//	if(data[idx].values[i][config[idx].columns2[j]].length>50){
		//str+="<td style='word-break:break-all'><a href='view_narrative.jsp?narrative="+data[idx].values[i][config[idx].columns2[j]]+"' data-toggle='tooltip'  data-placement='bottom'  data-original-title='Tooltip on bottom' title='"+data[idx].values[i][config[idx].columns2[j]]+"'><span onmouseover='setStyle("+data[idx].values[i][config[idx].columns2[j]].length+")'></span>hover to view complete text</a></td>";
	//}
	
	//str+="<div id='dialog'><p>THIS IS DIALOG!!!</p></div><button id='opener'>Open Dialog</button>";
	
	//else{
		var linkstr= getLinks(config[idx],j,data[idx].values[i]);
str+="<td style='word-break:break-all'>"+data[idx].values[i][config[idx].columns2[j]]+ " "+linkstr+"</td>";
//}
//}
		
}
	str+="</tr>";
}


	str+="</table></div>"
		/*str+="</div></div></div>"*/
		//alert(JSON.stringify(data[idx].values.length));
		// data[idx].values is the records/rows data[idx].values.length is the total no of rows
		
		str+="<div>"+getPageCtrls(data[idx].values.length,pageSize,idx)+"</div>";
	document.getElementById("myTable"+idx).innerHTML=str;
	//$(document).ready( function () {    $('#tr_"+idx+"').DataTable();} );		

	document.getElementById("myChart"+idx).style.display="none";
	
	document.getElementById("myTable"+idx).style.display="block";
if(document.getElementById("data")!=null)
	document.getElementById("data").style.display="none";
}




function getLinks(configObj,colIdx,valueObj)
{
//	console.log(configObj);
	var links=configObj.links;
	var field=configObj.columns2[colIdx];
	
	//console.log(links);
	
	//console.log(field);
	if(links==null)
		return "";
	for(var i=0; i< links.length;i++)
		{
	if(	links[i].name==field)
		{
		var fields=links[i].url.split("#")
		var vals=[];
		var url=fields[0];
		for(var j=1; j< fields.length;j+=2)
			{
			var fld=fields[j];
			var val=eval("valueObj."+fld);
			console.log(fld+" "+val);
			
			console.log(valueObj)
			url+=val;
		}
	console.log(url);
	return "<a href='"+url+"'>"+links[i].text+"</a/>";
		}
		}
return "";
	
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
function displaycharts(colorNum,colNum){
	Chart.defaults.line.fill = false;	
	color.num=colorNum;
	color.colNum=colNum;
setLayout();


for(var i=0; i<data.length;i++)
	{
	var ctype="bar";
	var ctx = document.getElementById('myChart'+i).getContext('2d');
myCharts.push(getDefaultChart(i));
	}
}

$(function() {
    $( "#dialog" ).dialog({
      autoOpen: false
    });

    $( "#opener" ).click(function() {
      $( "#dialog" ).dialog( "open" );
    });
  });