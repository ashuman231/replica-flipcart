<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%@ page import="java.util.*" %>
<% 
if(session.getAttribute("adminEmail")==null)
	response.sendRedirect("admin-login-signup.jsp");
%>
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
<title><%=session.getAttribute("adminName") %>'s orders</title>
</head>
<body>

<div class="text-center" style="background-color:#32127A">
<a style="padding-top:15px; padding-bottom:15px;" class="navbar-brand mr-auto" href="/ecommerce/admin-index.jsp"><img alt="Logo" src="images/amazonlogowhite.png" style="" height="40px" width="180px"></a>
</div>
<br><br>

<div class="container">
	<h2 style="font-family: 'Merriweather', serif;">Order You Received from Customers :----</h2>
</div>
<br><br>
<%!
public String getDiscountedPrice(int op, int d){
	int dp = op - (op*d)/100;
	return dp+"";
}
%>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon","root","ashu1234");
PreparedStatement statement = con.prepareStatement("select * from orders where productSoldBy=? and productStatus=?");
statement.setString(1, session.getAttribute("adminEmail").toString());
statement.setString(2,"pending");

ResultSet res = statement.executeQuery();
%>
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<Strong class="btn btn-danger btn-sm">Pending Order:-</Strong>
<div class="container">

	<div class="card">
		<div class="card-body">
			<div>
				<table class="table table-hover">
					<thead>
						<tr>
							<th >Product</th>
							<th>Name</th>
							<th>Price</th>
							<th>Size</th>
							<th>status</th>
						</tr>
					</thead>
					<%
                        while(res.next())
                      {
	                %>
					<tbody>
						<tr>
<%
                 String productImagePath = res.getString("productImagePath");
				if(productImagePath == null)
					productImagePath = "images/" + "prdouctplaceholder.jpg";
%>
							<td style="width:150px"><img class="" height="70px" src="<%=productImagePath %>" alt="Card image cap"></td>
							<td style="vertical-align:middle"><%=res.getString("productName") %></td>
							<td style="vertical-align:middle"><%= getDiscountedPrice(res.getInt("productPrice"),res.getInt("productDiscount")) %></td>
							<td style="vertical-align:middle"><%= res.getString("productSize") %></td>
							
							<td style="vertical-align:middle">
							<form action="changeProductStatus">
							<input type="hidden" name="orderId" value= <%= res.getString("orderId") %> >
							<button  class="btn btn-danger btn-sm"><span style="font-size:22px;font-weight:bold;color:white;"><%= res.getString("productStatus") %></span>
							 </button>
							</form>
							</td>
						</tr>
						
						<%
					}
					%>
					</tbody>
				</table>
			</div>
		</div>
	</div><br>
</div>

<%
statement = con.prepareStatement("select * from orders where productSoldBy=?  and productStatus=?");
statement.setString(1, session.getAttribute("adminEmail").toString());
statement.setString(2,"placed");
res = statement.executeQuery();
%>
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<Strong class="btn btn-info btn-sm">Placed Order:-</Strong>
<div class="container">
	<div class="card">
		<div class="card-body">
			<div>
				<table class="table table-hover">
					<thead>
						<tr>
							<th >Product</th>
							<th>Name</th>
							<th>Price</th>
							<th>Size</th>
							<th>status</th>
						</tr>
					</thead>
					<%
                        while(res.next())
                      {
	                %>
					<tbody>
						<tr>
<%
                 String productImagePath = res.getString("productImagePath");
				if(productImagePath == null)
					productImagePath = "images/" + "prdouctplaceholder.jpg";
%>
							<td style="width:150px"><img class="" height="70px" src="<%=productImagePath %>" alt="Card image cap"></td>
							<td style="vertical-align:middle"><%=res.getString("productName") %></td>
							<td style="vertical-align:middle"><%= getDiscountedPrice(res.getInt("productPrice"),res.getInt("productDiscount")) %></td>
							<td style="vertical-align:middle"><%= res.getString("productSize") %></td>
							<td style="vertical-align:middle"><span style="font-size:22px;font-weight:bold;color:blue" ><%= res.getString("productStatus") %></span></td>
						</tr>
						
						<%
					}
                 con.close();
					%>
					</tbody>
				</table>
			</div>
		</div>
	</div><br>
</div>

<br><br><br>
</body>
</html>
