<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.net.*"%>
<%@page import="java.util.*"%>
<%@page import="shop.dao.EmpDAO"%>

<%-- <%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginEmp") != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%> --%>

<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	// controller
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	
	System.out.println("empId: " + empId);
	System.out.println("empPw: " + empPw);
	
	
	/* 
		select emp_id empId
		from emp 
		where active='ON' and emp_id =? and emp_pw = password(?)
	*/
	
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	String sql1 = "select emp_id empId, emp_name empName, grade from emp where active='ON' and emp_id=? and emp_pw= password(?)";
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, empId);
	stmt1.setString(2, empPw);
	rs1 = stmt1.executeQuery();
	
	HashMap<String, Object> loginEmp = EmpDAO.empLogin(empId, empPw);
	
	if(loginEmp == null){
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디 비밀번호 확인해주세요." ,"utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg=" + errMsg);
	}else{
		System.out.println("로그인 성공");
		session.setAttribute("loginEmp", loginEmp);
		response.sendRedirect("/shop/emp/empList.jsp");
	}
	
	
	/* if(rs1.next()){
		// 로그인 성공 시 active 변경
		System.out.println("로그인 성공");
		// 하나의 세션 변수안에 여러개의 값을 저장하기 위해서 hashMap
		HashMap<String, Object> loginEmp = EmpDAO.empLogin(empId, empPw);
		loginEmp.put("empId", rs1.getString("empId"));
		loginEmp.put("empName", rs1.getString("empName"));
		loginEmp.put("grade", rs1.getInt("grade"));
		
		session.setAttribute("loginEmp", loginEmp);
		
		// 디버깅
		HashMap<String, Object> m = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
		System.out.println((String)(m.get("empId")));
		System.out.println((String)(m.get("empName")));
		System.out.println((Integer)(m.get("grade")));
		response.sendRedirect("/shop/emp/empList.jsp");
		
		
	}else{
		// 로그인 실패
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디 비밀번호 확인해주세요." ,"utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg=" + errMsg);
	} */
	
	
	
%>