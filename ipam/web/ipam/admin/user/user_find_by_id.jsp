<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./user_service.jsp" %>
<%
String result = "SUCCESS";
String user_id = nullToBlank(request.getParameter("user_id"));
if("".equals(user_id)) {
	result = "처리할 사용자정보가 없습니다.";
}else {
	IpamUserVo findUserVo = db_user_by_id(user_id);
	if(findUserVo == null) {
		result = "사용자가 존재하지 않습니다.";
	}
}
org.json.simple.JSONObject json = new org.json.simple.JSONObject();
json.put("RESULT", result);
out.print(json);
out.flush();
%>
