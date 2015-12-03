<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Browse</title>
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
                <li><a href="aboutUs.html">About Us</a></li>
            </ul>
            <form class="navbar-form navbar-left" role="search" action="browse.jsp">
                <div class="form-group">
                    <input type="text" class="form-control" name="pname" size="50">
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

<!-- add code here -->

<form action="browse.jsp" method="get">
	<b>Filter by Category:</b>
	<input type="radio" name="category" value="none" checked> All
	<input type="radio" name="category" value="Lab Books"> Lab Books
	<input type="radio" name="category" value="Textbooks"> Textbooks
	<input type="radio" name="category" value="Notes"> Notes
	<input type="radio" name="category" value="Clothes/Shoes"> Clothes/Shoes
	<input type="radio" name="category" value="Household Items"> Household Items
	<input type="radio" name="category" value="Electronics"> Electronics
	<input type="radio" name="category" value="Lab/Class Equipment"> Lab/Class Equipment
	<input type="radio" name="category" value="Miscellaneous"> Miscellaneous
	<br>
	<b>Filter by Price:</b>
	<input type="radio" name="price" value="none" checked> No Filter
	<input type="radio" name="price" value="<5"> Under 5$
	<input type="radio" name="price" value="BETWEEN 5 AND 20"> $5-$20
	<input type="radio" name="price" value="BETWEEN 20 AND 100"> $20-$100
	<input type="radio" name="price" value=">100"> Over $100
	<br>
	<input type="submit" value="submit">
</form>
<%
	// Get product name to search for
	String name = request.getParameter("pname");
	String catFilter = request.getParameter("category");
	String priceFilter = request.getParameter("price");
			
	boolean hasParameter = false;
	String sql;
	if (name == null) {
		name = "";
	}
	if (catFilter == null) {
		catFilter = "none";
	}
	if (priceFilter == null) {
		priceFilter = "none";
	}
	
	Connection con = null;
	String url = "jdbc:mysql://cosc304.ok.ubc.ca/group3";
	String uid = "group3";
	String pw = "group3";
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	try 
	{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url, uid, pw);
		
		sql = "SELECT pid, pname, price FROM Item WHERE issold = 0 ";
		
		if (catFilter.equals("none")) {
			if (priceFilter.equals("none")) {}
			else {
				sql = sql + "AND price "+priceFilter+";";
			}
		}
		else {
			sql = sql + "AND pcategory='"+catFilter+"' ";
			if (priceFilter.equals("none")) {}
			else {
				sql = sql + "AND price "+priceFilter;
			} 
		}
		
		if (name.equals("")) {
			out.println("<h2>All Products</h2>");
		}
		else {
			out.println("<h2>Results for "+name+"</h2>");
			hasParameter = true;
			sql = sql + "AND pname LIKE '%"+name+"%'";
		}
		

		PreparedStatement pstmt = con.prepareStatement(sql);
		
		ResultSet rst = pstmt.executeQuery();
		out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
		while (rst.next()) 
		{
			out.print("<tr><td><a href=\"item.jsp?pid=" + rst.getInt("pid")+"\">View Item</a></td>");
			out.println("<td>" + rst.getString(2) + "</td>" + "<td>" + currFormat.format(rst.getDouble(3))
					+ "</td></tr>");
		}
		out.println("</table>");
	} 
	catch (SQLException ex) 
	{
		out.println(ex);
	} 
	finally 
	{
		try 
		{
			if (con != null)
				con.close();
		} 
		catch (SQLException ex) 
		{
			out.println(ex);
		}
	}
%>


</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="../js/bootstrap.min.js"></script>
</body>

</html>
