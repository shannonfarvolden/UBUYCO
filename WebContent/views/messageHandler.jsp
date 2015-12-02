<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Messages</title>
    <!-- Bootstrap -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/stylesheet.css" rel="stylesheet">
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
            <a class="navbar-brand" href="#">UBUYCO</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="#">Create A Post <span class="sr-only">(current)</span></a></li>
                <li><a href="#">About Us</a></li>
            </ul>
            <form class="navbar-form navbar-left" role="search">
                <div class="form-group">
                    <input type="text" class="form-control">
                </div>
                <button type="submit" class="btn btn-default">Search</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <!--if user not login display login-->
                <li><a href="#">Login</a></li>
                <!--else display username-->
                <!--<li><a href="#">User Name</a></li>-->
            </ul>
        </div>
    </div>
</nav>
<!--end nav-->
<div class="container">
    

</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="../js/bootstrap.min.js"></script>
</body>
</html>

<%
	String offer = request.getParameter("offer");
	String prodID = request.getParameter("pid");
	String messID = request.getParameter("mid");
	
	Connection con = null;
	String url = "jdbc:mysql://cosc304.ok.ubc.ca/group3";
	String uid = "group3";
	String pw = "group3";
	
	try {
		con = DriverManager.getConnection(url, uid, pw);
		
		String updateMess = "UPDATE Message SET isRead = 1 WHERE mid = "+messID;
		String updateProd = "UPDATE Item SET isSold = 1 WHERE pid = "+prodID;
		
		PreparedStatement pstmt = con.prepareStatement(updateMess);
		pstmt.execute();
		
		if (offer.equals("1")) {
			out.println("<h3>Offer Accepted!</h3>");
			pstmt = con.prepareStatement(updateProd);
			pstmt.execute();
			
			updateMess = "UPDATE Message SET isRead = 1 WHERE pid = "+prodID;
			
			pstmt = con.prepareStatement(updateMess);
			pstmt.execute();
		}
		
		else if (offer.equals("2")) {
			out.println("<h3>Offer Declined!</h3>");
		}
		
		
	}
	catch (SQLException ex) {
		System.err.println("SQLException: " + ex);
	}
	finally {
		try 
		{
			if (con != null)
				con.close();
		} 
		catch (SQLException ex) 
		{
			out.println(ex);
		}
	}

	out.println("<br><a href=\"messages.jsp\">Return to Messages</a>");
%>