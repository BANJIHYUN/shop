<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String category = request.getParameter("category");
	System.out.println("category: " + category); 

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<form method="post" action="/shop/emp/deleteCategoryListAction.jsp">
	 	<input type="hidden" name =category value="<%=category%>">
			비밀번호:
		<input type="text" name ="category_pw">
		<button type ="submit">삭제</button>
	</form>	
</body>
</html>