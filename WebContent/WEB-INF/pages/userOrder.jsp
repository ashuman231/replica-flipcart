<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%
if(session.getAttribute("userEmail")==null)
	response.sendRedirect("user-login-signup.jsp");
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
<title><%=session.getAttribute("userName") %>'s orders</title>
</head>
<body>

<div class="text-center" style="background-color:#32127A">
<a style="padding-top:15px; padding-bottom:15px;" class="navbar-brand mr-auto" href="/ecommerce/userIndex"><img alt="Logo" src="images/amazonlogowhite.png" style="" height="40px" width="180px"></a>
</div>
<br><br>

<div class="container">
	<h2 style="font-family: 'Merriweather', serif;">Your orders</h2>
</div>
<br><br>

&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<Strong class="btn btn-danger btn-sm">Order:-</Strong>
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
							<th>Count</th>
							
						</tr>
					</thead>
					<%
					ArrayList<ArrayList<String>>list = (ArrayList<ArrayList<String>>)session.getAttribute("userOrder");
					ListIterator<ArrayList<String>> lt1 = list.listIterator();
					while(lt1.hasNext())
					{
					ListIterator<String>lt = lt1.next().listIterator();
					while(lt.hasNext())
					{
	                %>
					<tbody>
						<tr>
							<td style="width:150px"><img class="" height="70px" src="<%=lt.next()%>" alt="Card image cap"></td>
							<td style="vertical-align:middle"><%=lt.next()%></td>
							<td style="vertical-align:middle"><%=lt.next()%></td>
							<td style="vertical-align:middle"><%=lt.next()%></td>
							<td style="vertical-align:middle"><span style="font-size:22px;font-weight:bold;color:blue"><%=lt.next()%></span> </td>
							<td style="vertical-align:middle"><%=lt.next()%></td>
						</tr>
						
						<%
					}
					}
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
