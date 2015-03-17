<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.net.*" %>
<%@ include file="./ipam_client.jsp" %>

<%
	
	

%>
<!doctype html>
<html>
<head>  <meta charset="euc-kr">  
<title>jQuery UI Button - Default functionality</title>  
<link rel="stylesheet" href="../ipam_user/css/jquery-ui.css">
<script src="../ipam_user/js/jquery-1.9.1.min.js"></script>
<script src="../ipam_user/js/jquery-ui-1.10.3.min.js"></script>
<link rel="stylesheet" href="../ipam_user/css/style.default.css">
<script>  
	$(function()
	{ 
		$( "input[type=submit], a, button" ).button().
			click(function( event ) 
			{
				event.preventDefault();      
			});
			
	});

</script>
</head>
<body>
	<button>버튼 엘리먼트</button>
	<input type="submit" value="전송 버튼">
	<a href="#">An anchor</a>
</body>
</html>
