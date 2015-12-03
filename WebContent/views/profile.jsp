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
                <li><a href="aboutus.jsp">About Us</a></li>
            </ul>
            <form class="navbar-form navbar-left" role="search" action="browse.jsp">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Search" name="pname">
                </div>
                <button type="submit" class="btn btn-default">Submit</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <!--if user not login display login-->
					<%
						boolean isAuthenticated = session.getAttribute("username") == null ? false : true;
						if (isAuthenticated) {
							out.println("<li><a href='profile.jsp'>" + session.getAttribute("username") + "</a></li>");
							out.println("<li><a href='logout.jsp'>Logout</a></li>");
						} else {
							out.println("<li><a href='login.jsp'>Login</a></li>");
						}
					%>
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
	String currUserID = null;

	if(userName != null) {
	String SQL = "SELECT * FROM User WHERE username LIKE \""+userName+"\"";
	PreparedStatement pstmt = con.prepareStatement(SQL);
	ResultSet rst = pstmt.executeQuery();

	if (rst.first()) {
		currUserID = rst.getString("uid");
		if (userID == null) {userID = currUserID;}	
			yourPage = userID.equals(currUserID);
		}
	}
	
	String pageUserSQL = "SELECT * FROM User WHERE uid = "+userID;
	PreparedStatement pstmtPageUser = con.prepareStatement(pageUserSQL);
	ResultSet pageUser = pstmtPageUser.executeQuery();
	pageUser.first();
	
	out.print("<div class=\"container\">"+
	"<div class=\"jumbotron\">"+
	
	"<h1>" + pageUser.getString("username") + "</h1>");
	if (pageUser.getBoolean("showemail")) {
		out.print("<p><a href=\"mailto:"+pageUser.getString("email")+"?Subject=UBUYCO\" target=\"_top\">Send Mail</a></p>");
		}
	out.print("<p>Description: "+pageUser.getString("description")+"</p></div>");
	if(yourPage)
		out.print(		"	<div class=\"btn-group btn-group-justified\" role=\"group\" aria-label=\"...\">"+
						"	  <div class=\"btn-group\" role=\"group\">"+
						"	    <a href=\"messages.jsp\" class=\"btn btn-primary\">Messages</a>"+
						"	  </div>"+
						"	  <div class=\"btn-group\" role=\"group\">"+
						"	    <a href=\"settings.jsp\" class=\"btn btn-primary\">Settings</a>"+
						"	  </div>"+
						"	 </div>"
				); 

	
	out.print("<div class=\"page-header\">" + "<h1>Items on Sale</h1>" + "</div>");

	String itemsSoldSQL = "SELECT * FROM Item WHERE userselling = " + userID;
	PreparedStatement pstmtItemsSold = con.prepareStatement(itemsSoldSQL);
	ResultSet itemsSold = pstmtItemsSold.executeQuery();
	out.print("<div class=\"row\">");
	while (itemsSold.next()) {
		out.print("<div class=\"col-md-4\">"+
   			  	"  	<a href=\"item.jsp?pid="+ itemsSold.getInt("pid")+ " \">"+
				"  		<div class=\"panel panel-default\">"+
				"  			<div class=\"panel-heading \">"+
				"  				<h3 class=\"panel-title\">"+ itemsSold.getString("description") +"</h3>"+
				"  			</div>"+
				"  			<div class=\"panel-body\">"+ currFormat.format(itemsSold.getDouble("price"))+
				"  			</div>"+
				"  		</div>"+
				"  	</a>"
				);
		if (yourPage == true) {
			out.print("<a href=\"editItem.jsp?pid="+ itemsSold.getInt("pid")+" \" class=\"btn btn-lg btn-primary\">Edit</a>");
		}
		out.print("</div>");
	}
	out.print("</div>");

	if (yourPage == true) {
		String itemsBoughtSQL = "SELECT * FROM Item WHERE boughtby = " + userID;
		PreparedStatement pstmtItemsBought = con.prepareStatement(itemsBoughtSQL);
		ResultSet itemsBought = pstmtItemsBought.executeQuery();

		out.println("<br><div class=\"page-header\">" + "<h1>Items Bought</h1>" + "</div>");
		if (!itemsBought.first()) {
			out.println("Nothing to show");
		}
		out.print("<div class=\"row\">");
		while (itemsBought.next()) {
			out.print("<div class=\"col-md-4\">"+
	   			  	"  	<a href=\"item.jsp?pid="+ itemsBought.getInt("pid")+ " \">"+
					"  		<div class=\"panel panel-default\">"+
					"  			<div class=\"panel-heading \">"+
					"  				<h3 class=\"panel-title\">"+ itemsBought.getString("description") +"</h3>"+
					"  			</div>"+
					"  			<div class=\"panel-body\">"+ currFormat.format(itemsBought.getDouble("price"))+
					"  			</div>"+
					"  		</div>"+
					"  	</a>"+
					"</div>"
					);
		}
		out.print("</div>");
	}
	else {
		String comment = request.getParameter("comment");
		String subject = request.getParameter("subject");
		
		if (comment == null) {}
		else if(currUserID != null) {
			String addCommentSQL = "INSERT INTO Comment (subject,content,commenter,receiver) VALUES(\""+subject+"\",\""+comment+"\","+currUserID+","+userID+")";
			PreparedStatement pstmtAddComment = con.prepareStatement(addCommentSQL);
			pstmtAddComment.execute();
		}
		
		
		out.print("<div class=\"page-header\"><h1>Comments</h1></div>");
		String dispCommentSQL = "SELECT subject, content, username FROM Comment, User WHERE Comment.commenter=User.uid AND receiver = "+userID;
		PreparedStatement pstmtDispComments = con.prepareStatement(dispCommentSQL);
		ResultSet comments = pstmtDispComments.executeQuery();
		while (comments.next()) {
			out.print("<h3>"+comments.getString("subject")+"</h3><br>"+comments.getString("content")+"<br><i>"+comments.getString("username")+"</i>");
		}
		
    	out.print("<form action=\"profile.jsp?uid="+userID+"\" method=\"post\">"+
    				"<input type=\"text\" name=\"subject\" value=\"Subject of Comment\">"+
    				"<textarea class=\"form-control\" id=\"txtArea\" rows=\"10\" cols=\"50\" name=\"comment\">Leave a comment...</textarea></br>"+
    				"<input type=\"submit\" value=\"Submit\" class=\"btn btn-default\">"+
    		    "</form>");
	}
} catch (SQLException ex) {
		out.println(ex);
	} finally {
		try {
			if (con != null) {
				con.close();
			}
		} catch (SQLException ex) {
			out.println(ex);
		}
	}
%>

</div>


</body>
</html>
