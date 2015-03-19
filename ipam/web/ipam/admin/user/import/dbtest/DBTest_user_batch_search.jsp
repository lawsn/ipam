<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ include file= "../db_user.jsp" %>

<%

		List<HashMap> userList = null;
		int count = 0;
        try{
        	
        	
			/***************************************************
			* batch update flag search Å×½ºÆ®
			****************************************************/
			List<HashMap> searchList = null;
			String flag = "t";
			searchList = db_user_search_batch_updated_flag(flag);
			count = searchList.size();
			out.println("<br><br>db user test : search updated flag");
        	out.println("<br>-------------------------------------------");
        	out.println("<br>flag = " + flag);
        	out.println("<br>count = " + count);
        	
        	out.println("<br>content :");
        	out.println("<br>-------------------:");
        	for(int i=0; i<count; i++){
        		
        		String user_id = (String)searchList.get(i).get("user_id");
        		String user_name = (String)searchList.get(i).get("user_name");
        		String ip_list = (String)searchList.get(i).get("ip_list");
        		String other_desc = (String)searchList.get(i).get("other_desc");
        		String allow_excp = (String)searchList.get(i).get("allow_excp");
        		String reg_date = (String)searchList.get(i).get("reg_date");
        		String change_date = (String)searchList.get(i).get("change_date");
        		out.println("<br>item["+i+"]"+": user_id="+user_id+", user_name="+user_name+", ip_list="+ip_list+", other_desc="+other_desc+", allow_excp="+allow_excp+", reg_date="+reg_date+", change_date="+change_date);
        	}
        	out.println("<br>result: search success!!! :");
        	
        	
			
				
        }catch(Exception e){
                e.printStackTrace();
                out.println("<br>error: "+e.toString());
        }
        finally
        {   if(userList!=null)
        		userList.clear();
    	}
%>

