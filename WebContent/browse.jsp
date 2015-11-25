<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Browse Items</title>
</head>
<body>

<h1>Browse Items</h1>

<form action="browse.jsp" method="get">
	<input type="radio" name="faculty" value="sci" checked> Science
	<input type="radio" name="faculty" value="arts"> Arts
	<input type="radio" name="faculty" value="engi"> Engineering
	<input type="radio" name="faculty" value="nrsg"> Nursing
	<input type="radio" name="faculty" value="mgmt"> Management
	<input type="radio" name="faculty" value="educ"> Education
	<input type="radio" name="faculty" value="fina"> Fine Arts
	<input type="radio" name="price" value="<5" checked> Under 5$
	<input type="radio" name="price" value="BETWEEN 5 AND 20"> $5-$20
	<input type="radio" name="price" value="BETWEEN 20 AND 100"> $20-$100
	<input type="radio" name="price" value=">100"> Over $100
	<input type="submit" value="submit">
</form>


<%
Connection con = null;
String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_cmckay";
String uid = "cmckay";
String pw = "33932120";

String filter1 = "none";
String filter2 = "none";
filter1 = request.getParameter("faculty");
filter2 = request.getParameter("price");

try {	
	con = DriverManager.getConnection(url, uid, pw);
	
	String SQL = "SELECT * "+
			"FROM Item ";
	
	out.print(SQL);
	
	PreparedStatement pstmt;
	pstmt = con.prepareStatement(SQL);
	ResultSet rst = pstmt.executeQuery();
	
	out.println("<table><tr><th>Name</th><th>Image</th><th>Price</th></tr>");
	
	while (rst.next()) {	
		out.println("<tr><td>Words"+rst.getString("pname")+"</td><td>"+"</td><td>"+"</td><td>"+"</td></tr>");
		
	}
	out.println("</table>");
}
catch (SQLException ex) { 	
	out.println(ex); 
}
finally {
	if (con != null) {
		try {
			con.close();
		}
        catch (SQLException ex) {
        	System.err.println("SQLException: " + ex);
        }
	}
}
%>

</body>
</html>
