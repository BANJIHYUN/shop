 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="shop.dao.EmpDAO"%>
<%
	String emp_id = request.getParameter("emp_id");
	int grade = Integer.parseInt(request.getParameter("grade"));
	String emp_pw = request.getParameter("emp_pw");
	String emp_name = request.getParameter("emp_name");
	String emp_job = request.getParameter("emp_job");
	String hire_date = request.getParameter("hire_date");
	
	System.out.println("emp_id: " + emp_id);
	System.out.println("grade: " + grade);
	System.out.println("emp_pw: " + emp_pw);
	System.out.println("emp_name: " + emp_name);
	System.out.println("emp_job: " + emp_job);
	System.out.println("hire_date: " + hire_date);
	
/* 	String sql = "update emp set grade =?, emp_pw =?, emp_name=?, emp_job=?, hire_date=? where emp_id=?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection c = null;
	c = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = c.prepareStatement(sql);
	
	stmt.setInt(1, grade);
	stmt.setString(2, emp_pw);
	stmt.setString(3, emp_name);
	stmt.setString(4, emp_job);
	stmt.setString(5, hire_date);
	stmt.setString(6, emp_id); 
*/
	
/* 	int row = 0; 
	row = stmt.executeUpdate();
	
	if(row == 1){
		System.out.println("입력 성공");
		response.sendRedirect("/shop/emp/empOne.jsp?emp_id=" + emp_id);
	}else{
		System.out.println("입력 실패");
		response.sendRedirect("/shop/emp/empList.jsp?emp_id=" + emp_id);
	} */
	
	int UE = EmpDAO.updateEmp(emp_id, grade, emp_pw, emp_name, emp_job, hire_date);
	
	if(UE == 1){
		System.out.println("입력 성공");
		response.sendRedirect("/shop/emp/empOne.jsp?emp_id=" + emp_id);
	}else {
		System.out.println("입력 실패");
		response.sendRedirect("/shop/emp/empList.jsp?emp_id=" + emp_id);
	}
	
	
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