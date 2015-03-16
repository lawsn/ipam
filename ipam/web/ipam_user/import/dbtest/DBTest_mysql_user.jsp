<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ include file= "../db_nac_user.jsp" %>

<%

		List<HashMap> userList = null;
		String map_user_id = "nuser_id";
		String map_user_name = "nuser_name";
		String map_ip_list = "nip_list";

        try{
        	
        	userList = db_nac_user_list();
        	
        	int count = userList.size();
        	out.println("<br>nac user test :");
        	out.println("<br>-------------------------------------------");
        	out.println("<br>nac user test : count = " + count);
        	
        	out.println("<br>nac user content :");
        	out.println("<br>-------------------:");
        	for(int i=0; i<count; i++){
        		
        		String user_id = (String)userList.get(i).get(m_NMAP_USER_ID);
        		String user_name = (String)userList.get(i).get(m_NMAP_USER_NAME);
        		String nip_list = (String)userList.get(i).get(m_NMAP_IP_LIST);
        		out.println("<br>item["+i+"]"+": user_id="+user_id+", user_name="+user_name);
        		
        	}
        
			out.println("<br><br>result: test success!!! :");
			
			out.println("<br><br>nac user test : insert");
			out.println("<br>-------------------------------------------");
			HashMap userItem = new HashMap();
			
			userItem.put(map_user_id, getCurrentTimeLongString());
			userItem.put(map_user_name, getCurrentTimeLongString());
			userItem.put(map_ip_list, "127.10.10.1,127.10.10.2");
			//userItem.put("other_desc", "other_desc");
			//userItem.put("allow_excp", "f");
			
			db_nac_user_insert(userItem);
			out.println("<br>result: nac insert success!!! :");
			

			/***************************************************
			* delete Å×½ºÆ®
			****************************************************/
			out.println("<br><br>nac user test : delete");
			out.println("<br>-------------------------------------------");
			HashMap inItem = new HashMap();
			
			userItem.put(map_user_id, "user1-delete");
			userItem.put(map_user_name, "user1-delete");
			userItem.put(map_ip_list, "127.10.10.1,127.10.10.2,255.255.255.255");
			//userItem.put("other_desc", "other_desc-update");
			//userItem.put("allow_excp", "t");
			db_nac_user_insert(userItem);
			
			db_nac_user_delete("user1-delete");
			out.println("<br>result: nac delete success!!! :");
			
				
        }catch(Exception e){
                e.printStackTrace();
                out.println("<br>error: "+e.toString());
        }
        finally
        {   if(userList!=null)
        		userList.clear();
    	}
%>

