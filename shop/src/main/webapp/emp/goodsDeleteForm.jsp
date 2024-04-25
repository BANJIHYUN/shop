<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String goods_no = request.getParameter("goods_no");
	System.out.println("goods_no: " + goods_no); 

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<form method="post" action="/shop/emp/goodsDeleteAction.jsp">
	 	<input type="hidden" name ="goods_no" value="<%=goods_no%>">
			비밀번호:
		<input type="password" name ="goods_pw">
		<button type ="submit">삭제</button>
	</form>	
</body>
</html>