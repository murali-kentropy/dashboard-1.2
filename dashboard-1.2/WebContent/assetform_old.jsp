<%@page import="database.CrudOperations"%>
<%@page import="database.GenerateDashboardData"%>
<%@page import="org.json.JSONObject,java.io.*"%>
<%@page import="org.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>assets form</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
 <link rel="stylesheet" href="style.css">
 <script src="js/validate_field.js"></script>
  <style>
 
 label{
 
 font-size:20px;
 }
  span {
    display: inline-block;
   
    margin: 8px;
    background-color: rgb(240, 240, 240);
  }
  </style>
</head>
<body>
<% 
String res="";
if(request.getParameter("res")!=null){
	res=request.getParameter("res");
	if(res.equals("true")){
	%>
	<script>
	alert("Asset updated successfully....");
	window.open("survey_monitoring_dashboard.jsp?dashboard=assetmanagement&tabs=assetmanagement","_self");
	
	</script>
	<%
	}
	if(res.equals("false")){
		%>
		<script>
		alert("Sorry update operation failed , please try again later...");
		window.open("survey_monitoring_dashboard.jsp?dashboard=assetmanagement&tabs=assetmanagement","_self");
		
		</script>
		<%
}
	
}


GenerateDashboardData.confirgPath=request.getRealPath("/")+"/dashboards";
/* JSONArray surveyors=GenerateDashboardData.getSurveyors(); */
JSONArray locations=GenerateDashboardData.getLocations();
JSONArray asset_type=GenerateDashboardData.getAssetType();
JSONArray staff=GenerateDashboardData.getStaff();				
				
CrudOperations crop=new CrudOperations();
int asset_no=0;
String type="";String name="";String serial_no="";String ano="";String verified="";
String status="";String location="";String assignedto=""; String history="";String model="";
JSONObject obj=new JSONObject();				
if(request.getParameter("asset_no")!=null){
	asset_no=Integer.parseInt(request.getParameter("asset_no"));
	obj=crop.getByAssset_no(asset_no);
if(obj.has("type"))type=obj.getString("type");if(obj.has("name"))name=obj.getString("name");if(obj.has("asset_no"))ano=obj.getString("asset_no");if(obj.has("verified"))verified=obj.getString("verified");
if(obj.has("location"))location=obj.getString("location");if(obj.has("serial_no"))serial_no=obj.getString("serial_no");if(obj.has("status"))status=obj.getString("status");if(obj.has("assignedto"))assignedto=obj.getString("assignedto");
if(obj.has("history"))history=obj.getString("history");if(obj.has("model"))model=obj.getString("model");

System.out.println("ame-----------"+obj);
	
	
}
%>
<script>
<%-- var surveyors=<%=surveyors%>; --%>
var locations=<%=locations%>;
var asset_type=<%=asset_type%>;
var staff=<%=staff%>;
function createOpts(obj,opts,selectedVal)
{
	
	
	var optstr="";					
	optstr+="<option value='' > choose...";	
	for(var i=0; i< opts.length;i++)
	{		
		var selected="";
		 if(selectedVal.trim() == opts[i].value.trim()){						
			selected = "selected";
		//alert(selectedVal+" == "+opts[i].value);
		}
		
		optstr+="<option value='"+opts[i].name+"' "+selected+">"+opts[i].value;																	
	}										
	obj.innerHTML=optstr;
	
}
</script>
<script>
function setFieldRequired(field1,field2){
	
	var field1_val = document.getElementById("field1").value;
	if(field1_val=="yes"){
		alert("yes");
		document.getElementById("field2").required = true;
	}
		
}
function check_Alpha(form,fname){
	var form1=form;
	var fname1=fname;
	var ff=document.getElementById(fname);
	
	var val = document.forms['"'+ form1+  '"']['"'+ ff+  '"'].value;
	alert(val)
    var regex = /^[a-zA-Z0-9 ]*$/;
    if(regex.test(val) == false){
   alert("Name must be in alphabets only");
   field.focus();
   return false;
    }
    
    return true;
  }
</script>
<div class="container" align="center"><br><br>

<label class="form-group" for="heading" style="font-size:50px; background-color:red;color:white">ASSET</label>
<br><br>


<form method="get" name="asset" action="assetcrud.jsp" >
<span class="rounded-lg" >
<input type="hidden" name="asset_no" value=<%=asset_no%>>
<input type="hidden" name="history" value=<%=history%>>
<table>
<tr>
<th><label class="form-group" for="type">Type : </label><br></th>
<td><select required style="font-size:15px;" name="type" id="type" required>

</select> 


				<script>
					

					 selectedVal="<%=type%>";
					//createOpts(type,asset_type,selectedVal);
					var optstr="";
				
					//var arr=JSON.stringify(asset_type);
					optstr+="<option value='' "+selected+"> choose...";
					
					for(var i=0; i< asset_type.length;i++)
					{		
						var selected="";
						 if(selectedVal == asset_type[i].name)						
							selected = "selected";	
						optstr+="<option value='"+asset_type[i].value+"' "+selected+">"+asset_type[i].name;																	
					}										
					type.innerHTML=optstr;	
				</script>
</td>
</tr>
<tr></tr><tr></tr><tr></tr>
<tr>
<th><label class="form-group" for="name">Name : </label><br></th>
<td><input  required style="font-size:15px;" type="text" id="fname" name="fname" value="<%=name%>" onfocusout="check_Alpha(asset,fname)" required> </td>
</tr>
<tr><th></th><td></td></tr>
<tr>
<th><label class="form-group" for="assignedto">Assigned to : </label></th>
<td >

				<select id="assignedto" name="assignedto" style="font-size:15px; padding:08px"> 										
				</select>  &nbsp;							
				
				<!-- obtain the value from js file into dropdown list-->	
				<script>
				
				
					
				

					var selectedVal="<%=assignedto%>";
					
					
					//createOpts(assignedto,surveyors,selectedVal);
					var str="";					
	str+="<option value='' > choose...";	
	
	for(var i=0; i< staff.length;i++)
	{		
		var selected="";
		
		//alert(selectedVal.trim().length+"-----"+surveyors[i].value.trim().length);
		 if(selectedVal.trim() == staff[i].value.trim()){						
			selected = "selected";
		//alert(selectedVal+" == "+surveyors[i].value);
		}
		
		str+="<option value='"+staff[i].name+"' "+selected+">"+staff[i].value;																	
	}										
	assignedto.innerHTML=str;
					
									</script>
</td>

</tr>
<tr></tr><tr></tr><tr></tr>
<tr>
<th><label class="form-group" for="serialno">Serial no: </label></th>
<td><input style="font-size:15px;" type="text" name="serialno" value="<%=serial_no%>"> </td>
</tr>
<tr>
<th><label class="form-group" for="model">Model : </label></th>
<td><input style="font-size:15px;" type="text" name="model" value="<%=model%>"> </td>
</tr>
<tr></tr><tr></tr><tr></tr>
<tr>
<th><label class="form-group" for="verified">Verified :  </label></th>
<td>
<select  style="font-size:15px;" name="verified" id="verified"  onfocusout="setFieldRequired(verified,status2)" required>
</select> 

<script>
					
				 var arr=["Yes","No"];
					 selectedVal="<%=verified%>";
					var optstr="";					
					optstr+="<option value='' "+selected+"> choose...";
					
					for(var i=0; i< arr.length;i++)
					{		
						var selected="";
						 if(selectedVal == arr[i])						
							selected = "selected";	
						optstr+="<option value='"+arr[i]+"' "+selected+">"+arr[i];																	
					}										
					verified.innerHTML=optstr;				
					 
				</script>
<br></td>
</tr>
<tr></tr><tr></tr><tr></tr>
<tr>
<th><label class="form-group" for="status">Status : </label></th>
<td >

<select  id="status2" name="status2" style="font-size:15px; padding:08px"> 										
				</select>  &nbsp;							
				
				<!-- obtain the value from js file into dropdown list-->	
				<script>
					
				 var arr=["Perfect","Absolute","Working","Not Working","Under-Repair","Defective (Stock)","Good"];
					 selectedVal="<%=status%>";
					var optstr="";					
					optstr+="<option value='' "+selected+"> choose...";
					
					for(var i=0; i< arr.length;i++)
					{		
						var selected="";
						 if(selectedVal == arr[i])						
							selected = "selected";	
						optstr+="<option value='"+arr[i]+"' "+selected+">"+arr[i];																	
					}										
					status2.innerHTML=optstr;				
					 
				</script>
 </td>
</tr>
<tr></tr><tr></tr><tr></tr><tr></tr>
<tr>
<th><label class="form-group" for="comsa_Location">Location</label></th>
<td> 
<select id="comsa_location" name="location" style="font-size:15px; padding:08px" verified> 										
				</select>  &nbsp;							
				
				
				<script>
					

					 selectedVal="<%=location%>";
					createOpts(comsa_location,locations,selectedVal);
				</script>
</td>
</tr>

</table><br>
</span><br><br>
<a href="survey_monitoring_dashboard.jsp?dashboard=assetmanagement&tabs=assetmanagement" class="btn btn-info" >Cancel</a>

<button class="btn btn-warning" >Save</button>
</form>

</div>
</body>
</html>