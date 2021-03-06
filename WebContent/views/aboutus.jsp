<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>

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
			<h1 class="text-center">About Us</h1>
		</div>

		<div>
			<h2>Who Are We?</h2>
		</div>
		<div>
			<p class="lead">UBuyCO was started by a talented group of
				individuals seeking to provide the University of British Columbia -
				Okanagan with a unique buying and selling experience. This site is
				not your average Craigslist. To join in on the fun of buying and
				selling a variety of high-quality items vital for one's university
				experience, one must first be a member of the site. But don't fret!
				Creating an account is as easy as finding an item to buy. As a
				distinguished UBuyCO account holder, you can now browse through the
				many interesting items on the site, narrowing your search by an
				exciting choice of limiters. Better yet, dig out the textbook from
				that first year introductory Spanish class you failed (sorry mom!)
				and make some of your money back! As an esteemed seller, your happy
				customers are sure to write you glowing reviews on your profile page
				and rate you highly, which in turn will only attract more customers.
				The days of end-of-semester textbook buy-back at the bookstore are
				over! UBC what? U-Buy-CO!</p>
		</div>

		<div></div>
		<div class="media">
			<div class="thumbnail col-md-2">
				<img src="../assets/dana.jpg" alt="picture">
			</div>
			<div class="media-body">
				<h2 class="media-heading">Dana Klamut</h2>
				<p class="lead">Math and Computer Science Major. Writes like a
					lefty, except she's right-handed.</p>
			</div>
		</div>
		<div class="media">
			<div class="thumbnail col-md-2">
				<img src="../assets/shannon.jpg" alt="picture">
			</div>
			<div class="media-body">
				<h2 class="media-heading">Shannon Farvolden</h2>
				<p class="lead">Computer Science Major. She was addicted to the
					Hokey Pokey but she turned herself around.</p>
			</div>
		</div>
		<div class="media">
			<div class="thumbnail col-md-2">
				<img src="../assets/carson.jpg" alt="picture">
			</div>
			<div class="media-body">
				<h2 class="media-heading">Carson McKay</h2>
				<p class="lead">Chemistry Major, Computer Science Minor. A
					caffeine dependent life-form.</p>
			</div>
		</div>
		<div class="media">
			<div class="thumbnail col-md-2">
				<a href="#"> <img class="media-object" src="../assets/jeff.png"
					alt="picture">
				</a>
			</div>
			<div class="media-body">
				<h2 class="media-heading">Jeff Chimney</h2>
				<p class="lead">Computer Science Major. International Lawn
					Bowling Champion (undefeated).</p>
			</div>
		</div>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
</body>

</html>
