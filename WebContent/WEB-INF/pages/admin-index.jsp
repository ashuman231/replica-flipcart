<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<%
if(session.getAttribute("adminEmail") == null){
	response.sendRedirect("admin-login-signup.jsp");
	return;
}
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=session.getAttribute("adminName") %>'s Shop</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
    font-family: "Lato", sans-serif;
}

.productdisplayshadow
{
		-moz-box-shadow: 0 0 40px #ccc;
		-webkit-box-shadow: 0 0 40px #ccc;
		box-shadow: 0 0 40px #ccc;
	}

.sidenav {
    height: 100%;
    width: 0;
    position: fixed;
    z-index: 1;
    top: 0;
    left: 0;
    background-color: #111;
    overflow-x: hidden;
    transition: 0.5s;
    padding-top: 60px;
}

.sidenav a {
    padding: 8px 8px 8px 32px;
    text-decoration: none;
    font-size: 25px;
    color: #818181;
    display: block;
    transition: 0.3s;
}

.sidenav a:hover {
    color: #f1f1f1;
}

.sidenav .closebtn {
    position: absolute;
    top: 0;
    right: 25px;
    font-size: 36px;
    margin-left: 50px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
</style>
</head>
<body style="background-color: #F1F3FA;">
<nav class="navbar navbar-expand-lg navbar-light sticky-top" style="background-color:#32127A;">
  <a class="navbar-brand" href="/ecommerce/admin-index.jsp"><img alt="Logo" src="images/amazonlogowhite.png" style="" height="40px" width="180px"></a>
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
  &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp
  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
  &nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
 <span style="color: #ffffff; font-weight:bold;">Shop Name:- &nbsp&nbsp <%=session.getAttribute("adminName")%></span>
   &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
     &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
      &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
       &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
         
    <ul class="navbar-nav">
    
      <li class="nav-item active">
      	
      		<li class="nav-item dropdown">
        <button class="btn btn-md  dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fa fa-user-circle"></i>
        </button>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="/ecommerce/adminLogout">Logout</a>
        </div>
      </li>
        
      </li>
      &nbsp&nbsp&nbsp&nbsp
      <li class="nav-item active">
       <a href="/ecommerce/adminOrder"> <button class="btn btn-md" data-toggle="modal" ><i class="fa fa-shopping-cart"></i> 
        &nbsp<span style="font-size:15px;font-weight:bold;color:maroon;">Orders </span></button> </a>
      </li>
      &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    </ul>
  </div>
</nav>

<br>

&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <span style="color:red; font-size:30px;"> Products that you wanna sell: </span><br><br>
<div class="container" style="background-color: #ffffff">
	<br>
	<div class="row">
		<%
		ArrayList<ArrayList<String>>list = (ArrayList<ArrayList<String>>)session.getAttribute("adminIndex");
		ListIterator<ArrayList<String>> lt1 = list.listIterator();
		while(lt1.hasNext())
		{
		ListIterator<String>lt = lt1.next().listIterator();
		while(lt.hasNext())
	    {
			%>
			<div class="col-xl-3">
				<div class="card productdisplayshadow" style="margin-bottom: 20px;height: 480px; width: 100%;">
                   <div class="card-body">
		            <img class="card-img-top" height="120px" src="<%=lt.next()%>" alt="Card image cap">
				    <h5 class="card-title"><%=lt.next()%></h5>
				    <p class="card-text">" <%=lt.next()%>"<br>
				    <del style="text-decoration: line-through"> $<%=lt.next()%></del>
				  </div>
				  <% int productId = Integer.parseInt(lt.next());
				  %>
				  <div class="card-footer">
				  	            <form action="/ecommerce/edit" class="btn btn-info btn-sm">
						      <input type="hidden" name="productId" value=<%=productId%> />
				   <button class="btn btn-info btn-sm" type="submit">Edit</button>
						         </form>
				               <form action="/ecommerce/deleteFromProduct" class="btn btn-danger btn-sm">
						      <input type="hidden" name="productId" value=<%=productId%> /> 
				   <button class="btn btn-danger btn-sm" type="submit">Delete</button>
						         </form>
				  </div>          
				</div>
			</div>
			<%
		}
		}
		%>
		
		<!-- -- for adding a new product! -->
		<a   href="/ecommerce/addProduct.jsp"  >
		<div class="col-xl-3 text-center">
			<div class="card productdisplayshadow" style="height:450px ;width: 100%;">
			  <img class="card-img-top" width="150px" height="100%" src="images/addaproduct.png" alt="Card image cap">
			  <div class="card-body">
			  	<button class="btn btn-info">Add a Product</button>
			  </div>
			 </div>
		</div>
		</a>
		
		
	</div>
	<br>
</div>


<br><br>

</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.slim.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
</html>
