<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@page import="shop.dao.EmpDAO"%>
<%
	String emp_id = request.getParameter("emp_id");
	String emp_pw = request.getParameter("emp_pw");
	
	System.out.println("emp_id: " + emp_id);
	System.out.println("emp_pw: " + emp_pw);
	
/* 	String sql1 = "delete from emp where emp_id =? and emp_pw =?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection c = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = c.prepareStatement(sql1);
	stmt.setString(1, emp_id);
	stmt.setString(2, emp_pw);  */
 	
	int DE = EmpDAO.deleteEmp(emp_id, emp_pw);
	if(DE == 1){ 
		System.out.println("삭제 성공");
		response.sendRedirect("/shop/emp/empList.jsp");
	}else{
		System.out.println("삭제 실패");
		response.sendRedirect("/shop/emp/empDeleteForm.jsp?emp_id="+ emp_id);
	}
	
	/*	
	if(row == 0) {
		response.sendRedirect("/shop/emp/empDeleteForm.jsp?emp_id="+ emp_id);
	}else{
		response.sendRedirect("/shop/emp/empList.jsp");
	} */
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>

</body>
</html>