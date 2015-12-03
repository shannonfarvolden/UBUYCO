<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
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
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="home.jsp">UBUYCO</a>
			</div>
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="createItem.jsp">Create A Post <span
							class="sr-only">(current)</span></a></li>
					<li><a href="aboutus.jsp">About Us</a></li>
				</ul>
				<form class="navbar-form navbar-left" role="search"
					action="browse.jsp">
					<div class="form-group">
						<input type="text" class="form-control" name="pname">
					</div>
					<button type="submit" class="btn btn-default">Search</button>
				</form>
				<ul class="nav navbar-nav navbar-right">
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
		</div>
	</nav>
	<!--end nav-->

	<%
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		Connection con = null;
		String url = "jdbc:mysql://cosc304.ok.ubc.ca/group3";
		String uid = "group3";
		String pw = "group3";

		try {

			String prodID = request.getParameter("pid");

			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url, uid, pw);
			String SQL = "SELECT * " + "FROM Item " + "WHERE pid=" + prodID;

			PreparedStatement pstmt;
			pstmt = con.prepareStatement(SQL);
			ResultSet rst = pstmt.executeQuery();

			rst.first();

			String userID = rst.getString("userselling");

			String UserSQL = "SELECT username FROM User WHERE uid = " + userID;
			PreparedStatement pstmtUser;
			pstmtUser = con.prepareStatement(UserSQL);
			ResultSet rstUser = pstmtUser.executeQuery();
			rstUser.first();

			out.print("<div class=\"container\">" + "<div class=\"page-header\">" + "<h1>" + rst.getString("pname")
					+ "</h1>" + "</div>");

			out.print("<h3>Seller: <a href=\"profile.jsp?uid="
					+ rst.getInt("userselling") + "\">" + rstUser.getString("username") + "</a></h3>");

			out.print("<div class=\"panel panel-default\">"
						+ "<div class=\"panel-heading\">" + 
							"<h3 class=\"panel-title\">Description</h3></div>" 
								+ "<div class=\"panel-body\">" + rst.getString("description") + "</div>" + 
							"</div>"
						+ "<div class=\"panel panel-default\">" + "<div class=\"panel-heading\">"
					+ "<h3 class=\"panel-title\">Price</h3>" + "</div>" + "<div class=\"panel-body\">"
					+ currFormat.format(rst.getDouble("price")) + "</div>" + "</div>" +

			"<div class=\"panel panel-default\">" + "<div class=\"panel-heading\">"
					+ "<h3 class=\"panel-title\">Item Condition</h3>" + "</div>" + "<div class=\"panel-body\">"
					+ rst.getString("pcondition") + "</div>" + "</div>" + "<form action=\"buyMessage.jsp?pid="
					+ prodID + "&uid=" + userID + "\" method=\"post\">"
					+ "<input type=\"submit\" value=\"Buy Now\" class=\"btn btn-default\">" + "</form>"  +
			"</div>");
		} catch (SQLException ex) {
			out.println(ex);
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (SQLException ex) {
					System.err.println("SQLException: " + ex);
				}
			}
		}
	%>


	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
