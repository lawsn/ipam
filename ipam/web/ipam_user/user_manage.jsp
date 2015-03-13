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
			<label><input type="text" name="user_id" placeholder="사번" /></label>
		<%}else{%>
			<label style="padding-bottom: 10px;"><strong>사번 : <%=user_id%></strong></label>
			<input type="hidden" name="user_id" value="<%=user_id%>" />
		<%}%>
		<label><input type="text" name="user_name" placeholder="이름" /></label>
		<label><input type="text" name="ip_list" placeholder="사용자IP (여러개일 경우 , 로 구분)" /></label>
		<label><input type="text" name="other_desc" placeholder="비고" /></label>
		<label><input type="checkbox" name="allow_excp" value="t" /> 예외허용</label>
	</div>
	<div style="padding-top: 10px; text-align: center;">
		<input type="button" id="xx" value="취소"/> <input type="button" id="ok" value="확인"/>
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
