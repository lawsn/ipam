<%@ page contentType="text/html;charset=euc-kr" %>

<%!
//////////////////////////////////////////////////
//IPAM(IP Access Management) ��������
//////////////////////////////////////////////////
String m_IpamTitle = "Ipam Administrator";
String m_IpamVersion = "Ipam Version v1.0";
String m_IpamCopyRights = "2013. UHMSOFT Corporation. All Rights Reserved.";
String m_IpamCompanyHome = "http://www.uhmsoft.com";
String m_IpamCompany = "UHMSOFT";
String m_uhmmotp_loginpage = "./motp_user_login.jsp";

//////////////////////////////////////////////////
//DB ����:mysql
//////////////////////////////////////////////////
String m_nac_connection_driver = "com.mysql.jdbc.Driver";
String m_nac_connection_url = "jdbc:mysql://localhost:3306/NAC";
String m_nac_user = "uhm";
String m_nac_password = "uhm";

String m_NMAP_USER_TNAME = "nac_user";
String m_NMAP_USER_ID = "nuser_id";
String m_NMAP_USER_NAME = "nuser_name";
String m_NMAP_IP_LIST = "nip_list";


//////////////////////////////////////////////////
//DB ����:oracle
//////////////////////////////////////////////////
// String m_connection_driver = "oracle.jdbc.driver.OracleDriver";
// String m_connection_url = "jdbc:oracle:thin:@127.0.0.1:1521:IPAMDB";
// String m_user = "ipam_user";
// String m_password = "ipam_user";
String m_connection_driver = "oracle.jdbc.driver.OracleDriver";
String m_connection_url = "jdbc:oracle:thin:@127.0.0.1:1521:MOTPDB";
String m_user = "uhm_motp";
String m_password = "uhm_motp";

%>

<%
//////////////////////////////////////////////////
//      ���� ���� �� �Է����� ��ȣȭ
//////////////////////////////////////////////////
response.setHeader("Cache-Control", "no-cache, post-check=0, pre-check=0");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");

%>

