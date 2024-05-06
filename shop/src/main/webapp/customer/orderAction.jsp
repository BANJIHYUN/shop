<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.net.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="shop.dao.*"%>
<%
	HashMap<String, Object> loginMember = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
%>
<%
	int goods_no = Integer.parseInt(request.getParameter("goods_no"));
	String mail = request.getParameter("mail");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	int total_amount = Integer.parseInt(request.getParameter("total_amount"));
	int total_price = Integer.parseInt(request.getParameter("total_price"));
	String state = request.getParameter("state");
	
	System.out.println("goods_no: " + goods_no);
	System.out.println("mail: " + mail);
	System.out.println("name: " + name);
	System.out.println("address: " + address);
	System.out.println("total_amount: " + total_amount);
	System.out.println("total_price: " + total_price);
	
	int CO = CustomerDAO.addOrders(mail, goods_no, name, address, total_amount, total_price, state);
	
	if(CO == 1){
			System.out.println("주문 성공");
			GoodsDAO.updateGoodsAmount(total_amount, goods_no);
			response.sendRedirect("/shop/customer/CuOrderList.jsp");	
	}else{
		System.out.println("주문 실패");
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
	}
%>