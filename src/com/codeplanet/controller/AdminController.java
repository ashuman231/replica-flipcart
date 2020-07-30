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

import com.codeplanet.model.Admin;
import com.codeplanet.model.ProductItem;
import com.codeplanet.service.UserService;

@Controller
public class AdminController {
@Autowired 
UserService userService;
	@PostMapping(value="/adminSignup" )
	public String adminSignup(HttpServletRequest req,Admin admin ) throws SQLException
	{  System.out.println("controller start for signup");
		userService.adminSignup(admin);
		System.out.println("controller end for signup");
		req.setAttribute("message1","Warn:----  Signup Successfully");
		return "admin-login-signup";
	}
	@PostMapping(value="/adminLogin")
	public void adminLogin(Admin admin, HttpSession session,HttpServletRequest req,HttpServletResponse res) throws SQLException, ServletException, IOException
	{  System.out.println("controller start for login");
	   if(userService.adminLogin(admin,session)==true)
	   { 
		   System.out.println("login successful");
		   RequestDispatcher requestDispatcher = req.getRequestDispatcher("admin-index.jsp");
		   
	       requestDispatcher.forward(req,res);
		 
	   }
	   else
	   {  System.out.println("login failed");
	      req.setAttribute("message","Warn:----  Invalid Credential");
	      RequestDispatcher requestDispatcher = req.getRequestDispatcher("admin-login-signup.jsp");
          requestDispatcher.forward(req,res);
	   }
	}
	@RequestMapping(value="/adminLogout")
	public void adminLogout(HttpSession session,HttpServletRequest req, HttpServletResponse res) throws SQLException, ServletException, IOException
	{  System.out.println("controller start for logout");
	  session.invalidate();
	  RequestDispatcher red = req.getRequestDispatcher("admin-login-signup.jsp");
  	  red.forward(req,res);
	}
	
    @PostMapping(value="/addProduct" )
    public void addProduct(ProductItem product, HttpServletResponse res, HttpServletRequest req, HttpSession session) throws SQLException, ServletException, IOException
    {
    	
    	userService.addProduct(product, session);
    	RequestDispatcher red = req.getRequestDispatcher("admin-index.jsp");
    	red.forward(req,res);
    }
    
    @RequestMapping(value="/deleteFromProduct" )
    public void deleteFromProduct(HttpServletRequest req,HttpServletResponse res) throws SQLException, ServletException, IOException
    {
    	
    	userService.deleteFromProduct(req);
    	RequestDispatcher red = req.getRequestDispatcher("admin-index.jsp");
    	red.forward(req,res);
    }
    @RequestMapping(value="/editFromProduct" )
    public void editFromProduct(HttpServletRequest req,HttpServletResponse res,ProductItem product) throws SQLException, ServletException, IOException
    {
    	
    	userService.editFromProduct(req,product);
    	RequestDispatcher red = req.getRequestDispatcher("admin-index.jsp");
    	red.forward(req,res);
    }
    
    @RequestMapping(value="/changeProductStatus" )
    public String changeProductStatus(HttpServletRequest req) throws SQLException, ServletException, IOException
    {
    	
    	userService.changeProductStatus(req);
    	return "adminOrder";
    }
    
  
}
