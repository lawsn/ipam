<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file= "./DBConnection.jsp" %>


<%

	
	Connection conn = null;
	try{
		
		out.println("<br>db connection test :");
		out.println("<br>-------------------------------------");
		conn = getConnection();
		out.println("<br>db user test : connection = " + conn);
		
	    out.println("<br><br>result: test success!!! :");  
			
	}catch(Exception e){
	        e.printStackTrace();
	        out.println("<br>error: "+e);
	        System.out.println(e);
	        
	        closeDB(null, null, conn, null);
	}
%>

