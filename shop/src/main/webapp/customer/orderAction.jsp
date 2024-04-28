<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	int goods_no = Integer.parseInt(request.getParameter("goods_no"));
	String email = request.getParameter("email");
	String user_name = request.getParameter("user_name");
	String cu_address = request.getParameter("cu_address");
	int cu_amount = Integer.parseInt(request.getParameter("cu_amount"));
	int cu_totalPrice = Integer.parseInt(request.getParameter("cu_totalPrice"));
	
	System.out.println("goods_no: " + goods_no);
	System.out.println("email: " + email);
	System.out.println("user_name: " + user_name);
	System.out.println("cu_address: " + cu_address);
	System.out.println("cu_amount: " + cu_amount);
	System.out.println("cu_totalPrice: " + cu_totalPrice);
	
	String sql = "insert into orders(goods_no, email, user_name, cu_address, cu_amount, cu_totalPrice) values(?, ?, ?, ?, ?, ?)";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setInt(1, goods_no);
	stmt.setString(2, email); 
	stmt.setString(3, user_name); 
	stmt.setString(4, cu_address); 
	stmt.setInt(5, cu_amount); 
	stmt.setInt(6, cu_totalPrice); 
	
	int row = 0;
	
	if(row == 1){
		System.out.println("입력 성공");
		response.sendRedirect("/shop/customer/orderList.jsp");
	}else{
		System.out.println("입력 실패");
		response.sendRedirect("/shop/customer/orderList.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	
</body>
</html>