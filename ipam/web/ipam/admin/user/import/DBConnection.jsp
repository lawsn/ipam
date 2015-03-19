<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="sun.misc.BASE64Decoder"%> 
<%@ include file= "./ipam_init.jsp" %>

<%!
public static String base64Encode(String str)  throws java.io.IOException {
                sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
                byte[] b1 = str.getBytes("UTF-8");
                String result = encoder.encode(b1);
                return result ;
        }

public String base64decoding(String encodedString)
{
 String retVal = "";

 try
 {
     byte[] plainText = null; 
  sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
  plainText = decoder.decodeBuffer (encodedString ); 


  retVal =new String(plainText, "UTF8");
  //retVal = new String(retVal.getBytes("UTF-8"));
 }catch(Exception e){
 
  e.printStackTrace();
 }
 
 return retVal;

}


        

//*********************************************************
// getConnection
//*********************************************************
public Connection getConnection() throws Exception
{
		Connection conn = null;
		
		try
		{
			Properties props = new Properties();
			props.put("connection.driver", m_connection_driver);
			props.put("connection.url", m_connection_url);
			props.put("user", m_user);
			props.put("password", m_password);
	
			Class.forName(props.getProperty("connection.driver"));
	    conn = DriverManager.getConnection(props.getProperty("connection.url"), props);		  
	  }catch(Exception e){
	  	e.printStackTrace();
	  	throw e;
	  }

	  
    return conn;
}

//*********************************************************
//getConnection
//*********************************************************
public Connection getConnectionMysql() throws Exception
{
		Connection conn = null;
		
		try
		{
			Properties props = new Properties();
			props.put("connection.driver", m_nac_connection_driver);
			props.put("connection.url", m_nac_connection_url);
			props.put("user", m_nac_user);
			props.put("password", m_nac_password);
	
			Class.forName(props.getProperty("connection.driver"));
	    conn = DriverManager.getConnection(props.getProperty("connection.url"), props);		  
	  }catch(Exception e){
	  	e.printStackTrace();
	  	throw e;
	  }

	  
 return conn;
}



public void DB_commit(Connection conn)
{
	  try
	  {
			conn.commit();
			
	  }catch(Exception e){
	  	e.printStackTrace();
	  }
}

public void DB_rollback(Connection conn)
{
	  try
	  {
			conn.rollback();
			
	  }catch(Exception e){
	  	e.printStackTrace();
	  }
}

public void closeDB(ResultSet rs, PreparedStatement pstmt, Connection conn)
{
	  try{
	    	
	      if(rs!=null)  rs.close();
	      
		  }catch(Exception e1){
		    e1.printStackTrace();
		  }
		  
		  try{
		    if(pstmt!=null) pstmt.close();
		  }catch(Exception e1){
		    e1.printStackTrace();
		  }

		   try{
		       if(conn!=null) 	    conn.close();
		  }catch(Exception e1){
		    e1.printStackTrace();
		  }	  
}

public String closeDB(ResultSet rs, Statement stmt, Connection conn, Statement stmtCount)
{
    String result = "";
    try{
    	
      if(rs!=null)  rs.close();
      
	  }catch(Exception e1){
	    e1.printStackTrace();
	  }
	  
	  try{
	    if(stmt!=null) stmt.close();
	  }catch(Exception e1){
	    e1.printStackTrace();
	  }

	  try{
	    	if(stmtCount!=null) stmtCount.close();
	  }catch(Exception e1){
	    e1.printStackTrace();
	  }
	  
	   try{
	   
	    if(conn!=null) 	    conn.close();
	  }catch(Exception e1){
	    e1.printStackTrace();
	  }	  
	  
    return result;
}


public String do_protocol_error()
{
  StringBuffer buffer = new StringBuffer();
  
    	buffer.append("<result_code>1</result_code>");   
    	buffer.append("<result_msg>inavlid protocol</result_msg>");
	    buffer.append("</response>");   
	    
	return buffer.toString();    

}





%>	
