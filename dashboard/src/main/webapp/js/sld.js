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
    		position:"left"
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
{var values=[];
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
        backgroundColor: [
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

                      ],
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
function getDataTable(idx){
	alert("f");
	var str="<h5 style=\"color:blue\">"+idx+"</h5>";
	str+="<div class=\container\">";
	str+="<div class=\"panel-body\">";
	str+="<div class=\"table-responsive\">";
	str+="<table class=\"table table-bordered table-hover table-striped\">";
	str+="<thead><tr><th style=\"text-align:center\">Mother Name</th><th style=\"text-align:center\">Phone1</th><th style=\"text-align:center\">Phone2</th></tr></thead>";
	str+="<tbody  style=\"height:10%\">";
	str+="</tr>";
	str+="</tbody></table></div></div></div>";
	str+="</center>";
}
function getPanelButtons(idx)
{
	var types=config[idx].types;
	var str="";
	for(var i=0;i<types.length;i++){
		str+="<button class='btn btn-info' onclick=setType("+idx+",'"+types[i]+"')> "+types[i]+ " chart</button >&nbsp;";
	}
	return "<div class='panel-body'><div class='box1' ><div>"+str+"<button class='btn btn-warning'onclick=getTable("+idx+")>Data</button ></div><div id='myTable"+idx+"'></div><canvas id='myChart"+idx+"' width1='400' height='200'></canvas></div></div></div>";
}

function setLayout()
{
	var size=data.length;
	var cols=2;
	var tdsize=parseInt(100/cols);
	//var tdsize=100;
	var idx=0;
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
   str+="<table class='container' width=100% >";
	for(var i=0; i< size;i++)
		{
if(i%cols==0)
{
if(i>0)
str+="</tr>"
str+="<tr>"

}

str+="<td width="+tdsize+"%>"

	str+="<div class='panel panel-info'>"+getPanelButtons(i)+"</div>"
str+="</td>";	
str+="<td>";
str+="</td>";

}
	str+="</table>";
	//str+="</div>";
	layout.innerHTML=str;
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
		
		return getBarChart(idx);
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


