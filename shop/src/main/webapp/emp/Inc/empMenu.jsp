<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	HashMap<String, Object> loginMember = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>


	<a href="/shop/emp/empList.jsp">사원 관리</a>
	<a href="/shop/emp/empAddForm.jsp">사원 등록</a>
	
	<!-- 카테고리 -->
	<a href="/shop/emp/categoryList.jsp">카테고리 관리</a>
	
	<a href="/shop/emp/goodsList.jsp">상품 관리</a>
	
	
	<a href="/shop/emp/AddgoodsForm.jsp">상품등록</a>
	
	<a href="/shop/emp/customerList.jsp">고객리스트</a>
	
	<a href="/shop/customer/orderList.jsp">고객주문리스트</a>
	
	
	<a href="/shop/emp/empOne.jsp?emp_id=<%=(String)(loginMember.get("empId"))%>"><%=(String)(loginMember.get("empId"))%>님  반갑습니다.</a>
	
	
	<%-- <input name="empId" style="display:none" value="<%=(String)(loginMember.get("empId"))%>"> --%>

	<form method="post" action="/shop/emp/empLogout.jsp">
		<button type="submit">로그아웃</button>
	</form>
</body>
</html>