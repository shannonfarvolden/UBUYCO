<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="auth.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Settings</title>
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
	<!-- end nav -->

	<div class="container">
		<div class="page-header">
			<h1>Settings</h1>
		</div>
		<form method=get action=profile.jsp>
			<div class="form-group">
				<label for="name">Username</label> <input type="text"
					class="form-control" id="name" placeholder="Username">
			</div>
			<div class="form-group">
				<label for="email">Email</label> <input type="email"
					class="form-control" id="email" placeholder="Email">
			</div>
			<div class="form-group">
				<label for="password1">Password</label> <input type="password"
					class="form-control" id="password1" placeholder="Password">
			</div>
			<div class="form-group">
				<label for="password2">Confirm Password</label> <input
					type="password" class="form-control" id="password2"
					placeholder="Confirm Password">
			</div>
			<button type="submit" class="btn btn-default">Submit</button>
		</form>
		<br>

		<%
			Connection con = null;
			String url = "jdbc:mysql://cosc304.ok.ubc.ca/group3";
			String uid = "group3";
			String pw = "group3";
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(url, uid, pw);

				String username = request.getParameter("username");
				String email = request.getParameter("email");
				String password = request.getParameter("password");
				String password2 = request.getParameter("password2");
				String currname = (String) session.getAttribute("username");

				boolean hasUsername = username != null && !username.equals("");
				boolean hasEmail = email != null && !email.equals("");
				boolean hasPassword = password != null && !password.equals("");
				boolean hasPassword2 = password2 != null && !password2.equals("");
				boolean passwordMatch = password != null && !password.equals("") && password2 != null
						&& !password2.equals("") && password.equals(password2);
				out.print("<div class=\"container\">");
				if (!hasUsername)
					out.println("<div class=\"alert alert-danger\" role=\"alert\">Missing username!</div>");
				if (!hasEmail)
					out.println("<div class=\"alert alert-danger\" role=\"alert\">Missing email!</div>");
				if (!hasPassword)
					out.println("<div class=\"alert alert-danger\" role=\"alert\">Missing password!</div>");
				if (!hasPassword2)
					out.println(
							"<div class=\"alert alert-danger\" role=\"alert\">Missing password confirmation!</div>");
				if (!passwordMatch)
					out.println(
							"<div class=\"alert alert-danger\" role=\"alert\">Your password confirmation is incorrect!</div>");
				out.println("</div>");
				if (hasUsername && hasEmail && hasPassword && hasPassword2 && password.equals(password2)) {

					//temp pid, replace with item clicked on
					String sql = "UPDATE User SET username = '" + username + "', email='" + email + "', password = '"
							+ password + "' " + "WHERE username = '" + currname + "'";
					PreparedStatement pstmt = con.prepareStatement(sql);
					pstmt.execute();
				}
			} catch (SQLException ex) {
				out.println(ex);
			} finally {
				try {
					if (con != null)
						con.close();
				} catch (SQLException ex) {
					out.println(ex);
				}
			}
		%>

		<form method="get" action="home.jsp">
			<button type="submit" class="btn btn-danger delete-button">Delete
				Account</button>
		</form>

	</div>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="../js/bootstrap.min.js"></script>
</body>

</html>
