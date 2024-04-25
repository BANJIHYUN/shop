<%@page import="shop.dao.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	String category = request.getParameter("category");
	String category_pw = request.getParameter("category_pw");
	
	System.out.println("category: " + category);
	System.out.println("category_pw: " + category_pw);
	
	/* String sql = "update category set category =?, create_date =now(), category_pw=? where category =?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection c = null;
	c = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = c.prepareStatement(sql);
	
	stmt.setString(1, category_pw);
	stmt.setString(2, category); */
	
	int CD = CategoryDAO.updateCategory(category, category_pw);
	if(CD == 1){
		System.out.println("수정 성공");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}else {
		System.out.println("수정 실패");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}
	
	/* int row = 0; 
	row = stmt.executeUpdate();
	
	if(row == 1){
		System.out.println("수정 성공");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}else{
		System.out.println("수정 실패");
		response.sendRedirect("/shop/emp/categoryList.jsp");
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