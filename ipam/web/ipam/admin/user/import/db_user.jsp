<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>


<%@ include file= "./DBConnection.jsp" %>

<%!

public class IpamException extends Exception {

	public IpamException(String message){
		super(message);
	}
	
	public IpamException(String message, Throwable cause){
		super(message, cause);
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




public List<HashMap> db_user_list() throws IpamException 
{

  Connection conn = null;
  ResultSet rs    = null;
  Statement stmt  = null;
  
    String  rs1 = "";
	String rs2 = "";
	String rs4 = "";
	String rs5 = "";
	String rs6 = "";
	String rs7 = "";
	String rs8 = "";
	String rs9 = "";
	String rs15 = "";
	
	StringBuffer buffer = new StringBuffer();

	
  try{
      
      conn = getConnection();
      conn.setAutoCommit(false);		
      stmt = conn.createStatement();   

	
    //-------------------------------------------
    // Query section
    //-------------------------------------------
    List<HashMap> mCurrentList;
    mCurrentList = new java.util.ArrayList<HashMap>();
    
    String queary = "SELECT *  FROM IPAM_USER";
  	rs = stmt.executeQuery(queary);
    	
    	int i = 0;
    	while(rs.next())
    	{
    		
    		HashMap item = new HashMap();
        	item.put("user_id", rs.getString("user_id"));
        	item.put("user_name", rs.getString("user_name"));
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
      throw new IpamException("insert", ex);
      
  } catch (Exception ex) {
  		throw new IpamException("insert", ex);
  } finally{
	  
		closeDB(rs, stmt, conn, null);
	  
  }
  
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
		closeDB(null, pstmt, conn);
        //if (pstmt != null) try { pstmt.close(); } catch(Exception ex) {}
        //if (conn != null) try { conn.close(); } catch(Exception ex) {}
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
		closeDB(null, pstmt, conn);
        //if (pstmt != null) try { pstmt.close(); } catch(Exception ex) {}
        //if (conn != null) try { conn.close(); } catch(Exception ex) {}
    }
}




public void db_user_update_access_info(String uid, String last_access_ip, String last_access_time) throws IpamException {
	
	Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = getConnection();
        String query = "UPDATE ipam_user SET last_access_ip =?, last_access_time =?";
               query+=" WHERE user_id=?";
        
        
        pstmt = conn.prepareStatement(query);
        	  
		pstmt.setString(1, last_access_ip);
		pstmt.setString(2, last_access_time);
		pstmt.setString(3, uid);
		
        pstmt.executeUpdate();
        
    } catch(SQLException ex) {
        throw new IpamException("user access update:: "+ex.toString());
        
    } catch (Exception ex) {
    	   throw new IpamException("user access update:: "+ex.toString());
           	
	} finally {
		closeDB(null, pstmt, conn);
        //if (pstmt != null) try { pstmt.close(); } catch(Exception ex) {}
        //if (conn != null) try { conn.close(); } catch(Exception ex) {}
    }
}



public void db_user_update_batch_flag(String flag, String uid) throws IpamException {
	
	Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = getConnection();
        String query = "UPDATE ipam_user SET batch_updated_flag =?";
        if(uid!=null){
        	query+=" WHERE user_id=?";
        }
        
        pstmt = conn.prepareStatement(query);
          
        String change_date = getCurrentTime3(); 	  
        	  
		pstmt.setString(1, flag);
		if(uid!=null)
			pstmt.setString(2, uid);
		
        pstmt.executeUpdate();
        
    } catch(SQLException ex) {
        throw new IpamException("batch update:: "+ex.toString());
        
    } catch (Exception ex) {
    	   throw new IpamException("batch update:: "+ex.toString());
           	
	} finally {
		closeDB(null, pstmt, conn);
        //if (pstmt != null) try { pstmt.close(); } catch(Exception ex) {}
        //if (conn != null) try { conn.close(); } catch(Exception ex) {}
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
        throw new IpamException("delete:: "+ex.toString());
    } catch (Exception ex) {
    	throw new IpamException("delete:: "+ex.toString());
	}finally {
		closeDB(null, pstmt, conn);
        //if (pstmt != null) try { pstmt.close(); } catch(Exception ex) {}
        //if (conn != null) try { conn.close(); } catch(Exception ex) {}
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
        throw new IpamException("getCount:: "+ex.toString());
        
    }catch(Exception ex) {
        throw new IpamException("getCount:: "+ex.toString());
        
    } finally {
    	closeDB(rs, stmt, conn, null);
        //if (rs != null) try { rs.close(); } catch(Exception ex) {}
        //if (stmt != null) try { stmt.close(); } catch(Exception ex) {}
        //if (conn != null) try { conn.close(); } catch(Exception ex) {}
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
           	item.put("change_date", rs.getString("change_date"));
           	item.put("last_access_ip", rs.getString("last_access_ip"));
           	item.put("last_access_time", rs.getString("last_access_time"));
             	
			mCurrentList.add(item);
             	
        }
     
        return mCurrentList;
        
        
    } catch(SQLException ex) {
        throw new IpamException("Search", ex);
        
    } catch (Exception ex) {
		
    	throw new IpamException("Search", ex);
	} finally {
		closeDB(rs, stmt, conn, null);
        //if (rs != null) try { rs.close(); } catch(Exception ex) {}
        //if (stmt != null) try { stmt.close(); } catch(Exception ex) {}
        //if (conn != null) try { conn.close(); } catch(Exception ex) {}
    }
	
}

public List<HashMap> db_user_search_batch_updated_flag(String flag) throws IpamException {
	
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    List<HashMap> mCurrentList;
    
    try {
    
   	    conn = getConnection();
        String queary = "SELECT * FROM ipam_user ";
    
       queary+=" WHERE ";
       queary+=" batch_updated_flag = "+"'"+flag+"' ";
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
        throw new IpamException("Search Flag:: "+ex.toString());
        
    } catch (Exception ex) {
		
    	throw new IpamException("Search Flag:: "+ex.toString());
	} finally {
		closeDB(rs, stmt, conn, null);
        //if (rs != null) try { rs.close(); } catch(Exception ex) {}
        //if (stmt != null) try { stmt.close(); } catch(Exception ex) {}
        //if (conn != null) try { conn.close(); } catch(Exception ex) {}
    }
	
}





%>	
