<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./user_service.jsp" %>
<%
ParameterVo param = new ParameterVo();
param.page_no = toInt(request.getParameter("page_no"), 1);
param.view_count = toInt(request.getParameter("view_count"), 5);
param.add_condition = nullToBlank(request.getParameter("add_condition"));
param.key_user_name = nullToBlank(request.getParameter("key_user_name"));
param.key_user_id = nullToBlank(request.getParameter("key_user_id"));
param.key_ip_list = nullToBlank(request.getParameter("key_ip_list"));
param.key_other_desc = nullToBlank(request.getParameter("key_other_desc"));
param.key_allow_excp = nullToBlank(request.getParameter("key_allow_excp"));

List<IpamUserVo> userList = null;
try{
	userList = db_user_list(param);
	if(userList == null) {
		userList = new ArrayList<IpamUserVo>();
	}
}catch(Exception ex){
	ex.printStackTrace();
	userList = new ArrayList<IpamUserVo>();		
}
%>

	<form name="frm_list" method="post" onsubmit="return false;">
	<input type="hidden" name="page_no" value="<%=param.page_no%>" />
	<input type="hidden" id="add_condition" name="add_condition" value="<%=param.add_condition%>"/>
	<input type="hidden" name="key_user_name" value="<%=param.key_user_name%>" />
	<input type="hidden" name="key_user_id" value="<%=param.key_user_id%>" />
	<input type="hidden" name="key_ip_list" value="<%=param.key_ip_list%>" />
	<input type="hidden" name="key_other_desc" value="<%=param.key_other_desc%>" />
	<input type="hidden" name="key_allow_excp" value="<%=param.key_allow_excp%>" />
        <ul class="breadcrumbs">
            <!-- <li><a href="#"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>사용자</li>-->
            <li class="right">
            </li>
        </ul>
        
        <!-- <div class="pageheader">
            <div class="pageicon"><span class="iconfa-user"></span></div>
            <div class="pagetitle">
                <h1>사용자 나열</h1>
            </div>
        </div>--><!--pageheader-->
        
			        <div class="maincontent">
			            <div class="maincontentinner">
			                <div class="row-fluid">
								<div class="divider0"></div>
							
								<!-- <h4 class="widgettitle">사용자</span></a></h4>-->
								
				
			        
					<div id="dyntable_wrapper" class="dataTables_wrapper" role="grid">
						<div id="dyntable_length" class="dataTables_length">
							<label>사번 <input type="text" id="tempkey_user_id" value="<%=param.key_user_id%>" placeholder="사번" style=" width: auto !important; margin: 0;">
								<input class="btn-small btn-inverse" type="button" id="search" value="검색"/> <input class="btn-small btn-info" type="button" id="add_condition_btn" value="상세"/>
							</label>
							<div id="add_condition_view"<%="true".equals(param.add_condition) ? "" : "style=\"display: none;\""%>>
								<label>이름 <input type="text" id="tempkey_user_name" value="<%=param.key_user_name%>" aria-controls="dyntable" placeholder="이름" style=" width: auto !important; margin-top: 9px;"/></label>
								<label style="margin-left: 14px;">IP <input type="text" id="tempkey_ip_list" value="<%=param.key_ip_list%>" aria-controls="dyntable" placeholder="IP" style=" width: auto !important; margin-top: 0px;" /></label>
								<label style="margin-left: 30px;"><input type="checkbox" id="tempkey_allow_excp" value="t" <%="t".equals(param.key_allow_excp)?"checked":""%> style="margin-top: 0px;"/> 예외허용 검색</label>
							</div>
						</div>
						<div class="dataTables_filter">
							<input class="btn-small btn-inverse" type="button" id="addUser" value="사용자추가" onclick="ipam.user.manage();"/>
						</div>
						<table id="dyntable" class="table table-bordered dataTable" aria-describedby="dyntable_info" style="border-right: 1px;">
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
									<th class="center head0 nosort sorting_asc" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Number: activate to sort column ascending">번호</th>
									<th class="center head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Rendering engine: activate to sort column ascending">사용자이름</th>
									<th class="center head1 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">사번</th>
									<th class="center head1 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending">예외허용</th>
									<th class="center head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">IP목록</th>
									<th class="center head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Delete: activate to sort column ascending">변경/삭제</th>
									<th class="center head1 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">비고</th>
								</tr>
							</thead>
							<tbody role="alert" aria-live="polite" aria-relevant="all">
							<%for(IpamUserVo user : userList) {%>
								<tr class=" ">
									<td class="center "><%=user.rnum%></td>
									<td class=" "><%=user.user_name%></td>
									<td class=" "><%=user.user_id%></td>
									<td class="center "><%=user.allow_excp%></td>
									<td class="center "><%=user.joinIpList("<br/>")%></td>
									<td class="centeralign">
										<a href="#//" class="updaterow"><span onclick="ipam.user.manage('<%=user.user_id%>');" class="icon-pencil" style="padding-right: 5px;" title="사용자수정"></span></a>
										<a href="#//" class="deleterow"><span onclick="ipam.user.del(document.forms['frm_list'], '<%=user.user_id%>');" class="icon-trash" title="사용자삭제"></span></a>
									</td>
									<td class=" "><%=user.other_desc%></td>
								</tr>
							<%}%>
							<%if(param.total_count == 0) {%>
								<tr class=" ">
									<td class="center " colspan="7">조회된 사용자가 없습니다.</td>
								</tr>
							<%}%>
							</tbody>
						</table>
						<div class="dataTables_info" id="dyntable_info"> </div>
						<div class="dataTables_paginate paging_full_numbers" id="dyntable_paginate">
							<a class="first paginate_button" id="dyntable_first">First</a>
							<a class="previous paginate_button" id="dyntable_previous">Previous</a>
							<%
							for(int iPage=param.getStartPageNo(); iPage<param.getStartPageNo()+g_scale; iPage++) {
								if(iPage > param.getTotalPage()) {
									break;
								}
								if(param.page_no == iPage) {
							%>
							<span><a tabindex="0" class="paginate_active"><%=iPage%></a></span>
							<%
								}else {
							%>
							<a tabindex="0" class="paginate_button move_page"><%=iPage%></a>
							<%	
								}
							}
							%>
							<a class="next paginate_button" id="dyntable_next">Next</a>
							<a class="last paginate_button" id="dyntable_last">Last</a>
						</div>
					</div><!--span4-->
					<br />
                </div><!--row-fluid-->
                
                <div class="footer">
                    <div class="footer-left">
                        <span>&copy; <%=m_IpamCopyRights%></span>
                    </div>
                    <div class="footer-right">
                        <span>Designed by: <a href="<%=m_IpamCompanyHome%>"><%=m_IpamCompany%></a></span>
                    </div>
                </div><!--footer-->
                
            </div><!--maincontentinner-->
        </div><!--maincontent-->
	</form>
<script type="text/javascript">
jQuery(document).ready(function() {
	
	<%--------------------------------------
	-- style --
	----------------------------------------%>
	jQuery('#dyntable tbody tr:even').addClass('even');
	jQuery('#dyntable tbody tr:odd').addClass('odd');
	
	<%--------------------------------------
	-- search --
	----------------------------------------%>
	jQuery('#add_condition_btn').click(function() {
		jQuery('#add_condition').val(function() {
			if(this.value == 'true') {
				jQuery('#add_condition_view').hide();
				return '';
			}else {
				jQuery('#add_condition_view').show();
				return 'true';
			}
		});
		jQuery('#dyntable_paginate').css('position', 'relative').css('position', 'absolute'); //IE7호환
	});
	
	jQuery('#tempkey_user_id,#tempkey_user_name,#tempkey_ip_list').keyup(function(e) {
		if(e.which == 13) {
			ipam.user.search(document.forms['frm_list']);
		}
	});
	jQuery('#search').click(function() {
		ipam.user.search(document.forms['frm_list']);
	});
	
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
	jQuery('#dyntable_info').html('전체:<%=param.total_count%>, 범위:' + start_no + ' - ' + end_no);
	
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
	
	if(<%=param.getTotalPage() <= param.getStartPageNo() + g_scale - 1%>) { //Next
		jQuery('#dyntable_next').addClass('paginate_button_disabled');
	}else {
		jQuery('#dyntable_next').click(function() {
			ipam.user.list(document.forms['frm_list'], <%=param.getStartPageNo() + g_scale%>);
		});
	}
	
	if(<%=param.total_count == 0 || param.page_no == param.getTotalPage()%>) { //Last
		jQuery('#dyntable_last').addClass('paginate_button_disabled');
	}else {
		jQuery('#dyntable_last').click(function() {
			ipam.user.list(document.forms['frm_list'], <%=param.getTotalPage()%>);
		});
	}
	
	//jQuery('form:first *:input[type!=hidden]:first').focus();
	
});
</script>
