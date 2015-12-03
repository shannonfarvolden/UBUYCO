<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <title>Messages</title>
</head>
<body>
<!--navigation bar-->
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="home.jsp">UBUYCO</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="createItem.jsp">Create A Post <span class="sr-only">(current)</span></a></li>
                <li><a href="aboutUs.html">About Us</a></li>
            </ul>
            <form class="navbar-form navbar-left" role="search" action="browse.jsp">
                <div class="form-group">
                    <input type="text" class="form-control" name="pname">
                </div>
                <button type="submit" class="btn btn-default">Search</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <!--if user not login display login-->
                <li><a href="login.jsp">Login</a></li>
                <!--else display username-->
                <!--<li><a href="#">User Name</a></li>-->
            </ul>
        </div>
    </div>
</nav>
<!--end nav-->
<div class="container">
    <div class="page-header">
       <h1>
           Messages
       </h1>
    </div>
    <%
    
    Connection con = null;
    String url = "jdbc:mysql://cosc304.ok.ubc.ca/group3";
    String uid = "group3";
    String pw = "group3";
    
    try {
    	con = DriverManager.getConnection(url, uid, pw);
        
        String SQL = "SELECT mid, content, senttime, sender, pname, Item.pid FROM Message, Item WHERE Message.pid = Item.pid AND isRead = 0";
    	PreparedStatement pstmt;
    	pstmt = con.prepareStatement(SQL);
    	ResultSet rst = pstmt.executeQuery();
    	out.println("<h4>Unread</h4>");
    	out.println("<table><tr><th>Sender</th><th>Item</th><th>Message</th><th></th><th></th></tr>");
    	
    	String userSQL;
    	PreparedStatement userpstmt;
    	ResultSet userrst;
    	while (rst.next()) {
    		userSQL = "SELECT username FROM User WHERE uid=" + rst.getInt("sender");
    		userpstmt = con.prepareStatement(userSQL);
    		userrst = userpstmt.executeQuery();
    		if (userrst.first()) {
    			out.println("<tr><td>"+userrst.getString("username")+"</td><td>"+rst.getString("pname")+"</td><td>"+rst.getString("content")+"</td><td>"+rst.getString("senttime")+
    					"</td><td><a href=\"messageHandler.jsp?offer=1&pid="+rst.getString("pid")+"&mid="+rst.getString("mid")+"\">Accept</a>|<a href=\"messageHandler.jsp?offer=2&pid="+
    			rst.getString("pid")+"&mid="+rst.getString("mid")+"\">Decline</a></td></tr>");	
    		}
    	}
    	out.println("<table>");
    	
    	SQL = "SELECT mid, content, senttime, sender, pname, Item.pid FROM Message, Item WHERE Message.pid = Item.pid AND isRead = 1";
    	pstmt = con.prepareStatement(SQL);
    	rst = pstmt.executeQuery();
    	out.println("<h4>Read</h4>");
    	out.println("<table><tr><th>Sender</th><th>Item</th><th>Message</th><th></th><th></th></tr>");
    	while (rst.next()) {
    		userSQL = "SELECT username FROM User WHERE uid=" + rst.getInt("sender");
    		userpstmt = con.prepareStatement(userSQL);
    		userrst = userpstmt.executeQuery();
    		if (userrst.first()) {
    			out.println("<tr><td>"+userrst.getString("username")+"</td><td>"+rst.getString("pname")+"</td><td>"+rst.getString("content")+"</td><td>"+rst.getString("senttime")+
    					"</td><td></td></tr>");	
    		}
    	}
    	out.println("<table>");
    }
    catch (SQLException ex) {
    	System.err.println("SQLException: " + ex);
    }
    finally {
    	if (con != null) {
    		try {
    			con.close();
    		}
            catch (SQLException ex) {
            	System.err.println("SQLException: " + ex);
            }
    	}	
    }
    
    
    
    %>
</div>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="js/bootstrap.min.js"></script>

</body>
</html>
