<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ include file= "../DBConnection.jsp" %>


<%

	
	Connection conn = null;
	try{
		
		out.println("<br>db connection test :ipam");
		out.println("<br>-------------------------------------");
		conn = getConnection();
		
		out.println("<br>m_connection_driver = " + m_connection_driver);
		out.println("<br>m_connection_url = " + m_connection_url);
		out.println("<br>m_user = " + m_user);
		
		
	    out.println("<br><br>result: test success!!! :");  
			
	}catch(Exception e){
	        e.printStackTrace();

	        out.println("<br>error: "+e.toString());
	        closeDB(null, null, conn, null);
	}
%>

