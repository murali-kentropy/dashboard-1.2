
function getMultiCharts(ctx, dataArr){
		var myChart = new Chart(ctx, {
    type: 'bar',
    responsive: true,
    data: {
        labels: ["red", "blue", "green", "white", "yellow"],
        
        datasets: [
                   
        {
            label: '#colors',
           data:[12,22,33,44,55],
            backgroundColor: "pink",
            borderWidth: 1
        },
        {
        	label: '#intensity',
            data: [43,87,90,88,77],
            backgroundColor:"grey",
            borderWidth: 1
           
         },
          {
         	label: '#mixing',
             data: [32,65,56,67,76],
             backgroundColor:"gold",
             borderWidth: 1
          } 
        ]
        //datasets: alert(getDataSet(dataArr))
    },
    
    options: {
    	legend: {
            labels: {
                // This more specific font property overrides the global property
                //fontColor: 'black',
                fontSize:20
            }
        },
        scales: {
            yAxes: [{
                ticks: {
                	 min: 0,
                    max: 100,
                    fontSize: 20
                	// beginAtZero:true
                },
                scaleLabel: {
                    display: true,
                    labelString: "values",
                    fontSize: 20
                }
            }],
    xAxes:[{
    	ticks:{
    		 fontSize: 20
    	}
    }]
        }
    }
});
}

function getDataSet(dataArr){
	//var dataset=[];var str={};
	/*var dataset = {
		    str: []
		};*/
	
	alert(JSON.stringify(dataArr));
	for(var i=0;i<dataArr.length;i++){
		alert(dataArr[i].aaa);
		//dataset.push(values);
		dataset.str.push("label:'#colors'");
        // dataset.push("data:'"+values.sss+"'");
		 dataset.str.push("data:55");
		 dataset.str.push("backgroundColor:'pink'");
		 dataset.str.push("borderWidth:1");
        // dataset.push(str);
	}
	//alert(dataset);
	
	alert("dataset:"+JSON.stringify(dataset));
	
	return dataset;	
}