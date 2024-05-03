
<%@page import="shop.dao.OrdersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%
	String email = request.getParameter("email");
	System.out.println("email: " + email);
	
	String sql1 = "select email, name, birth, gender from customer where email =?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	ResultSet rs1 = null;
	stmt1.setString(1, email);
	rs1 = stmt1.executeQuery();	
%>
<%
	String sql2 = "select * from customer where email = ?";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 = null;
	stmt1.setString(1, email);
	rs2 = stmt1.executeQuery();	
%>

<%
	String state = request.getParameter("state");
	String mail = request.getParameter("mail");
	System.out.println("state: " + state);
	
	String sql3 = "select * from orders where mail=?";
	PreparedStatement stmt3 = conn.prepareStatement(sql3);
	ResultSet rs3 = null;
	stmt3.setString(1, mail);
	rs3 = stmt3.executeQuery();	
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		.card {
		  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
		  max-width: 300px;
		  margin: auto;
		  text-align: center;
		  font-family: arial;
		}
		
		.title {
		  color: grey;
		  font-size: 18px;
		}
		
		a {
		  text-decoration: none;
		  font-size: 22px;
		  color: black;
		}
		
 		button:hover, a:hover {
		  opacity: 0.7;
		} 
	</style>
</head>
<body>
	
	<h2 style="text-align:center">User Profile Card</h2>
	
		<div class="card">
		<%
				if(session.getAttribute("loginCustomer") != null){
		%>
						<%
							if(rs1.next()){
						%>
							<h1><%=rs1.getString("email")%></h1>
					<img src="/shop/emp/image/people_login.png" alt="user" style="width: 100%">
							<div>
								email: <%=rs1.getString("email")%>
							</div>
							<div>
								name: <%=rs1.getString("name")%>
							</div>
							<div>
								birth: <%=rs1.getString("birth")%>
							</div>
							<div>
								gender: <%=rs1.getString("gender")%>
							</div>
							  <div style="margin: 24px 0;"> <br>
							<%
								if(rs3.next()){
							%>
								<a href="/shop/customer/CuOrderList.jsp?email=<%=email%>">주문정보 확인</a>
							<%
							} else{
							%>
								<div>주문 정보가 없습니다.</div>
							<%
							}
							%> 
							
							<a href="/shop/customer/customerUpdateForm.jsp?email=<%=email%>"><button>회원 정보 수정</button></a>
							<a href="/shop/customer/customerDeleteForm.jsp?email=<%=email%>"><button>회원 탈퇴</button></a>
							<a href="/shop/customer/mainShop.jsp"><button>취소</button></a>
						<%	
							}
						%>
						<%
							}else if(session.getAttribute("loginCustomer") == null){
						%>
							<a href="/shop/customer/mainShop.jsp"></a>
						<%
							}
						%>
								</div>
								
					</div>
</body>
</html>