<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@ page import="java.net.*"%>
<%@page import="shop.dao.CustomerDAO"%>
<%
	int goods_no = Integer.parseInt(request.getParameter("goods_no"));
	System.out.println("goods_no: " + goods_no);

	/* int goods_no = Integer.parseInt(request.getParameter("goods_no"));
	int goods_price = Integer.parseInt(request.getParameter("goods_price"));
	 */
	int buy_amount = 0;
	ArrayList<HashMap<String, Object>> CustomerGoodsOne = CustomerDAO.CuGoodsOne(goods_no);
%>

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
			for(HashMap<String, Object> m: CustomerGoodsOne) { 
		%>
		
			<table>
				<tr>
					<td>GoodsNo: </td>
					<td><%=(Integer)(m.get("goods_no"))%></td>
				</tr>
				<tr>
					<td>category: </td>
					<td><%=(String)(m.get("category"))%></td>
				</tr>
				<tr>
					<td>제목: </td>
					<td><%=(String)(m.get("goods_title"))%></td>
				</tr>
				<tr>
					<img src="/shop/upload/<%=(String)(m.get("filename"))%>">
				</tr>
				<tr>
					<td>내용: </td>
					<td><%=(String)(m.get("goods_content"))%></td>
				</tr>
				<tr>
					<td>가격: </td>
					<td><%=(Integer)(m.get("goods_price"))%></td>
				</tr>
				<tr>
					<td>총 가격: <%=(Integer)(m.get("goods_price"))%>원 X</td>
					<td>
						수량: <input type="number" name="buy_amount">개
					</td>
				</tr>
			</table>	
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
		<a href="/shop/customer/orderForm.jsp?goods_no=<%=goods_no%>" class="btn btn-danger">주문하기</a>
	<%
		}
	%>
	
</body>
</html>