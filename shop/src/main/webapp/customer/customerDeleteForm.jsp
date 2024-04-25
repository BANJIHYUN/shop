<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("loginCustomer")== null){
	response.sendRedirect("/shop/customer/loginForm.jsp");
	return;
}
%>
<%
	String email = request.getParameter("email");
	System.out.println("email" + email); 
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<form method="post" action="/shop/customer/customerDeleteAction.jsp">
	 	<input type="hidden" name ="email" value="<%=email%>">
			탈퇴하시겠습니까?
		<button type ="submit">삭제</button>
	</form>
</body>
</html>