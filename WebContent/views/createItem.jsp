<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Create Item</title>
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
					<li><a href="createItem.jsp">Create A Post <span class="sr-only">(current)</span></a></li>
					<li><a href="aboutUs.html">About Us</a></li>
				</ul>
				<form class="navbar-form navbar-left" role="search" action="browse.jsp">
					<div class="form-group">
						<input type="text" class="form-control">
					</div>
					<button type="submit" class="btn btn-default">Search</button>
				</form>
				<ul class="nav navbar-nav navbar-right">
					<!--if user not login display login-->
					<li><a href="login.jsp">Login</a></li>
					<!--else display username-->
					<!--<li><a href="#">User Name</a></li>-->
				</ul>
			</div>
		</div>
	</nav>
	<!--end nav-->
	<div class="container">
		<div class="page-header">
			<h1>Create an Item</h1>
		</div>
		<div class="row">
			<div class="col-xs-6 col-md-3">
				<div class="thumbnail">
					<img src="../assets/placeholder.png" alt="Item Image">
				</div>
			</div>
		</div>
		<form action="createItem.jsp" method="POST">

			<input type='file' name="fileToUpload" id="fileToUpload" /> <br>
			<div class="col-md-8">
				<div class="form-group">
					<label for="itemName">Item</label> <input type="text"
						class="form-control" name="itemName" id="itemName"
						placeholder="Item">
				</div>
				<div class="form-group">
					<label for="price">Price</label> <input type="number"
						class="form-control" name="price" id="price" placeholder="Price">
				</div>
				<div class="form-group">
					<label for="description">Description</label> <input type="text"
						class="form-control" name="description" id="description"
						placeholder="Description">
				</div>
				<div class="form-group">
					<label for="condition">Item Condition</label> <input type="text"
						class="form-control" name="condition" id="condition"
						placeholder="Item Condition">
				</div>
				<div class="form-group">
					<label for="category">Category</label> <select class="form-control"
						name="category" id="category">
						<option value="Textbook">Textbook</option>
						<option value="Lab Book">Lab Book</option>
						<option value="Lab/Class Equipment">Lab/Class Equipment</option>
						<option value="Notes">Notes</option>
						<option value="Clothing">Clothing</option>
						<option value="Electronics">Electronics</option>
						<option value="Household Items">Household Item</option>
						<option value="Miscellaneous">Miscellaneous</option>
					</select>
				</div>
			</div>
			<div class="col-md-8">
				<button type="submit" class="btn btn-default">Submit</button>
			</div>
		</form>
	</div>
	<br>
	<div class="container">
		<%
			Connection con = null;
			String url = "jdbc:mysql://cosc304.ok.ubc.ca/group3";
			String uid = "group3";
			String pw = "group3";
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();

			String itemName = request.getParameter("itemName");
			String price = request.getParameter("price");
			String desc = request.getParameter("description");
			String condition = request.getParameter("condition");
			String category = request.getParameter("category");

			boolean hasItem = itemName != null && !itemName.equals("");
			boolean hasPrice = price != null && !price.equals("");
			boolean hasDesc = desc != null && !desc.equals("");
			boolean hasCon = condition != null && !condition.equals("");

			if (!hasItem)
				out.println("<div class=\"alert alert-danger\" role=\"alert\">Missing item name</div>");
			if (!hasPrice)
				out.println("<div class=\"alert alert-danger\" role=\"alert\">Missing price</div>");
			if (!hasDesc)
				out.println("<div class=\"alert alert-danger\" role=\"alert\">Missing Description</div>");
			if (!hasCon)
				out.println("<div class=\"alert alert-danger\" role=\"alert\">Missing Item Condition</div>");

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(url, uid, pw);
				//temp change userselling to person logged in
				if (hasItem && hasPrice && hasDesc && hasCon) {
					String sql = "INSERT INTO Item (pname, price, description, pcondition, issold, userselling, pcategory) VALUES ('"
							+ itemName + "', '" + price + "', '" + desc + "', '" + condition + "', false, 3, '"
							+ category + "' );";
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
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="../js/bootstrap.min.js"></script>
</body>

</html>
