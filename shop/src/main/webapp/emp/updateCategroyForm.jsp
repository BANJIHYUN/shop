<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	Class.forName("org.mariadb.jdbc.Driver");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String category = request.getParameter("category");
	System.out.println("category: " + category);
	String sql = "select category, create_date, category_pw from category where category=?";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, category);
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
	<form method="post" action="/shop/emp/updateCategoryAction.jsp">
		<h1>카테고리 수정하기</h1>
			<%
				for(HashMap<String, Object> m : categoryList){
			%>
			수정할 카테고리 : <%=(String)m.get("category")%><br>
				<div>수정할 내용: <input type ="text" name="category"></div>
				<div>비밀번호: <input type ="text" name="category_pw"></div>
				<div><button type="submit">수정하기</button> &nbsp;
				<a href="/shop/emp/categoryList.jsp"><button type="button">취소</button></a></div>
			<%
				}
			%>
	</form>
</body>
</html>