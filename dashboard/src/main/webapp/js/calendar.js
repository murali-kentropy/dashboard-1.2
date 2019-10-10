
		
			$(document).ready(function () 
			{				  
			    var pre = new Date("01/01/2016");
				var date=new Date();				
				date.setDate(date.getDate());
			//	var fromDate=document.getElementById("datefrom").value;
				for(var i=0; i<data.length;i++)
					{
					console.log(	$('#dateto_'+i));
				$('#dateto_'+i).datepicker(
						{
							dateFormat: "yy-mm-dd" ,
							numberOfMonths: 1,			
							//minDate:  fromDate,
							//maxDate:date,
						}
				);

			    $("#datefrom_"+i).datepicker(
					{
						dateFormat: "yy-mm-dd",
						numberOfMonths: 1,			
						//minDate:  pre,
						//maxDate:date,
						onSelect: function(date){            
							var date1 = $('#datefrom').datepicker('getDate');           
							var date = new Date( Date.parse( date1 ) ); 
							date.setDate( date.getDate() + 1 );        
							var newDate = date.toDateString(); 
							newDate = new Date( Date.parse( newDate ) );                      
							$('#dateto').datepicker("option","minDate",newDate);        
							settoAll();
							
			        }
			    });	
					}
			});			
			