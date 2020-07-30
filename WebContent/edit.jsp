<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
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

<div style="background-color:#32127A">
&nbsp&nbsp&nbsp
<span style="color:#ffffff;font-size:30px;cursor:pointer" onclick="openNav()">&#9776;</span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<a class="navbar-brand mr-auto" href="/ecommerce/admin-index.jsp"><img alt="Logo" src="images/amazonlogowhite.png" style="" height="40px" width="180px"></a>
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<span style="color: #ffffff"><span style="font-weight:bold;"><%=session.getAttribute("adminName")%>'s</span> shop</span>
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<span style="color: #ffffff">Sellers' id:<span style="font-weight:bold"> <%=session.getAttribute("adminEmail") %></span></span>
</div>
<br>

      <div class="modal-header">
        <h5 class="modal-title" id="addaproductmodal">Tell us about the product</h5>
      </div>
      <%
      Class.forName("com.mysql.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon","root","ashu1234");
      PreparedStatement statement = con.prepareStatement("select * from products where productId = ?");
      statement.setString(1,request.getParameter("productId"));
      ResultSet rs = statement.executeQuery();
      if(rs.next())
      {
      %>
      <div class="modal-body">
        <form action="/ecommerce/editFromProduct" style="max-height:400px" >
            <input type="hidden" name="productId" value="<%= rs.getString(1) %>" > 
        	<input required type="text" class="form-control" placeholder="<%= rs.getString(2) %>" name="productName"><br>
        	<input required class="form-control" placeholder="<%= rs.getString(3) %>" name="productDescription"><br>
        	<div class="form-inline">
	        	<input required type="radio" name="productGender" class="form-control" value="Male">
	        	<label for="productGenderMale">&nbsp&nbspMale</label>&nbsp&nbsp&nbsp&nbsp&nbsp
	        	<input type="radio" name="productGender" class="form-control" value="Female">
	        	<label for="productGenderFemale">&nbsp&nbspFemale</label>&nbsp&nbsp&nbsp&nbsp&nbsp
	        	<input type="radio" name="productGender" class="form-control" value="Both">
	        	<label for="productGenderBoth">&nbsp&nbspBoth</label>
        	</div><br>
        	<select required name="productCategory" class="form-control">
        		<option value="Topwear">Topwear</option>
        		<option value="Bottomwear">Bottomwear</option>
        		<option value="Footwear">Footwear</option>
        		<option value="Accessories">Accessories</option>
        	</select><br>
        	<input required type="number" class="form-control" name="productQuantitySmall" placeholder="<%= rs.getString(6) %>"><br>
        	<input required type="number" class="form-control" name="productQuantityMedium" placeholder="<%= rs.getString(7) %>"><br>
        	<input required type="number" class="form-control" name="productQuantityLarge" placeholder="<%= rs.getString(8) %>"><br>
        	<input required type="number" class="form-control" name="productPrice" placeholder="<%= rs.getString(10) %>"><br>
        	<input required type="number" class="form-control" name="productDiscount" placeholder="<%= rs.getString(11) %>"><br>
        	<input type="hidden" name="productSoldBy" value= <%= session.getAttribute("adminEmail") %> ><br>
       <%
       }
        %>
            <div class="modal-footer">
       		<button  type="submit" >Submit</button>
       	     </form>
            </div>
<br><br>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.slim.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
</body>
</html>
