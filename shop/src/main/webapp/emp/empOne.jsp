<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%
	String emp_id = request.getParameter("emp_id");
	System.out.println("emp_id: " + emp_id);
	
	String sql1 = "select emp_id, emp_name, emp_job, hire_date from emp where emp_id =?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	ResultSet rs1 = null;
	stmt1.setString(1, emp_id);
	rs1 = stmt1.executeQuery();	
%>
<%
	String sql2 = "select * from emp where emp_id = ?";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 = null;
	stmt1.setString(1, emp_id);
	rs2 = stmt1.executeQuery();	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사원 상세정보</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
		
 		button {
		  border: none;
		  outline: 0;
		  display: inline-block;
		  padding: 8px;
		  color: white;
		  background-color: #000;
		  text-align: center;
		  cursor: pointer;
		  width: 10%;
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
							if(rs1.next()){
						%>
							<h1><%=rs1.getString("emp_name")%></h1>
					<img src="/shop/emp/image/people_login.png" alt="user" style="width: 100%">
							<div>
								emp_id: <%=rs1.getString("emp_id")%>
							</div>
							<div>
								emp_name: <%=rs1.getString("emp_name")%>
							</div>
							<div>
								emp_job: <%=rs1.getString("emp_job")%>
							</div>
							<div>
								hire_date: <%=rs1.getString("hire_date")%>
							</div>
							<%
								if(emp_id.equals("admin")){
							%>
								<p class="title">CEO & Founder</p>
							<%
								}
							%>
							  <div style="margin: 24px 0;">
							    <a href="#"><i class="fa fa-dribbble"></i></a> 
							    <a href="#"><i class="fa fa-twitter"></i></a>  
							    <a href="#"><i class="fa fa-linkedin"></i></a>  
							    <a href="#"><i class="fa fa-facebook"></i></a> <br>
						<%	
							}
						%>
								</div>
								 <div style="margin: 24px 0;">
									    <a href="/shop/emp/empUpdateForm.jsp?emp_id=<%=emp_id%>"><button>수정</button></a>
										<a href="/shop/emp/empDeleteForm.jsp?emp_id=<%=emp_id%>"><button>삭제</button></a>
										<a href="/shop/emp/empList.jsp"><button>취소</button></a>
								</div>
					</div>
</body>
</html>