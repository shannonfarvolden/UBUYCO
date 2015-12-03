<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Home Page</title>
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
			<h1 class="text-center">Welcome to UBuyCO</h1>
		</div>


		<div class="panel panel-default">
			<div class="panel-body">
				<div class="row">
					<div class="col-sm-6 col-md-3">
						<div class="thumbnail">
							<img src="../assets/textbooks.jpg">
							<h3>Text Books</h3>
							<a href="browse.jsp?category=Textbooks" class="btn btn-primary"
								role="button">Browse</a>
						</div>
					</div>
					<div class="col-sm-6 col-md-3">
						<div class="thumbnail">
							<img src="../assets/labBooks.jpg">
							<h3>Lab Books</h3>
							<a href="browse.jsp?category=Lab+Books" class="btn btn-primary"
								role="button">Browse</a>
						</div>
					</div>

					<div class="col-sm-6 col-md-3">
						<div class="thumbnail">
							<img src="../assets/notes.jpg">
							<h3>Notes</h3>
							<a href="browse.jsp?category=Notes" class="btn btn-primary"
								role="button">Browse</a>
						</div>
					</div>
					<div class="col-sm-6 col-md-3">
						<div class="thumbnail">
							<img src="../assets/labEquipt.jpg">
							<h3>Lab/Class Equipment</h3>
							<a href="browse.jsp?category=Lab%2FClass+Equipment"
								class="btn btn-primary" role="button">Browse</a>
						</div>
					</div>
				</div>
				<div class="row">

					<div class="col-sm-6 col-md-3">
						<div class="thumbnail">
							<img src="../assets/clothing.jpg">
							<h3>Clothes/Shoes</h3>
							<a href="browse.jsp?category=Clothes%2FShoes"
								class="btn btn-primary" role="button">Browse</a>
						</div>
					</div>

					<div class="col-sm-6 col-md-3">
						<div class="thumbnail">
							<img src="../assets/electronics.jpg">
							<div class="caption">
								<h3>Electronics</h3>
								<a href="browse.jsp?category=Electronics"
									class="btn btn-primary" role="button">Browse</a>
							</div>
						</div>
					</div>

					<div class="col-sm-6 col-md-3">
						<div class="thumbnail">
							<img src="../assets/householdItem.jpg">
							<h3>Household Items</h3>
							<a href="browse.jsp?category=Household+Items"
								class="btn btn-primary" role="button">Browse</a>
						</div>
					</div>
					<div class="col-sm-6 col-md-3">
						<div class="thumbnail">
							<img src="../assets/misc.jpg">
							<h3>Miscellaneous</h3>
							<a href="browse.jsp?category=Miscellaneous"
								class="btn btn-primary" role="button">Browse</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
</body>
</head>