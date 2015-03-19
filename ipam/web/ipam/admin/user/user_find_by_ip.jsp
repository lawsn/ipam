<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./user_service.jsp" %>
<%
String result = "SUCCESS";
String user_ip = nullToBlank(request.getParameter("user_ip"));
if("".equals(user_ip)) {
	result = "처리할 IP정보가 없습니다.";
}else {
	List<IpamUserVo> findUserList = db_user_by_ip(user_ip);
	if(findUserList == null || findUserList.size() == 0) {
		result = "사용자가 존재하지 않습니다.";
	} 
}
org.json.simple.JSONObject json = new org.json.simple.JSONObject();
json.put("RESULT", result);
out.print(json);
out.flush();
%>
