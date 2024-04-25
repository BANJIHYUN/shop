<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String emp_id = request.getParameter("emp_id");
	System.out.println("emp_id: " + emp_id); 

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<form method="post" action="/shop/emp/empDeleteAction.jsp">
	 	<input type="hidden" name ="emp_id" value="<%=emp_id%>">
			비밀번호:
		<input type="password" name ="emp_pw">
		<button type ="submit">삭제</button>
	</form>
</body>
</html>