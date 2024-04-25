<%@page import="shop.dao.GoodsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%
	int goods_no = Integer.parseInt(request.getParameter("goods_no"));
	System.out.println("goods_no: " + goods_no);
	
	// 구현 코드
/* 	String sql = "delete from goods where goods_no = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection c = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = c.prepareStatement(sql);
	stmt.setInt(1, goods_no);
	int row = stmt.executeUpdate(); */
	
	int GD = GoodsDAO.deleteGoods(goods_no);
	if(GD == 1) {
		System.out.println("삭제 성공");
		response.sendRedirect("/shop/emp/goodsList.jsp?goods_no=" + goods_no);
	}else {
		System.out.println("삭제 실패");
		response.sendRedirect("/shop/emp/goodsList.jsp?goods_no=" + goods_no);
	}
	System.out.println(GD + " <-- GD");
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>야구 굿즈 상세정보 삭제</title>
</head>
<body>

</body>
</html>