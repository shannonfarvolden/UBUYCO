<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.io.output.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
    Connection conn = null;
	String url = "jdbc:mysql://cosc304.ok.ubc.ca/group3";
	String uid = "group3";
	String pw = "group3";
	try 
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection(url, uid, pw);

   PreparedStatement psImageInsertDatabase=null;

   byte[] b=null;
   try{
      String sqlImageInsertDatabase="insert into upload_image (bImage) values(?)";
      psImageInsertDatabase=conn.prepareStatement(sqlImageInsertDatabase);

      DiskFileItemFactory factory = new DiskFileItemFactory();

      ServletFileUpload sfu = new ServletFileUpload(factory);
      List items = sfu.parseRequest(request);

      Iterator iter = items.iterator();

      while (iter.hasNext()) {
         FileItem item = (FileItem) iter.next();
         if (!item.isFormField()) {
              b = item.get();
          }
      }

      psImageInsertDatabase.setBytes(1,b);
      psImageInsertDatabase.executeUpdate();
   }
	
   catch(Exception e)
   {
     e.printStackTrace();
     response.sendRedirect("addimage.jsp");
   }
  }
	
	catch (SQLException ex) 
	{
		out.println(ex);
	} 
   
   finally 
	{
		try 
		{
			if (conn != null)
				conn.close();
		} 
		catch (SQLException ex) 
		{
			out.println(ex);
		}
	}

%>
