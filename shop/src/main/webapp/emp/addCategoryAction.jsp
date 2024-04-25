<%@page import="shop.dao.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	String category = request.getParameter("category");
	String create_date = request.getParameter("create_date");
	String category_pw = request.getParameter("category_pw");
	
	// 디버깅
	System.out.println("category" + category);
	System.out.println("create_date" + create_date);
	System.out.println("category_pw" + category_pw);
	
/* 	String sql = "insert into category(category, create_date, category_pw) values(?, NOW(), password(?))";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setString(1, category);
	stmt.setString(2, category_pw); */
	// categoryDAO에서 가져온 카테고리와 비벝
	int AC = CategoryDAO.addCategory(category, category_pw);
	if(AC == 1){
		System.out.println("입력 성공");
	}else {
		System.out.println("입력 실패");
	}
	response.sendRedirect("/shop/emp/categoryList.jsp");
	
	/* int row = 0;
	row = stmt.executeUpdate();
	
	if(row == 1) {
		System.out.println("입력 성공");
	}else {
		System.out.println("입력 실패");
	}
	response.sendRedirect("/shop/emp/categoryList.jsp"); */
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