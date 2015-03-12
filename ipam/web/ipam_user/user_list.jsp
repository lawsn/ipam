<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./user_service.jsp" %>
<%
ParameterVo param = new ParameterVo();
param.page_no = toInt(request.getParameter("page_no"), 1);
param.view_count = toInt(request.getParameter("view_count"), 10);
param.key_user_name = nullToBlank(request.getParameter("key_user_name"));
param.key_user_id = nullToBlank(request.getParameter("key_user_id"));
param.key_ip_list = nullToBlank(request.getParameter("key_ip_list"));
param.key_other_desc = nullToBlank(request.getParameter("key_other_desc"));
param.key_allow_excp = nullToBlank(request.getParameter("key_allow_excp"));

List<IpamUserVo> userList = db_user_list(param);
if(userList == null) {
	userList = new ArrayList<IpamUserVo>();
}
%>
<form name="frm_list" method="post" onsubmit="return false;">
	<input type="hidden" name="page_no" value="<%=param.page_no%>" />
	<input type="hidden" name="key_user_name" value="<%=param.key_user_name%>" />
	<input type="hidden" name="key_user_id" value="<%=param.key_user_id%>" />
	<input type="hidden" name="key_ip_list" value="<%=param.key_ip_list%>" />
	<input type="hidden" name="key_other_desc" value="<%=param.key_other_desc%>" />
	<input type="hidden" name="key_allow_excp" value="<%=param.key_allow_excp%>" />
	<h5 class="subtitle">Recently Viewed Pages</h5>
	<div class="divider30"></div>

	<h4 class="widgettitle">Data Table<a href="javascript:ipam.user.manage();" class="manage-user"><span class="icon-user"></span></a></h4>
	<div id="dyntable_wrapper" class="dataTables_wrapper" role="grid">
		<div id="dyntable_length" class="dataTables_length">
			<label>Show 
			<select size="1" name="view_count" aria-controls="dyntable" onchange="ipam.user.list(document.forms['frm_list'], 1);">
			<option value="1"<%if(param.view_count==1){%> selected="selected"<%}%>>1</option>
			<option value="2"<%if(param.view_count==2){%> selected="selected"<%}%>>2</option>
			<option value="5"<%if(param.view_count==5){%> selected="selected"<%}%>>5</option>
			<option value="10"<%if(param.view_count==10){%> selected="selected"<%}%>>10</option>
			<option value="25"<%if(param.view_count==25){%> selected="selected"<%}%>>25</option>
			<option value="50"<%if(param.view_count==50){%> selected="selected"<%}%>>50</option>
			<option value="100"<%if(param.view_count==100){%> selected="selected"<%}%>>100</option>
			</select>
			entries</label>
		</div>
		<div class="dataTables_filter" id="dyntable_filter">
			<label>Search: <input type="text" id="tempkey_user_id" value="<%=param.key_user_id%>" aria-controls="dyntable" onkeyup="ipam.user.search(document.forms['frm_list']);"></label>
		</div>
		<table id="dyntable" class="table table-bordered responsive dataTable" aria-describedby="dyntable_info">
			<colgroup>
				<col class="con0"  style="align: center; width: 10%">
				<col class="con1"  style="width: 15%">
				<col class="con0"  style="width: 15%">
				<col class="con1"  style="width: 10%">
				<col class="con0"  style="width: 15%">
				<col class="con1"  style="width: 10%">
				<col class="con1"  style="width: 25%">
			</colgroup>
			<thead>
				<tr role="row">
					<th class="center head0 nosort sorting_asc" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Number: activate to sort column ascending" style="width: 50px;">번호</th>
					<th class="center head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Rendering engine: activate to sort column ascending" style="width: 301px;">사용자이름</th>
					<th class="center head1 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending" style="width: 370px;">사번</th>
					<th class="center head1 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending" style="width: 258px;">예외허용</th>
					<th class="center head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending" style="width: 339px;">IP목록</th>
					<th class="center head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Delete: activate to sort column ascending" style="width: 186px;">변경/삭제</th>
					<th class="center head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending" style="width: 186px;">비고</th>
				</tr>
			</thead>
			<tbody role="alert" aria-live="polite" aria-relevant="all">
			<%for(IpamUserVo user : userList) {%>
				<tr class="gradeX odd">
				<td class="center "><%=user.rnum%></td>
				<td class=" "><%=user.user_name%></td>
				<td class=" "><%=user.user_id%></td>
				<td class="center "><%=user.allow_excp%></td>
				<td class="center "><%=user.joinIpList("<br/>")%></td>
				<td class="centeralign">
					<a href="#//" class="updaterow"><span onclick="ipam.user.manage('<%=user.user_id%>');" class="icon-pencil"></span></a>
					<a href="#//" class="deleterow"><span onclick="ipam.user.del(document.forms['frm_list'], '<%=user.user_id%>');" class="icon-trash"></span></a>
				</td>
				<td class=" "><%=user.other_desc%></td>
				</tr>
			<%}%>
			</tbody>
		</table>
		<div class="dataTables_info" id="dyntable_info"></div>
		<div class="dataTables_paginate paging_full_numbers" id="dyntable_paginate">
			<a class="first paginate_button" id="dyntable_first">First</a>
			<a class="previous paginate_button" id="dyntable_previous">Previous</a>
			<span>
				<%
				for(int iPage=param.getStartPageNo(); iPage<param.getStartPageNo()+g_scale; iPage++) {
					if(iPage > param.getTotalPage()) {
						break;
					}
					if(param.page_no==iPage) {
				%>
				<a tabindex="0" class="paginate_active"><%=iPage%></a>
				<%
					}else {
				%>
				<a tabindex="0" class="paginate_button move_page"><%=iPage%></a>
				<%	
					}
				}
				%>
			</span>
			<a class="next paginate_button" id="dyntable_next">Next</a>
			<a class="last paginate_button" id="dyntable_last">Last</a>
		</div>
	</div>
	<br />
	<!--span4-->
</form>
<script type="text/javascript">
jQuery(document).ready(function() {
	
	<%--------------------------------------
	-- paging --
	----------------------------------------%>
	var start_no = '<%=param.total_count%>';
	if(<%=param.total_count > param.getStartNo()%>) {
		start_no = <%=param.getStartNo()%>;
	}
	var end_no = <%=param.total_count%>;
	if(<%=param.total_count > param.getEndNo()%>) {
		end_no = <%=param.getEndNo()%>;
	}
	jQuery('#dyntable_info').html('Showing ' + start_no + ' to ' + end_no + ' of <%=param.total_count%> entries');
	
	if(<%=param.page_no == 1%>) { //First
		jQuery('#dyntable_first').addClass('paginate_button_disabled');
	}else {
		jQuery('#dyntable_first').click(function() {
			ipam.user.list(document.forms['frm_list'], 1);
		});
	}
	
	if(<%=param.getStartPageNo() < g_scale%>) { //Prev
		jQuery('#dyntable_previous').addClass('paginate_button_disabled');
	}else {
		jQuery('#dyntable_previous').click(function() {
			ipam.user.list(document.forms['frm_list'], <%=param.getStartPageNo() - 1%>);
		});
	}
	
	jQuery('a.move_page').click(function() { //Page
		var no = parseInt(jQuery(this).text(), 10);
		ipam.user.list(document.forms['frm_list'], no);
	});
	
	if(<%=param.getTotalPage() < param.getStartPageNo() + g_scale - 1%>) { //Next
		jQuery('#dyntable_next').addClass('paginate_button_disabled');
	}else {
		jQuery('#dyntable_next').click(function() {
			ipam.user.list(document.forms['frm_list'], <%=param.getStartPageNo() + g_scale%>);
		});
	}
	
	if(<%=param.page_no == param.getTotalPage()%>) { //Last
		jQuery('#dyntable_last').addClass('paginate_button_disabled');
	}else {
		jQuery('#dyntable_last').click(function() {
			ipam.user.list(document.forms['frm_list'], <%=param.getTotalPage()%>);
		});
	}
});
</script>















