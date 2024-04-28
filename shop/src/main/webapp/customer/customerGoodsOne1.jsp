<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@ page import="java.net.*"%>
<%
	int goods_no = Integer.parseInt(request.getParameter("goods_no"));
	System.out.println("goods_no: "+ goods_no);
	int goods_price = Integer.parseInt(request.getParameter("goods_price"));
	System.out.println("goods_price: "+ goods_price);
	String category = request.getParameter("category");
	System.out.println("category: "+ category);
	String goods_title = request.getParameter("goods_title");
	String goods_content = request.getParameter("goods_content");
	
	String sql = "select * from goods where goods_no = ?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt1 = conn.prepareStatement(sql);
	ResultSet rs1 = null;
	stmt1.setInt(1, goods_no);
	rs1 = stmt1.executeQuery();	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
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
		<%
		}
		%>
</body>
</html>