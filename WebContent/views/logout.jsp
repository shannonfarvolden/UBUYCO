<%
	HttpSession isSession = request.getSession(false);
	    if (isSession != null) 
	    {
	         isSession.invalidate();

	    }
%>
<jsp:forward page="login.jsp"></jsp:forward>
