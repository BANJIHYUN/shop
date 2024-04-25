<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.net.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="shop.dao.CustomerDAO"%>
<%
	// 인증 분기 세션 변수 이름 : loginCustomer
	HashMap<String,Object>  loginCustomer = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
%>
  <%
  		if(session.getAttribute("loginCustomer") != null){
  %>
  	<li style="float:right"><a href="/shop/customer/customerOne.jsp?email=<%=(String)(loginCustomer.get("email"))%>"><%=(String)(loginCustomer.get("email"))%>님  반갑습니다.</a></li>
  	<li style="float:right"><a class="active" href="/shop/customer/customerLogout.jsp">로그아웃</a></li>
  <%
  	}else{
  %>
  <li style="float:right"><a class="active" href="/shop/customer/customerLoginForm.jsp">로그인</a></li>
    	
  <%
  	}
  %> 
<%
	// 값 불러오기
	String email = request.getParameter("email");
	String user_pw = request.getParameter("user_pw");
	String user_name = request.getParameter("user_name");
	String user_birth = request.getParameter("user_birth");
	String user_gender = request.getParameter("user_gender");
	String update_date = request.getParameter("update_date");
	String create_date = request.getParameter("create_date");
	
	// 디버깅 로그인 바뀌기 전
	System.out.println("email: " + email);
	System.out.println("user_pw: " + user_pw);
	System.out.println("name: " + user_name);
	System.out.println("birth: " + user_birth);
	System.out.println("gender: " + user_gender);
	System.out.println("update_date: " + update_date);
	System.out.println("create_date: " + create_date);
	
	String sql = "update customer set pw=?, name=?, birth=?, gender=?, update_date=NOW(), create_date=NOW() where email=? "; 
	
	
	/* Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	stmt1 = conn.prepareStatement(sql);
	stmt1.setString(1, user_pw);
	stmt1.setString(2, user_name);
	stmt1.setString(3, user_birth);
	stmt1.setString(4, user_gender);
	stmt1.setString(5, update_date);
	stmt1.setString(6, create_date);
	
	System.out.println(stmt1);
	
	int row = 0;
	
	row = stmt1.executeUpdate(); */
	
	int MC = CustomerDAO.modifyCustomer(email,  user_pw,  user_name,  user_birth,  user_gender);
	
	if(MC == 1) {
		System.out.println("로그인 on/off 성공");
		response.sendRedirect("/shop/customer/mainShop.jsp");
	} else {
		System.out.println("로그인 on/off 실패");
		response.sendRedirect("/shop/customer/customerLogin.jsp");
	}
	
	

%>