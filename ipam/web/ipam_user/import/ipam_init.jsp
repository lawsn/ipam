<%@ page contentType="text/html;charset=utf-8" %>

<%!
//////////////////////////////////////////////////
//IPAM(IP Access Management) 버전정보
//////////////////////////////////////////////////
String m_IpamVersion = "Ipam Version v1.0";
String m_IpamCopyRights = "2013. UHMSOFT Corporation. All Rights Reserved.";
String m_IpamCompanyHome = "http://www.uhmsoft.com";
String m_uhmmotp_loginpage = "./motp_user_login.jsp";

//////////////////////////////////////////////////
//DB 정보
//////////////////////////////////////////////////
String m_connection_driver = "oracle.jdbc.driver.OracleDriver";
String m_connection_url = "jdbc:oracle:thin:@127.0.0.1:1521:MOTPDB";
String m_user = "uhm_motp";
String m_password = "uhm_motp";

%>

<%
//////////////////////////////////////////////////
//      변수 선언 및 입력정보 복호화
//////////////////////////////////////////////////
response.setHeader("Cache-Control", "no-cache, post-check=0, pre-check=0");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");

%>

