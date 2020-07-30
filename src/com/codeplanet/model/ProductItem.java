package com.codeplanet.model;

import org.springframework.web.multipart.MultipartFile;

public class ProductItem {
	private String productName ;				
	private String productDescription;				
	private String productGender	;	
	private String productCategory	;		
	private int productQuantitySmall;				
	private int productQuantityMedium;				
	private int productQuantityLarge;				
	private String productSoldBy	;	
	private int productPrice		;		
	private int productDiscount		;		
	private MultipartFile productImagePath;
	
	
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductDescription() {
		return productDescription;
	}
	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}
	public String getProductGender() {
		return productGender;
	}
	public void setProductGender(String productGender) {
		this.productGender = productGender;
	}
	public String getProductCategory() {
		return productCategory;
	}
	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}
	public int getProductQuantitySmall() {
		return productQuantitySmall;
	}
	public void setProductQuantitySmall(int productQuantitySmall) {
		this.productQuantitySmall = productQuantitySmall;
	}
	public int getProductQuantityMedium() {
		return productQuantityMedium;
	}
	public void setProductQuantityMedium(int productQuantityMedium) {
		this.productQuantityMedium = productQuantityMedium;
	}
	public int getProductQuantityLarge() {
		return productQuantityLarge;
	}
	public void setProductQuantityLarge(int productQuantityLarge) {
		this.productQuantityLarge = productQuantityLarge;
	}
	public String getProductSoldBy() {
		return productSoldBy;
	}
	public void setProductSoldBy(String productSoldBy) {
		this.productSoldBy = productSoldBy;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public int getProductDiscount() {
		return productDiscount;
	}
	public void setProductDiscount(int productDiscount) {
		this.productDiscount = productDiscount;
	}
	public MultipartFile getProductImagePath() {
		return productImagePath;
	}
	public void setProductImagePath(MultipartFile productImagePath) {
		this.productImagePath = productImagePath;
	}		

}
