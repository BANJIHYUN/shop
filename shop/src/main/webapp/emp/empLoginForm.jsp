<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.net.*"%>
<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginEmp") != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<!-- 구글 폰트 -->
 	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Playpen+Sans:wght@100..800&display=swap" rel="stylesheet">
	<style>
	*{
  		 font-family: "Playpen Sans", cursive;
  		  font-family: "Bagel Fat One", system-ui;
  		}
		.login_head {
  			text-align:center;
  		}
  		.form {
  			 margin: 0 auto;
  		}
  		.login_btn{
  			text-align:center;
  		}
  		.memberID {
  			text-align: center;
  		}
  		.login_text {
  			background :linear-gradient(0.25turn, #3f87a6, #ebf8e1, #f69d3c);
  			opacity: 0.5;
  		}
  		.pic {
  			border-radius: 15%;
  		}
  		.login_pic{
  			border-radius: 50%;
  			position: relative;
  		}
  		.ss{
  			width: 100px;
  			margin: 0 auto;
  		}

	</style>
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col"></div>
		<div class="mt-5 col-7 bg-white border shadow-sm p-3 mb-5 bg-body-tertiary rounded">
			<h1 class="memberID">WELCOME</h1>
		
		<form method="post" action="/shop/emp/empLoginAction.jsp">
		<div class="login_head"><img src="/shop/emp/image/people_login.png" class="login_pic ss"></div>
				<div class="login_head">아이디 </div>
				<input type="text" name="empId" class="mt-3 col-100 bg-white border shadow-sm p-2 mb-2 bg-body-tertiary roundeds">
				<div class="login_head">비밀번호 </div>
				<input type="password" name="empPw" class="mt-3 col-100 bg-white border shadow-sm p-2 mb-2 bg-body-tertiary rounded ">
			<br><br><button type="submit" class="btn btn-dark mt-3 col-100 border shadow-sm bg-body-tertiary rounded">로그인</button>
		</form>
		</div>
		<div class="col"></div>
	</div>
</div>
</body>
</html>