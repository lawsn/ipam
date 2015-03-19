<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./ipam_client.jsp" %>
<%
	String client_ip = null;
	String user_id = null;
	String result = null;
	IpamResult ir = null;
	
	
	
	client_ip = nullToBlank(request.getParameter("client_ip"));
	user_id = nullToBlank(request.getParameter("user_id"));
	
	out.println("<br>ipam client test :");
	out.println("<br>user_id   :"+user_id);
	out.println("<br>client_ip :"+client_ip);
	out.println("<br>-------------------------------------------");
	
	if("".equals(client_ip)) {
		result = "처리할 client ip정보가 없습니다.";
		out.println("<br>result :"+result);
		out.flush();
		return;
	}
	
	if("".equals(user_id)) {
		result = "처리할 user id 없습니다.";
		out.println("<br>result :"+result);
		out.flush();
		return;
	}

	try{
		
		ir = Ipam_CheckIp(user_id, client_ip);
		if( ir.result !=0 ){
			if(ir.result==-3){
				out.println("<br>lastAccessIp   : ["+ir.lastAccessIp+"]");
				out.println("<br>lastAccessTime : ["+ir.lastAccessTime+"]");
				out.println("<br>result         :fail : ["+ir.result+"]");
				out.println("<br>result         :접근허용 불가 ");
				out.flush();
				return;
			}
			
			out.println("<br>result         :등록된 사용자가 아님");
			out.println("<br>result         :fail : ["+ir.result+"]");
			out.flush();
			return;
		}
		
		out.println("<br>lastAccessIp   : ["+ir.lastAccessIp+"]");
		out.println("<br>lastAccessTime : ["+ir.lastAccessTime+"]");
		out.println("<br>result         :success : ["+ir.result+"]");
		out.flush();
		return;
	}catch(IpamException e){
		e.printStackTrace();
		out.println("<br>result         : fail : ["+e.toString()+"]");
	}catch(Exception e){
		e.printStackTrace();
		out.println("<br>result         : fail : ["+e.toString()+"]");
	}
	

%>
