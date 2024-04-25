<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%@page import="shop.dao.CustomerDAO"%>
<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/mainShop.jsp");
		return;
	}
%>
<%
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	String user_name = request.getParameter("user_name");
	String user_birth = request.getParameter("user_birth");
	String user_gender = request.getParameter("user_gender");
	
	System.out.println("user_id: " + user_id);
	System.out.println("user_pw: " + user_pw);
	System.out.println("user_name: " + user_name);
	System.out.println("user_birth: " + user_birth);
	System.out.println("user_gender: " + user_gender);
	
	/* String sql = "insert into customer(email, pw, name, birth, gender, update_date, create_date) value(?, password(?), ?, ?, ?, NOW(), NOW())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql); 
	
	stmt.setString(1, user_id);
	stmt.setString(2, user_pw);
	stmt.setString(3, user_name);
	stmt.setString(4, user_birth); 
	stmt.setString(5, user_gender); */
	
	int AC = CustomerDAO.addCustomer(user_id, user_pw, user_name, user_birth, user_gender);
	
	if(AC == 1){
		System.out.println("입력 성공");
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
	}else {
		System.out.println("입력 실패");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
	}
	
	/* int row = 0;
	row = stmt.executeUpdate();
	
	if(row == 1) {
		System.out.println("입력 성공");
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
	}else{
		System.out.println("입력 실패");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
	} */

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