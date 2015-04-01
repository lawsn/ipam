<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ include file= "./audit_service.jsp" %>

<%!

/**
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
		query.append("SELECT ROW_NUMBER() OVER(ORDER BY reg_date DESC) AS rnum").append("\n");
		query.append(",user_name,user_id,ip_list,other_desc").append("\n");
		query.append(",DECODE(allow_excp,'t','Yes','No') AS allow_excp").append("\n");
		query.append(",reg_date, change_date").append("\n");
		query.append("FROM ipam_user").append("\n");
		// search
		bind = new LinkedList<Object>();
		
		query.append("WHERE 1=1").append("\n");
		if(!"".equals(param.key_user_name)) {
			query.append("AND user_name like '%'||?||'%'").append("\n");
			bind.add(param.key_user_name);
		}
		if(!"".equals(param.key_user_id)) {
			query.append("AND user_id like '%'||?||'%'").append("\n");
			bind.add(param.key_user_id);
		}
		if(!"".equals(param.key_ip_list)) {
			query.append("AND ip_list like '%'||?||'%'").append("\n");
			bind.add(param.key_ip_list);
		}
		if(!"".equals(param.key_other_desc)) {
			query.append("AND other_desc like '%'||?||'%'").append("\n");
			bind.add(param.key_other_desc);
		}
		if(!"".equals(param.key_allow_excp)) {
			query.append("AND allow_excp = ?").append("\n");
			bind.add(param.key_allow_excp);
		}
		
		param.total_count = getCount(conn, query.toString(), bind.toArray());
		
		pstmt = conn.prepareStatement("SELECT * FROM (" + query.toString() + ") WHERE RNUM BETWEEN ? AND ?");
		if(DEBUG) System.out.format("QUERY=%s", query.toString());
		
    	for(Object b : bind) {
   			pstmt.setObject(paramIndex++, b);
    	}
    	pstmt.setInt(paramIndex++, param.getStartNo());
		pstmt.setInt(paramIndex++, param.getEndNo());
		if(DEBUG) System.out.format("BETWEEN %d AND %d", param.getStartNo(), param.getEndNo());

		rs = pstmt.executeQuery();
    	
		mCurrentList = new ArrayList<IpamUserVo>();
    	while(rs.next()) {
    		
    		vo = new IpamUserVo();
    		vo.rnum = rs.getInt("rnum");
    		vo.user_name = nullToBlank(rs.getString("user_name"));
    		vo.user_id = nullToBlank(rs.getString("user_id"));
    		vo.ip_list = nullToBlank(rs.getString("ip_list"));
    		vo.other_desc = nullToBlank(rs.getString("other_desc"));
    		vo.allow_excp = nullToBlank(rs.getString("allow_excp"));
    		vo.reg_date = nullToBlank(rs.getString("reg_date"));
    		vo.change_date = nullToBlank(rs.getString("change_date"));
    		
         	mCurrentList.add(vo);
    	}
    	
    	return mCurrentList;
    	
	} catch(SQLException ex) {
		ex.printStackTrace();
		throw new IpamException("list: "+ex.toString());
	} catch (Exception ex) {
		ex.printStackTrace();
		throw new IpamException("list: "+ex.toString());
	} finally{
		closeDB(rs, pstmt, conn);
		//if (rs != null) try { rs.close(); } catch(Exception ex) {ex.printStackTrace();}
		//if (pstmt != null) try { pstmt.close(); } catch(Exception ex) {ex.printStackTrace();}
		//if (conn != null) try { conn.close(); } catch(Exception ex) {ex.printStackTrace();}
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
    	DB_rollback(conn);
    	//try { conn.rollback(); } catch(SQLException nohub) {}
        throw new IpamException("manage: "+ex.toString());
    } catch (Exception ex) {
    	DB_rollback(conn);
    	//try { conn.rollback(); } catch(SQLException nohub) {}
    	throw new IpamException("manage: "+ex.toString());
	} finally {
		closeDB(null, pstmt, conn);
        //if (pstmt != null) try { pstmt.close(); } catch(Exception nohub) {}
        //if (conn != null) try { conn.close(); } catch(Exception nohub) {}
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
    	DB_rollback(conn);
    	//try { conn.rollback(); } catch(Exception nohub) {nohub.printStackTrace();}
        throw new IpamException("delete: "+ex.toString());
        
    } catch(Exception ex) {
    	DB_rollback(conn);
    	//try { conn.rollback(); } catch(Exception nohub) {nohub.printStackTrace();}
        throw new IpamException("delete: "+ex.toString());
        
    } finally {
    	closeDB(null, pstmt, conn);
        //if (pstmt != null) try { pstmt.close(); } catch(Exception ex) {}
        //if (conn != null) try { conn.close(); } catch(Exception ex) {}
    }
}

/**
 * ipam_user 테이블 조회 by user_id
 */
public IpamUserVo db_user_by_id(String user_id) throws IpamException {

	if(user_id == null || user_id.length() == 0) {
		return null;
	}

	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	StringBuilder query = null;
	
    IpamUserVo ipamUserVo = null;
    
	try{
		conn = getConnection();
		conn.setAutoCommit(false);		
	
		//-------------------------------------------
		// Query section
		//-------------------------------------------
		query = new StringBuilder();
		query.append("SELECT user_name,user_id,ip_list,other_desc,allow_excp").append("\n");
		query.append(",reg_date, change_date").append("\n");
		query.append("FROM ipam_user").append("\n");
		query.append("WHERE user_id = ?").append("\n");
		
		pstmt = conn.prepareStatement(query.toString());
		if(DEBUG) System.out.format("QUERY=%s", query.toString());
		
   		pstmt.setString(1, user_id);
		if(DEBUG) System.out.format("USER_ID=%s", user_id);

		rs = pstmt.executeQuery();
    	
    	if(rs.next()) {
    		
    		ipamUserVo = new IpamUserVo();
    		ipamUserVo.user_name = nullToBlank(rs.getString("user_name"));
    		ipamUserVo.user_id = nullToBlank(rs.getString("user_id"));
    		ipamUserVo.ip_list = nullToBlank(rs.getString("ip_list"));
    		ipamUserVo.other_desc = nullToBlank(rs.getString("other_desc"));
    		ipamUserVo.allow_excp = nullToBlank(rs.getString("allow_excp"));
    		ipamUserVo.reg_date = nullToBlank(rs.getString("reg_date"));
    		ipamUserVo.change_date = nullToBlank(rs.getString("change_date"));
    	}
    	
    	return ipamUserVo;
    	
	} catch(SQLException ex) {
		throw new IpamException("data: "+ex.toString());
	} catch (Exception ex) {
		throw new IpamException("data: "+ex.toString());
	} finally{
		closeDB(rs, pstmt, conn);
		//if (rs != null) try { rs.close(); } catch(Exception ex) {}
		//if (pstmt != null) try { pstmt.close(); } catch(Exception ex) {}
		//if (conn != null) try { conn.close(); } catch(Exception ex) {}
	}
}

/**
 * ipam_user 테이블 조회 by ip
 */
public List<IpamUserVo> db_user_by_ip(String user_ip) throws IpamException {

	if(user_ip == null || user_ip.length() == 0) {
		return null;
	}
	
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	StringBuilder query = null;
	
	List<IpamUserVo> mCurrentList = null;
    IpamUserVo ipamUserVo = null;
    
    boolean isExist = false;
    
	try{
		conn = getConnection();
		conn.setAutoCommit(false);		
	
		//-------------------------------------------
		// Query section
		//-------------------------------------------
		query = new StringBuilder();
		query.append("SELECT user_name,user_id,ip_list,other_desc,allow_excp").append("\n");
		query.append(",reg_date, change_date").append("\n");
		query.append("FROM ipam_user").append("\n");
		query.append("WHERE ip_list like '%'||?||'%'").append("\n");
		
		pstmt = conn.prepareStatement(query.toString());
		if(DEBUG) System.out.format("QUERY=%s", query.toString());
		
   		pstmt.setString(1, user_ip);
		if(DEBUG) System.out.format("Search IP=%s", user_ip);

		rs = pstmt.executeQuery();
    	
		mCurrentList = new ArrayList<IpamUserVo>();
    	while(rs.next()) {
    		String _temp = rs.getString("ip_list");
    		if(_temp == null || _temp.length() == 0) {
    			continue;
    		}
    		String[] ips = _temp.split(",");
    		if(ips == null || ips.length == 0) {
    			continue;
    		}
    		
    		isExist = false;
    		for(String ip : ips) {
    			if(user_ip.equals(ip)) {
    				isExist = true;
    				break;
    			}
    		}
    		if(!isExist) {
    			continue;
    		}
    		
    		ipamUserVo = new IpamUserVo();
    		ipamUserVo.user_name = rs.getString("user_name");
    		ipamUserVo.user_id = rs.getString("user_id");
    		ipamUserVo.ip_list = rs.getString("ip_list");
    		ipamUserVo.other_desc = rs.getString("other_desc");
    		ipamUserVo.allow_excp = rs.getString("allow_excp");
    		ipamUserVo.reg_date = rs.getString("reg_date");
    		ipamUserVo.change_date = rs.getString("change_date");
    	}
    	
    	return mCurrentList;
    	
	} catch(SQLException ex) {
		throw new IpamException("data: "+ex.toString());
	} catch (Exception ex) {
		throw new IpamException("data: "+ex.toString());
	} finally{
		closeDB(rs, pstmt, conn);
		//if (rs != null) try { rs.close(); } catch(Exception ex) {}
		//if (pstmt != null) try { pstmt.close(); } catch(Exception ex) {}
		//if (conn != null) try { conn.close(); } catch(Exception ex) {}
	}
}

/**
 * 입력한 ID에 일치하는 사용자가 있는지 조회
 */
public boolean has_by_id(String user_id) throws IpamException {
	if(db_user_by_id(user_id) != null) {
		return true;
	}
	return false;
}

/**
 * 입력한 IP에 일치하는 사용자가 있는지 조회
 */
public boolean has_by_ip(String user_ip) throws IpamException {
	List<IpamUserVo> list = db_user_by_ip(user_ip);
	if(list != null && list.size() > 0) {
		return true;
	}
	return false;
}
%>	
