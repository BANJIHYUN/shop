<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%@page import="shop.dao.CustomerDAO"%>
<%
	HashMap<String, Object> loginMember = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
%>

<%
	int goods_no = Integer.parseInt(request.getParameter("goods_no"));
	System.out.println("goods_no: " + goods_no);
	int goods_price = Integer.parseInt(request.getParameter("goods_price"));
	System.out.println("goods_price: " + goods_price);
	
	ArrayList<HashMap<String, Object>> CustomerGoodsOne = CustomerDAO.CuGoodsOne(goods_no, goods_price);
	
	int total_amount = Integer.parseInt(request.getParameter("total_amount"));
	System.out.println("goods_price: " + goods_price);
	
	int total_price = 0;
	total_price = goods_price * total_amount;
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
			 <input type="text" name="mail" value="<%=(String)(loginMember.get("email"))%>" readonly="readonly">
		</div>
		<div>
			이름:
			<input type="text" name="name">
		</div>
		<div>주소:</div>
		<div>
			<textarea rows="7" cols="50" name = "address"></textarea>
		</div>
		<hr>
		<div> 
			수량:
			 <input type="number" name = "total_amount" value="<%=total_amount%>"> 
		</div>
		<div>
			물건 금액: 
			<input type ="number" name="goods_price" value="<%=goods_price%>"> 
		</div>
		<div>
			총액: 
			<input type ="number" name="total_price" value="<%=total_price%>"> 
		</div>
		<button type="submit">주문하기</button>
	</form>
		<a href="/shop/customer/customerGoodsList.jsp">취소하기</a>
</body>
</html>