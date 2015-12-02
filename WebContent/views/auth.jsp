<%
	boolean authenticated = session.getAttribute("authenticatedUser") == null ? false : true;

	if (!authenticated)
	{
        	String loginMessage = "You aren't logged in.  What were you thinking?";
        	session.setAttribute("loginMessage",loginMessage);
        	response.sendRedirect("login.jsp");
 		//RequestDispatcher disp = request.getRequestDispatcher("/login.jsp");
		//disp.forward(request,response);
	}
%>
