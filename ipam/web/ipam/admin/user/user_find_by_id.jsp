<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./user_service.jsp" %>
<%
String result = "SUCCESS";
String user_id = nullToBlank(request.getParameter("user_id"));
if("".equals(user_id)) {
	result = "ó���� ����������� �����ϴ�.";
}else {
	IpamUserVo findUserVo = db_user_by_id(user_id);
	if(findUserVo == null) {
		result = "����ڰ� �������� �ʽ��ϴ�.";
	}
}
org.json.simple.JSONObject json = new org.json.simple.JSONObject();
json.put("RESULT", result);
out.print(json);
out.flush();
%>
