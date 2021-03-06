package com.codeplanet.service;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeplanet.dao.AdminDao;
import com.codeplanet.dao.UserDao;
import com.codeplanet.model.Admin;
import com.codeplanet.model.ProductItem;
import com.codeplanet.model.User;

@Service
public class UserService {
@Autowired
UserDao userDao;
@Autowired
AdminDao adminDao;

	public boolean userSignup(User user) throws SQLException {
		 System.out.println("service start");
		 System.out.println("service start");
		return userDao.userSignup(user);
		
	}
	public boolean userLogin(User user, HttpSession session) throws SQLException {
	    return userDao.userLogin(user,session);
	}
	public void addToCart(HttpServletRequest req) throws ClassNotFoundException, SQLException {
		userDao.addToCart(req);
		// TODO Auto-generated method stub
		
	}
	public void deleteFromCart(HttpServletRequest req) throws ClassNotFoundException, SQLException {
		userDao.deleteFromCart(req);
		
	}
	public void payment(HttpServletRequest req) throws ClassNotFoundException, SQLException {
		userDao.payment(req);
		
	}
	public boolean adminSignup(Admin admin) throws SQLException {
		System.out.println("service start");
		System.out.println("service close");
		return adminDao.adminSignup(admin);
		 
		
	}
	public boolean adminLogin(Admin admin, HttpSession session) throws SQLException {
		 return adminDao.adminLogin(admin,session);
	}
	public void addProduct(ProductItem product, HttpSession session) throws SQLException, IOException {
		adminDao.addProduct(product, session);
		
	}
	public void deleteFromProduct(HttpServletRequest req) throws SQLException {
		 adminDao.deleteFromProduct(req);
	}
	public void editFromProduct(HttpServletRequest req, ProductItem product) throws SQLException {
		 adminDao.editFromProduct(req,product);
		
	}
	public void changeProductStatus(HttpServletRequest req) throws SQLException {
		adminDao.changeProductStatus(req);
		
	}
	public void userIndex(HttpServletRequest req, HttpServletResponse res) throws ClassNotFoundException, SQLException {
		userDao.userIndex(req,res);
		
	}
	public void adminIndex(HttpServletRequest req) throws ClassNotFoundException, SQLException {
		adminDao.adminIndex(req);
		
	}
	public void userCart(HttpServletRequest req) throws ClassNotFoundException, SQLException {
		userDao.userCart(req);
		
	}
	public void productDetails(HttpServletRequest req) throws ClassNotFoundException, SQLException {
	userDao.productDetails(req);
		
	}
	public void search(HttpServletRequest req) throws ClassNotFoundException, SQLException {
		userDao.search(req);
	}
	public void userOrder(HttpServletRequest req) throws ClassNotFoundException, SQLException {
		userDao.userOrder(req);
		
	}
	public void adminOrder(HttpServletRequest req) throws ClassNotFoundException, SQLException {
		adminDao.adminOrder(req);
		
	}
}
