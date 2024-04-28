<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%
	HashMap<String, Object> loginMember = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
%>
<%
	int goods_no = Integer.parseInt(request.getParameter("goods_no"));
	System.out.println("goods_no: " + goods_no);
	
	int goods_price = Integer.parseInt(request.getParameter("goods_price"));
	int buy_amount = Integer.parseInt(request.getParameter("buy_amount"));
	
	int total_price = goods_price * buy_amount;
	String sql = "";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;

	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
%> 

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<h1>주문하기</h1>
	<!-- form post로 보내기  -->
	<form method ="post" action="/shop/customer/orderAction.jsp">
		<div>
			물건 No:
			 <input type ="number" name ="goods_no" value= "<%=(goods_no)%>" readonly="readonly"> 
		</div>		
		<div>
			이메일:
			 <input type="text" name="user_id" value="<%=(String)(loginMember.get("email"))%>" readonly="readonly">
		</div>
		<div>
			이름:
			<input type="text" name="user_name">
		</div>
		<div>주소:</div>
		<div>
			<textarea rows="7" cols="50" name = "cu_address"></textarea>
		</div>
		<hr>
		<div>
			물건 개수:
			 <input type="number" name = "buy_amount"> 
		</div>
		<div>
			물건 총합: 
			<input type ="number" name="cu_totalPrice" value="<%=(String)("goods_price")%>"> 
		</div>
		<button type="submit">주문하기</button>
	</form>
		<a href="/shop/customer/customerGoodsList.jsp">취소하기</a>
</body>
</html>