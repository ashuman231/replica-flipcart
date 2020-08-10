package com.codeplanet.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.codeplanet.model.Admin;
import com.codeplanet.model.User;
import com.mysql.cj.protocol.ResultStreamer;

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
				PreparedStatement statement1 = con.prepareStatement("insert into carts(cartEmail,productId,productSize) values(?,?,?)");
				statement1.setString(1, req.getSession().getAttribute("userEmail").toString());
				statement1.setInt(2, Integer.parseInt(req.getParameter("productId")));
				statement1.setString(3, req.getParameter("productSize"));
				statement1.executeUpdate();
			}
         
      
          public void deleteFromCart(HttpServletRequest req) throws ClassNotFoundException, SQLException
          {
        	  Class.forName("com.mysql.jdbc.Driver");
              Connection con = jdbcTemplate.getDataSource().getConnection();
   				PreparedStatement statement1 = con.prepareStatement("DELETE FROM carts WHERE cartId ="+req.getParameter("cartId"));
   				statement1.executeUpdate();   
			
   				
          }
		public void payment(HttpServletRequest req) throws ClassNotFoundException, SQLException {
			 Class.forName("com.mysql.jdbc.Driver");
             Connection con = jdbcTemplate.getDataSource().getConnection();
             // for insert order into order table of user
             PreparedStatement statemnet1 = con.prepareStatement("SELECT products.productName,products.productImagePath,products.productSoldBy,products.productPrice,products.productDiscount,carts.productSize\r\n" + 
             		"FROM carts\r\n" + 
             		"JOIN products ON carts.productId=products.productId and cartEmail=?;");
             statemnet1.setString(1,(String) req.getSession().getAttribute("userEmail"));
             ResultSet res = statemnet1.executeQuery();
             while(res.next())
             {    	 
            	 PreparedStatement statement = con.prepareStatement("insert into orders(userEmail,productName,productSize,productImagePath,productStatus,productSoldBy,productPrice,productDiscount) values(?,?,?,?,?,?,?,?)");
     			statement.setString(1,(String)req.getSession().getAttribute("userEmail"));
     			statement.setString(2,res.getString("productName"));
     			statement.setString(3,res.getString("productSize"));
     			statement.setString(4,res.getString("productImagePath"));
     			statement.setString(5,"pending");
     			statement.setString(6,res.getString("productSoldBy"));
     			statement.setString(7, res.getString("productPrice"));
     			statement.setString(8, res.getString("productDiscount"));	
     		    statement.executeUpdate();	
             }
             // to delete orders from cart of the user 
             PreparedStatement statement2  = con.prepareStatement("delete from carts where cartEmail=?");
             statement2.setString(1,(String)req.getSession().getAttribute("userEmail"));
             statement2.executeUpdate();
		}
}
