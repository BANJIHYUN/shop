<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	//인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	Class.forName("org.mariadb.jdbc.Driver");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM category";
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	System.out.println(stmt);
	
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	
	while(rs.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("category", rs.getString("category"));
		m.put("create_date", rs.getString("create_date"));
		m.put("category_pw", rs.getString("category_pw"));
		categoryList.add(m);
	}
	System.out.println(categoryList);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<form method="post" action="/shop/emp/addCategoryAction.jsp">
		<div>카테고리 추가하기</div>
				카테고리: <input type ="text" name="category"><br>
				비밀번호: <input type ="text" name="category_pw">
				<button type="submit">추가하기</button>
	</form>
</body>
</html>