<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.util.*"%>
<%
	String emp_id = request.getParameter("emp_id");
	System.out.println("emp_id: " + emp_id);
	
	String sql1= "select emp_id, grade, emp_name, emp_pw, emp_job, hire_date from emp where emp_id = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql1);
	stmt.setString(1, emp_id);
	rs = stmt.executeQuery();
	if(rs.next()){
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사원 정보 수정</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  	
  	<style>
		.card {
		  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
		  max-width: 300px;
		  margin: auto;
		  text-align: center;
		  font-family: arial;
		}
		
		.title {
		  color: grey;
		  font-size: 18px;
		}
		
 		button {
		  border: none;
		  outline: 0;
		  display: inline-block;
		  padding: 8px;
		  color: white;
		  background-color: #000;
		  text-align: center;
		  cursor: pointer;
		  width: 10%;
		  font-size: 18px;
		  
		} 
		
		a {
		  text-decoration: none;
		  font-size: 22px;
		  color: black;
		}
		
 		button:hover, a:hover {
		  opacity: 0.7;
		} 
</style>
</head>
<body>
	<h1>사원 정보 수정</h1>
		<h2 style="text-align:center">User Profile Card</h2>
			<div class="card">
		<form method="post" action="/shop/emp/empUpdateAction.jsp">
		<div>
			emp_id:
			<input type="text" name="emp_id" value="<%=rs.getString("emp_id")%>" readonly="readonly">
		</div>
		<div>
			grade:
			<input type="number" name="grade" value="<%=rs.getString("grade")%>">
		</div>
		<div>
			emp_pw:
			<input type="text" name="emp_pw" value="<%=rs.getString("emp_pw")%>" readonly="readonly">
		</div>
		<div>
			emp_name:
			<input type="text" name="emp_name" value="<%=rs.getString("emp_name")%>">
		</div>
		<div>
			emp_job:
			<input type="text" name="emp_job" value="<%=rs.getString("emp_job")%>">
		</div>
		<div>
			hire_date:
			<input type="date" name="hire_date" value="<%=rs.getString("hire_date")%>" readonly="readonly">
		</div>
		<button type="submit">등록</button>
	</form>
		<a href="/shop/emp/empList.jsp">취소</a>
	</div>
</body>
</html>
<%
	}
%>