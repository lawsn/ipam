<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file= "ipam_init.jsp" %>


<%

        Connection con=null;
        Statement stmt=null;
        ResultSet rs=null;
        
        out.println("<br>db test : m_connection_driver="+m_connection_driver);
        out.println("<br>db test : m_connection_url="+m_connection_url);
        out.println("<br>db test : m_user="+m_user);
        out.println("<br>db test : m_password="+m_password);
        
        try{

                Class.forName(m_connection_driver);
                con = DriverManager.getConnection(m_connection_url, m_user,m_password);
		out.println("<br>TransactionIsolation : " + con.getTransactionIsolation() ); 
		out.println("<br>AutoCommit: " + con.getAutoCommit());
		out.println("<br>ReadOnly : " + con.isReadOnly());

		con.setAutoCommit(false);
		con.setTransactionIsolation(2);

		out.println("<br>1 TransactionIsolation : " + con.getTransactionIsolation() ); 
		out.println("<br>1 AutoCommit: " + con.getAutoCommit());
		out.println("<br>1 ReadOnly : " + con.isReadOnly());
		out.println("<br>");

                String sql = " select * from IPAM_USER";
                stmt = con.createStatement();        
                rs = stmt.executeQuery(sql);
                while(rs.next())
                {
                        out.println("<br>user_id="+rs.getString("user_id"));
                        out.println(",user_name="+rs.getString("user_name"));
                        out.println(",ip_list="+rs.getString("ip_list"));
                        out.println(",other_desc="+rs.getString("other_desc"));
                        out.println(",allow_excp="+rs.getString("allow_excp"));
                }
                
                out.println("<br><br>connection = "+con);
				out.println("<br>db test success!!! :");  
				
        }catch(Exception e){
                e.printStackTrace();
                out.println("<br>error: "+e);
                System.out.println(e);
        }
        finally
        { 
	        if(rs != null) { try{ rs.close(); }catch(Exception e){e.printStackTrace();} } 
    	    if(stmt != null) { try{ stmt.close(); }catch(Exception e){e.printStackTrace();} } 
        	if(con != null) { try{ con.close(); }catch(Exception e){e.printStackTrace(); } }
    	}
%>

