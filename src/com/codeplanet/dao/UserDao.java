package com.codeplanet.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.codeplanet.model.User;

@Repository
public class UserDao {
@Autowired
JdbcTemplate jdbcTemplate;
 public boolean userSignup(User user) throws SQLException {
	    System.out.println("dao start");
		Connection con = jdbcTemplate.getDataSource().getConnection();
    /*	PreparedStatement pst = con.prepareStatement("insert into sdetails values(?,?,?,?)");
    	pst.setString(1,user.getUserName());
    	pst.setString(2,user.getMobile());
    	pst.setString(3,user.getEmailId());
    	pst.setString(4,user.getPassword());
    	pst.executeUpdate();*/
		
		// For checking purpose that email already exists or not  !!
		String email = user.getUserEmail();
		email = email.toLowerCase();
		PreparedStatement pst1 = con.prepareStatement("select * from amazon.users");
		ResultSet res = pst1.executeQuery();
		while(res.next())
		{
			if(email.equals(res.getString("email"))==true)
			return false;
		}
		pst1.close();
		res.close();
		
		CallableStatement pst = con.prepareCall("call amazon.users(?,?,?,?)");
		pst.setString(1,"insert");
		pst.setString(2,user.getUserEmail().toLowerCase());
		pst.setString(3,user.getUserPassword());
		pst.setString(4,user.getUserName());
		pst.executeUpdate();
		pst.close();
    	System.out.println("dao end");
    	return true;
	}
public boolean userLogin(User user, HttpSession session) throws SQLException {
	String email = user.getUserEmail();
	email = email.toLowerCase();
	String password = user.getUserPassword();
	boolean temp=false;
	 try {
	Connection con = jdbcTemplate.getDataSource().getConnection();
	PreparedStatement pst = con.prepareStatement("select * from amazon.users");
	ResultSet res = pst.executeQuery();
	while(res.next())
	{   
		if(password.equals(res.getString("password"))==true&&email.equals(res.getString("email"))==true)
		{   temp = true;
		    session.setAttribute("userEmail",res.getString("email"));
		    session.setAttribute("userName",res.getString("name"));
			break;
		}
	}
	   }
	 catch(Exception e)
	 {
		 e.printStackTrace();
	 }
	return temp;
}
          public void addToCart(HttpServletRequest req) throws ClassNotFoundException, SQLException {

           Class.forName("com.mysql.jdbc.Driver");
           Connection con = jdbcTemplate.getDataSource().getConnection();
				PreparedStatement statement1 = con.prepareStatement("insert into carts(cartEmail,productId,productSize,productCount) values(?,?,?,?)");
				statement1.setString(1, req.getSession().getAttribute("userEmail").toString());
				statement1.setInt(2, Integer.parseInt(req.getParameter("productId")));
				statement1.setString(3, req.getParameter("productSize"));
				statement1.setInt(4,Integer.parseInt(req.getParameter("productCount")));
				statement1.executeUpdate();
		       userCart(req);
          }
      
          public void deleteFromCart(HttpServletRequest req) throws ClassNotFoundException, SQLException
          {
        	  Class.forName("com.mysql.jdbc.Driver");
              Connection con = jdbcTemplate.getDataSource().getConnection();
   				PreparedStatement statement1 = con.prepareStatement("DELETE FROM carts WHERE cartId=?");
   				statement1.setInt(1,Integer.parseInt(req.getParameter("cartId")));
   				statement1.execute();
			    userCart(req);
          }
		public void payment(HttpServletRequest req) throws ClassNotFoundException, SQLException {
			 Class.forName("com.mysql.jdbc.Driver");
             Connection con = jdbcTemplate.getDataSource().getConnection();
             // for insert order into order table of user
             PreparedStatement statemnet1 = con.prepareStatement("SELECT products.productName,products.productImagePath,products.productSoldBy,products.productPrice,carts.productCount,carts.productSize\r\n" + 
             		"FROM carts\r\n" + 
             		"JOIN products on carts.productId=products.productId where cartEmail=?");
             statemnet1.setString(1,(String) req.getSession().getAttribute("userEmail"));
             ResultSet res = statemnet1.executeQuery();
             while(res.next())
             {    	 
            	 PreparedStatement statement = con.prepareStatement("insert into orders(userEmail,productName,productSize,productImagePath,productStatus,productSoldBy,productPrice,productCount) values(?,?,?,?,?,?,?,?)");
     			statement.setString(1,(String)req.getSession().getAttribute("userEmail"));
     			statement.setString(2,res.getString("productName"));
     			statement.setString(3,res.getString("productSize"));
     			statement.setString(4,res.getString("productImagePath"));
     			statement.setString(5,"pending");
     			statement.setString(6,res.getString("productSoldBy"));
     			statement.setString(7, res.getString("productPrice"));
     			statement.setString(8, res.getString("productCount"));	
     		    statement.executeUpdate();	
             }
             userOrder(req);
             // to delete orders from cart of the user 
             PreparedStatement statement2  = con.prepareStatement("delete from carts where cartEmail=?");
             statement2.setString(1,(String)req.getSession().getAttribute("userEmail"));
             statement2.executeUpdate();
             userCart(req);
		}
		public void userIndex(HttpServletRequest req, HttpServletResponse res) throws SQLException, ClassNotFoundException {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon","root","ashu1234");
			PreparedStatement statement = con.prepareStatement("select * from products where productCategory='Footwear' order by productId desc limit 4");
			ResultSet res1 = statement.executeQuery();
			ArrayList<ArrayList<String>>footWear =  attributeForUserIndex(res1);
			req.getSession().setAttribute("footWear", footWear);
			
			
			statement = con.prepareStatement("select * from products where productCategory='Topwear' order by productId desc limit 4");
			res1 = statement.executeQuery();
			ArrayList<ArrayList<String>>topWear =  attributeForUserIndex(res1);
			req.getSession().setAttribute("topWear", topWear);
			
			
			statement = con.prepareStatement("select * from products where productCategory='Bottomwear' order by productId desc limit 4");
			res1 = statement.executeQuery();
			ArrayList<ArrayList<String>>bottamWear =  attributeForUserIndex(res1);
			req.getSession().setAttribute("bottomWear", bottamWear);
			
		}
		private ArrayList<ArrayList<String>> attributeForUserIndex(ResultSet res) throws SQLException
		{
			ArrayList<ArrayList<String>>list = new ArrayList<ArrayList<String>>();
			
			while(res.next())
			{
				ArrayList<String>temp = new ArrayList<String>();
				temp.add(Integer.toString(res.getInt("productId"))); // productId
				temp.add(res.getString("productImagePath")); // Image
				temp.add(res.getString("productName")); // name
				temp.add(res.getString("productDescription")); // desc
				temp.add(Integer.toString(res.getInt("productPrice")));  // price
				list.add(temp);
			}
	     return list;
		}
		public void userCart(HttpServletRequest req) throws ClassNotFoundException, SQLException {
			Class.forName("com.mysql.jdbc.Driver");
			 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon","root","ashu1234");
			  PreparedStatement statement = con.prepareStatement("select * from carts Inner join products on products.productId = carts.productId where cartEmail=?");
			  statement.setString(1,(String) req.getSession().getAttribute("userEmail"));
			  ResultSet res1 = statement.executeQuery();
			  ArrayList<ArrayList<String>>userCart =  attributeForUserCart(res1);
				req.getSession().setAttribute("userCart",userCart);
		}
		private ArrayList<ArrayList<String>> attributeForUserCart(ResultSet res) throws SQLException
		{
			ArrayList<ArrayList<String>>list = new ArrayList<ArrayList<String>>();
			
			while(res.next())
			{
				ArrayList<String>temp = new ArrayList<String>();
				
				temp.add(res.getString("productImagePath")); // Image
				temp.add(res.getString("productName")); // name
				temp.add(Integer.toString(res.getInt("productPrice")));  // price
				temp.add(res.getString("productSize"));  // Size
				temp.add(Integer.toString(res.getInt("productCount"))); // count
				temp.add(Integer.toString(res.getInt("carts.cartId")));
				list.add(temp);
			}
	     return list;
		}
		public void productDetails(HttpServletRequest req) throws ClassNotFoundException, SQLException {
			    Class.forName("com.mysql.jdbc.Driver");
	            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon","root","ashu1234");
				PreparedStatement statement = con.prepareStatement("select * from products where productId=?");
				statement.setString(1,req.getParameter("productId"));
				ResultSet res1 = statement.executeQuery();
				ArrayList<ArrayList<String>>productDetails =  attributeForUserIndex(res1);
				req.getSession().setAttribute("productDetails",productDetails);
		}
		public void search(HttpServletRequest req) throws SQLException, ClassNotFoundException {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon","root","ashu1234");
			PreparedStatement statement = con.prepareStatement("select * from products where productName LIKE ?");
			String p = "%" + req.getParameter("productSearch") + "%" ;
			statement.setString(1,p);
			ResultSet res1 = statement.executeQuery();
			ArrayList<ArrayList<String>>productSearch =  attributeForUserIndex(res1);
			req.getSession().setAttribute("productSearch",productSearch);
		}
		public void userOrder(HttpServletRequest req) throws SQLException, ClassNotFoundException {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon","root","ashu1234");
			PreparedStatement statement = con.prepareStatement("select * from orders where userEmail=?");
			statement.setString(1, req.getSession().getAttribute("userEmail").toString());
			ResultSet res1 = statement.executeQuery();	
			ArrayList<ArrayList<String>>userOrder =  attributeForUserOrders(res1);
			req.getSession().setAttribute("userOrder",userOrder);
		}
		private ArrayList<ArrayList<String>> attributeForUserOrders(ResultSet res) throws SQLException
		{
			ArrayList<ArrayList<String>>list = new ArrayList<ArrayList<String>>();
			
			while(res.next())
			{
				ArrayList<String>temp = new ArrayList<String>();
				
				temp.add(res.getString("productImagePath")); // Image
				temp.add(res.getString("productName")); // name
				temp.add(Integer.toString(res.getInt("productPrice")));  // price
				temp.add(res.getString("productSize"));  // Size
				temp.add(res.getString("productStatus")); // status
				temp.add(Integer.toString(res.getInt("productCount"))); // count
				list.add(temp);
			}
	     return list;
		}
}