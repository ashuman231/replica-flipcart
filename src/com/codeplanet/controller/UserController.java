package com.codeplanet.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codeplanet.model.User;
import com.codeplanet.service.UserService;

@Controller
public class UserController {
@Autowired
UserService userService;
	@PostMapping(value="/userSignup" )
	public String userSignup(HttpServletRequest req,User user ) throws SQLException
	{  System.out.println("controller start for signup");
	   System.out.println("controller end for signup");
		if(userService.userSignup(user)==false)
		req.setAttribute("message1","Warn:---- Email already exists.Use another email-id to sign-up for user");		
		else
		req.setAttribute("message1","Warn:---- Signup Successfully for user");
		return "user-login-signup";
	}
	@PostMapping(value="/userLogin")
	public String userLogin(User user, HttpSession session,HttpServletRequest req) throws SQLException
	{  System.out.println("controller start for login");
	   if(userService.userLogin(user,session)==true)
	   { 
		   System.out.println("login successful");
		   return "user-index" ; 
		 
	   }
	   else
	   {   
		   req.setAttribute("message","Warn:---- Invalid Credential");
		   return "user-login-signup"; 
	   }
	}
	@RequestMapping(value="/userLogout")
	public String userLogout(HttpSession session) throws SQLException
	{  System.out.println("controller start for logout");
	  session.invalidate();
	  return "user-index";
	}
	
	
	
	// Business Logic
	@RequestMapping(value="/addToCart")
	public String addToCart(HttpServletRequest req) throws ClassNotFoundException, SQLException
	{   if(req.getSession().getAttribute("userEmail")==null)
		return "user-login-signup";
		userService.addToCart(req);
		return "user-index";	
	}
	
	@RequestMapping(value="/deleteFromCart")
	public String deleteFromCart(HttpServletRequest req) throws ClassNotFoundException, SQLException
	{
	   userService.deleteFromCart(req);
	   return "userCart";
	}
	@PostMapping(value="/payment")
	public String payment(HttpServletRequest req) throws ClassNotFoundException, SQLException
	{
		userService.payment(req);
		return "userOrder";	
	}
	@RequestMapping(value="/productSearch")
	public String search(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException, ClassNotFoundException, SQLException 
	{
	userService.search(req);
	return "productSearch";
	}
	/*
	@RequestMapping(value="/userIndex")
	public void userIndex(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException 
	{
	 RequestDispatcher rsd = req.getRequestDispatcher("search.jsp?productSearch="+req.getParameter("productSearch").toString());
	 rsd.forward(req, res);
	}
	*/
	@RequestMapping(value="/userIndex")
	public String userIndex(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException, ClassNotFoundException, SQLException 
	{
	 userService.userIndex(req,res);
	 return "user-index";
	}
	@RequestMapping(value="/userCart")
	public String userCart(HttpServletRequest req) throws ServletException, IOException, ClassNotFoundException, SQLException 
	{
	 userService.userCart(req);
	 return "userCart";
	}
	@RequestMapping(value="/productDetails")
	public String productDetails(HttpServletRequest req) throws ServletException, IOException, ClassNotFoundException, SQLException 
	{
	 userService.productDetails(req);
	 return "productDetails";
	}
	@RequestMapping(value="/userOrder")
	public String userOrder(HttpServletRequest req) throws ServletException, IOException, ClassNotFoundException, SQLException 
	{
	 userService.userOrder(req);
	 return "userOrder";
	}
	@RequestMapping(value="/user-login-signup")
	public String userLoginSignup(HttpServletRequest req) throws ServletException, IOException, ClassNotFoundException, SQLException 
	{
	 return "user-login-signup";
	}
	@RequestMapping(value="/checkout")
	public String checkout(HttpServletRequest req) throws ServletException, IOException, ClassNotFoundException, SQLException 
	{
	 return "checkout";
	}
	
}

