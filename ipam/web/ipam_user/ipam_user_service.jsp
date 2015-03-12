<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ include file= "./import/DBConnection.jsp" %>

<%!
boolean DEBUG = true;

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
	public int scale;
	public int total_count;

	public String key_user_name;
	public String key_user_id;
	public String key_ip_list;
	public String key_other_desc;
	public String key_allow_excp;
	
	@Override
	public String toString() {
		return String.format("page_no=%s\nscale=%s\ntotal_count=%s\nkey_user_name=%s\nkey_user_id=%s\nkey_ip_list=%s\nkey_other_desc=%s\nkey_allow_excp=%s\n", page_no, scale, total_count, key_user_name, key_user_id, key_ip_list, key_other_desc, key_allow_excp);
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
        throw new IpamException("getCount", ex);
        
    } finally {
        if (rs != null) try { rs.close(); } catch(SQLException ex) {}
        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
    }
}


/**
 * @TODO 검색조건 처리 
 * ipam_user 테이블 목록 조회
 * @param param 검색조건
 */
public List<IpamUserVo> db_user_list(ParameterVo param) throws IpamException {

	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	StringBuilder query = null;
	int paramIndex = 1;
	List<Object> bind = null;
	
    List<IpamUserVo> mCurrentList = null;
    IpamUserVo vo = null;
    
	try{
		conn = getConnection();
		conn.setAutoCommit(false);		
	
		//-------------------------------------------
		// Query section
		//-------------------------------------------
		query = new StringBuilder();
		query.append("select row_number() over(order by reg_date asc) as rnum").append("\n");
		query.append(",user_name,user_id,ip_list,other_desc").append("\n");
		query.append(",decode(allow_excp,'t','Yes','No') as allow_excp").append("\n");
		query.append(",reg_date, change_date").append("\n");
		query.append("from ipam_user").append("\n");
		// search
		bind = new LinkedList<Object>();
		
		query.append("where 1=1").append("\n");
		if(!"".equals(param.key_user_name)) {
			query.append("and user_name like '%'||?||'%'").append("\n");
			bind.add(param.key_user_name);
		}
		if(!"".equals(param.key_user_id)) {
			query.append("and user_id like '%'||?||'%'").append("\n");
			bind.add(param.key_user_id);
		}
		if(!"".equals(param.key_ip_list)) {
			query.append("and ip_list like '%'||?||'%'").append("\n");
			bind.add(param.key_ip_list);
		}
		if(!"".equals(param.key_other_desc)) {
			query.append("and other_desc like '%'||?||'%'").append("\n");
			bind.add(param.key_other_desc);
		}
		if(!"".equals(param.key_allow_excp)) {
			query.append("and allow_excp = ?").append("\n");
			bind.add(param.key_allow_excp);
		}
		
		param.total_count = getCount(conn, query.toString(), bind.toArray());
		
		pstmt = conn.prepareStatement("SELECT * FROM (" + query.toString() + ") WHERE RNUM BETWEEN ? AND ?");
		if(DEBUG) System.out.format("QUERY=%s", query.toString());
		
    	for(Object b : bind) {
   			pstmt.setObject(paramIndex++, b);
    	}
    	pstmt.setInt(paramIndex++, ((param.page_no - 1) * param.scale) + 1);
		pstmt.setInt(paramIndex++, param.page_no * param.scale);
		if(DEBUG) System.out.format("BETWEEN %d AND %d", ((param.page_no - 1) * param.scale) + 1, param.page_no * param.scale);

		rs = pstmt.executeQuery();
    	
		mCurrentList = new ArrayList<IpamUserVo>();
    	while(rs.next()) {
    		
    		vo = new IpamUserVo();
    		vo.rnum = rs.getInt("rnum");
    		vo.user_name = rs.getString("user_name");
    		vo.user_id = rs.getString("user_id");
    		vo.ip_list = rs.getString("ip_list");
    		vo.other_desc = rs.getString("other_desc");
    		vo.allow_excp = rs.getString("allow_excp");
    		vo.reg_date = rs.getString("reg_date");
    		vo.change_date = rs.getString("change_date");
    		
         	mCurrentList.add(vo);
    	}
    	
    	return mCurrentList;
    	
	} catch(SQLException ex) {
		throw new IpamException("list", ex);
	} catch (Exception ex) {
		throw new IpamException("list", ex);
	} finally{
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
}

/**
 * ipam_user 테이블 입력/수정
 * @param userVo 입력/수정 정보
 */
public void db_user_manage(IpamUserVo userVo) throws IpamException {
	
	Connection conn = null;
    PreparedStatement pstmt = null;
    StringBuilder query = null;
    int paramIndex = 1;
    
    try {
        conn = getConnection();
        conn.setAutoCommit(false);
        
        query = new StringBuilder();
        query.append("MERGE INTO ipam_user").append("\n");
        query.append("     USING DUAL").append("\n");
        query.append("        ON (user_id = ?)").append("\n");
        query.append("WHEN MATCHED").append("\n");
        query.append("THEN").append("\n");
        query.append("   UPDATE SET user_name = ?,").append("\n");
        query.append("              ip_list = ?,").append("\n");
        query.append("              other_desc = ?,").append("\n");
        query.append("              allow_excp = NVL(?, 'f'),").append("\n");
        query.append("              change_date = TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI:SS')").append("\n");
        query.append("WHEN NOT MATCHED").append("\n");
        query.append("THEN").append("\n");
        query.append("   INSERT     (user_id,").append("\n");
        query.append("               user_name,").append("\n");
        query.append("               ip_list,").append("\n");
        query.append("               other_desc,").append("\n");
        query.append("               allow_excp,").append("\n");
        query.append("               reg_date,").append("\n");
        query.append("               change_date)").append("\n");
        query.append("       VALUES (?,").append("\n");
        query.append("               ?,").append("\n");
        query.append("               ?,").append("\n");
        query.append("               ?,").append("\n");
        query.append("               NVL(?, 'f'),").append("\n");
        query.append("               TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),").append("\n");
        query.append("               TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI:SS'))").append("\n");
        
        pstmt = conn.prepareStatement(query.toString());
        if(DEBUG) System.out.format("QUERY=%s", query.toString());
        if(DEBUG) System.out.println(userVo);
        
        pstmt.setString(paramIndex++, userVo.user_id);
        pstmt.setString(paramIndex++, userVo.user_name);
        pstmt.setString(paramIndex++, userVo.ip_list);
        pstmt.setString(paramIndex++, userVo.other_desc);
        pstmt.setString(paramIndex++, userVo.allow_excp);
        pstmt.setString(paramIndex++, userVo.user_id);
        pstmt.setString(paramIndex++, userVo.user_name);
        pstmt.setString(paramIndex++, userVo.ip_list);
        pstmt.setString(paramIndex++, userVo.other_desc);
        pstmt.setString(paramIndex++, userVo.allow_excp);
        
        pstmt.executeUpdate();
        conn.commit();
        
    } catch(SQLException ex) {
    	try { conn.rollback(); } catch(SQLException nohub) {}
        throw new IpamException("manage", ex);
    } catch (Exception ex) {
    	try { conn.rollback(); } catch(SQLException nohub) {}
    	throw new IpamException("manage", ex);
	} finally {
        if (pstmt != null) try { pstmt.close(); } catch(SQLException nohub) {}
        if (conn != null) try { conn.close(); } catch(SQLException nohub) {}
    }
}

/**
 * ipam_user 테이블 삭제
 */
public void db_user_delete(String user_id) throws IpamException {
	
	Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = getConnection();
        conn.setAutoCommit(false);
        
        pstmt = conn.prepareStatement("DELETE FROM ipam_user WHERE user_id=?");
        pstmt.setString(1, user_id);
        pstmt.executeUpdate();
        conn.commit();
    	
    } catch(SQLException ex) {
    	try { conn.rollback(); } catch(SQLException nohub) {}
        throw new IpamException("delete", ex);
        
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
}
%>	
