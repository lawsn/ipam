<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./audit_service.jsp" %>
<%
ParameterAudit param = new ParameterAudit();
param.page_no = toInt(request.getParameter("page_no"), 1);
param.view_count = toInt(request.getParameter("view_count"), 5);
param.add_condition = nullToBlank(request.getParameter("add_condition"));
param.key_audit_type = nullToBlank(request.getParameter("key_audit_type"));
param.key_operator_id = nullToBlank(request.getParameter("key_operator_id"));
param.key_ip_list = nullToBlank(request.getParameter("key_ip_list"));
param.key_other_desc = nullToBlank(request.getParameter("key_other_desc"));
param.key_allow_excp = nullToBlank(request.getParameter("key_allow_excp"));

List<IpamAuditVo> auditList = null;
try{
	auditList = db_audit_list(param);
	if(auditList == null) {
		auditList = new ArrayList<IpamAuditVo>();
	}
}catch(Exception ex){
	ex.printStackTrace();
	auditList = new ArrayList<IpamAuditVo>();		
}
%>

	<form name="frm_list" method="post" onsubmit="return false;">
	<input type="hidden" name="page_no" value="<%=param.page_no%>" />
	<input type="hidden" id="add_condition" name="add_condition" value="<%=param.add_condition%>"/>
	<input type="hidden" name="key_audit_type" value="<%=param.key_audit_type%>" />
	<input type="hidden" name="key_operator_id" value="<%=param.key_operator_id%>" />
	<input type="hidden" name="key_ip_list" value="<%=param.key_ip_list%>" />
	<input type="hidden" name="key_other_desc" value="<%=param.key_other_desc%>" />
	<input type="hidden" name="key_allow_excp" value="<%=param.key_allow_excp%>" />
        <ul class="breadcrumbs">
            <!-- <li><a href="#"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>감사기록</li>-->
            <li class="right">
            </li>
        </ul>
        
        <!-- <div class="pageheader">
            <div class="pageicon"><span class="iconfa-user"></span></div>
            <div class="pagetitle">
                <h1>감사기록 나열</h1>
            </div>
        </div>--><!--pageheader-->
        
        <div class="maincontent">
            <div class="maincontentinner">
                <div class="row-fluid">
					<div class="divider0"></div>
				
					<!-- <h4 class="widgettitle">감사기록</span></a></h4>-->
					<div id="dyntable_wrapper" class="dataTables_wrapper" role="grid">
						<div id="dyntable_length" class="dataTables_length">
							<label>관리자아이디 <input type="text" id="tempkey_operator_id" value="<%=param.key_operator_id%>" placeholder="사번" style=" width: auto !important; margin: 0;">
								<input class="btn-small btn-inverse" type="button" id="search" value="검색"/> <!-- <input class="btn-small btn-info" type="button" id="add_condition_btn" value="상세"/>-->
							</label>
							<!-- <div id="add_condition_view"<%="true".equals(param.add_condition) ? "" : "style=\"display: none;\""%>>
								<label>이름 <input type="text" id="tempkey_audit_type" value="<%=param.key_audit_type%>" aria-controls="dyntable" placeholder="이름" style=" width: auto !important; margin-top: 9px;"/></label>
								<label style="margin-left: 14px;">IP <input type="text" id="tempkey_ip_list" value="<%=param.key_ip_list%>" aria-controls="dyntable" placeholder="IP" style=" width: auto !important; margin-top: 0px;" /></label>
								<label style="margin-left: 30px;"><input type="checkbox" id="tempkey_allow_excp" value="t" <%="t".equals(param.key_allow_excp)?"checked":""%> style="margin-top: 0px;"/> 예외허용 검색</label>
							</div>-->
						</div>
						<!-- <div class="dataTables_filter">
							<input class="btn-small btn-inverse" type="button" id="addUser" value="사용자추가" onclick="ipam.audit.manage();"/>
						</div>-->
						<table id="dyntable" class="table table-bordered dataTable" aria-describedby="dyntable_info" style="border-right: 1px;">
							<colgroup>
								<col class="con0"  style="align: center; width: 10%"><!-- num -->
								<col class="con1"  style="width: 10%"><!-- audit_type -->
								<col class="con1"  style="width: 10%"><!-- operator_id -->
								<col class="con1"  style="width: 10%"><!-- allow_excp -->
								<col class="con1"  style="width: 15%"><!-- other_desc -->
								<col class="con1"  style="width: 20%"><!-- ip_list -->
								<!-- <col class="con1"  style="width: 10%">-- view -->
								<col class="con1"  style="width: 10%"><!-- reg_date -->								
							</colgroup>
							<thead>
								<tr role="row">
									<th class="center head0 nosort sorting_asc" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Number: activate to sort column ascending">번호</th>
									<th class="center head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Rendering engine: activate to sort column ascending">타입</th>
									<th class="center head1 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">관리자아이디</th>
									<th class="center head1 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending">예외허용</th>
									<th class="center head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">IP목록</th>
									<th class="center head1 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">비고</th>
									<!--<th class="center head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Delete: activate to sort column ascending">변경/삭제</th>-->
									<th class="center head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">등록일</th>
								</tr>
							</thead>
							<tbody role="alert" aria-live="polite" aria-relevant="all">
							<%for(IpamAuditVo audit : auditList) {%>
								<tr class=" ">
									<td class="center "><%=audit.rnum%></td>
									<td class="center "><%=audit.audit_type%></td>
									<td class="center "><%=audit.operator_id%></td>
									<td class="center "><%=audit.allow_excp%></td>
									<td class="center "><%=audit.joinIpList("<br/>")%></td>
									<td class=" "><%=audit.other_desc%></td>
									<!-- <td class="centeralign">
										<a href="#//" class="updaterow"><span onclick="ipam.audit.manage('<%=audit.operator_id%>');" class="icon-pencil" style="padding-right: 5px;" title="사용자수정"></span></a>
										<a href="#//" class="deleterow"><span onclick="ipam.audit.del(document.forms['frm_list'], '<%=audit.operator_id%>');" class="icon-trash" title="사용자삭제"></span></a>
									</td>-->
									<td class="center "><%=audit.reg_date%></td>
									
								</tr>
							<%}%>
							<%if(param.total_count == 0) {%>
								<tr class=" ">
									<td class="center " colspan="7">조회된 내역이 없습니다.</td>
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
	
	jQuery('#tempkey_operator_id,#tempkey_audit_type,#tempkey_ip_list').keyup(function(e) {
		if(e.which == 13) {
			ipam.audit.search(document.forms['frm_list']);
		}
	});
	jQuery('#search').click(function() {
		ipam.audit.search(document.forms['frm_list']);
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
			ipam.audit.list(document.forms['frm_list'], 1);
		});
	}
	
	if(<%=param.getStartPageNo() < g_scale%>) { //Prev
		jQuery('#dyntable_previous').addClass('paginate_button_disabled');
	}else {
		jQuery('#dyntable_previous').click(function() {
			ipam.audit.list(document.forms['frm_list'], <%=param.getStartPageNo() - 1%>);
		});
	}
	
	jQuery('a.move_page').click(function() { //Page
		var no = parseInt(jQuery(this).text(), 10);
		ipam.audit.list(document.forms['frm_list'], no);
	});
	
	if(<%=param.getTotalPage() <= param.getStartPageNo() + g_scale - 1%>) { //Next
		jQuery('#dyntable_next').addClass('paginate_button_disabled');
	}else {
		jQuery('#dyntable_next').click(function() {
			ipam.audit.list(document.forms['frm_list'], <%=param.getStartPageNo() + g_scale%>);
		});
	}
	
	if(<%=param.total_count == 0 || param.page_no == param.getTotalPage()%>) { //Last
		jQuery('#dyntable_last').addClass('paginate_button_disabled');
	}else {
		jQuery('#dyntable_last').click(function() {
			ipam.audit.list(document.forms['frm_list'], <%=param.getTotalPage()%>);
		});
	}
});
</script>
