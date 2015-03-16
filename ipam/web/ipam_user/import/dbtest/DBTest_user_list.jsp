<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ include file= "../db_user.jsp" %>

<%

		List<HashMap> userList = null;

        try{
        	
        	userList = db_user_list();
        	
        	int count = userList.size();
        	out.println("<br>db user test :");
        	out.println("<br>-------------------------------------------");
        	out.println("<br>db user test : count = " + count);
        	
        	out.println("<br>db user content :");
        	out.println("<br>-------------------:");
        	for(int i=0; i<count; i++){
        		
        		String user_id = (String)userList.get(i).get("user_id");
        		String user_name = (String)userList.get(i).get("user_name");
        		String ip_list = (String)userList.get(i).get("ip_list");
        		out.println("<br>item["+i+"]"+": user_id="+user_id+", user_name="+user_name+", ip_list=["+ip_list+"]");
        		
        	}
        
			out.println("<br><br>result: test success!!! :");
			
			
				
        }catch(Exception e){
                e.printStackTrace();
                out.println("<br>error: "+e.toString());
        }
        finally
        {   if(userList!=null)
        		userList.clear();
    	}
%>