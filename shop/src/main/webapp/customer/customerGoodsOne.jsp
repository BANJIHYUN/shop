<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%
	int goods_no = Integer.parseInt(request.getParameter("goods_no"));
	String category = request.getParameter("category");
	String goods_title = request.getParameter("goods_title");
	String filename = request.getParameter("filename");
	String goods_content = request.getParameter("goods_content");
	String goods_price = request.getParameter("goods_price");
	
	System.out.println("goods_no: "+ goods_no);
	System.out.println("category: "+ category);
	System.out.println("goods_title: "+ goods_title);
	System.out.println("filename: "+ filename);
	System.out.println("goods_content: "+ goods_content);
	System.out.println("goods_price: "+ goods_price);
	
	String sql = "select goods_no, category, goods_title, filename, goods_content, goods_price, goods_amount from goods where goods_no = ?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt1 = conn.prepareStatement(sql);
	ResultSet rs1 = null;
	stmt1.setInt(1, goods_no);
	rs1 = stmt1.executeQuery();	
%>
<%-- <%
	String sql2 = "select * from goods where goods_no =?";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, goods_no);
	System.out.println(stmt2);
	ResultSet rs2 = null;
	rs2 = stmt2.executeQuery();
	
%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>긋즈 상세 정보</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1>상세 정보</h1>
	
	<%
		if(rs1.next()){
	%>
		<div>
			no : <%=rs1.getInt("goods_no")%>
		</div>
		<div>
			category : <%=rs1.getString("category")%>
		</div>
		<div>
			제목 : <%=rs1.getString("goods_title")%>
		</div>
		<div>
			<img src="/shop/upload/<%=(String)(rs1.getString("filename"))%>">
		</div>
		<div>
			내용 : <%=rs1.getString("goods_content")%>
		</div>
		<div>
			가격 : <%=rs1.getString("goods_price")%>원
		</div>
		<div>
			남은 수량 : <%=rs1.getString("goods_amount")%>개
		</div>
		
		
	<%
		}
	%>
	<a href="/shop/customer/customerGoodsList.jsp" class="btn btn-danger">취소</a>
	<%
		if(session.getAttribute("loginCustomer") == null){
	%>
		<a href="/shop/customer/customerLoginForm.jsp" class="btn btn-danger">주문하기</a>
	<%
		}else{
	%>
		<a href="/shop/order/orderForm.jsp" class="btn btn-danger">주문하기</a>
	<%
		}
	%>
	
</body>
</html>