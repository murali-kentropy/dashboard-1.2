<%@page import="utils.sql.SQLQueryBuilder,java.util.Calendar,java.text.*,database.*"%>

<%
try{
Calendar cal=Calendar.getInstance();
	cal.add(Calendar.DATE,-2);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
GenerateDashboardData.confirgPath=request.getRealPath("/")+dashboardPath"/dashboards";
	SQLQueryBuilder.syncBasicDetails(sdf.format(cal.getTime()));
out.println("Completed");
}catch(Exception e)
{
out.println(e);
}
%>
