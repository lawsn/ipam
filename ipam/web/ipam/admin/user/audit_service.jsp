<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ include file= "./comm_service.jsp" %>

<%!

/**
 * IPAM_AUDIT Parameter ValueObject
 */
public class ParameterAudit {

	public int page_no;
	public int view_count;
	public int total_count;

	public String add_condition;
	public String key_event_no;
	public String key_audit_type;
	public String key_operator_id;
	public String key_ip_list;
	public String key_other_desc;
	public String key_allow_excp;
	public String key_reg_date;
	public String key_audit_detail;
	
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
		return String.format("page_no=%s\nview_count=%s\ntotal_count=%s\nkey_event_no=%s\nkey_audit_type=%s\nkey_operator_id=%s\nkey_ip_list=%s\nkey_other_desc=%s\nkey_allow_excp=%s\n", page_no, view_count, total_count, key_event_no, 
				key_audit_type, key_operator_id, key_ip_list, key_other_desc, key_allow_excp);
	}
}

/**
 * IPAM_AUDIT ValueObject
 */
public class IpamAuditVo {
	
	public int rnum;
	public String event_no;
	public String audit_type;
	public String operator_id;
	public String ip_list;
	public String other_desc;
	public String allow_excp;
	public String reg_date;
	public String audit_detail;
	
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
		return String.format("audit_type=%s\noperator_id=%s\nip_list=%s\nother_desc=%s\nallow_excp=%s\nreg_date=%s\naudit_detail=%s\n", audit_type, operator_id, ip_list, other_desc, allow_excp, reg_date, audit_detail);
	}
}

/**
 * ipam_audit 테이블 목록 조회
 * @param param 검색조건
 */
public List<IpamAuditVo> db_audit_list(ParameterAudit param) throws IpamException {

	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	StringBuilder query = null;
	int paramIndex = 1;
	List<Object> bind = null;
	
    List<IpamAuditVo> mCurrentList = null;
    IpamAuditVo vo = null;
    
	try{
		conn = getConnection();
		conn.setAutoCommit(false);		
	
		//-------------------------------------------
		// Query section
		//-------------------------------------------
		query = new StringBuilder();
		query.append("SELECT ROW_NUMBER() OVER(ORDER BY event_no DESC) AS rnum").append("\n");
		query.append(",audit_type,operator_id,ip_list,other_desc").append("\n");
		query.append(",DECODE(allow_excp,'t','Yes','No') AS allow_excp").append("\n");
		query.append(",reg_date, audit_detail").append("\n");
		query.append("FROM ipam_audit").append("\n");
		// search
		bind = new LinkedList<Object>();
		
		query.append("WHERE 1=1").append("\n");
		if(!"".equals(param.key_audit_type)) {
			query.append("AND audit_type like '%'||?||'%'").append("\n");
			bind.add(param.key_audit_type);
		}
		if(!"".equals(param.key_operator_id)) {
			query.append("AND operator_id like '%'||?||'%'").append("\n");
			bind.add(param.key_operator_id);
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
    	
		mCurrentList = new ArrayList<IpamAuditVo>();
    	while(rs.next()) {
    		
    		vo = new IpamAuditVo();
    		vo.rnum = rs.getInt("rnum");//event_no는 입력할때만 사용한다.
    		vo.audit_type = nullToBlank(rs.getString("audit_type"));
    		vo.operator_id = nullToBlank(rs.getString("operator_id"));
    		vo.ip_list = nullToBlank(rs.getString("ip_list"));
    		vo.other_desc = nullToBlank(rs.getString("other_desc"));
    		vo.allow_excp = nullToBlank(rs.getString("allow_excp"));
    		vo.reg_date = nullToBlank(rs.getString("reg_date"));
    		vo.audit_detail = nullToBlank(rs.getString("audit_detail"));
    		
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
	}
}

/**
 * ipam_audit 테이블 입력
 * @param auditVo 입력
 */
public void db_audit_insert(IpamAuditVo auditVo) throws IpamException {
	
	Connection conn = null;
    PreparedStatement pstmt = null;
    StringBuilder query = null;
    int paramIndex = 1;
    
    try {
        conn = getConnection();
        conn.setAutoCommit(false);
        
        query = new StringBuilder();
      
        query.append("   INSERT  INTO ipam_audit   (event_no,").append("\n");
        query.append("               audit_type,").append("\n");
        query.append("               operator_id,").append("\n");
        query.append("               ip_list,").append("\n");
        query.append("               other_desc,").append("\n");
        query.append("               allow_excp,").append("\n");
        query.append("               reg_date,").append("\n");
        query.append("               audit_detail)").append("\n");
        
        query.append("       VALUES (ipam_audit_seq.NEXTVAL,").append("\n");
        query.append("               ?,").append("\n");
        query.append("               ?,").append("\n");
        query.append("               ?,").append("\n");
        query.append("               ?,").append("\n");
        query.append("               NVL(?, 'f'),").append("\n");
        query.append("               TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),").append("\n");
        query.append("               ?)").append("\n");
        
        pstmt = conn.prepareStatement(query.toString());
        if(DEBUG) System.out.format("QUERY=%s", query.toString());
        if(DEBUG) System.out.println(auditVo);
        
        pstmt.setString(paramIndex++, auditVo.audit_type);
        pstmt.setString(paramIndex++, auditVo.operator_id);
        pstmt.setString(paramIndex++, auditVo.ip_list);
        pstmt.setString(paramIndex++, auditVo.other_desc);
        pstmt.setString(paramIndex++, auditVo.allow_excp);
        //pstmt.setString(paramIndex++, auditVo.reg_date);
        pstmt.setString(paramIndex++, auditVo.audit_detail);
        
        pstmt.executeUpdate();
        conn.commit();
        
    } catch(SQLException ex) {
    	DB_rollback(conn);
        throw new IpamException("manage: "+ex.toString());
    } catch (Exception ex) {
    	DB_rollback(conn);
    	throw new IpamException("manage: "+ex.toString());
	} finally {
		closeDB(null, pstmt, conn);
    }
}

/**
 * ipam_user 테이블 삭제
 */
public void db_audit_delete(String event_no) throws IpamException {
	
	Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = getConnection();
        conn.setAutoCommit(false);
        
        pstmt = conn.prepareStatement("DELETE FROM ipam_audit WHERE event_no=?");
        pstmt.setString(1, event_no);
        pstmt.executeUpdate();
        conn.commit();
    	
    } catch(SQLException ex) {
    	DB_rollback(conn);
    	
        throw new IpamException("delete: "+ex.toString());
        
    } catch(Exception ex) {
    	DB_rollback(conn);
    	
        throw new IpamException("delete: "+ex.toString());
        
    } finally {
    	closeDB(null, pstmt, conn);
      
    }
}

/**
 * ipam_audit 테이블 조회 by operator_id
 */
public IpamAuditVo db_event_no_by_id(String event_no) throws IpamException {

	if(event_no == null || event_no.length() == 0) {
		return null;
	}

	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	StringBuilder query = null;
	
    IpamAuditVo ipamAuditVo = null;
    
	try{
		conn = getConnection();
		conn.setAutoCommit(false);		
	
		//-------------------------------------------
		// Query section
		//-------------------------------------------
		query = new StringBuilder();
		query.append("SELECT audit_type,operator_id,ip_list,other_desc,allow_excp").append("\n");
		query.append(",reg_date, audit_detail").append("\n");
		query.append("FROM ipam_audit").append("\n");
		query.append("WHERE event_no = ?").append("\n");
		
		pstmt = conn.prepareStatement(query.toString());
		if(DEBUG) System.out.format("QUERY=%s", query.toString());
		
   		pstmt.setString(1, event_no);
		if(DEBUG) System.out.format("event_no=%s", event_no);

		rs = pstmt.executeQuery();
    	
    	if(rs.next()) {
    		
    		ipamAuditVo = new IpamAuditVo();
    		ipamAuditVo.audit_type = nullToBlank(rs.getString("audit_type"));
    		ipamAuditVo.operator_id = nullToBlank(rs.getString("operator_id"));
    		ipamAuditVo.ip_list = nullToBlank(rs.getString("ip_list"));
    		ipamAuditVo.other_desc = nullToBlank(rs.getString("other_desc"));
    		ipamAuditVo.allow_excp = nullToBlank(rs.getString("allow_excp"));
    		ipamAuditVo.reg_date = nullToBlank(rs.getString("reg_date"));
    		ipamAuditVo.audit_detail = nullToBlank(rs.getString("audit_detail"));
    	}
    	
    	return ipamAuditVo;
    	
	} catch(SQLException ex) {
		throw new IpamException("data: "+ex.toString());
	} catch (Exception ex) {
		throw new IpamException("data: "+ex.toString());
	} finally{
		closeDB(rs, pstmt, conn);
		
	}
}

public void db_audit(String audit_type,String operator_id, IpamUserVo selectedUserVo) throws IpamException {
	
	try{
		
		IpamAuditVo auditVo = new IpamAuditVo();
		
		if(audit_type.equals("USER_ADD")){
			auditVo.audit_type = "사용자추가";
			
		}else if(audit_type.equals("USER_MOD")){
			auditVo.audit_type = "사용자변경";
			
		}else if(audit_type.equals("USER_DEL")){
			auditVo.audit_type = "사용자삭제";
		}
		
		auditVo.operator_id = operator_id;
		auditVo.ip_list = selectedUserVo.ip_list;
		auditVo.other_desc = selectedUserVo.other_desc;
		auditVo.allow_excp = selectedUserVo.allow_excp;
		
		String audit_detail = selectedUserVo.toString();
		auditVo.audit_detail = audit_detail;
		
		db_audit_insert(auditVo);
		
	
	}catch (IpamException ex) {
		throw ex;
	}catch (Exception ex) {
		throw new IpamException("db_audit: "+ex.toString());
	}  
	
}


%>	
