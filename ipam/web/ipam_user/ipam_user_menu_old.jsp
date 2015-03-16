<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./import/ipam_init.jsp" %>
<%

	/*
	String sessionUserid = (String)session.getAttribute("s_id");
	if (sessionUserid==null){
		 response.sendRedirect("./motp_user_login.jsp");
		 return;
	}
	
	if (sessionUserid.equalsIgnoreCase("")){
		 response.sendRedirect("./motp_user_login.jsp");
		 return;
	}

	
	//사용자등록 상태체크
	String reg_status = request.getParameter("reg_status");
	if(reg_status==null){
		reg_status="";
	}
	
	//사용자정보변경 상태체크
	String change_status = request.getParameter("change_status");
	if(change_status==null){
		change_status="";
	}	*/
	
	String reg_status="";
	String change_status="";
	
%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>User Login </title>
<link rel="stylesheet" href="css/style.default.css" type="text/css" />
<link rel="stylesheet" href="css/style.shinyblue.html" type="text/css" />

<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.3.min.js"></script>
<script type="text/javascript" src="js/modernizr.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
<script type="text/javascript" src="js/jquery.alerts.js" charset="euc-kr"></script>

<script type="text/javascript">
    jQuery(document).ready(function(){
        jQuery('#login').submit(function(){
            var uid = jQuery('#userid').val();
            var p = jQuery('#password').val();
            
            if(uid == '' && p == '') {
                //jQuery('.login-alert1').fadeIn();
             jAlert('Invalid username or password', 'Alert Dialog', function(){
                           //jQuery.alerts.dialogClass = null; // reset to default
             });

                return false;
            }
            
            if(p == '') {
                //jQuery('.login-alert1').fadeIn();
             jAlert('Invalid password', 'Alert Dialog', function(){
                           //jQuery.alerts.dialogClass = null; // reset to default
             });

                return false;
            }
            
            
        });
    });
    
    function logoutMethod(){
    	location.href = "./motp_user_logout.jsp";
    }
    
    function checkRegStatus(){
    	var reg_status = '<%=reg_status%>'; 
    	if( reg_status == 'success' ){
    		
    		 jAlert('사용자가 등록되었습니다.', 'Alert Dialog', function(){
   				});
    	}
    	
    	var change_status = '<%=change_status%>'; 
    	if( change_status == 'success' ){
    		
    		 jAlert('사용자정보가 변경되었습니다.', 'Alert Dialog', function(){
   				});
    	}
    	
    	
    }
    
</script>



</head>

<body class="loginpage" onload="checkRegStatus()">

<div class="loginpanel">
    <div class="loginpanelinner">
        <!--<div class="logo animate0 bounceIn"><img src="images/logo.png" alt="" /></div>-->
		
		
		<div class="logo">
				<font color="white">
                <h5><%=m_IpamVersion%></h5>
                <h3>User Menu</h3>
				</font>
		</div>
        <form id="login" action="./motp_userreg_process.jsp" method="post">
            
            <div class="inputwrapper animate1 bounceIn">
                 <ul class="list-nostyle" >
                    <li><a href="./motp_issue.jsp" class="btn btn-info btn-rounded"><i class="iconfa-heart icon-white">     </i> MobileOTP 발급</a></li>
                    <li><a href="./motp_unissue.jsp" class="btn btn-info btn-rounded"><i class="iconfa-headphones icon-white"></i> MobileOTP 해제</a></li>
                    <li><a href="./motp_user_change_info.jsp" class="btn btn-info btn-rounded"><i class="iconfa-headphones icon-white"></i>사용자 정보변경</a></li>
				 </ul>
            </div>
           
          
            <div class="inputwrapper animate5 bounceIn">
                <button name="logout" onclick="logoutMethod();return false;" >Logout</button>
                <!--<a href="./motp_user_logout.jsp"><button name="logout">Logout</button></a>-->
            </div>
            
        </form>
    </div><!--loginpanelinner-->
</div><!--loginpanel-->

<div class="loginfooter">
    <p>&copy; <%=m_IpamCopyRights%></p>
</div>

</body>

</html>
