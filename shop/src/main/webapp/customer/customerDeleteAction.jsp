<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@page import="shop.dao.CustomerDAO"%>
<%
/* 	if(session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	} */

	// 인증 분기 세션 변수 이름 : loginCustomer
	HashMap<String,Object>  loginCustomer = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
%> 
<%
	String email = request.getParameter("email");
	System.out.println("email: " + email);
	
	/* String sql1 = "delete from customer where email =?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection c = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = c.prepareStatement(sql1);
	stmt.setString(1, email);
	int row = stmt.executeUpdate();
	System.out.println("row: " + row);
	if(row == 0) {
		response.sendRedirect("/shop/customer/customerDeleteForm.jsp?email="+ email);

	}else{
		session.invalidate();
		response.sendRedirect("/shop/customer/mainShop.jsp");
		System.out.println("탈퇴 성공");
	} */
	
	int DC = CustomerDAO.deleteCustomer(email);
	
	if(DC == 0){
		response.sendRedirect("/shop/customer/customerDeleteForm.jsp?email="+ email);
	}else {
		session.invalidate();
		response.sendRedirect("/shop/customer/mainShop.jsp");
		System.out.println("탈퇴 성공");
	}
%>