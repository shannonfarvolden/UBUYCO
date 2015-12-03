<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Profile</title>
    <!-- Bootstrap -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/stylesheet.css" rel="stylesheet">
</head>
<body>
	
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
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

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="createItem.jsp">Create A Post <span class="sr-only">(current)</span></a></li>
                <li><a href="aboutUs.html">About Us</a></li>
            </ul>
            <form class="navbar-form navbar-left" role="search" action="browse.jsp">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Search" name="pname">
                </div>
                <button type="submit" class="btn btn-default">Submit</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <!--if user not login display login-->
                <li><a href="login.jsp">Login</a></li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>

<!-- profile picture -->
												
<%@ include file="auth.jsp"%>

<%
    String userName = (String) session.getAttribute("authenticatedUser");
    String userID = request.getParameter("uid");
        if (userID == null) {}		
    Connection con = null;
    String url = "jdbc:mysql://cosc304.ok.ubc.ca/group3";
    String uid = "group3";
    String pw = "group3";
    boolean yourPage = false;
    
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    
    try {
    	Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url, uid, pw);
		
		if(userName != null) {
			String SQL = "SELECT * FROM User WHERE username LIKE \""+userName+"\"";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			ResultSet rst = pstmt.executeQuery();
			
			if (rst.first()) {
				String currUserID = rst.getString("uid");
				if (userID == null) {userID = currUserID;}	
				yourPage = userID.equals(currUserID);
			}
		}
		if (yourPage) {out.println("<h1>Welcome back, "+userName+"</h1>");}
		
		String pageUserSQL = "SELECT * FROM User WHERE uid = "+userID;
		PreparedStatement pstmtPageUser = con.prepareStatement(pageUserSQL);
		ResultSet pageUser = pstmtPageUser.executeQuery();
		pageUser.first();
		
		out.print("<div class=\"container\">"+
		
	    "<div class=\"row\">"+
	        "<div class=\"col-xs-6 col-md-3\">"+
	            "<div class=\"thumbnail\">"+
	                "<img src=\"../WebContent/assets/"+pageUser.getString("username")+".jpeg\" alt=\"Item Image\">"+pageUser.getString("username")+
	            "</div>"+
	        "</div>"+
	        "<div class=\"page-header\">"+
	        "<h1>"+pageUser.getString("username")+"</h1>"+
	    	"</div>"+
	    "</div>"+
		"<form name=\"input\" action=\"uploadPic.jsp\" method=\"POST\" enctype=\"multipart/form-data\">"+
	    	"<input type='file' name=\"fileToUpload\" id=\"fileToUpload\"/>"+
			"<input type=\"submit\" value=\"Upload\" />"+
		"</form>"+
		
	    "<div class=\"page-header\">"+
	        "<h1>Items on Sale</h1>"+
	    "</div>");
	    
		
			String itemsSoldSQL = "SELECT * FROM Item WHERE userselling = "+userID;
			PreparedStatement pstmtItemsSold = con.prepareStatement(itemsSoldSQL);
			ResultSet itemsSold = pstmtItemsSold.executeQuery();
			
			while(itemsSold.next()) {
				out.print("<div class=\"row\">"+
			        "<div class=\"col-xs-6 col-md-3\">"+
			            "<div class=\"thumbnail\">"+
			                "<img src=\"../assets/"+itemsSold.getString("pic")+"\" alt=\"Item Image\">"+
			            "</div>"+
			        "</div>"+
			        "<div class=\"col-md-6\">"+
			            "<div class=\"panel panel-default\">"+
			                "<div class=\"panel-heading\">"+
			                    "<h3 class=\"panel-title\">Item Description</h3>"+
			                "</div>"+
			                "<div class=\"panel-body\">"+
			                    itemsSold.getString("description")+
			                "</div>"+
			            "</div>"+
			        "</div>"+
			        "<div class=\"input-group col-md-6\">"+
			            "<span class=\"input-group-addon\">"+currFormat.format(itemsSold.getDouble("price"))+"</span>"+
			        "</div>"+
			    "</div>");
			    if (yourPage == false) {
			    	out.print("<button type=\"button\" class=\"btn btn-lg btn-primary\">Buy Now</button>");
			    }
			}
			
		  if (yourPage == true) {
			String itemsBoughtSQL = "SELECT * FROM Item WHERE boughtby = "+userID;
			PreparedStatement pstmtItemsBought = con.prepareStatement(itemsBoughtSQL);
			ResultSet itemsBought = pstmtItemsBought.executeQuery();
			
		    out.print("<div class=\"page-header\">"+
		        "<h1>Items Bought</h1>"+
		    "</div>");
		    if (!itemsBought.first()) {out.println("Nothing to show");}
		    while (itemsBought.next()) {
			    out.print("<div class=\"row\">"+
			        "<div class=\"col-xs-6 col-md-3\">"+
			            "<div class=\"thumbnail\">"+
			                "<img src=\"../assets/"+itemsBought.getString("pic")+"\" alt=\"Item Image\">"+
			            "</div>"+
			        "</div>"+
			        "<div class=\"col-md-6\">"+
			            "<div class=\"panel panel-default\">"+
			                "<div class=\"panel-heading\">"+
			                    "<h3 class=\"panel-title\">Item Description</h3>"+
			                "</div>"+
			                "<div class=\"panel-body\">"+
			                    itemsBought.getString("description")+
			                "</div>"+
			            "</div>"+
			        "</div>"+
			        "<div class=\"input-group col-md-6\">"+
			            "<span class=\"input-group-addon\">"+currFormat.format(itemsBought.getDouble("price"))+"</span>"+
			            "<input type=\"text\" class=\"form-control\" aria-label=\"Offer Price\">"+
			        "</div>"+
			    "</div>"+
			 "</div>");
		    }
		}
    }
    catch (SQLException ex) {
    	out.println(ex);
    }
    finally {
    	try {
			if (con != null) {
				con.close();
			}
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
    }
%>

</div>


</body>
</html>
