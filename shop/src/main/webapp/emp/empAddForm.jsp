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
	String emp_id = request.getParameter("emp_id");
	System.out.println("emp_id: " + emp_id);
	String emp_name = request.getParameter("emp_name");
	System.out.println("emp_name: " + emp_name);
	
	String sql = "";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;

	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<h1>사원 추가</h1>
	
	<form method="post" action="/shop/emp/empAddAction.jsp">
		<div>
			emp_id:
			<input type="text" name="emp_id">
		</div>
		<div>
			grade:
			<input type="number" name="grade">
		</div>
		<div>
			emp_name:
			<input type="text" name="emp_name">
		</div>
		<div>
			 emp_pw:
			<input type="text" name="emp_pw">
		</div>
		<div>
			emp_job:
			<input type="text" name="emp_job">
		</div>
		<div>
			hire_date:
			<input type="date" name="hire_date">
		</div>
		<div>
			active:
			<input type="enum" name="active">
		</div>
		<button type="submit">등록</button>
	</form>
</body>
</html>