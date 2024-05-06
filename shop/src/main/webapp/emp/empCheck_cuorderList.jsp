<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%
	// 인증 분기 세션 변수 이름 : loginCustomer
	HashMap<String,Object>  loginCustomer = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
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
		m.put("name", rs.getString("name"));
		m.put("goods_no", rs.getInt("goods_no"));
		m.put("total_amount", rs.getInt("total_amount"));
		m.put("total_price", rs.getInt("total_price"));
		m.put("address", rs.getString("address"));
		m.put("state", rs.getString("state"));
		m.put("update_date", rs.getString("update_date"));
		m.put("create_date", rs.getString("create_date"));
		
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
  	<style>
  		
		table, th, td {
		  border: 1px solid black;
		}

  	</style>
</head>
<body>
	<h1>주문 리스트</h1>
			
			<%
				for(HashMap<String, Object> m : orderList){
			%>
			
						<table border="1">
						<tr bgcolor="pink">
							<th>주문 번호</th>
							<th>이메일</th>
							<th>이름</th>
							<th>물건 번호</th>
							<th>물건 총 개수</th>
							<th>물건 총 값</th>
							<th>주소</th>
							<th>상태</th>
							<th>주문 시간 </th>
							<th>생성 시간 </th>
						</tr>	
						<tr>
							<td><%=(Integer)m.get("orders_no")%></td>
							
							<td><%=(String)m.get("mail")%></td>
							
							<td><%=(String)m.get("name")%></td>
							
							<td><%=(Integer)m.get("goods_no")%></td>
							
							<td><%=(Integer)m.get("total_amount")%></td>
							
							<td><%=(Integer)m.get("total_price")%></td>
							
							<td><%=(String)m.get("address")%></td>
							
							<td>
								<form method="post" action="/shop/emp/cuOrderUpdateList.jsp?orders_no=<%=(Integer)m.get("orders_no")%>">
									<select name="state">
										<option value="<%=(String)(m.get("state"))%>"><%=(String)(m.get("state"))%></option>
										<option value="배송중">배송중</option>
										<option value="배송완료">배송완료</option>
									</select>
									<button type="submit">상태 변경하기</button>
								</form>
							</td>
							
							<td><%=(String)m.get("update_date")%></td>
							<td><%=(String)m.get("create_date")%></td>
						</tr>
					</table>	
			<%
				}
			%>
			
		
		<a href="/shop/emp/empList.jsp"><button type="button">취소</button></a>
</body>
</html>