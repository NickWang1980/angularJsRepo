<%@ page import="java.sql.*"%>
<%
	/* Class.forName is only required post 11g Oracle version, 11g and prior 11g you need to 
	   download ojdbc.jar depending on oracle version, then you have to omit Class.forName function 
	  call.*/
	//    Class.forName("oracle.jdbc.driver.OracleDriver");
	/* DriverManager creating connection object, didn't put it into try block but you can do so. Format 
	    for connection string is {jdbc:oracle:thin:@[ipaddress or hostname]:oracle_sid" , 
	    "user_name",""password"}. */
        try {
            Class.forName ("oracle.jdbc.OracleDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
	    
	String connStrHome 	= "jdbc:oracle:thin:@192.168.189.128:1521:cdb1";
 	String userNameHome		= "c##fnapp";
	String pwdHome			 	= "fnapp";
	    
	String connStrWork 	= "jdbc:oracle:thin:@SINSA1100332.SG.NET.INTRA:1521:SINFND2";
	String userNameWork		= "FNAPP";
	String pwdWork 			 	= "fnapp";
	
	
	Connection conn = DriverManager.getConnection(connStrHome, userNameHome, pwdHome);

	/* request.getParameter reads from post object sqlStr which is actually an input element in the 
	     html  page consisting of the sql statement */
	/* String sqlStr = "SELECT T.OWNER, T.TABLE_NAME FROM ALL_TABLES T WHERE t.owner = 'C##FNAPP' order by t.table_name"; */
	String sqlCount = "SELECT COUNT(1) FROM ALL_TABLES T where owner not in ( 'SYS', 'SYSTEM')";
	String sqlStr = "SELECT T.OWNER, T.TABLE_NAME FROM ALL_TABLES T where owner not in ( 'SYS', 'SYSTEM')";
	
	System.out.println("sqlStr=["+sqlStr+ "]");
/* 	String sql = request.getParameter("SELECT T.OWNER, T.TABLE_NAME FROM ALL_TABLES T WHERE t.owner = 'FNAPP' order by t.table_name;");
	System.out.println("sql=["+sql+ "]");
 */
	try {
		/* Statement object  need to parse sql statement and return the cursor */
		Statement stmt = conn.createStatement();
		/* Resultset (recordset) object  used to create cursor object */
		ResultSet rs = stmt.executeQuery(sqlStr);
		/* ResultSetMetaData object is used to retrieve column name and table name and number of 
		    columns from parse recordset object using getMetaData function. Since we are attempting to 
		    make table columns dynamic and not be hard coded that's why we are using metadata. */

		ResultSetMetaData rsMetaData = rs.getMetaData();

		int numberOfColumns = rsMetaData.getColumnCount();
		/* JSON data starts here */
		out.print("[");
		rs.next();
		/* Outer loop for each row. */
		while (true) {
			/* Starting of row of an array */
			out.print("{");
			/*  Inner loop for all columns */
			for (int i = 1; i <= numberOfColumns; i++) {
				out.print("\"" + rsMetaData.getColumnName(i) + "\":\""
						+ rs.getString(rsMetaData.getColumnName(i))
						+ "\"");
				if (i < numberOfColumns)
					out.print(",");
			}
			/* Starting of row of an array */
			out.print("}");
			/* This if statement serves two purpose, first one is it's takes cursor to the next record and it's 
			    also check whether it is not at EOF, if not it prints a comma and a newline, as you know 
			    each row in json data is in curly braces and separated by comma. i.e. 
			   {"Name":"Simon","Age":"26"}, and if reaches EOF prints the closing bracket of the array 
			   and exists loop */
			if (rs.next())
				out.print(",\n");
			else {
				out.print("]");
				break;
			}
		}
		/*        Object closed and released.*/stmt.close();
		rs.close();
		stmt = null;
		rs = null;

	} catch (SQLException e) {
		out.println("SQL Error encountered " + e.getMessage());
		System.out.println(e.getMessage());
	}
	conn.close();
	conn = null;
%>