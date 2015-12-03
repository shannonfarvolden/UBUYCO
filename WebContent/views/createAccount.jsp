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
            <a class="navbar-brand" href="home.jsp">UBUYCO</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="createItem.jsp">Create A Post <span class="sr-only">(current)</span></a></li>
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
		boolean hasPass1 = password1 != null && !password1.equals("");
		boolean hasPass2 =  password2 != null && !password2.equals("");
		boolean passwordsMatch = password1 != null && password2 != null && password1.equals(password2);
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url, uid, pw);
			
			/* if (!hasName)
				out.println("<div class=\"alert alert-danger\" role=\"alert\">I can't track you in your home if you don't give me your name.</div>");
			if (!hasUsername)
				out.println("<div class=\"alert alert-danger\" role=\"alert\">Enter a username.</div>");
			if (!hasEmail)
				out.println("<div class=\"alert alert-danger\" role=\"alert\">Enter an email.  We won't spam you...promise.</div>");
			if (!passwordsMatch)
				out.println("<div class=\"alert alert-danger\" role=\"alert\">Your passwords don't match</div>"); */
				
			if (hasName && hasUsername && hasPass1 && hasPass2 && hasEmail) {
				if(passwordsMatch){
					String sql = "INSERT INTO User (username, email, password) VALUES ('"
								+ username + "', '" + email + "', '" + password1 + "' );";
					PreparedStatement pstmt = con.prepareStatement(sql);
					pstmt.execute();
					session.setAttribute( "authenticatedUser", name );
					session.setAttribute( "username", username );
					session.setAttribute( "password", password1 );
					%><jsp:forward page="home.jsp"></jsp:forward><%
				}
				else{
					out.println("<div class=\"container\"><br><div class=\"col-md-offset-2 col-md-8\"><div class=\"alert alert-danger\" role=\"alert\">Passwords do not match</div></div></div>");
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
	</div>
</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="../js/bootstrap.min.js"></script>
</body>

</html>
