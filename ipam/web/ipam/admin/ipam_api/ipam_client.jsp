<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ include file= "../user/import/db_user.jsp" %>

<%!
/*********************************************************
 * Ipam Client Variable
 *********************************************************/

/*********************************************************
 * User Define Utils START
 *********************************************************/
/**
 * String to Int with DefaultValue
 */
public int toInt(String no, int defaultValue) {
	try {
		return Integer.parseInt(no);
	}catch(NumberFormatException e) {
		return defaultValue;
	}
}

/**
 * NULL to Blank
 */
public String nullToBlank(String str) {
	if(str == null) {
		return "";
	}
	return str.trim();
}

public boolean Ipam_IsEmpty(String str) {
	if(str == null) {
		return true;
	}
	
	String temp = str.trim();
	if(temp.equals(""))
		return true;
	
	return false;
}



/*********************************************************
 * User Define Utils END
 *********************************************************/


/**
 * IpamResult
 */
public class IpamResult {

	public int result = 0;
	public String lastAccessTime = "";
	public String lastAccessIp = "";
	
	public IpamResult(int result, String lastAccessIp, String lastAccessTime){
		this.result = result;
		this.lastAccessIp = lastAccessIp;
		this.lastAccessTime = lastAccessTime;
	}

}

/*********************************************************
 * Ipam Client API
 * user_id: ����� ���̵�
 * client_ip: ����� Clinet Ip
 *********************************************************/
public IpamResult Ipam_CheckIp(String user_id, String client_ip)throws IpamException{
	
	  IpamResult ir = null;
	  
	  try
	  {
			if(Ipam_IsEmpty(user_id)){
				throw new IpamException("parameter is invalid: user_id is null");
			}
			
			if(Ipam_IsEmpty(client_ip)){
				throw new IpamException("parameter is invalid: client_ip is null");
			}

			List<HashMap> searchList = db_user_search(user_id, null, null, null);
			if(searchList==null){//����ڸ� ã������
				ir = new IpamResult(-1,"","");
				return ir;
			}
			int size = searchList.size();
			if(size!=1){//����ڸ� ã������
				ir = new IpamResult(-2,"","");
				return ir;
			}
			
			/*********************************************************
			 * ����ڸ� ã�Ҵ� 
			 * �������˻�
			 * ������� üũ �˻�
			 *********************************************************/
			String fip_list = (String)searchList.get(0).get("ip_list");
			String fallow_excp = (String)searchList.get(0).get("allow_excp");
			String flast_access_ip = (String)searchList.get(0).get("last_access_ip");
			String flast_access_time = (String)searchList.get(0).get("last_access_time");
			
			fip_list = nullToBlank(fip_list);
			fallow_excp = nullToBlank(fallow_excp);
			flast_access_ip = nullToBlank(flast_access_ip);
			flast_access_time = nullToBlank(flast_access_time);
			
			int fip = fip_list.indexOf(client_ip);//client ip�� �������Ǵ��� �˻��Ѵ�.
			if(fip==-1){//������� �Ұ�
					//������� �˻�
					if(fallow_excp.equals("f")){
						//������� �Ұ��ϸ� �������� ������ ���������� ������Ʈ ���� �ʴ´�.
						System.out.println("ipam_client: client can't access portal:"+client_ip);
						ir = new IpamResult(-3,flast_access_ip,flast_access_time);
						return ir;
					}else{
						System.out.println("ipam_client: Ipam_CheckIp success! : allow excep true");
					}
			}else{
				System.out.println("ipam_client: Ipam_CheckIp success!");
			}
			
			/*********************************************************
			 * client ip ������� ���� üũ ����
			 * ���� ����ip,time�� ������Ʈ�Ѵ�.
			 *********************************************************/
			String currTime = getCurrentTime3();
			String currClientIp = client_ip;
			
			
			db_user_update_access_info(user_id, currClientIp, currTime);
			
			ir = new IpamResult(0,flast_access_ip,flast_access_time);
			return ir;
			
			
	  }catch(Exception ex){
	  		ex.printStackTrace();
	  		throw new IpamException("IpamClient: invalid operation: "+ex.toString());
	  }
}



%>	
