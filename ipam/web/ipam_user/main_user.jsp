<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./import/ipam_init.jsp" %>
<%

	
%>


<!DOCTYPE html>
<html>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>UHM-MobileOTP Administrator </title>
<link rel="stylesheet" href="css/style.default.css" type="text/css" />

<link rel="stylesheet" href="css/responsive-tables.css">
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.3.min.js"></script>
<script type="text/javascript" src="js/modernizr.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="js/jquery.uniform.min.js"></script>
<script type="text/javascript" src="js/flot/jquery.flot.min.js"></script>
<script type="text/javascript" src="js/flot/jquery.flot.resize.min.js"></script>
<script type="text/javascript" src="js/responsive-tables.js"></script>
<script type="text/javascript" src="js/jquery.slimscroll.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="js/excanvas.min.js"></script><![endif]-->
</head>

<body>

<div id="mainwrapper" class="mainwrapper">
    
    <div class="header">
        <div class="logo">
            	<font color="white">
                <h5><%=m_IpamVersion%></h5>
                <h3>User Menu</h3>
				</font>

        </div>
        <div class="headerinner">
            <ul class="headmenu">
                
                <li>
                    <a class="dropdown-toggle" data-toggle="dropdown" data-target="#">
                    <span class="head-icon head-users"></span>
                    <span class="headmenu-label">사용자</span>
                    </a>
                </li>
            </ul><!--headmenu-->
        </div>
    </div>
    
    <div class="leftpanel">
        
        <div class="leftmenu">        
            <ul class="nav nav-tabs nav-stacked">
            	<li class="nav-header">Navigation</li>
                <li class="active"><a href="main_user.jsp"><span class="iconfa-user"></span>사용자</a></li>
            </ul>
        </div><!--leftmenu-->
        
    </div><!-- leftpanel -->
    
    <div class="rightpanel">
        
        <ul class="breadcrumbs">
            <li><a href="main_user.jsp"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>사용자</li>
            <li class="right">
            </li>
        </ul>
        
        <div class="pageheader">
            <form action="/motp/admin/results.html" method="post" class="searchbar">
                <input type="text" name="keyword" placeholder="To search type and hit enter..." />
            </form>
            <div class="pageicon"><span class="iconfa-user"></span></div>
            <div class="pagetitle">
                <h5>사용자 나열</h5>
                <h1>사용자 나열</h1>
            </div>
        </div><!--pageheader-->
        
        <div class="maincontent">
            <div class="maincontentinner">
                <div class="row-fluid">
                    
                        <div class="divider30"></div>
                        
                        <h4 class="widgettitle">Data Table</h4>
                        <div id="dyntable_wrapper" class="dataTables_wrapper" role="grid">
                        <div id="dyntable_length" class="dataTables_length"><label>Show 
                        <select size="1" name="dyntable_length" aria-controls="dyntable">
                        <option value="10" selected="selected">10</option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                        </select>
                         entries</label></div>
                        <div class="dataTables_filter" id="dyntable_filter">
                        	<label>Search: <input type="text" aria-controls="dyntable"></label>
                        </div>
                        <table id="dyntable" class="table table-bordered responsive dataTable" aria-describedby="dyntable_info">
                        
                    <colgroup>
                        <col class="con0"  style="align: center; width: 5%">
                        <col class="con1"  style="width: 20%">
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
                        	<th class="head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending" style="width: 339px;">IP목록</th>
                        	<th class="head1 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending" style="width: 258px;">예외허용</th>
                        	<th class="head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending" style="width: 186px;">비고</th>
                        	<th class="head0 sorting" role="columnheader" tabindex="0" aria-controls="dyntable" rowspan="1" colspan="1" aria-label="Delete: activate to sort column ascending" style="width: 186px;">변경/삭제</th>
                        </tr>
                    </thead>
                    
                <tbody role="alert" aria-live="polite" aria-relevant="all">
                		<tr class="gradeX odd">
                            <td class="center ">1</td>
                            <td class=" ">Trident</td>
                            <td class=" ">Internet Explorer 4.0</td>
                            <td class=" ">Win 95+</td>
                            <td class="center ">4</td>
                            <td class="center ">X</td>
                            <td class="centeralign"><a href="#" class="deleterow"><span class="icon-trash"></span></a></td>
                        </tr>
                        <tr class="gradeC even">
							<td class="center ">2</td>
							<td class=" ">Trident</td>
                            <td class=" ">Internet Explorer 5.0</td>
                            <td class=" ">Win 95+</td>
                            <td class="center ">5</td>
                            <td class="center ">C</td>
                            <td class="centeralign"><a href="#" class="deleterow"><span class="icon-trash"></span></a></td>
                        </tr>
                        <tr class="gradeA odd">
                        	<td class="center ">3</td>
                            <td class=" ">Internet Explorer 5.5</td>
                            <td class=" ">Trident</td>
                            <td class=" ">Win 95+</td>
                            <td class="center ">5.5</td>
                            <td class="center ">A</td>
                            <td class="centeralign"><a href="#" class="deleterow"><span class="icon-trash"></span></a></td>
                        </tr>
                        <tr class="gradeA even">
                        	<td class="center ">4</td>
                            <td class=" ">Trident</td>
                            <td class=" ">Internet Explorer 6</td>
                            <td class=" ">Win 98+</td>
                            <td class="center ">6</td>
                            <td class="center ">A</td>
                            <td class="centeralign"><a href="#" class="deleterow"><span class="icon-trash"></span></a></td>
                            
                        </tr><tr class="gradeA odd">
                        	<td class="center ">5</td>
                            <td class=" ">Trident</td>
                            <td class=" ">Internet Explorer 7</td>
                            <td class=" ">Win XP SP2+</td>
                            <td class="center ">7</td>
                            <td class="center ">A</td>
                            <td class="centeralign"><a href="#" class="deleterow"><span class="icon-trash"></span></a></td>
                        </tr><tr class="gradeA even">
                          <td class="center ">6</td>
                            <td class=" ">Trident</td>
                            <td class=" ">AOL browser (AOL desktop)</td>
                            <td class=" ">Win XP</td>
                            <td class="center ">6</td>
                            <td class="center ">A</td>
                            <td class="centeralign"><a href="#" class="deleterow"><span class="icon-trash"></span></a></td>
                        </tr><tr class="gradeA odd">
                          <td class="center ">7</td>
                            <td class=" ">Gecko</td>
                            <td class=" ">Firefox 1.0</td>
                            <td class=" ">Win 98+ / OSX.2+</td>
                            <td class="center ">1.7</td>
                            <td class="center ">A</td>
                            <td class="centeralign"><a href="#" class="deleterow"><span class="icon-trash"></span></a></td>
                        </tr><tr class="gradeA even">
                            <td class="center ">8</td>
                            <td class=" ">Gecko</td>
                            <td class=" ">Firefox 1.5</td>
                            <td class=" ">Win 98+ / OSX.2+</td>
                            <td class="center ">1.8</td>
                            <td class="center ">A</td>
                            <td class="centeralign"><a href="#" class="deleterow"><span class="icon-trash"></span></a></td>
                        </tr><tr class="gradeA odd">
                            <td class="center ">9</td>
                            <td class=" ">Gecko</td>
                            <td class=" ">Firefox 2.0</td>
                            <td class=" ">Win 98+ / OSX.2+</td>
                            <td class="center ">1.8</td>
                            <td class="center ">A</td>
                            <td class="centeralign"><a href="#" class="deleterow"><span class="icon-trash"></span></a></td>
                        </tr><tr class="gradeA even">
                          <td class="center ">10</td>
                            <td class=" ">Gecko</td>
                            <td class=" ">Firefox 3.0</td>
                            <td class=" ">Win 2k+ / OSX.3+</td>
                            <td class="center ">1.9</td>
                            <td class="center ">A</td>
                            <td class="centeralign"><a href="#" class="deleterow"><span class="icon-trash"></span></a></td>
                        </tr>
                   </tbody></table>
                   			<div class="dataTables_info" id="dyntable_info">Showing 1 to 10 of 51 entries</div>
                   			<div class="dataTables_paginate paging_full_numbers" id="dyntable_paginate">
                   			<a tabindex="0" class="first paginate_button paginate_button_disabled" id="dyntable_first">First</a>
                   			<a tabindex="0" class="previous paginate_button paginate_button_disabled" id="dyntable_previous">Previous</a>
                   			<span><a tabindex="0" class="paginate_active">1</a><a tabindex="0" class="paginate_button">2</a>
                   			<a tabindex="0" class="paginate_button">3</a><a tabindex="0" class="paginate_button">4</a>
                   			<a tabindex="0" class="paginate_button">5</a></span>
                   			<a tabindex="0" class="next paginate_button" id="dyntable_next">Next</a>
                   			<a tabindex="0" class="last paginate_button" id="dyntable_last">Last</a>
                   			</div>
               </div>
                        <br />
                    
                    <!--span4-->
                </div><!--row-fluid-->
                
                <div class="footer">
                    <div class="footer-left">
                        <span>&copy; 2013. UHMSOFT Corporation. All Rights Reserved.</span>
                    </div>
                    <div class="footer-right">
                        <span>Designed by: <a href="<%=m_IpamCompanyHome%>">UHMSOFT</a></span>
                    </div>
                </div><!--footer-->
                
            </div><!--maincontentinner-->
        </div><!--maincontent-->
        
    </div><!--rightpanel-->
    
</div><!--mainwrapper-->
<script type="text/javascript">
    jQuery(document).ready(function() {
        
      // simple chart
		function showTooltip(x, y, contents) {
			jQuery('<div id="tooltip" class="tooltipflot">' + contents + '</div>').css( {
				position: 'absolute',
				display: 'none',
				top: y + 5,
				left: x + 5
			}).appendTo("body").fadeIn(200);
		}
      
		 // delete row in a table
	    if(jQuery('.deleterow').length > 0) {
	        jQuery('.deleterow').click(function(){
	            var conf = confirm('Continue delete?');
		    if(conf)
	                jQuery(this).parents('tr').fadeOut(function(){
						jQuery(this).remove();
					// do some other stuff here
		    		});
		    return false;
		});	
	    }
		 
	
			
		
		var previousPoint = null;
        
        //datepicker
        jQuery('#datepicker').datepicker();
        
        // tabbed widget
        jQuery('.tabbedwidget').tabs();
        
        
    
    });
</script>
</body>

</html>
