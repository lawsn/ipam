<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./import/ipam_init.jsp" %>
<%
String errCode=request.getParameter("code");
String errMsg = null;
String errPageNotFound = "The page you are looking for has not been found.";

	if (errCode.equals("ERR_LOGIN_0001")) 
		errMsg = "해당 ID가 존재하지 않습니다.";
	else if (errCode.equals("ERR_LOGIN_0002"))
		errMsg = "비밀번호가 올바르지 않습니다.";
	else
		errMsg = "알수없는 에러입니다.";
		
%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>UhmMOTP Error Status </title>
<link rel="stylesheet" href="css/style.default.css" type="text/css" />

<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.3.min.js"></script>
<script type="text/javascript" src="js/modernizr.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="js/jquery.slimscroll.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
</head>

<body class="errorpage">

<div id="mainwrapper" class="mainwrapper">
    
    <div class="header">
        <div class="logo">
        		<font color="white">
                <h4><%=m_IpamVersion%></h4>
				</font>
        </div>
        <div class="headerinner">
            <ul class="headmenu">
                
                
                
            </ul><!--headmenu-->
        </div>
    </div>
    
    <div class="errortitle">
        <h4 class="animate0 fadeInUp"><%=errMsg%></h4>
        <!-- <span class="animate1 bounceIn"><%=errCode%></span>-->
        <div class="errorbtns animate4 fadeInUp">
            <a onclick="history.back()" class="btn btn-primary btn-large">Go to Previous Page</a>
            <a href="./main_user.jsp" class="btn btn-large">Go to Main Menu</a>
        </div>
    </div>
    
</div><!--mainwrapper-->

</body>

</html>