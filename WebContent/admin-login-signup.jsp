<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<%
if(session.getAttribute("adminEmail") != null){
	response.sendRedirect("admin-index.jsp");
	return;
}
%>

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>E-commerce admin</title>

        <!-- CSS -->
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="assets/css/form-elements.css">
        <link rel="stylesheet" href="assets/css/style.css">

        <!-- Favicon and touch icons -->
        <link rel="shortcut icon" href="assets/ico/favicon.png">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">

    </head>
 <body>

        <!-- Top content -->
        <div class="top-content">
        
        	<h1 style="color:blue; font-size:50px;">WELCOME ON OUR WEBPAGES(Flipcart Lite)</h1>
        	<h2 style="color:red; font-size:30px;"><strong> Login and Signup page for sellers.</strong></h2>
            <div class="inner-bg">
                <div class="container">
                
                    <div class="row">
                        <div class="col-sm-5">
                        	<span style="color:red; font-size:30px" > ${message} </span>
                        	<div class="form-box">
	                        	<div class="form-top">
	                        		<div class="form-top-left">
	                        			<h3>Login to our site</h3>
	                            		<p>Enter email and password to log on:</p>
	                            		<p id="loginerror" style="color: red;"></p>
	                        		</div>
	                        		<div class="form-top-right">
	                        			<i class="fa fa-key"></i>
	                        		</div>
	                            </div>
	                            <div class="form-bottom">
				                    <form role="form"  action="/ecommerce/adminLogin" method="post" class="login-form">
				                    	<div class="form-group">
				                    		<label class="sr-only" for="form-username">Email</label>
				                        	<input required type="text"  placeholder="Email..." class="form-username form-control" name="adminEmail">
				                        </div>
				                        <div class="form-group">
				                        	<label class="sr-only" for="form-password">Password</label>
				                        	<input required type="password" placeholder="Password..." class="form-password form-control" name="adminPassword">
				                        </div>
				                        <input type="submit" class="btn btn-lg btn-secondary" value="Sign in!">
				                    </form>
			                    </div>
		                    </div>
		                
                        </div>
                        
                        <div class="col-sm-5">
                        	<span style="color:red; font-size:30px" > ${message1} </span>
                        	<div class="form-box">
                        		<div class="form-top">
	                        		<div class="form-top-left">
	                        			<h3>Sign up now</h3>
	                            		<p>Fill in the form below to get instant access:</p>
	                            		<p id="signuperror" style="color:red;"></p>
	                        		</div>
	                        		<div class="form-top-right">
	                        			<i class="fa fa-pencil"></i>
	                        		</div>
	                            </div>
	                            <div class="form-bottom">
				                    <form role="form" action="/ecommerce/adminSignup" method="post" class="registration-form">
				                    	<div class="form-group">
				                    		<label class="sr-only" for="form-first-name">Name</label>
				                        	<input required type="text" name="adminName" placeholder="Name..." class="form-first-name form-control" >
				                        </div>
				                        <div class="form-group">
				                        	<label class="sr-only" for="form-email">Email</label>
				                        	<input required type="email" name="adminEmail" placeholder="Email..." class="form-email form-control">
				                        </div>
				                        <div class="form-group">
				                        	<label class="sr-only" for="form-last-name">Password</label>
				                        	<input required type="password" name="adminPassword" placeholder="Password..." class="form-last-name form-control">
				                        </div>
				                        <input id="signupbutton" type="submit" class="btn btn-lg btn-secondary" value="Sign me up!">
				                    </form>
			                    </div>
                        	</div>
                        	
                        </div>
                    </div>
                    
                </div>
            </div>
            
        </div>

        <!-- Footer -->
        <footer>
        	<div class="container">
        		<div class="row">
        			
        			<div class="col-sm-8 col-sm-offset-2">
        				<div class="footer-border"></div>
        				<p>Copyright 2020 E-Commerce</p>
        			</div>
        			
        		</div>
        	</div>
        </footer>
    </body>

</html>