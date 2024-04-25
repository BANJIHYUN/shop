<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%@page import="shop.dao.EmpDAO"%>
<%
	String emp_id = request.getParameter("emp_id");
	int grade = Integer.parseInt(request.getParameter("grade")); 
	String emp_name = request.getParameter("emp_name");
	String emp_pw = request.getParameter("emp_pw");
	String emp_job = request.getParameter("emp_job");
	String hire_date = request.getParameter("hire_date");
	String active = request.getParameter("active");
	
	System.out.println("emp_id: " + emp_id);
	System.out.println("grade: " + grade);
	System.out.println("emp_name: " + emp_name);
	System.out.println("emp_pw: " + emp_pw); 
	System.out.println("emp_job: " + emp_job);
	System.out.println("hire_date: " + hire_date);
	System.out.println("active: " + active);
	
	String sql1 = "insert into emp(emp_id, grade, emp_name, emp_pw, emp_job, hire_date, update_date, create_date, active) value(?, ?, ?, password(?), ?, ?, NOW(), NOW(), ?)";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt1 = null;
	stmt1 = conn.prepareStatement(sql1); 
	
	stmt1.setString(1, emp_id);
	stmt1.setInt(2, grade);
	stmt1.setString(3, emp_name);
	stmt1.setString(4, emp_pw); 
	stmt1.setString(5, emp_job);
	stmt1.setString(6, hire_date);
	stmt1.setString(7, active);
	
	int AE = EmpDAO.addEmp(emp_id, grade, emp_name, emp_pw, emp_job, hire_date, active);
	
	
	
	if(AE == 1){
		System.out.println("입력 성공");
		response.sendRedirect("/shop/emp/empList.jsp");
	}else{
		System.out.println("입력 실패");
		response.sendRedirect("/shop/emp/empList.jsp");
	}
	
	/* int row = 0;
	
	
	if(row == 1) {
		System.out.println("입력 성공");
		response.sendRedirect("/shop/emp/empList.jsp");
	}else{
		System.out.println("입력 실패");
		response.sendRedirect("/shop/emp/empList.jsp");
	}
 */
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