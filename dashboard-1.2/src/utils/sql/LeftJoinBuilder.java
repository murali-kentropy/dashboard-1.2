package utils.sql;

import java.io.ByteArrayInputStream;
//import java.lang.annotation.Repeatable;
import java.util.Arrays;
import java.util.List;

//import org.gibello.zql.*;


import net.sf.jsqlparser.parser.JSqlParser;
import net.sf.jsqlparser.parser.ParseException;

public class LeftJoinBuilder {
	
	public String  join(String table1, String table2, String col1,String col2)
	{
		return table1 +" left join "+table2 +" "+table1+".col1 = "+table2+" .col2";
	}
	public String  join1(String table1, String table2, String col1,String col2)
	{
		return " left join "+table2 +" ON "+table1+"."+col1 +"="+table2+"."+col2;
	}
	
public String mdJoin(String master, List<String> detail, String masterKey,List<String> detailKey)	
{
	String sql=master+" ";
	for (int i=0;i<detail.size();i++)
	{
		sql+=join1(master,detail.get(i),masterKey,detailKey.get(i));
	}
	
	return sql;
	
	
}

	public static void main(String[] args) throws ParseException {
		// TODO Auto-generated method stub
		
		String det="va_neonate,stillBirth,injury,fever,cough,breathing,diarrhoea,vomit,consciousness,convulsions,"+
"skin,jaundice,birthDetails,pregnancyHistory,immunization,va_neonate_extra";

		
		String detKey="deathId,deathId,deathId,deathId,deathId,deathId,deathId,deathId";
		//String detKey="deathId,deathId,deathId,deathId,deathId,deathId,deathId,deathId";
		List<String> detail= Arrays.asList(det.split(","));
		String [] detKey1= new String [detail.size()];
		Arrays.fill(detKey1,"deathId");
		List<String> detailKey= Arrays.asList(detKey1);
System.out.println(new LeftJoinBuilder().mdJoin("deathDetail", detail, "deathId", detailKey));

//ZqlParser zp= new ZqlParser(new ByteArrayInputStream(" select * from tt a ,tt1  where a.kk=10 ;".getBytes()));
//System.out.println("ZP "+zp.readStatements().get(0).getClass().getName());

//ZQuery zq= (ZQuery)zp.readStatements().get(0);

//System.out.println(zq.getWhere());

	}

}
