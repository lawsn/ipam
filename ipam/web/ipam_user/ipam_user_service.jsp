<%@ page contentType="text/html;charset=utf-8" %>
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
 * IPAM_USER ValueObject
 */
public class IpamUserVo {
	
	public int pageNo;
	public int scale;
	
	public String userName;
	public String userId;
	public String ipList;
	public String otherDesc;
	public String allowExcp;
	public String regDate;
	public String changeDate;

}


/**
 * ipam_user 테이블 목록 조회
 * @TODO 페이징처리, 검색조건 처리 
 */
public List<Map<String, String>> db_user_list(IpamUserVo param) throws IpamException {

    List<Map<String, String>> mCurrentList = null;
    
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	StringBuilder query = null;
	int paramIndex = 1;
	
	try{
		conn = getConnection();
		conn.setAutoCommit(false);		
	
		mCurrentList = new ArrayList<Map<String, String>>();
		
		//-------------------------------------------
		// Query section
		//-------------------------------------------
		query = new StringBuilder();
		query.append("select * from (").append("\n");
		query.append("select row_number() over(order by reg_date asc) as rnum").append("\n");
		query.append(",user_name,user_id,ip_list,other_desc").append("\n");
		query.append(",decode(allow_excp,'t','Yes','NO') as allow_excp").append("\n");
		query.append(",reg_date, change_date").append("\n");
		query.append("from ipam_user").append("\n");
		query.append(") where rnum between ? and ?").append("\n");
		
		pstmt = conn.prepareStatement(query.toString());
		if(DEBUG) System.out.format("QUERY=%s", query.toString());
		
		pstmt.setInt(paramIndex++, ((param.pageNo - 1) * param.scale) + 1);
		pstmt.setInt(paramIndex++, param.pageNo * param.scale);
		if(DEBUG) System.out.format("BETWEEN %d AND %d", ((param.pageNo - 1) * param.scale) + 1, param.pageNo * param.scale);

		rs = pstmt.executeQuery();
    	
    	int i = 0;
    	while(rs.next()) {
    		
    		HashMap item = new HashMap();
        	item.put("rnum", rs.getString("rnum"));
        	item.put("user_name", rs.getString("user_name"));
        	item.put("user_id", rs.getString("user_id"));
        	item.put("ip_list", rs.getString("ip_list"));
        	item.put("other_desc", rs.getString("other_desc"));
        	item.put("allow_excp", rs.getString("allow_excp"));
        	item.put("reg_date", rs.getString("reg_date"));
        	item.put("change_date", rs.getString("change_date"));
         	
         	mCurrentList.add(item);
			i++;
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








//crow1 start
public static String getCurrentTime3() {

    SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
    Date currentTime = new Date();
    String dateString = formatter.format(currentTime);

   return dateString;
}

public String getCurrentTimeLongString()
{
	long ctime =  System.currentTimeMillis();
	return Long.toString(ctime);
}





public void db_user_insert(HashMap userItem) throws IpamException {
	
	Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = getConnection();
        pstmt = conn.prepareStatement(
        "INSERT INTO ipam_user (user_id, user_name, ip_list, other_desc, allow_excp, reg_date, change_date) " +
        "VALUES (?,?,?,?,?,?,?)");
        
        String reg_date = getCurrentTime3();
        String change_date = reg_date;
        	  
		pstmt.setString(1, (String) userItem.get("user_id"));
		pstmt.setString(2, (String) userItem.get("user_name"));
		pstmt.setString(3, (String) userItem.get("ip_list"));
		pstmt.setString(4, (String) userItem.get("other_desc"));
		pstmt.setString(5, (String) userItem.get("allow_excp"));
		pstmt.setString(6, reg_date);
		pstmt.setString(7, change_date);
		
        pstmt.executeUpdate();
        
    } catch(SQLException ex) {
        throw new IpamException("insert", ex);
        
    } catch (Exception ex) {
    	throw new IpamException("insert", ex);
	} finally {
        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
}

public void db_user_update(HashMap userItem) throws IpamException {
	
	Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = getConnection();
        pstmt = conn.prepareStatement(
        "UPDATE ipam_user SET user_name =?, ip_list =?, other_desc =? , "+
        " allow_excp=?  , change_date=? " +
        "WHERE user_id=?");
          
        String change_date = getCurrentTime3(); 	  
        	  
		pstmt.setString(1, (String) userItem.get("user_name"));
		pstmt.setString(2, (String) userItem.get("ip_list"));
		pstmt.setString(3, (String) userItem.get("other_desc"));
		pstmt.setString(4, (String) userItem.get("allow_excp"));
		pstmt.setString(5, change_date);
		pstmt.setString(6, (String)userItem.get("user_id"));
		
        pstmt.executeUpdate();
        
    } catch(SQLException ex) {
        throw new IpamException("update", ex);
        
    } catch (Exception ex) {
    	   throw new IpamException("update", ex);
           	
	} finally {
        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
}

public void db_user_delete(String user_id) throws IpamException {
	
	Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = getConnection();
        pstmt = conn.prepareStatement(
        "DELETE FROM ipam_user WHERE user_id=?");
        pstmt.setString(1, user_id);
        pstmt.executeUpdate();        	
    	
    } catch(SQLException ex) {
        throw new IpamException("delete", ex);
        
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
}

public int getCount(String user_id, String user_name) throws IpamException {
	
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
    	boolean bFind1 = false;
    	boolean bFind2 = false;
    	
    	 String queary = "SELECT COUNT(*) FROM ipam_user ";
         
         if(user_id!=null&&user_id.equalsIgnoreCase("")==false)
         	bFind1 = true;
         if(user_name!=null&&user_name.equalsIgnoreCase("")==false)
         	bFind2 = true;
         if(bFind1==true||bFind2==true)
         	queary+=" WHERE ";
         
         if(bFind1)
         	queary+=" user_id = "+"'"+user_id+"' ";
         if(bFind2)
             queary+=" user_name = "+"'"+user_name+"' ";
         
         
        conn = getConnection();
        stmt = conn.createStatement();
        rs = stmt.executeQuery(queary);
        
        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
        
    } catch(SQLException ex) {
        throw new IpamException("getCount", ex);
        
    } finally {
        if (rs != null) try { rs.close(); } catch(SQLException ex) {}
        if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
}



public List<HashMap> db_user_search(String user_id, String user_name, String ip_list, String allow_excp) throws IpamException {
	
    Connection conn = null;
    //PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    List<HashMap> mCurrentList;
    
    try {
    	boolean bFind1 = false;//user_id
    	boolean bFind2 = false;//user_name
    	boolean bFind3 = false;//ip_list
   		boolean bFind4 = false;//allow_excp
   		
   		String Find2And="";
   		String Find3And="";
   		String Find4And="";
   		
        conn = getConnection();
        String queary = "SELECT * FROM ipam_user ";
    
        if(user_id!=null&&user_id.equalsIgnoreCase("")==false)
        	bFind1 = true;
        if(user_name!=null&&user_name.equalsIgnoreCase("")==false){
        	if(bFind1==true)
        		Find2And=" AND ";
        	bFind2 = true;
        }
        
        if(ip_list!=null&&ip_list.equalsIgnoreCase("")==false){
        	if(bFind1==true||bFind2==true)
        		Find3And=" AND ";
        	bFind3 = true;
        }
        
        if(allow_excp!=null&&allow_excp.equalsIgnoreCase("")==false){
        	if(bFind1==true||bFind2==true||bFind3==true)
        		Find4And=" AND ";
        	bFind4 = true;
        }
        
        if(bFind1==true||bFind2==true||bFind3==true||bFind4==true)
        	queary+=" WHERE ";
        
        if(bFind1)
        	queary+=" user_id = "+"'"+user_id+"' ";
        if(bFind2){
        	queary+=Find2And;
            queary+=" user_name = "+"'"+user_name+"' ";
        }
        if(bFind3){
        	queary+=Find3And;
            queary+=" ip_list = "+"'"+ip_list+"' ";
        }
        if(bFind4){
        	queary+=Find4And;
            queary+=" allow_excp = "+"'"+allow_excp+"' ";
        }
        	
        queary+=" ORDER BY reg_date ASC ";
        	
        System.out.println("search queary="+queary);		
        stmt = conn.createStatement();
        rs = stmt.executeQuery(queary);
        
        
        mCurrentList = new java.util.ArrayList<HashMap>();
        
        while(rs.next()) {
        	
        	HashMap item = new HashMap();
           	item.put("user_id", rs.getString("user_id"));
           	item.put("user_name", rs.getString("user_name"));
           	item.put("ip_list", rs.getString("ip_list"));
           	item.put("other_desc", rs.getString("other_desc"));
           	item.put("allow_excp", rs.getString("allow_excp"));
           	item.put("reg_date", rs.getString("reg_date"));
           	item.put("change_date", rs.getString("change_date"));
             	
			mCurrentList.add(item);
             	
        }
     
        return mCurrentList;
        
        
    } catch(SQLException ex) {
        throw new IpamException("Search", ex);
        
    } catch (Exception ex) {
		
    	throw new IpamException("Search", ex);
	} finally {
        if (rs != null) try { rs.close(); } catch(SQLException ex) {}
        if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
	
}




%>	
