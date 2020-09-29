package com.codeplanet.dao;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
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
import org.springframework.web.multipart.MultipartFile;

import com.codeplanet.model.Admin;
import com.codeplanet.model.ProductItem;

@Repository
public class AdminDao {
@Autowired 
JdbcTemplate jdbcTemplate;
	public boolean adminSignup(Admin admin) throws SQLException {
		System.out.println("dao start");
		Connection con = jdbcTemplate.getDataSource().getConnection();
    /*	PreparedStatement pst = con.prepareStatement("insert into sdetails values(?,?,?,?)");
    	pst.setString(1,user.getUserName());
    	pst.setString(2,user.getMobile());
    	pst.setString(3,user.getEmailId());
    	pst.setString(4,user.getPassword());
    	pst.executeUpdate();*/
		
	//// FOR checking purpose mainly Email already exists or not !!
		String email = admin.getAdminEmail();
		email = email.toLowerCase();
		PreparedStatement pst1 = con.prepareStatement("select * from amazon.sellers");
		ResultSet res = pst1.executeQuery();
		while(res.next())
		{
			if(email.equals(res.getString("email"))==true)
			return false;
		}
		pst1.close();
		res.close();
		

		CallableStatement pst = con.prepareCall("call amazon.sellers(?,?,?,?)");
		System.out.println("dao class");
		pst.setString(1,"insert");
		pst.setString(2,admin.getAdminEmail().toLowerCase());
		pst.setString(3,admin.getAdminPassword());
		pst.setString(4,admin.getAdminName());
		pst.executeUpdate();
		con.close();
    	System.out.println("dao end");		
    	return true;
	}

	public boolean adminLogin(Admin admin, HttpSession session) throws SQLException {
		String email = admin.getAdminEmail();
		email = email.toLowerCase();
		String password = admin.getAdminPassword();
		boolean temp=false;
		Connection con= null;
		 try {
		 con = jdbcTemplate.getDataSource().getConnection();
		PreparedStatement pst = con.prepareStatement("select * from amazon.sellers");
		ResultSet res = pst.executeQuery();
		while(res.next())
		{   
			if(password.equals(res.getString("password"))==true&&email.equals(res.getString("email"))==true)
			{   temp = true;
			    session.setAttribute("adminEmail",res.getString("email"));
			    session.setAttribute("adminName",res.getString("name"));
			    session.setAttribute("adminId",res.getString("sellerId"));
			    
				break;
			}
		}
		   }
		 catch(Exception e)
		 {
			 e.printStackTrace();
		 }
		 con.close();
		return temp;
	}

	public void addProduct(ProductItem product,HttpSession session) throws SQLException, IOException {
		
		System.out.println("dao start");
		Connection con = jdbcTemplate.getDataSource().getConnection();
    /*	PreparedStatement pst = con.prepareStatement("insert into sdetails values(?,?,?,?)");
    	pst.setString(1,user.getUserName());
    	pst.setString(2,user.getMobile());
    	pst.setString(3,user.getEmailId());
    	pst.setString(4,user.getPassword());
    	pst.executeUpdate();*/
		PreparedStatement statement = con.prepareStatement("insert into amazon.products(productName,productDescription,productGender,productCategory,productSoldBy,productPrice,productImagePath) values(?,?,?,?,?,?,?)");
		System.out.println("dao class for add product in products table ");
		statement.setString(1,product.getProductName());
		statement.setString(2,product.getProductDescription());
		statement.setString(3,product.getProductGender());
		statement.setString(4,product.getProductCategory());
		statement.setString(5,product.getProductSoldBy());
		statement.setInt(6,product.getProductPrice());
		
		// for uploading  image of product
		String rootDirectory = "C:/Users/ASHUTOSH MANGAL/eclipse-workspace/ecommerce/WebContent/images/"+session.getAttribute("adminId").toString();
		File directory = new File(rootDirectory);
		directory.mkdirs();
		MultipartFile m = product.getProductImagePath();
		String fileName = m.getOriginalFilename();
		String filePath =directory.getAbsolutePath()+File.separator+fileName;
		BufferedOutputStream bf = new BufferedOutputStream(new FileOutputStream(filePath));
		bf.write(m.getBytes());
		bf.flush();
		bf.close();
		// for set filepath in eclipse workspace instread of E: directory cause of images are not lodad prefrectly!
		filePath = "images/"+session.getAttribute("adminId").toString()+File.separator+fileName;
		
		
		statement.setString(11,filePath);
		statement.executeUpdate();
    	System.out.println("dao end for add product in products table ");	
    	con.close();
		
		
	}

	public void deleteFromProduct(HttpServletRequest req) throws SQLException {
		System.out.println("dao start");
		Connection con = jdbcTemplate.getDataSource().getConnection();
		PreparedStatement statement = con.prepareStatement("delete from products where productId=?");
		statement.setInt(1,Integer.parseInt(req.getParameter("productId")));
		statement.executeUpdate();
		con.close();
	}


	public void editFromProduct(HttpServletRequest req,ProductItem product) throws SQLException {
		System.out.println("dao start");
		Connection con = jdbcTemplate.getDataSource().getConnection();	
		PreparedStatement statement = con.prepareStatement("update amazon.products"
                                                           + " set productName=?,productDescription=?,productGender=?,productCategory=?,productPrice=?"
                                                           +  " where productId = " + 	Integer.parseInt(req.getParameter("productId")));
		statement.setString(1,product.getProductName());
		statement.setString(2,product.getProductDescription());
		statement.setString(3,product.getProductGender());
		statement.setString(4,product.getProductCategory());
		statement.setInt(5,product.getProductPrice());
		statement.executeUpdate();
	}

	public void changeProductStatus(HttpServletRequest req) throws SQLException {
		Connection con = jdbcTemplate.getDataSource().getConnection();
		PreparedStatement statement1 = con.prepareStatement("UPDATE orders SET productStatus = 'placed'  WHERE orderId = ?");
		statement1.setInt(1,Integer.parseInt(req.getParameter("orderId")));
		 statement1.executeUpdate();	
	}

	
	public void adminIndex(HttpServletRequest req) throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.jdbc.Driver"); 
		Connection  con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon","root","ashu1234");
		PreparedStatement statement = con.prepareStatement("select * from products where productSoldBy=?");
		statement.setString(1, req.getSession().getAttribute("adminEmail").toString());
		ResultSet res1 = statement.executeQuery();
		ArrayList<ArrayList<String>>adminIndex =  attributeForUserIndex(res1);
		req.getSession().setAttribute("adminIndex",adminIndex);
		
	}
	private ArrayList<ArrayList<String>> attributeForUserIndex(ResultSet res) throws SQLException
	{
		ArrayList<ArrayList<String>>list = new ArrayList<ArrayList<String>>();
		while(res.next())
		{
			ArrayList<String>temp = new ArrayList<String>();
			temp.add(res.getString(8)); // Image
			temp.add(res.getString(2)); // name
			temp.add(res.getString(3)); // desc
			temp.add(Integer.toString(res.getInt(7)));  // price
			temp.add(res.getString(1)); // productId
			
			list.add(temp);
		}
     return list;
	}

	public void adminOrder(HttpServletRequest req) throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon","root","ashu1234");
		PreparedStatement statement = con.prepareStatement("select * from orders where productSoldBy=?");
		statement.setString(1, req.getSession().getAttribute("adminEmail").toString());
		ResultSet res1 = statement.executeQuery();	
		ArrayList<ArrayList<String>>adminOrder =  attributeForAdminOrders(res1);
		req.getSession().setAttribute("adminOrder",adminOrder);

	}

	private ArrayList<ArrayList<String>> attributeForAdminOrders(ResultSet res) throws SQLException {
		ArrayList<ArrayList<String>>list = new ArrayList<ArrayList<String>>();
		while(res.next())
		{
			ArrayList<String>temp = new ArrayList<String>();
			temp.add(res.getString("productImagePath")); // Image
			temp.add(res.getString("productName"));
			temp.add(Integer.toString(res.getInt("productPrice"))); // name
			temp.add(res.getString("productSize")); 
			temp.add(res.getString("orderId"));
			temp.add(res.getString("productStatus"));
			list.add(temp);
		}
     return list;
	}

}
