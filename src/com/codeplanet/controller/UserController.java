package com.codeplanet.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
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
		userService.userSignup(user);
		System.out.println("controller end for signup");
		req.setAttribute("message1","Warn:---- Signup Successfully");
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
	@RequestMapping(value="/search")
	public void search(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException 
	{
	 RequestDispatcher rsd = req.getRequestDispatcher("search.jsp?productSearch="+req.getParameter("productSearch").toString());
	 rsd.forward(req, res);
	}
	
}
