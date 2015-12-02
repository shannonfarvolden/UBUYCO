<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create Account</title>
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
    <div class="page-header">
        <h1 class="text-center">Create an Account</h1>
    </div>
    <div class="panel panel-default col-md-offset-2 col-md-8">
        <div class="panel-body">
            <form action="createAccount.jsp" method="POST">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Full Name">
                </div>
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Username">
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Email">
                </div>
                <div class="form-group">
                    <label for="password1">Password</label>
                    <input type="password" class="form-control" id="password1" name="password1" placeholder="Password">
                </div>
                <div class="form-group">
                    <label for="password2">Confirm Password</label>
                    <input type="password" class="form-control" id="password2" name="password2" placeholder="Confirm Password">
                </div>
                <button type="submit" class="btn btn-default">Submit</button>
            </form>
        </div>
    </div>
	
	<div class="container">
		<%
		Connection con = null;
		String url = "jdbc:mysql://cosc304.ok.ubc.ca/group3";
		String uid = "group3";
		String pw = "group3";
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		
		String name = request.getParameter("name");
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");
		boolean hasName = name != null && !name.equals("");
		boolean hasUsername = username != null && !username.equals("");
		boolean hasEmail = email != null && !email.equals("");
		boolean passwordsMatch = password1 != null && password2 != null && password1.equals(password2);
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url, uid, pw);
			//temp change userselling to person logged in
			if (!hasName)
				out.println("<div class=\"alert alert-danger\" role=\"alert\">I can't track you in your home if you don't give me your name.</div>");
			if (!hasUsername)
				out.println("<div class=\"alert alert-danger\" role=\"alert\">Enter a username.</div>");
			if (!hasEmail)
				out.println("<div class=\"alert alert-danger\" role=\"alert\">Enter an email.  We won't spam you...promise.</div>");
			if (!passwordsMatch)
				out.println("<div class=\"alert alert-danger\" role=\"alert\">Your passwords don't match</div>");
			if (hasName && hasUsername && passwordsMatch && hasEmail) {
				String sql = "INSERT INTO User (username, email, password) VALUES ('"
							+ username + "', '" + email + "', '" + password1 + "' );";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.execute();
				session.setAttribute( "authenticatedUser", name );
				session.setAttribute( "username", username );
				session.setAttribute( "password", password1 );
				%><jsp:forward page="profile.jsp"></jsp:forward><%
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
	</div>
</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="../js/bootstrap.min.js"></script>
</body>

</html>
