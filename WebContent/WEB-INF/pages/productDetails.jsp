<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link href="https://fonts.googleapis.com/css?family=Alegreya" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Merriweather|Open+Sans" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>E-Commerce</title>
<style>
.productbox
	{
		-moz-box-shadow: 0 0 40px #ccc;
		-webkit-box-shadow: 0 0 40px #ccc;
		box-shadow: 0 0 40px #ccc;
	}
.productbox:hover
	{
	opacity:0.7;
		-moz-box-shadow: 0 0 40px #ccc;
		-webkit-box-shadow: 0 0 40px #ccc;
		box-shadow: 0 0 40px #ccc;
	}
</style>
</head>  
<body style="background-color: #ffffff;">
<nav class="navbar navbar-expand-lg navbar-light sticky-top" style="background-color:#32127A;">
  <a class="navbar-brand" href="/ecommerce/userIndex"><img alt="Logo" src="images/amazonlogowhite.png" style="" height="40px" width="180px"></a>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
  	<form action="/ecommerce/search" class="form-inline mr-auto">
  		<input required  name="productSearch" list="datalist" type="text" class="form-control mr-sm-2"  style="width:500px" placeholder="Type a product name">
  		<input type="submit" class="btn" value="Search">
  	</form>
    <ul class="navbar-nav">
      <li class="nav-item active">
      	<%
      	if(session.getAttribute("userEmail") == null){
      		%>
      	<a href="/ecommerce/user-login-signup.jsp"><button id="navbarloginsignup" class="btn btn-md" >Login/Sign up</button> </a>
      		<%
      	} else{
      		%>
      		<li class="nav-item dropdown">
        <button class="btn btn-md  dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fa fa-user-circle"></i>
        </button>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="/ecommerce/userOrder.jsp">Orders</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="/ecommerce/userLogout">Logout</a>
        </div>
      </li>
      		<%
      	}
      	%>
      </li>
      &nbsp&nbsp&nbsp&nbsp
      <li class="nav-item active">
       <a href="/ecommerce/userCart.jsp"> <button class="btn btn-md" data-toggle="modal" ><i class="fa fa-shopping-cart"></i></button> </a>
      </li>
  </div>
</nav>
<br><br>
           <%
           ArrayList<ArrayList<String>>list = (ArrayList<ArrayList<String>>)session.getAttribute("productDetails");
       	ListIterator<ArrayList<String>> lt1 = list.listIterator();
       	while(lt1.hasNext())
       	{
       	ListIterator<String>lt = lt1.next().listIterator();
       	while(lt.hasNext())
       	{
       	  int productId =  Integer.parseInt(lt.next());	
           %>
			<div class="container">
			<div class="row"> 
			<div class=col-lg-4>
		    <img src=<%=lt.next()%>  height="250px" width="200px"> 
			</div>
			<div class=col-lg-8>
			<span style="font-weight:bold font-size:28px color:#32127A"" ><%=lt.next()%>  </span><br>
			<span style=""> <%=lt.next()%>  </span><br><br>
			<span>it is the vary beautiful dress about that!<br>
			you can take it by only simply click on add to cart button!<br>
			and further follow the next instruction.
			</span><br><br>
			<span><del style="text-decoration:line-through">$ <%=Integer.parseInt(lt.next())%></del></span> &nbsp&nbsp
			<form action="/ecommerce/addToCart" >
			<input type="hidden" name="productId" value=<%=productId%> >
			<select name="productSize" class="form-control" placeholder="select your size" required> 
						      	<option>Small</option>
						      	<option>Medium</option>  
						      	<option>Large</option> 
		   </select><br>
		   <input name="productCount" class="form-control" placeholder="how many product you wanna have" required>
			<p id='addtocarterror' style='color:red'></p>
			<button type="submit" class="btn btn-md btn-info"><i class="fa fa-shopping-cart"></i>&nbsp&nbspAdd item to cart</button>
			</form>
			<% }} %>
        </div>
		</div>
		</div>
		<br><br>
</body>
</html>
