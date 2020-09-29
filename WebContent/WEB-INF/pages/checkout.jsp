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
<title>Checkout - <%=session.getAttribute("userName") %></title>
<style>
* {
  box-sizing: border-box;
}
html, body {
    max-width: 100%;
    overflow-x: hidden;
}

.row {
  display: -ms-flexbox; /* IE10 */
  display: flex;
  -ms-flex-wrap: wrap; /* IE10 */
  flex-wrap: wrap;
  margin: 0 -16px;
}

.col-25 {
  -ms-flex: 25%; /* IE10 */
  flex: 25%;
}

.col-50 {
  -ms-flex: 50%; /* IE10 */
  flex: 50%;
}

.col-75 {
  -ms-flex: 75%; /* IE10 */
  flex: 75%;
}

.col-25,
.col-50,
.col-75 {
  padding: 0 16px;
}

.container {
  background-color: #f2f2f2;
  padding: 5px 20px 15px 20px;
  border: 1px solid lightgrey;
  border-radius: 3px;
}

input[type=text] {
  width: 100%;
  margin-bottom: 20px;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 3px;
}

label {
  margin-bottom: 10px;
  display: block;
}

.icon-container {
  margin-bottom: 20px;
  padding: 7px 0;
  font-size: 24px;
}

a {
  color: #2196F3;
}

hr {
  border: 1px solid lightgrey;
}

span.price {
  float: right;
  color: grey;
}

/* Responsive layout - when the screen is less than 800px wide, make the two columns stack on top of each other instead of next to each other (also change the direction - make the "cart" column go on top) */
@media (max-width: 800px) {
  .row {
    flex-direction: column-reverse;
  }
  .col-25 {
    margin-bottom: 20px;
  }
}
</style>
</style>
</head>
<body>
<div class="text-center" style="background-color:#32127A">
<a style="padding-top:15px; padding-bottom:15px;" class="navbar-brand mr-auto" href="/ecommerce/user-index.jsp"><img alt="Logo" src="images/amazonlogowhite.png" style="" height="40px" width="180px"></a>
</div>
<br><br>

<div class=" container">
 <div class="modal-body">
		        	<table class="table table-hover">
					    <thead>
					      <tr>
					        <th>Image</th>
					        <th>Product</th>
					        <th>Price</th>
					        <th>Size</th>
					        <th>Count</th>
					        <th></th>
					      </tr>
					    </thead>
					    <tbody>
		        		<%
		        		int total =0;
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
						<td><%=lt.next()%></td>  <%-- name --%>
						<% int price = Integer.parseInt(lt.next()); %>
						
						<td>$<%=price%></td>
						<td><%=lt.next()%></td>  <%-- size --%>
						<% int count = Integer.parseInt(lt.next()); %>
						<td><%=count%></td>  <%-- count --%>
					    <%
					    total += price*count; %>
					   <%  lt.next();%>  <%-- extra value cause we have to call it --%>
					 	</tr>										
		        		<%
		        	    }
		        		}
		        	%>
		        	<span style="font-weight:bold;color:red">Total:</span>&nbsp&nbsp&nbsp<span style="font-size:22px; color:#32127A; font-weight:bold">$<%=total %></span>
		        	</tbody>
		        	</table>
		        </div>
</div>
<br><br>

<div class="row">
  <div class="col-75">
    <div class="container">
      <form action="/ecommerce/payment" method="post">
      
        <div class="row">
          <div class="col-50"><br>
            <h3>Billing Address</h3><br>
            <input type="hidden" value="<%=total%>" name="totalPrice" >
            <label for="fname"><i class="fa fa-user"></i> Full Name</label>
            <input type="text" id="fname" name="firstname" placeholder="John M. Doe" required="required">
            <label for="email"><i class="fa fa-envelope"></i> Email</label>
            <input type="text" id="email" name="email" placeholder="john@example.com" required="required">
            <label for="adr"><i class="fa fa-address-card-o"></i> Address</label>
            <input type="text" id="adr" name="address" placeholder="542 W. 15th Street" required="required">
            <label for="city"><i class="fa fa-institution"></i> City</label>
            <input type="text" id="city" name="city" placeholder="New York" required="required">

              <div class="row">
              <div class="col-50">
                <label for="state">State</label>
                <input type="text" id="state" name="state" placeholder="NY" required="required">
              </div>
              <div class="col-50">
                <label for="zip">PinCode</label>
                <input type="text" id="zip" name="zip" placeholder="10001" required="required">
              </div>
            </div>
          </div>

          <div class="col-50"><br>
            <h3>Payment</h3><br>
            <label for="fname">Accepted Cards</label>
            <div class="icon-container">
              <i class="fa fa-cc-visa" style="color:navy;"></i>
              <i class="fa fa-cc-amex" style="color:blue;"></i>
              <i class="fa fa-cc-mastercard" style="color:red;"></i>
              <i class="fa fa-cc-discover" style="color:orange;"></i>
            </div>
            <label for="cname">Name on Card</label>
            <input type="text" id="cname" name="cardname" placeholder="John More Doe">
            <label for="ccnum">Credit card number</label>
            <input type="text" id="ccnum" name="cardnumber" placeholder="1111-2222-3333-4444">
            <label for="expmonth">Exp Month</label>
            <input type="text" id="expmonth" name="expmonth" placeholder="September">
            <div class="row">
              <div class="col-50">
                <label for="expyear">Exp Year</label>
                <input type="text" id="expyear" name="expyear" placeholder="2018">
              </div>
              <div class="col-50">
                <label for="cvv">CVV</label>
                <input type="text" id="cvv" name="cvv" placeholder="352">
              </div>
            </div>
          </div>
          
        </div><br>
        <input style="width:100%; height:50px" class="btn btn-info" type="submit" value="Continue to checkout" class="btn">
      </form>
    </div>
  </div>
  
</div>
<br><br><br>
<br><br><br><br>
</body>
</html>
