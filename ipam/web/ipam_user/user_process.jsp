<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./user_service.jsp" %>
<%
String user_id = null;
String proc = null;
IpamUserVo selectedUserVo = null;
String result = "SUCCESS";

user_id = nullToBlank(request.getParameter("user_id"));

if("".equals(user_id)) {
	result = "ó���� ����������� �����ϴ�.";
	
}else {
	proc = nullToBlank(request.getParameter("proc"));

	selectedUserVo = db_user_by_id(user_id);
	
	/////////////////////////////////////////////////////////
	//DELETE PROCESS
	/////////////////////////////////////////////////////////
	if("delete".equals(proc)) {
		if(selectedUserVo == null) {
			result = "����ڰ� �������� �ʽ��ϴ�.";
		}else {
			db_user_delete(user_id);
		}
	}
	
	/////////////////////////////////////////////////////////
	//CREATE PROCESS
	/////////////////////////////////////////////////////////
	if("create".equals(proc)) {
		if(selectedUserVo == null) {
			IpamUserVo userVo = new IpamUserVo();
			userVo.user_id = nullToBlank(request.getParameter("user_id"));
			userVo.user_name = nullToBlank(request.getParameter("user_name"));
			userVo.ip_list = nullToBlank(request.getParameter("ip_list"));
			userVo.other_desc = nullToBlank(request.getParameter("other_desc"));
			userVo.allow_excp = nullToBlank(request.getParameter("allow_excp"));
			db_user_manage(userVo);
		}else {
			result = "�̹� �����ϴ� ������Դϴ�.";
		}		
	}
	
	/////////////////////////////////////////////////////////
	//UPDATE PROCESS
	/////////////////////////////////////////////////////////
	if("update".equals(proc)) {
		if(selectedUserVo == null) {
			result = "����ڰ� �������� �ʽ��ϴ�.";
		}else {
			IpamUserVo userVo = new IpamUserVo();
			userVo.user_id = nullToBlank(request.getParameter("user_id"));
			userVo.user_name = nullToBlank(request.getParameter("user_name"));
			userVo.ip_list = nullToBlank(request.getParameter("ip_list"));
			userVo.other_desc = nullToBlank(request.getParameter("other_desc"));
			userVo.allow_excp = nullToBlank(request.getParameter("allow_excp"));
			db_user_manage(userVo);
		}		
	}
}

org.json.simple.JSONObject json = new org.json.simple.JSONObject();
json.put("RESULT", result);
out.print(json);
out.flush();
%>
