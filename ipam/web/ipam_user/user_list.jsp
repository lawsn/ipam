<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./ipam_user_service.jsp" %>
<%
ParameterVo param = new ParameterVo();
param.page_no = toInt(request.getParameter("page_no"), 1);
param.scale = toInt(request.getParameter("scale"), 10);
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
			<select size="1" name="scale" aria-controls="dyntable" onchange="ipam.user.list(document.forms['frm_list'], 1);">
			<option value="1"<%if(param.scale==1){%> selected="selected"<%}%>>1</option>
			<option value="5"<%if(param.scale==5){%> selected="selected"<%}%>>5</option>
			<option value="10"<%if(param.scale==10){%> selected="selected"<%}%>>10</option>
			<option value="25"<%if(param.scale==25){%> selected="selected"<%}%>>25</option>
			<option value="50"<%if(param.scale==50){%> selected="selected"<%}%>>50</option>
			<option value="100"<%if(param.scale==100){%> selected="selected"<%}%>>100</option>
			</select>
			entries</label>
		</div>
		<div class="dataTables_filter" id="dyntable_filter">
			<label>Search: <input type="text" id="tempkey_user_id" value="<%=param.key_user_id%>" aria-controls="dyntable" onkeyup="ipam.user.search(document.forms['frm_list']);"></label>
		</div>
		<table id="dyntable" class="table table-bordered responsive dataTable" aria-describedby="dyntable_info">
			<colgroup>
				<col class="con0"  style="align: center; width: 7%">
				<col class="con1"  style="width: 18%">
				<col class="con0"  style="width: 15%">
				<col class="con1"  style="width: 15%">
				<col class="con0"  style="width: 15%">
				<col class="con1"  style="width: 15%">
				<col class="con1"  style="width: 15%">
			</colgroup>
			<thead>
				<tr role="row">
					<th class="head0 nosort sorting_asc" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Number: activate to sort column ascending" style="width: 50px;">번호</th>
					<th class="head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Rendering engine: activate to sort column ascending" style="width: 301px;">사용자이름</th>
					<th class="head1 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending" style="width: 370px;">사번</th>
					<th class="head1 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending" style="width: 258px;">예외허용</th>
					<th class="head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending" style="width: 339px;">IP목록</th>
					<th class="head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Delete: activate to sort column ascending" style="width: 186px;">변경/삭제</th>
					<th class="head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending" style="width: 186px;">비고</th>
				</tr>
			</thead>
			<tbody role="alert" aria-live="polite" aria-relevant="all">
			<%for(IpamUserVo user : userList) {%>
				<tr class="gradeX odd">
				<td class="center "><%=user.rnum%></td>
				<td class=" "><%=user.user_name%></td>
				<td class=" "><%=user.user_id%></td>
				<td class=" "><%=user.allow_excp%></td>
				<td class="center "><%=user.ip_list%></td>
				<td class="centeralign">
					<a href="#" class="deleterow"><span onclick="ipam.user.manage('<%=user.user_id%>');" class="icon-pencil"></span></a>
					<a href="#" class="deleterow"><span onclick="ipam.user.del('<%=user.user_id%>');" class="icon-trash"></span></a>
				</td>
				<td class="center "><%=user.other_desc%></td>
				</tr>
			<%}%>
			</tbody>
		</table>
		<div class="dataTables_info" id="dyntable_info">Showing <%=((param.page_no - 1) * param.scale) + 1%> to <%=param.total_count > param.page_no * param.scale ? param.page_no * param.scale : param.total_count%> of <%=param.total_count%> entries</div>
		<div class="dataTables_paginate paging_full_numbers" id="dyntable_paginate">
			<a tabindex="0" class="first paginate_button paginate_button_disabled" id="dyntable_first" href="javascript:ipam.user.list(document.forms['frm_list'], 1);">First</a>
			<a tabindex="0" class="previous paginate_button paginate_button_disabled" id="dyntable_previous">Previous</a>
			<span>
				<a tabindex="0" class="paginate_active" href="javascript:ipam.user.list(document.forms['frm_list'], 1);">1</a>
				<a tabindex="0" class="paginate_button" href="javascript:ipam.user.list(document.forms['frm_list'], 2);">2</a>
				<a tabindex="0" class="paginate_button" href="javascript:ipam.user.list(document.forms['frm_list'], 3);">3</a>
				<a tabindex="0" class="paginate_button" href="javascript:ipam.user.list(document.forms['frm_list'], 4);">4</a>
				<a tabindex="0" class="paginate_button" href="javascript:ipam.user.list(document.forms['frm_list'], 5);">5</a>
			</span>
			<a tabindex="0" class="next paginate_button" id="dyntable_next">Next</a>
			<a tabindex="0" class="last paginate_button" id="dyntable_last">Last</a>
		</div>
	</div>
	<br />
	<!--span4-->
</form>
