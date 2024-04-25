<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.net.*"%>

<%
	// 값 불러오기
	String emp_id = request.getParameter("emp_id");
	String active = request.getParameter("active");
	
	// 디버깅 로그인 바뀌기 전
	System.out.println("emp_id: " + emp_id);
	System.out.println("active: " + active);
	
	if(active.equals("OFF")){
		active = "ON";
	}else{
		active ="OFF";
	}
	
	// 디버깅 로그인 바뀐 후
	System.out.println("emp_id: " + emp_id);
	System.out.println("active: " + active);
	
	String sql = "update emp set active=? where emp_id=? "; 
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	stmt1 = conn.prepareStatement(sql);
	stmt1.setString(1, active);
	stmt1.setString(2, emp_id);
	
	System.out.println(stmt1);
	
	int row = 0;
	
	row =stmt1.executeUpdate();
	
	if(row == 1) {
		System.out.println("로그인 on/off 성공");
		response.sendRedirect("/shop/emp/empList.jsp");
	} else {
		System.out.println("로그인 on/off 실패");
		response.sendRedirect("/shop/emp/empList.jsp");
	}
	
	

%>