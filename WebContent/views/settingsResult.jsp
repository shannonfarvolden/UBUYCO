<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>About Us</title>
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
					String description = request.getParameter("description");
					String password = request.getParameter("password");
					String password2 = request.getParameter("password2");
					String currname = (String) session.getAttribute("username");
					String showE = request.getParameter("showEmail");
					boolean showEmail = Boolean.parseBoolean(showE);
					
					boolean hasUsername = username != null && !username.equals("");
					boolean hasEmail = email != null && !email.equals("");
					boolean hasDesc = email !=null && !description.equals("");
					boolean hasPassword = password != null && !password.equals("");
					boolean hasPassword2 = password2 != null && !password2.equals("");
					boolean passwordMatch = password != null && !password.equals("") && password2 != null
							&& !password2.equals("") && password.equals(password2);
					out.print(	"<div class=\"container\">");
					if (!hasUsername)
						out.println("<div class=\"alert alert-danger\" role=\"alert\">Missing username!</div>");
					if (!hasEmail)
						out.println("<div class=\"alert alert-danger\" role=\"alert\">Missing email!</div>");
					if (!hasDesc)
						out.println("<div class=\"alert alert-danger\" role=\"alert\">Missing description!</div>");
					if (!hasPassword)
						out.println("<div class=\"alert alert-danger\" role=\"alert\">Missing password!</div>");
					if (!hasPassword2)
						out.println(
								"<div class=\"alert alert-danger\" role=\"alert\">Missing password confirmation!</div>");
					if (!passwordMatch)
						out.println(
								"<div class=\"alert alert-danger\" role=\"alert\">Your password confirmation is incorrect!</div>");
					if(!hasUsername || !hasEmail ||!hasPassword || !hasDesc ||!hasPassword2 || !password.equals(password2))
						out.println("<a class=\"btn btn-default\" href=\"settings.jsp\">Back to Settings</a>");
					
					if (hasUsername && hasEmail && hasDesc &&hasPassword && hasPassword2 && password.equals(password2)) {

						String sql = "UPDATE User SET username = '" + username + "', password='"+password+"', email='" + email + "', description = '"+description+"', showEmail="+showEmail+" WHERE username = '" + currname + "'";
						PreparedStatement pstmt = con.prepareStatement(sql);
						pstmt.execute();
						out.println("<div class=\"alert alert-success\" role=\"alert\">Successfully Edited Your Profile. Please log out and log back in with your new username </div>");
						out.println("<a class=\"btn btn-default\" href=\"logout.jsp\">To Logout</a>");
					}
					out.print("</div>");
				
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

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
</body>

</html>