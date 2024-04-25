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
	HashMap<String, Object> loginMember = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
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
		categoryList.add(m);
	}
	System.out.println(categoryList);
%>
<%
	String category = request.getParameter("category");
	String sql2 = "select category, create_date from category where category=?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, category);
	rs2 = stmt2.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1>카테고리 관리</h1>	
		
		<table border="1">
			<%
				for(HashMap<String, Object> m : categoryList){
			%>
						<tr>
							<th>제목 :</th>
							<td><%=(String)m.get("category")%></td>
						</tr>
						<tr>
							<th>작성일 :</th>
							<td><%=(String)m.get("create_date")%></td>
						</tr>
						<tr>
							<td><a href="/shop/emp/updateCategroyForm.jsp?category=<%=(String)m.get("category")%>"><button type="button">수정</button></a></td>
							<td><a href="/shop/emp/deleteCategoryListForm.jsp?category=<%=(String)m.get("category")%>"><button type="button">삭제</button></a></td>
						</tr>
			<%
				}
			%>
		</table>	
							<a href="/shop/emp/addCategoryForm.jsp"><button type="button">카테고리 추가하기</button></a>
							<a href="/shop/emp/goodsList.jsp"><button type="button">취소</button></a>
</body>
</html>