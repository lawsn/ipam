<%@ page contentType="text/html;charset=euc-kr" %>
<%@ include file="./import/ipam_init.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title><%=m_IpamTitle%> </title>
<link rel="stylesheet" href="./css/style.default.css" type="text/css" />
<link rel="stylesheet" href="./css/responsive-tables.css" type="text/css" />
<link rel="stylesheet" href="./css/user_style.css" type="text/css" />

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
<script type="text/javascript" src="js/jquery.alerts.js" charset="euc-kr"></script>
<script type="text/javascript" src="./js/custom.js"></script>
<!--[if IE]><script type="text/javascript" src="./js/css3-mediaqueries.js"></script><![endif]-->
<script type="text/javascript" src="./js/user_script.js"></script>
<script type="text/javascript">
jQuery(document).ready(function() {
	ipam.audit.list();
});
</script>
</head>

<body>
<div id="mainwrapper" class="mainwrapper">
    <div class="header">
        <!-- <div class="logo">
           	<font color="white">
               <h5><%=m_IpamVersion%></h5>
               <h3>User Menu</h3>
			</font>
        </div>-->
        <div class="headerinner">
            <ul class="headmenu">
                <li class="close" onclick="ipam.user.ipamuser();">
                    <a class="dropdown-toggle" data-traget="dropdown">
                    <span class="head-icon head-users"></span>
                    <span  class="headmenu-label">사용자</span>
                    </a>
                </li>
                <li class="open" onclick="ipam.user.ipamaudit();">
                    <a class="dropdown-toggle" data-traget="dropdown">
                    <span class="head-icon head-audit"></span>
                    <span  class="headmenu-label">감사기록</span>
                    </a>
                </li>
            </ul><!--headmenu-->
        </div>
    </div><!-- header -->
    
    <!-- <div class="leftpanel">
        <div class="leftmenu">        
            <ul class="nav nav-tabs nav-stacked">
            	<li class="nav-header">Navigation</li>
                <li class="active" style="cursor: pointer;"><a href="./user_template.jsp"><span class="iconfa-user"></span>사용자</a></li>
            </ul>
        </div> leftmenu--
    </div> leftpanel -->
    
    <div class="rightpanel" id="contents">
    </div><!--rightpanel-->
    
</div><!--mainwrapper-->
</body>

</html>
