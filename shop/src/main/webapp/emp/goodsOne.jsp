<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%
	String goods_no = request.getParameter("goods_no");
	
	System.out.println("goods_no: " + goods_no);
	
	String sql = "select goods_no, category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date from goods where goods_no = ?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt1 = conn.prepareStatement(sql);
	ResultSet rs1 = null;
	stmt1.setString(1, goods_no);
	rs1 = stmt1.executeQuery();	
%>
<%
	String sql2 = "select * from goods where goods_no =?";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, goods_no);
	System.out.println(stmt2);
	ResultSet rs2 = null;
	rs2 = stmt2.executeQuery();
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1>상세 정보</h1>
	
	<%
		if(rs1.next()){
	%>
		<div>
			goods_no : <%=rs1.getInt("goods_no")%>
		</div>
		<div>
			category : <%=rs1.getString("category")%>
		</div>
		<div>
			emp_id : <%=rs1.getString("emp_id")%>
		</div>
		<div>
			goods_title : <%=rs1.getString("goods_title")%>
		</div>
		<div>
			<img src="/shop/upload/<%=(String)(rs1.getString("filename"))%>">
		</div>
		<div>
			goods_content : <%=rs1.getString("goods_content")%>
		</div>
		<div>
			goods_price : <%=rs1.getString("goods_price")%>
		</div>
		<div>
			goods_amount : <%=rs1.getString("goods_amount")%>
		</div>
		
		<div>
			update_date : <%=rs1.getString("update_date")%>
		</div>
		
	<%
		}
	%>
	<a href="/shop/emp/goodsUpdateForm.jsp?goods_no=<%=goods_no%>" class="btn btn-info">수정</a>
	<a href="/shop/emp/goodsDeleteForm.jsp?goods_no=<%=goods_no%>" class="btn btn-danger">삭제</a>
	<a href="/shop/emp/goodsList.jsp" class="btn btn-danger">취소</a>
	
</body>
</html>