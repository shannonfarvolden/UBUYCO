<%@ page language="java" import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Log In</title>
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
	<div class="container">
	
		<div class="page-header">
			<h1 class="text-center">Log In</h1>
			<%
				// Print prior error login message if present
				if (session.getAttribute("loginMessage") != null)
					out.println("<p>" + session.getAttribute("loginMessage").toString() + "</p>");
			%>
		
		</div>
		<div class="panel panel-default col-md-offset-2 col-md-8">
			<div class="panel-body">
				<form onsubmit="validate()">
					<div class="form-group">
						<label for="username">Username</label> <input type="text"
							class="form-control" id="username" name="username" 
							placeholder="Username">
					</div>
					<div class="form-group">
						<label for="password">Password</label> <input type="password"
							class="form-control" id="password" name="password"
							placeholder="Password">
					</div>
					<button type="submit" class="btn btn-default">Submit</button>
				</form>
			</div>
		</div>
		<div class="col-md-offset-2 col-md-8">
			<h3>New User? Create an Account</h3>
			<button type="button" class="btn btn-default"
				onclick="document.location.href='createAccount.jsp';">Create
				Account</button>
		</div>
		
</div>
		<%
			Connection con = null;
			String url = "jdbc:mysql://cosc304.ok.ubc.ca/group3";
			String uid = "group3";
			String pw = "group3";
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();

			String username = request.getParameter("username");
			String password = request.getParameter("password");
			boolean hasUsername = username != null && !username.equals("");
			boolean hasPassword = password != null && !password.equals("");
			
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(url, uid, pw);
				
				if (hasUsername && hasPassword) {
					String sql = "SELECT username FROM User WHERE username = '" + username + "' AND password = '"
							+ password + "';";
			
					PreparedStatement pstmt = con.prepareStatement(sql);
					ResultSet rst = pstmt.executeQuery(sql);
					if (rst.first()) {
						session.setAttribute("authenticatedUser", username);
						session.setAttribute("username", username);
		%>
		<jsp:forward page="home.jsp"></jsp:forward>

		<%
					}
					else{
						out.println("<div class=\"container\"><br><div class=\"col-md-offset-2 col-md-8\"><div class=\"alert alert-danger\" role=\"alert\">Wrong username or password</div></div></div>");
					}
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

	
	<script type="text/javascript"> window.onload = errorMessage; </script>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="../js/bootstrap.min.js"></script>
</body>

</html>