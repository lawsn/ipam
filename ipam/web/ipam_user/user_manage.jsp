<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./ipam_user_service.jsp" %>
<%
String proc = nullToBlank(request.getParameter("proc"));
if("cteate".equals(proc)) {
	// check dupl.. if dupl then return;
}
if("create".equals(proc) || "update".equals(proc)) {
	IpamUserVo userVo = new IpamUserVo();
	userVo.user_id = request.getParameter("user_id");
	userVo.user_name = request.getParameter("user_name");
	userVo.ip_list = request.getParameter("ip_list");
	userVo.other_desc = request.getParameter("other_desc");
	userVo.allow_excp = request.getParameter("allow_excp");
	db_user_manage(userVo);
	return;
}

String user_id = nullToBlank(request.getParameter("user_id"));
if("undefined".equals(user_id)) {
	user_id = "";
}

if("delete".equals(proc)) {
	db_user_delete(user_id);
}
%>
<div id="layer1" class="pop-layer">
	<div class="pop-container">
		<div class="pop-conts">
			<form name="frm_manage" method="post" action="./ipam_user_manage.jsp" accept-charset="euc-kr">
			<input type="hidden" name="proc" value="<%="".equals(user_id)?"create":"update"%>" />
			<ul>
				<li><input type="text" name="user_name" placeholder="�̸�" /></li>
				<li>
				<%if("".equals(user_id)) {%>
					<input type="text" name="user_id" placeholder="���" />
				<%}else{%>
					<input type="hidden" name="user_id" value="<%=user_id%>" /><%=user_id%>
				<%}%>
				</li>
				<li><input type="text" name="ip_list" placeholder="�����IP (�������� ��� , �� ����)" /></li>
				<li><input type="text" name="other_desc" placeholder="���" /></li>
				<li><input type="checkbox" name="allow_excp" value="t" />�������</li>
			</ul>
			<input type="button" onclick="ipam.user.closeLayer('layer1');" value="���"/> <input type="button" onclick="ipam.user.process(document.forms['frm_manage']);" value="Ȯ��"/>
			</form>
		</div>
	</div>
</div>
                    
<script type="text/javascript">
    jQuery(document).ready(function() {
        
        
    
    });
</script>
