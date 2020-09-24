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
<body style="background-color: #ffffff;"><nav class="navbar navbar-expand-lg navbar-light sticky-top" style="background-color:#32127A;">
  <a class="navbar-brand" href="/ecommerce/user-index.jsp"><img alt="Logo" src="images/amazonlogowhite.png" style="" height="40px" width="180px"></a>
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
       <a href="/ecommerce/userCart.jsp"> <button class="btn btn-md" data-toggle="modal" ><i class="fa fa-shopping-cart"></i> 
        &nbsp<span style="font-size:15px;font-weight:bold;color:maroon;"> Cart </span></button> </a>
      </li>
      &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    </ul>
  </div>
</nav>

<br><br>
        
<!-------------   Cart Modal ------------------>
<div class="container" style="background-color:#ffffff">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
	      <%
	      if(session.getAttribute("userEmail") == null){
	    	  %>
	    	  	<div class="modal-header">
			   	<h5 class="modal-title" id="cartmodal"><strong> You need to login first! </strong> </h5>
		        </div>	 	  
	    	  <%
	      } else {
	    	  %>
	    	  <%
			  int total = 0;
	    	  %>
	    	    <div class="modal-header">
				    <h5 class="modal-title" id="cartmodal">Your cart</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
		        </div>
		        <div class="modal-body">
		        	<table class="table table-hover">
					    <thead>
					      <tr>
					        <th>Image</th>
					        <th>Product</th>
					        <th>Price</th>
					        <th>Size</th>
					        <th></th>
					      </tr>
					    </thead>
					    <tbody>
		        		<%
		        		ArrayList<ArrayList<String>>list = (ArrayList<ArrayList<String>>)session.getAttribute("userCart");
		        		ListIterator<ArrayList<String>> lt1 = list.listIterator();
		        		while(lt1.hasNext())
		        		{
		        		ListIterator<String>lt = lt1.next().listIterator();
		        		while(lt.hasNext())
		        		{
                          %>
						<tr>
						<td style="width:150px"><img class="" height="70px" src="<%=lt.next()%>" alt="Card image cap"></td>
						<td><%=lt.next()%></td>
						<% int price = Integer.parseInt(lt.next());
						
						total += price ;%>
						<td>$<%=price%></td>
						<td><form action="deleteFromCart" class="btn btn-sm btn-danger">
						      <input type="hidden" name="cartId" value=<%=Integer.parseInt(lt.next())%> /> 
						        <button type="submit">Remove</button>
						         </form>
						</td>
						</tr>										
		        		<%
		        	}
		        		}
		        	%>
		        	</tbody>
		        	</table>
		        </div>
		        <div class="modal-footer">
		        <span style="font-weight:bold;color:red">Total:</span>&nbsp&nbsp&nbsp<span style="font-size:22px; color:#32127A; font-weight:bold">$<%=total %></span>
		        <%
		        if(total != 0){
		        	%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		        		<a href="/ecommerce/checkout.jsp"><button  class="btn btn-info btn-sm">Checkout</button></a>
		        	<%
		        }
		        %>
		        </div>	  
	    	  <%
	      }
	      %>
    </div>
  </div>
</div>
		<br><br>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.slim.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>

</html>
