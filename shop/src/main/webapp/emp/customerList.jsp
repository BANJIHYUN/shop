<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="shop.dao.EmpDAO"%>
<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	String email = request.getParameter("email");
	String name = request.getParameter("name");
	
	System.out.println("email: " + email);
	System.out.println("name: " + name);
	
	ArrayList<HashMap<String, Object>> CL = EmpDAO.selectedCustomerList(email, name);
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<h1>고객 리스트</h1>
	<table border="1">
		<tr>
			<td>아이디</td>
			<td>이름</td>
		</tr>
		<%
				for(HashMap<String, Object> m:CL){
					//while(rs3.next()){
		%>
			<td><%=(String)(m.get("email")) %></td>
			<td><%=(String)(m.get("name")) %></td>
		<%
				}
		%>
	</table>
	<a href="/shop/emp/empList.jsp">취소</a>
</body>
</html>