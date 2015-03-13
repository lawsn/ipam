<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./user_service.jsp" %>
<%
String process = "create";
String user_id = null;
IpamUserVo selectedUserVo = null;

user_id = nullToBlank(request.getParameter("user_id"));
if("undefined".equals(user_id)) {
	user_id = "";
}

if(!"".equals(user_id)) {
	process = "update";
	selectedUserVo = db_user_by_id(user_id);
}
%>
	<form name="frm_manage" method="post">
	<input type="hidden" name="proc" value="<%=process%>" />
	<div id="dyntable_length" class="dataTables_length">
		<%if("create".equals(process)) {%>
			<label><input type="text" name="user_id" placeholder="���" /></label>
		<%}else{%>
			<label style="padding-bottom: 10px;"><strong>��� : <%=user_id%></strong></label>
			<input type="hidden" name="user_id" value="<%=user_id%>" />
		<%}%>
		<label><input type="text" name="user_name" placeholder="�̸�" /></label>
		<label><input type="text" name="ip_list" placeholder="�����IP (�������� ��� , �� ����)" /></label>
		<label><input type="text" name="other_desc" placeholder="���" /></label>
		<label><input type="checkbox" name="allow_excp" value="t" /> �������</label>
	</div>
	<div style="padding-top: 10px; text-align: center;">
		<input type="button" id="xx" value="���"/> <input type="button" id="ok" value="Ȯ��"/>
	</div>
	</form>
                    
<script type="text/javascript">
jQuery(document).ready(function() {
	<%if(selectedUserVo != null) {%>
	var f = document.forms['frm_manage'];
	f.user_name.value = '<%=selectedUserVo.user_name%>';
	f.user_id.value = '<%=selectedUserVo.user_id%>';
	f.ip_list.value = '<%=selectedUserVo.ip_list%>';
	f.other_desc.value = '<%=selectedUserVo.other_desc%>';
	if(<%="t".equals(selectedUserVo.allow_excp)%>) {
		f.allow_excp.checked = 'checked';
	}
	<%}%>
	jQuery('#xx').click(function() {
		ipam.user.closeLayer();
	});
	jQuery('#ok').click(function() {
		ipam.user.process(document.forms['frm_manage'], document.forms['frm_list']);
	});
});
</script>
