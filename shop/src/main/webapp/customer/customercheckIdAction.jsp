<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import="java.net.*"%>
<%@page import="shop.dao.CustomerDAO"%>
<%
	String checkId = request.getParameter("checkId");
	System.out.println("checkId: " + checkId);
	
	/*
	String sql1 = "select email from customer where email=?";
	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1); 
	stmt1.setString(1, checkId);
	rs1 = stmt1.executeQuery();
	
	if(rs1.next()){
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkId=" + checkId+"&ck=F");
	}else{
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkId=" + checkId+"&ck=T");
	} */
	
	boolean CI = CustomerDAO.customerCheckId(checkId);
	if(CI == false) {
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkId=" + checkId+"&ck=F");
	}else{
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkId=" + checkId+"&ck=T");
	}
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 중복 체크</title>
</head>
<body>	
</body>
</html>