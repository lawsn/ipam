<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ include file= "../db_user.jsp" %>

<%

		List<HashMap> userList = null;
		int count = 0;
        try{
        	
        	
			/***************************************************
			* batch update flag  테스트1: 전체 업데이트
			****************************************************/
			out.println("<br><br>-------------------------------------------");
			out.println("<br>db user test1 : batch updated flag");
        	out.println("<br>-------------------------------------------");
        	String flag = "f";
        	db_user_update_batch_flag(flag, null);
        	out.println("<br>flag:"+flag);
	       	out.println("<br>result: update success!!! :");
	       	
			/***************************************************
			* batch update flag  테스트2: 사용자 flag 업데이트
			****************************************************/
			out.println("<br><br>-------------------------------------------");
	    	out.println("<br>db user test2 : batch updated flag");
        	out.println("<br>-------------------------------------------");
			
        	/////////////////////////////////////////////////////
        	//insert user
        	HashMap userItem = new HashMap();
			String user_id = getCurrentTimeLongString()+"_batch";
			
			userItem.put("user_id", user_id);
			userItem.put("user_name", user_id);
			userItem.put("ip_list", "127.10.10.1,127.10.10.2,255.255.255.255");
			userItem.put("other_desc", "other_desc-batch");
			userItem.put("allow_excp", "f");
			
			db_user_insert(userItem);
			
        	/////////////////////////////////////////////////////
        	//update user batch flag
        	flag = "t";
			db_user_update_batch_flag(flag, user_id);
			out.println("<br>user_id:"+user_id);
			out.println("<br>flag:"+flag);
			out.println("<br>result: update success!!! :");
			
	       	
				
        }catch(Exception e){
                e.printStackTrace();
                out.println("<br>error: "+e.toString());
        }
        finally
        {   if(userList!=null)
        		userList.clear();
    	}
%>

