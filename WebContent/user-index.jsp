<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
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
          <a class="dropdown-item" href="/ecommerce/userOrder">Orders</a>
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
       <a href="/ecommerce/userCart"> <button class="btn btn-md" data-toggle="modal" ><i class="fa fa-shopping-cart"></i> 
        &nbsp<span style="font-size:15px;font-weight:bold;color:maroon;"> Cart </span></button> </a>
      </li>
      &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    </ul>
  </div>
</nav>

<div class="container" style="background-color:#ffffff">
<br>
	<p style="font-size:26px; color:#2f4f4f;font-family: 'Alegreya', serif;">Premium collection in Footwear</p>
	<a href='/ecommerce/viewAll.jsp?productCategory=Footwear'>  <p  style="text-align:right;" > View all </p>   </a>
	<div class="row">
	<%
	ArrayList<ArrayList<String>>list = (ArrayList<ArrayList<String>>)session.getAttribute("footWear");
	ListIterator<ArrayList<String>> lt1 = list.listIterator();
	while(lt1.hasNext())
	{
	ListIterator<String>lt = lt1.next().listIterator();
	while(lt.hasNext())
	{
		%>
		<div class="col-xl-3">	
<a href='/ecommerce/productDetails?productId=<%=Integer.parseInt(lt.next())%>' >
<div  class="card productbox" onmouseover="this.opacity=0.5" style="margin-bottom: 20px; width: 250px;">
			  <img class="card-img-top" width="150px" height="200px" src="<%=lt.next()%>" alt="Card image cap">
			  <div class="card-body" style="height:90px">
			   <p style="font-style:italic;" class="card-text"><span style="font-weight:bold;color:red">"</span><strong><%=lt.next()%></strong><span style="font-weight:bold;color:red">"</span><br></p>
			    <p style="font-style:italic;" class="card-text"><span style="font-weight:bold;color:red">"</span><%=lt.next()%><span style="font-weight:bold;color:red">"</span><br></p>
			  </div>
			  <div class="card-footer">
			  <del style="text-decoration: line-through">$<%=lt.next()%></del>
			  </div>
</div>
</a>
		</div>
		<%
	}
	}
	%>		
	</div>
<br>
</div>
<div class="container" style="background-color:#ffffff">
<br>
	<p style="font-size:26px; color:#2f4f4f;font-family: 'Alegreya', serif;">Premium collection in Topwear</p>
	<a href='/ecommerce/viewAll.jsp?productCategory=Topwear' style="text-align:right;">  <p  style="text-align:right;" > View all </p> </a>
	<div class="row">
	<%
	list = (ArrayList<ArrayList<String>>)session.getAttribute("topWear");
	 lt1 = list.listIterator();
	while(lt1.hasNext())
	{
	ListIterator<String>lt = lt1.next().listIterator();
	while(lt.hasNext())
	{	
		%>
		<div class="col-xl-3">	
<a href='/ecommerce/productDetails?productId=<%=Integer.parseInt(lt.next())%>'>
<div  class="card productbox" onmouseover="this.opacity=0.5" style="margin-bottom: 20px; width: 250px;">
			  <img class="card-img-top" width="150px" height="200px" src="<%=lt.next()%>" alt="Card image cap">
			  <div class="card-body" style="height:90px">
			   <p style="font-style:italic;" class="card-text"><span style="font-weight:bold;color:red">"</span><strong><%=lt.next()%></strong><span style="font-weight:bold;color:red">"</span><br></p>
			    <p style="font-style:italic;" class="card-text"><span style="font-weight:bold;color:red">"</span><%=lt.next()%><span style="font-weight:bold;color:red">"</span><br></p>
			  </div>
			  <div class="card-footer">
			  <del style="text-decoration: line-through"> $<%=lt.next()%></del>
			  </div>
</div>
</a>
		</div>
		<%
	}
	}
	%>	
	</div>
<br>
</div>
<div class="container" style="background-color:#ffffff">
<br>
	<p style="font-size:26px; color:#2f4f4f;font-family: 'Alegreya', serif;">Premium collection in Bottomwear</p>
	<a href='/ecommerce/viewAll.jsp?productCategory=Bottomwear' style="text-align:right;">  <p  style="text-align:right;" > View all </p> </a>
	<div class="row">
	<%
	list = (ArrayList<ArrayList<String>>)session.getAttribute("bottamWear");
	lt1 = list.listIterator();
	while(lt1.hasNext())
	{
	ListIterator<String>lt = lt1.next().listIterator();
	while(lt.hasNext())
	{	
		%>
		<div class="col-xl-3">	
<a href='/ecommerce/productDetails?productId=<%=Integer.parseInt(lt.next())%>'>
<div  class="card productbox" onmouseover="this.opacity=0.5" style="margin-bottom: 20px; width: 250px;">
			  <img class="card-img-top" width="150px" height="200px" src="<%=lt.next()%>" alt="Card image cap">
			  <div class="card-body" style="height:90px">
			   <p style="font-style:italic;" class="card-text"><span style="font-weight:bold;color:red">"</span><strong><%=lt.next()%></strong><span style="font-weight:bold;color:red">"</span><br></p>
			    <p style="font-style:italic;" class="card-text"><span style="font-weight:bold;color:red">"</span><%=lt.next()%><span style="font-weight:bold;color:red">"</span><br></p>
			  </div>
			  <div class="card-footer">
			  <del style="text-decoration: line-through"> $<%=lt.next()%></del>
			  </div>
</div>
</a>
		</div>
		<%
	}
	}
	%>	
	</div>
<br>
</div>

 <br><br><br>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.slim.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
</html>
