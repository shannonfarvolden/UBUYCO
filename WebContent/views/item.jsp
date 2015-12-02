<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Item</title>
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

<%
String ID = request.getParameter("pid");
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

Connection con = null;
String url = "jdbc:mysql://cosc304.ok.ubc.ca/group3";
String uid = "group3";
String pw = "group3";

try {
	con = DriverManager.getConnection(url, uid, pw);
	String SQL = "SELECT * "+
			"FROM Item "+
			"WHERE pid="+ID;

	PreparedStatement pstmt;
	pstmt = con.prepareStatement(SQL);
	ResultSet rst = pstmt.executeQuery();
	
	rst.first();
	
	String UserSQL = "SELECT username FROM User WHERE uid = "+rst.getInt("userselling");
	PreparedStatement pstmtUser;
	pstmtUser = con.prepareStatement(UserSQL);
	ResultSet rstUser = pstmtUser.executeQuery();
	rstUser.next();
	out.print("<div class=\"container\">"+
			"<div class=\"page-header\">"+
		    	"<h1>"+rst.getString("pname")+"</h1>"+
			"</div>");

		out.print("<div class=\"col-xs-6 col-md-3\">"+
		    "<div class=\"thumbnail\">"+
		        "<img src=\"../assets/placeholder.png\" alt=\"Item Image\">"+
		    "</div>"+
		    "<a href=\"#\"><h3>"+rstUser.getString("username")+"</h3></a>"+
		"</div>");

		out.print("<div class=\"col-md-offset-4\">"+
		    "<div class=\"panel panel-default\">"+
		        "<div class=\"panel-heading\">"+
		            "<h3 class=\"panel-title\">Description</h3>"+
		        "</div>"+
		        "<div class=\"panel-body\">"+
		        	rst.getString("description")+
		        "</div>"+
		    "</div>"+
		    "<div class=\"panel panel-default\">"+
		        "<div class=\"panel-heading\">"+
		            "<h3 class=\"panel-title\">Price</h3>"+
		        "</div>"+
		        "<div class=\"panel-body\">"+
		        	currFormat.format(rst.getDouble("price"))+
		        "</div>"+
		    "</div>"+

		    "<div class=\"panel panel-default\">"+
		        "<div class=\"panel-heading\">"+
		            "<h3 class=\"panel-title\">Item Condition</h3>"+
		        "</div>"+
		        "<div class=\"panel-body\">"+
		            rst.getString("pcondition")+
		        "</div>"+
		    "</div>"+

		    "<button type=\"submit\" class=\"btn btn-lg btn-primary\">Buy Now</button>"+
		"</div>"+

		"<h3>Comments</h3>"+
		"<form>"+
		    "​<textarea class=\"form-control\" id=\"txtArea\" rows=\"3\" cols=\"70\"></textarea><br>"+
		    "<button type=\"submit\" class=\"btn btn-default\">Submit</button>"+
		"</form>"+

		"</div>");
}
catch (SQLException ex) { 	
	out.println(ex); 
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


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="js/bootstrap.min.js"></script>
</body>
</html>
