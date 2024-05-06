<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%@page import="shop.dao.OrdersDAO"%>

<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<%
	int orders_no = Integer.parseInt(request.getParameter("orders_no"));
	String state = request.getParameter("state");
	System.out.println("orders_no: " + orders_no);
	System.out.println("state: " + state);
	
	int UOL = OrdersDAO.UpdateOrderList(orders_no, state);
	if(UOL == 1){
		System.out.println("주문 상태 업데이트 성공");
		response.sendRedirect("/shop/emp/empCheck_cuorderList.jsp");
	}else{
		System.out.println("주문 상태 업데이트 실패");
		response.sendRedirect("/shop/emp/empCheck_cuorderList.jsp");
	}
%>