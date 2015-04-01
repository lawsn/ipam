<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ include file= "./import/DBConnection.jsp" %>

<%!
/*********************************************************
 * Global Variable
 *********************************************************/
boolean DEBUG = true;
int g_scale = 5; //paging sacle count

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
	return str;
}
/*********************************************************
 * User Define Utils END
 *********************************************************/

/**
 * User Define Exception CLAZZ
 */
public class IpamException extends Exception {

	public IpamException(String message){
		super(message);
	}
	
	public IpamException(String message, Throwable cause){
		super(message, cause);
	}
}

/**
 * IPAM_USER Parameter ValueObject
 */
public class ParameterVo {

	public int page_no;
	public int view_count;
	public int total_count;

	public String add_condition;
	public String key_user_name;
	public String key_user_id;
	public String key_ip_list;
	public String key_other_desc;
	public String key_allow_excp;
	
	public int getStartNo() {
		return ((this.page_no - 1) * this.view_count) + 1;
	}
	
	public int getEndNo() {
		return this.page_no * this.view_count;
	}
	
	public int getTotalPage() {
		int no = ((int) (this.total_count / this.view_count));
		if(this.total_count % this.view_count == 0) {
			return no;
		}
		return no + 1;
	}
	
	public int getStartPageNo() {
		int no = ((int) (this.page_no / g_scale) * g_scale) + 1;
		if(this.page_no % g_scale == 0) {
			return no - g_scale;
		}
		return no;
	}
	
	@Override
	public String toString() {
		return String.format("page_no=%s\nview_count=%s\ntotal_count=%s\nkey_user_name=%s\nkey_user_id=%s\nkey_ip_list=%s\nkey_other_desc=%s\nkey_allow_excp=%s\n", page_no, view_count, total_count, key_user_name, key_user_id, key_ip_list, key_other_desc, key_allow_excp);
	}
}

/**
 * IPAM_USER ValueObject
 */
public class IpamUserVo {
	
	public int rnum;
	public String user_name;
	public String user_id;
	public String ip_list;
	public String other_desc;
	public String allow_excp;
	public String reg_date;
	public String change_date;
	
	public String joinIpList(String join) {
		
		StringBuilder sb = new StringBuilder();
		if(this.ip_list != null && this.ip_list.length() > 0) {
			String[] ipList = this.ip_list.split(",");
			for(String ip : ipList) {
				sb.append(ip).append(join);
			}
		}
		return sb.toString();
	}

	@Override
	public String toString() {
		return String.format("user_name=%s\nuser_id=%s\nip_list=%s\nother_desc=%s\nallow_excp=%s\n", user_name, user_id, ip_list, other_desc, allow_excp);
	}
}

/**
 * 총건수 조회
 * @param conn 연결된 DBConnection
 * @param subQuery 건수 조회 할 query
 * @param bind query bind values
 */
public int getCount(Connection conn, String subQuery, Object... bind) throws IpamException {
	
	PreparedStatement pstmt = null;
    ResultSet rs = null;
    
	int count = 0;
	int paramIndex = 1;
	
    try {
    	pstmt = conn.prepareStatement("SELECT COUNT(*) FROM (" + subQuery + ")");
    	for(int i=0; i<bind.length; i++) {
   			pstmt.setObject(paramIndex++, bind[i]);
    	}
    	rs = pstmt.executeQuery();
    	
        if (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
        
    } catch(SQLException ex) {
        throw new IpamException("getCount: "+ex.toString());
        
    } catch(Exception ex) {
        throw new IpamException("getCount: "+ex.toString());
        
    } finally {
    	closeDB(rs, pstmt, null);
      
    }
}

%>	
