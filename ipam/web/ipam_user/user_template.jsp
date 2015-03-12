<%@ page contentType="text/html;charset=euc-kr" %>
<%@ include file="./import/ipam_init.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>UHM-MobileOTP Administrator </title>
<link rel="stylesheet" href="./css/style.default.css" type="text/css" />
<link rel="stylesheet" href="./css/responsive-tables.css">
<link rel="stylesheet" href="./css/user_style.css">
<script type="text/javascript" src="./js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="./js/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="./js/jquery-ui-1.10.3.min.js"></script>
<script type="text/javascript" src="./js/modernizr.min.js"></script>
<script type="text/javascript" src="./js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/jquery.cookie.js"></script>
<script type="text/javascript" src="./js/jquery.uniform.min.js"></script>
<script type="text/javascript" src="./js/flot/jquery.flot.min.js"></script>
<script type="text/javascript" src="./js/flot/jquery.flot.resize.min.js"></script>
<script type="text/javascript" src="./js/responsive-tables.js"></script>
<script type="text/javascript" src="./js/jquery.slimscroll.js"></script>
<script type="text/javascript" src="./js/custom.js"></script>
<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="./js/excanvas.min.js"></script><![endif]-->
<script type="text/javascript" src="./js/user_script.js"></script>
<script type="text/javascript">
jQuery(document).ready(function() {
	ipam.user.list();
});
</script>
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
    </div><!-- header -->
    
    <div class="leftpanel">
        <div class="leftmenu">        
            <ul class="nav nav-tabs nav-stacked">
            	<li class="nav-header">Navigation</li>
                <li class="active"><a href="./user_template.jsp"><span class="iconfa-user"></span>사용자</a></li>
            </ul>
        </div><!--leftmenu-->
    </div><!-- leftpanel -->
    
    <div class="rightpanel">
        
        <ul class="breadcrumbs">
            <li><a href="./user_template.jsp"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
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
                <div id="contents" class="row-fluid">
                <%-- contents include --%>
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
</body>

</html>
