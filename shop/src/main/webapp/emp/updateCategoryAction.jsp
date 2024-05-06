<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%@page import="shop.dao.CategoryDAO"%>
<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	String category = request.getParameter("category");
	String category_pw = request.getParameter("category_pw");
	
	System.out.println("category: " + category);
	System.out.println("category_pw: " + category_pw);
	
	int CD = CategoryDAO.updateCategory(category, category_pw);
	if(CD == 1){
		System.out.println("수정 성공");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}else {
		System.out.println("수정 실패");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}
%>