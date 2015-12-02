<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Profile</title>
    <!-- Bootstrap -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/stylesheet.css" rel="stylesheet">
</head>
<body>
	
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
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

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="#">Create A Post <span class="sr-only">(current)</span></a></li>
                <li><a href="#">About Us</a></li>
            </ul>
            <form class="navbar-form navbar-left" role="search">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Search">
                </div>
                <button type="submit" class="btn btn-default">Submit</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <!--if user not login display login-->
                <li><a href="#">Login</a></li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>

<!-- profile picture -->
												
<%@ include file="auth.jsp"%>

<%
    String userName = (String) session.getAttribute("authenticatedUser");
    out.println("<h1>Welcome back, "+userName+"</h1>");
%>
<div class="container">
    <div class="row">
        <div class="col-xs-6 col-md-3">
            <div class="thumbnail">
                <img src="../assets/profile_placeholder.png" alt="Item Image">
            </div>
        </div>
    </div>
	<form name="input" action="uploadPic.jsp" method="POST" enctype="multipart/form-data">
    	<input type='file' name="fileToUpload" id="fileToUpload"/>
		<input type="submit" value="Upload" />
	</form>
	
    <div class="page-header">
        <h1>Items on Sale</h1>
    </div>
    <div class="row">
        <div class="col-xs-6 col-md-3">
            <div class="thumbnail">
                <img src="../assets/placeholder.png" alt="Item Image">
            </div>
        </div>
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Item Description</h3>
                </div>
                <div class="panel-body">
                    Item content...
                </div>
            </div>
        </div>
        <div class="input-group col-md-6">
            <span class="input-group-addon">$</span>
            <input type="text" class="form-control" aria-label="Offer Price">
        </div>
    </div>
    <!--<button type="button" class="btn btn-lg btn-primary">Buy Now</button>-->
    <div class="page-header">
        <h1>Items Bought</h1>
    </div>
    <div class="row">
        <div class="col-xs-6 col-md-3">
            <div class="thumbnail">
                <img src="../assets/placeholder.png" alt="Item Image">
            </div>
        </div>
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Item Description</h3>
                </div>
                <div class="panel-body">
                    Item content...
                </div>
            </div>
        </div>
        <div class="input-group col-md-6">
            <span class="input-group-addon">$</span>
            <input type="text" class="form-control" aria-label="Offer Price">
        </div>
    </div>
</div>



</body>
</html>