<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ include file= "./db_user.jsp" %>

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
        		out.println("<br>item["+i+"]"+": user_id="+user_id+", user_name="+user_name);
        		
        	}
        
			out.println("<br><br>result: test success!!! :");
			
			out.println("<br><br>db user test : insert");
			out.println("<br>-------------------------------------------");
			HashMap userItem = new HashMap();
			
			userItem.put("user_id", getCurrentTimeLongString());
			userItem.put("user_name", getCurrentTimeLongString());
			userItem.put("ip_list", "127.10.10.1,127.10.10.2");
			userItem.put("other_desc", "other_desc");
			userItem.put("allow_excp", "f");
			
			db_user_insert(userItem);
			out.println("<br>result: insert success!!! :");
			
			/***************************************************
			* search 테스트
			****************************************************/
			List<HashMap> searchList = null;
			searchList = db_user_search("user1",null,null,null);
			count = searchList.size();
			out.println("<br><br>db user test : search");
        	out.println("<br>-------------------------------------------");
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
        	
        	searchList = db_user_search(null,null,null,"t");
			count = searchList.size();
			out.println("<br><br>db user test : search");
        	out.println("<br>-------------------------------------------");
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
        	
        	
			/***************************************************
			* update 테스트
			****************************************************/
			out.println("<br><br>db user test : update");
			out.println("<br>-------------------------------------------");
			HashMap upItem = new HashMap();
			
			userItem.put("user_id", "user1");
			userItem.put("user_name", "user1-update");
			userItem.put("ip_list", "127.10.10.1,127.10.10.2,255.255.255.255");
			userItem.put("other_desc", "other_desc-update");
			userItem.put("allow_excp", "t");
			
			db_user_update(userItem);
			out.println("<br>result: update success!!! :");
			
			/***************************************************
			* delete 테스트
			****************************************************/
			out.println("<br><br>db user test : delete");
			out.println("<br>-------------------------------------------");
			HashMap inItem = new HashMap();
			
			userItem.put("user_id", "user1-delete");
			userItem.put("user_name", "user1-delete");
			userItem.put("ip_list", "127.10.10.1,127.10.10.2,255.255.255.255");
			userItem.put("other_desc", "other_desc-update");
			userItem.put("allow_excp", "t");
			db_user_insert(userItem);
			
			db_user_delete("user1-delete");
			out.println("<br>result: delete success!!! :");
			
				
        }catch(Exception e){
                e.printStackTrace();
                out.println("<br>error: "+e);
                System.out.println(e);
        }
        finally
        {   if(userList!=null)
        		userList.clear();
    	}
%>

