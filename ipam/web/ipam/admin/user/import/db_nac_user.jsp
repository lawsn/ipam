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




public List<HashMap> db_nac_user_list() throws IpamException 
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
      
      conn = getConnectionMysql();
      conn.setAutoCommit(false);		
      stmt = conn.createStatement();   

	
    //-------------------------------------------
    // Query section
    //-------------------------------------------
    List<HashMap> mCurrentList;
    mCurrentList = new java.util.ArrayList<HashMap>();
    
    String queary = "SELECT *  FROM "+m_NMAP_USER_TNAME;
  	rs = stmt.executeQuery(queary);
    	
    	int i = 0;
    	while(rs.next())
    	{
    		
    		HashMap item = new HashMap();
        	item.put(m_NMAP_USER_ID, rs.getString(m_NMAP_USER_ID));
        	item.put(m_NMAP_USER_NAME, rs.getString(m_NMAP_USER_NAME));
        	item.put(m_NMAP_IP_LIST, rs.getString(m_NMAP_IP_LIST));
         	
         	mCurrentList.add(item);
			i++;
    	}
    	
    	return mCurrentList;
		
  } catch(SQLException ex) {
      throw new IpamException("list:: "+ex.toString());
      
  } catch (Exception ex) {
  		throw new IpamException("list:: "+ex.toString());
  } finally{
	   try{
		   closeDB(rs, stmt, conn, null);
	  }catch(Exception e){
	    e.printStackTrace();
	  }
  }
  
}


public void db_nac_user_insert(HashMap userItem) throws IpamException {
	
	Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = getConnectionMysql();
        pstmt = conn.prepareStatement(
        "INSERT INTO nac_user (nuser_id, nuser_name, nip_list) " +
        "VALUES (?,?,?)");
        
        String reg_date = getCurrentTime3();
        String change_date = reg_date;
        	  
		pstmt.setString(1, (String) userItem.get("nuser_id"));
		pstmt.setString(2, (String) userItem.get("nuser_name"));
		pstmt.setString(3, (String) userItem.get("nip_list"));
		
        pstmt.executeUpdate();
        
    } catch(SQLException ex) {
        throw new IpamException("insert:: "+ex.toString());
        
    } catch (Exception ex) {
    	throw new IpamException("insert:: "+ex.toString());
	} finally {
        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
}


public void db_nac_user_delete(String user_id) throws IpamException {
	
	Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = getConnectionMysql();
        pstmt = conn.prepareStatement(
        "DELETE FROM nac_user WHERE nuser_id=?");
        pstmt.setString(1, user_id);
        pstmt.executeUpdate();        	
    	
    } catch(SQLException ex) {
        throw new IpamException("delete:: "+ex.toString());
        
    }  catch (Exception ex) {
  		throw new IpamException("delete:: "+ex.toString());
    }finally {
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
    	
    	 String queary = "SELECT COUNT(*) FROM nac_user ";
         
         if(user_id!=null&&user_id.equalsIgnoreCase("")==false)
         	bFind1 = true;
         if(user_name!=null&&user_name.equalsIgnoreCase("")==false)
         	bFind2 = true;
         if(bFind1==true||bFind2==true)
         	queary+=" WHERE ";
         
         if(bFind1)
         	queary+=" nuser_id = "+"'"+user_id+"' ";
         if(bFind2)
             queary+=" nuser_name = "+"'"+user_name+"' ";
         
         
        conn = getConnectionMysql();
        stmt = conn.createStatement();
        rs = stmt.executeQuery(queary);
        
        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
        
    } catch(SQLException ex) {
        throw new IpamException("getCount:: "+ex.toString());
        
    }catch (Exception ex) {
  		throw new IpamException("getCount "+ex.toString());
    } finally {
        if (rs != null) try { rs.close(); } catch(SQLException ex) {}
        if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
}

public synchronized int db_nac_user_search(Connection srcConn, 
		String user_id, String user_name) throws IpamException {
	
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
    	boolean bFind1 = false;
    	boolean bFind2 = false;
    	
    	 String queary = "SELECT COUNT(*) FROM "+m_NMAP_USER_TNAME+" ";
         
         if(user_id!=null&&user_id.equalsIgnoreCase("")==false)
         	bFind1 = true;
         if(user_name!=null&&user_name.equalsIgnoreCase("")==false)
         	bFind2 = true;
         if(bFind1==true||bFind2==true)
         	queary+=" WHERE ";
         
         if(bFind1)
         	queary+=" "+m_NMAP_USER_ID+" = "+"'"+user_id+"' ";
         if(bFind2)
             queary+=" "+m_NMAP_USER_NAME+" = "+"'"+user_name+"' ";
         
         
        conn = srcConn;
        stmt = conn.createStatement();
        rs = stmt.executeQuery(queary);
        
        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
        
    } catch(SQLException ex) {
        throw new IpamException("search:: "+ex.toString());
        
    }catch(Exception ex) {
        throw new IpamException("search:: "+ex.toString());
        
    } finally {
        if (rs != null) try { rs.close(); } catch(SQLException ex) {}
        if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
}



%>	
