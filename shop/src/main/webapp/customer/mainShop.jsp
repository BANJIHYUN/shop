<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%
	// 인증 분기 세션 변수 이름 : loginCustomer
	HashMap<String,Object>  loginCustomer = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
%> 
<!DOCTYPE html>
<html>
<head>
  <title>쇼핑몰 메인페이지</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
     
.ul_1 {
  list-style-type: none;
  margin: 0;s
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
    <jsp:include page="/customer/Inc/customerMenu.jsp"></jsp:include>
</ul>



</body>
</html>