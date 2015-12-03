<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <title>Message</title>
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
           Send Message
       </h1>
    </div>
    <%

    
    Connection con = null;
    String url = "jdbc:mysql://cosc304.ok.ubc.ca/group3";
    String uid = "group3";
    String pw = "group3";
    
    try {
    	con = DriverManager.getConnection(url, uid, pw);
        
    	String prodID = request.getParameter("pid");
		String userID = request.getParameter("uid");
		String words = request.getParameter("message");
		
        String UserSQL = "SELECT username FROM User WHERE uid = "+userID;
    	PreparedStatement pstmtUser;
    	pstmtUser = con.prepareStatement(UserSQL);
    	ResultSet rstUser = pstmtUser.executeQuery();
    	rstUser.first();
    	
    	if (words == null) {
    		out.print("<h5>Send To: "+rstUser.getString("username")+"</h5>"+
    		    "<form action=\"buyMessage.jsp?pid="+prodID+"&uid="+userID+"\" method=\"post\">"+
    				"<textarea class=\"form-control\" id=\"txtArea\" rows=\"10\" cols=\"50\" name=\"message\">Hello, I would like to purchase your product, friend :)</textarea></br>"+
    				"<input type=\"submit\" value=\"Submit\" class=\"btn btn-default\">"+
    		    "</form>");
    	}
    	else {
    		out.println("<h3>Your message has been sent!</h3>"+
    					"<br><a href=\"browse.jsp\">Return to Browse</a>");
    		
    	}
 		
 		    
    	String timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new java.util.Date());
    	out.println(timeStamp);
    	
    	
    	if (words != null) {
    		String addMess = "INSERT INTO Message (pid,senttime,receiver,content,sender,isRead) "+
					"VALUES("+prodID+",\""+timeStamp+"\","+userID+",\""+words+"\",1,0); ";
	
			
			PreparedStatement insert = con.prepareStatement(addMess);
			insert.execute();
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
