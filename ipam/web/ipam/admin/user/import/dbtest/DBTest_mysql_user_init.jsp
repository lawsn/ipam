<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ include file= "../db_nac_user.jsp" %>

<%

		List<HashMap> userList = null;

        try{

        	/*****************************************************
        	100명 사용자를 초기화한다.
        	*****************************************************/
			out.println("<br><br>nac user test : insert");
			out.println("<br>-------------------------------------------");
			HashMap userItem = new HashMap();
			String userid = "";
			String username = "";
			int ncount = 100;
			for(int i=0; i<ncount; i++){
				userid = getCurrentTimeLongString()+"_"+i;
				username = "name_"+userid;
				userItem.put("nuser_id", userid);
				userItem.put("nuser_name", username);
				userItem.put("nip_list", "127.10.10.1,192.0.0."+i);
				//userItem.put("other_desc", "other_desc");
				//userItem.put("allow_excp", "f");
				db_nac_user_insert(userItem);
				out.println("<br>result: success:"+userid);
			}
			
			out.println("<br>result: nac insert success!!! :");
			

			
				
        }catch(Exception e){
                e.printStackTrace();
                out.println("<br>error: "+e.toString());
        }
        finally
        {   if(userList!=null)
        		userList.clear();
    	}
%>

