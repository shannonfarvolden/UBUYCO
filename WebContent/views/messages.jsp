<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="auth.jsp"%>
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
                <li><a href="aboutus.jsp">About Us</a></li>
            </ul>
            <form class="navbar-form navbar-left" role="search" action="browse.jsp">
                <div class="form-group">
                    <input type="text" class="form-control" name="pname">
                </div>
                <button type="submit" class="btn btn-default">Search</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
              <%
				boolean isAuthenticated = session.getAttribute("username") == null ? false : true;
				if (isAuthenticated) {
					out.println("<li><a href='profile.jsp'>"+session.getAttribute("username")+"</a></li>");
					out.println("<li><a href='logout.jsp'>Logout</a></li>");
				} else {
					out.println("<li><a href='login.jsp'>Login</a></li>");
				}
			%>
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
    
    String userName = (String) session.getAttribute("authenticatedUser");
    
    try {
    	con = DriverManager.getConnection(url, uid, pw);
        
        String SQL = "SELECT mid, content, senttime, sender, pname, Item.pid, User.username FROM Message, Item, User WHERE User.username=\""+userName+"\" AND User.uid = Message.receiver AND Message.pid = Item.pid AND isRead = 0";
    	PreparedStatement pstmt;
    	pstmt = con.prepareStatement(SQL);
    	ResultSet rst = pstmt.executeQuery();
    	out.println("<h2>Unread</h2>");
    	
    	String userSQL;
    	PreparedStatement userpstmt;
    	ResultSet userrst;
    	while (rst.next()) {
    		userSQL = "SELECT username FROM User WHERE uid=" + rst.getInt("sender");
    		userpstmt = con.prepareStatement(userSQL);
    		userrst = userpstmt.executeQuery();
    		if (userrst.first()) {
    			out.print("<div class=\"panel panel-default\">"+
    					"  			<div class=\"panel-heading \">"+
    					"  				<h3 class=\"panel-title\">"+ userrst.getString("username") +"</h3>"+
    					"  			</div>"+
    					"  			<div class=\"panel-body\">"+ rst.getString("content") +
    					"  			</div>"+
    					"  		</div><i>"+rst.getString("senttime")+"</i>");
    			
    					
    					if (!rst.getString("content").equals("I accept your offer!") && !rst.getString("content").equals("I reject your offer!")) {
    						out.print(" <a href=\"messageHandler.jsp?offer=1&pid="+rst.getString("pid")+"&mid="+rst.getString("mid")+"\">Accept</a>|<a href=\"messageHandler.jsp?offer=2&pid="
    						+rst.getString("pid")+"&mid="+rst.getString("mid")+"\">Decline</a> <br><br><br>");}
    					else {
    						out.print(" <b>Deal Complete</b> <br><br><br>");
    					}
    					
    			
    		}
    	}
    	
    	SQL = "SELECT mid, content, senttime, sender, pname, Item.pid, User.username FROM Message, Item, User WHERE User.username=\""+userName+"\" AND User.uid = Message.receiver AND Message.pid = Item.pid AND isRead = 1";
    	pstmt = con.prepareStatement(SQL);
    	rst = pstmt.executeQuery();
    	out.println("<h2>Read</h2>");
    	while (rst.next()) {
    		userSQL = "SELECT username FROM User WHERE uid=" + rst.getInt("sender");
    		userpstmt = con.prepareStatement(userSQL);
    		userrst = userpstmt.executeQuery();
    		if (userrst.first()) {
    			out.print("<div class=\"panel panel-default\">"+
    					"  			<div class=\"panel-heading \">"+
    					"  				<h3 class=\"panel-title\">"+ userrst.getString("username") +"</h3>"+
    					"  			</div>"+
    					"  			<div class=\"panel-body\">"+ rst.getString("content") +
    					"  			</div>"+
    					"  		</div><i>"+rst.getString("senttime")+"</i> <br><br><br>");	
    		}
    	}
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
