<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./user_service.jsp" %>
<%
String result = "SUCCESS";
String user_ip = nullToBlank(request.getParameter("user_ip"));
if("".equals(user_ip)) {
	result = "ó���� IP������ �����ϴ�.";
}else {
	List<IpamUserVo> findUserList = db_user_by_ip(user_ip);
	if(findUserList == null || findUserList.size() == 0) {
		result = "����ڰ� �������� �ʽ��ϴ�.";
	} 
}
org.json.simple.JSONObject json = new org.json.simple.JSONObject();
json.put("RESULT", result);
out.print(json);
out.flush();
%>
