<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인증 분기 세션 변수 이름 : loginCustomer
	HashMap<String,Object>  loginCustomer = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	  <style>
	     
	.ul_1 {
	  list-style-type: none;
	  margin: 0;
	  padding: 0;
	  overflow: hidden;
	  background-color: #F6F6F6;
	}
	
	li {
	  float: left;
	}
	li a {
	  display: block;
	  color: black;
	  text-align: center;
	  padding: 14px 16px;
	  text-decoration: none;
	}
	
	li a:hover:not(.active) {
	  background-color: transparent;
	}
	
	.active {
	  background-color: #F6F6F6;
	}
  </style>
</head>
<body>
<ul class="ul_1">
<%
  	if(session.getAttribute("loginCustomer") != null){
%>
  	<li style="float:right"><a class="active" href="/shop/customer/customerOne.jsp?email=<%=(String)(loginCustomer.get("email"))%>"><%=(String)(loginCustomer.get("email"))%>님  반갑습니다.</a></li>
  	<li style="float:right"><a class="active" href="/shop/customer/customerLogout.jsp">로그아웃</a></li>
<%
  	}else{
%>
  	<li style="float:right"><a class="active" href="/shop/customer/addCustomerForm.jsp">회원가입</a></li>
  	<li style="float:right"><a class="active" href="/shop/customer/customerLoginForm.jsp">로그인</a></li>
    	
<%
  	}
%> 
  </ul>
  <nav class="navbar navbar-expand-sm bg-dark navbar-dark">

 	&nbsp;&nbsp;<a class="navbar-brand" href="/shop/customer/mainShop.jsp">
      <img src="/shop/customer/image/baseball.png" alt="Logo" style="width:40px;" class="rounded-pill">B쇼핑
    </a>
   
  <div class="container-fluid">
   
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="/shop/customer/customerGoodsList.jsp">상품리스트</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/shop/customer/customerGoodsList.jsp">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:void(0)">Link</a>
        </li>
      </ul>
      
    <form class="d-flex">
        <input class="form-control me-2" type="text" placeholder="Search">
        <button class="btn btn-primary" type="button">Search</button>
  	</form>
  </div>
</nav>
</body>
</html>