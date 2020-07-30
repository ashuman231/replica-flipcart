package com.codeplanet.service;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
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

	public void userSignup(User user) throws SQLException {
		 System.out.println("service start");
		userDao.userSignup(user);
		 System.out.println("service start");
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
	public void adminSignup(Admin admin) throws SQLException {
		System.out.println("service start");
		adminDao.adminSignup(admin);
		 System.out.println("service close");
		
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
}
