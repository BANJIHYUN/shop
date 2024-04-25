<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%
	String category = request.getParameter("category");
	System.out.println("category: " + category);
	
	// 구현 코드
	String sql = "delete from category where category = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection c = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = c.prepareStatement(sql);
	stmt.setString(1, category);
	int row = stmt.executeUpdate();
	
	System.out.println(row + " <-- row");
	
	if(row == 1) {
		System.out.println("삭제 성공");
		response.sendRedirect("/shop/emp/categoryList.jsp");
		
	}else {
		System.out.println("삭제 실패");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>굿즈 카테고리 삭제</title>
</head>
<body>

</body>
</html>