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
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	Class.forName("org.mariadb.jdbc.Driver");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM orders";
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	System.out.println(stmt);
	
	ArrayList<HashMap<String, Object>> orderList = new ArrayList<HashMap<String, Object>>();
	
	while(rs.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("orders_no", rs.getInt("orders_no"));
		m.put("mail", rs.getString("mail"));
		orderList.add(m);
	}
	System.out.println(orderList);
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
	<h1>주문 리스트</h1>	
	<table border="1">
			<%
				for(HashMap<String, Object> m : orderList){
			%>
						<tr>
							<th>주문 번호: </th>
							<td><%=(Integer)m.get("orders_no")%></td>
						</tr>
						<tr>
							<th>이메일 :</th>
							<td><%=(String)m.get("email")%></td>
						</tr>
						<tr>
							<th>물건 번호 :</th>
							<td><%=(String)m.get("email")%></td>
						</tr>
						<tr>
							<th>물건 총 개수: </th>
							<td><%=(String)m.get("total_amount")%></td>
						</tr>
						<tr>
							<th>물건 총 값: </th>
							<td><%=(String)m.get("total_price")%></td>
						</tr>
						<tr>
							<th>주소: </th>
							<td><%=(String)m.get("address")%></td>
						</tr>
						<tr>
							<th>주문 시간: </th>
							<td><%=(String)m.get("ㅁㅇ")%></td>
						</tr>
						<tr>
							<th>주문 시간: </th>
							<td><%=(String)m.get("ㅁㅇ")%></td>
						</tr>
						
						<tr>
							<td><a href="/shop/emp/updateCategroyForm.jsp?category=<%=(String)m.get("category")%>"><button type="button">수정</button></a></td>
							<td><a href="/shop/emp/deleteCategoryListForm.jsp?category=<%=(String)m.get("category")%>"><button type="button">삭제</button></a></td>
						</tr>
			<%
				}
			%>
		</table>	
							<a href="/shop/emp/addCategoryForm.jsp"><button type="button">카테고리 추가하기</button></a>
							<a href="/shop/emp/goodsList.jsp"><button type="button">취소</button></a>
</body>
</html>