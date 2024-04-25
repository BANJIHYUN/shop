<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.net.*"%>
<%@page import="java.util.*"%>
<%@page import="shop.dao.CustomerDAO"%>
<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/mainShop.jsp");
		return;
	}
%>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String email = request.getParameter("email");
	String pw = request.getParameter("pw");
	
	System.out.println("email: " + email);
	System.out.println("pw: " + pw);
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	HashMap<String, String> CL = CustomerDAO.login(email, pw);
	if(CL != null){
		System.out.println("로그인 성공");
		// 하나의 세션 변수안에 여러개의 값을 저장하기 위해서 hashMap
	 	HashMap<String, String> loginCustomer = new HashMap<String, String>();
		loginCustomer.put("email", CL.get("email"));
		loginCustomer.put("pw", CL.get("pw"));
		session.setAttribute("loginCustomer", loginCustomer);  
		response.sendRedirect("/shop/customer/mainShop.jsp");

		
	}else{
		// 로그인 실패
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디 비밀번호 확인해주세요." ,"utf-8");
		response.sendRedirect("/shop/customer/customerLoginForm.jsp?errMsg=" + errMsg);
	}

	
/* 	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	String sql1 = "select email, pw from customer where email=? and pw= password(?)";
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, email);
	stmt1.setString(2, pw);
	rs1 = stmt1.executeQuery(); */
	
	/* if(rs1.next()){
		// 로그인 성공 시 active 변경
		System.out.println("로그인 성공");
		// 하나의 세션 변수안에 여러개의 값을 저장하기 위해서 hashMap
		HashMap<String, Object> loginCustomer = new HashMap<String, Object>();
		loginCustomer.put("email", rs1.getString("email"));
		loginCustomer.put("pw", rs1.getString("pw"));
		session.setAttribute("loginCustomer", loginCustomer); */
		
		
		//session.setAttribute("loginEmp", rs1.getString("empId"));
		
		// 디버깅
/* 		HashMap<String, Object> m = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
		System.out.println((String)(m.get("email")));
		System.out.println((String)(m.get("pw"))); */
/* 		response.sendRedirect("/shop/customer/mainShop.jsp");
		
		
	}else{
		// 로그인 실패
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디 비밀번호 확인해주세요." ,"utf-8");
		response.sendRedirect("/shop/customer/customerLoginForm.jsp?errMsg=" + errMsg);
	} */
%>