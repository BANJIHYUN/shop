<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.net.*"%>
<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
%>
<%
	/* 아이디 중복 체크 */
	String checkId = request.getParameter("checkId");
	System.out.println("checkId: " + checkId);
	
	if(checkId == null) {
		checkId = "";
	}
	String ck = request.getParameter("ck");
	System.out.println("ck: " + ck);
	if(ck == null) {
		ck = "";
	}
	String msg = "";
	if(ck.equals("T")){
		msg = "사용할수 있는 아이디 입니다.";
	} else if(ck.equals("F")){		
		msg = "사용할수 없는 아이디 입니다. 다른 아이디를 써주세요.";
	}
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="mt-5 col-7 bg-white border shadow-sm p-3 mb-5 bg-body-tertiary rounded">
				<h1>회원가입</h1>	
						<form method="post" action="/shop/customer/customercheckIdAction.jsp">
						<div>
							아이디:
							<input type="text" name="checkId" value="<%=checkId%>">
							<!-- 아이디 중복 체크 구간 -->
							<button type="submit">중복체크</button>
							<br><span><%=msg%></span><%--  -> checkId : <%=checkId%> / ck : <%=ck%>	 --%>
						</div> 
						</form>
					<form method="post" action="/shop/customer/addCustomerAction.jsp">
						<div>
						<!-- T일때만 사용 가능 -->
							<%
								if(ck.equals("T")){
							%>
							<input type="text" name="user_id" readonly="readonly" value="<%=checkId%>" style="display:none">
							<%
								}else if(ck.equals("F")){
							%>
							<input type="text" name="user_id" readonly="readonly" style="display:none">
							<%
								}
							%>
						</div>
						<div>
							 비밀번호:
							<input type="text" name="user_pw">
						</div>
						<div>
							이름:
							<input type="text" name="user_name">
						</div>
						<div>
							생년 월일:
							<input type="date" name="user_birth">
						</div>
						<div>
							성별:
							<input type="text" name="user_gender">
						</div>
						<button type="submit">등록</button>
						<a href="/shop/customer/mainShop.jsp">취소</a>
					</form>
					</div>
						<div class="col"></div>
					</div>
		</div>
</body>
</html>