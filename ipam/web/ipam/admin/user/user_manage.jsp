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

<script type="text/javascript" src="js/jquery.alerts.js" charset="euc-kr"></script>

	<form name="frm_manage" method="post">
	<input type="hidden" name="proc" value="<%=process%>" />
	<h4 class="widgettitle">사용자 <%="create".equals(process)?"추가":"수정"%></span></a></h4>	
	<div class="dataTables_wrapper">
		<table class="table table-bordered table-invoice" style="border-right: 1px;">
			<colgroup>
				<col class="con1"  style="align: right; width: 25%">
				<col class="con0"  style="width: 75%">
			</colgroup>
			<tbody role="alert" aria-live="polite" aria-relevant="all">
				<tr class="gradeX ">
					<td class="right "><label><font color="red">*</font>사번</label></th>
					<td class=" ">
					<%if("create".equals(process)) {%>
						<input type="text" name="user_id" placeholder="사번" />
					<%}else{%>
						<%=user_id%><input type="hidden" name="user_id" value="<%=user_id%>" />
					<%}%>
					</td>
				</tr>
				<tr class="gradeX ">
					<td class="right "><label><font color="red">*</font>이름</label></th>
					<td class=" "><input type="text" name="user_name" placeholder="이름" /></td>
				</tr>
				<tr class="gradeX ">
					<td class="right "><label><font color="red">*</font>사용자IP</label></th>
					<td class=" "><input type="text" name="ip_list" placeholder="사용자IP (여러개일 경우 , 로 구분)" /></td>
				</tr>
				<tr class="gradeX ">
					<td class="right "><label>비고</label></th>
					<td class=" "><label><input type="text" name="other_desc" placeholder="비고" /></label></td>
				</tr>
				<tr class="gradeX ">
					<td class="right "><label>예외허용</label></th>
					<td class=" "><label><input type="checkbox" name="allow_excp" value="t" /></label></td>
				</tr>
			</tbody>
		</table>	
	</div>
	<div style="padding-top: 10px; text-align: center;">
		<input class="btn btn-info" type="button" id="ok" value="확인"/> <input class="btn" type="button" id="xx" value="취소"/>
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
