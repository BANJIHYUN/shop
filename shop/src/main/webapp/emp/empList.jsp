<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.util.*"%>
<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	// 페이징
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	//int startRow = (currentPage - 1) * rowPerPage;
	
	//select count(*) from emp 전체 행의 수
	String sql2 = "Select count(*) from emp";
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
	
	int totalRow = 0;
	if(rs2.next()){
		totalRow = rs2.getInt("count(*)");
	}
	// 디버깅
	System.out.println("totalRow " + totalRow);
		
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0){	// 나머지가 0이 아니면 +1 해줘야 함. '실수'로 바꿔서 올림해버리면 똑같은 결과값이 나옴.
		lastPage = lastPage + 1;
	}
	// 디버깅
	System.out.println("lastPage " + lastPage);
%>
<%
	
	
	Class.forName("org.mariadb.jdbc.Driver");
	
	String sql = "select emp_id, emp_name, emp_job, hire_date, active from emp order by emp_name desc LIMIT ?, ?";
	PreparedStatement stmt = null;
	ResultSet rs5 = null;
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, (currentPage-1)*rowPerPage);
	stmt.setInt(2, rowPerPage);
	rs5 = stmt.executeQuery();
	System.out.println(stmt);
	//String sql = null;
	/* if(emp_name == null) {
		sql = "select emp_id, emp_name, emp_job, hire_date from emp order by emp_name desc";
		stmt = conn.prepareStatement(sql);
	} else {
		sql = "select emp_id,emp_name, emp_job, hire_date from emp where emp_name =? oreber by emp_name desc";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, emp_name);
	} */
	
/* 	String sql2 = "select distinct emp_name from emp order by emp_name";
	PreparedStatement stmt2 = null;
	stmt2 = conn.prepareStatement(sql2);
	System.out.println(stmt2);
	ResultSet rs2 = stmt2.executeQuery(); */
	
	 // JDBC API 종속된 자료구조 모델 ResultSet -> 기본 API 자료구조(ArrayList) 변경
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	
	// rs -> arrayList
	while(rs5.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("emp_id", rs5.getString("emp_id"));
		m.put("emp_name", rs5.getString("emp_name"));
		m.put("emp_job", rs5.getString("emp_job"));
		m.put("hire_date", rs5.getString("hire_date"));
		m.put("active", rs5.getString("active"));
		list.add(m);
	} 
	
	// JDBC 사용 끝나면 자원 반납.

%>

<%
	// 특수한 형태의 데이터(RDBMS: mariadb)
	// API 사용
	// 일반화된
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="mt-5 col-7 bg-white border shadow-sm p-3 mb-5 bg-body-tertiary rounded">
	<jsp:include page="/emp/Inc/empMenu.jsp"></jsp:include>

	<h1>사원 목록</h1>
	<span><%=currentPage%>페이지</span>
	<table class="table table-hover">
		<tr>
			<td>emp_id</td>
			<td>emp_name</td>
			<td>emp_job</td>
			<td>hire_date</td>
			<td>active</td>
		</tr>
		<%
				for(HashMap<String, Object> m:list){
					//while(rs3.next()){
		%>

			<tr>
				<td><%-- <a href="/shop/emp/empOne.jsp?emp_id=<%=(String)(m.get("emp_id"))%> && emp_name=<%=(String)(m.get("emp_name"))%>"> --%><%=(String)(m.get("emp_id"))%></a></td>
				<td><%=(String)(m.get("emp_name")) %></td>
				<td><%=(String)(m.get("emp_job")) %></td>
				<td><%=(String)(m.get("hire_date")) %></td>
				<td>
				<%
					HashMap<String, Object> sm = (HashMap<String , Object>)(session.getAttribute("loginEmp"));
		 			if((Integer)(sm.get("grade")) > 0){
				%>	
					<a href='/shop/emp/modifyEmpAction.jsp?active=<%=(String)(m.get("active"))%>&emp_id=<%=(String)(m.get("emp_id"))%>'><%=(String)(m.get("active"))%></a>
				
				<%
					}
				%>
				
				</td>
			</tr>

		<%
				//}
			}
		%>  
<%-- 		<tbody>
					
			<%
					while(rs3.next()){
			%>
							<tr>
								<td><%=rs3.getString("emp_id")%></td>
								<td>
									<a href="/shop/emp/empOne.jsp?emp_id=<%=rs3.getString("emp_id")%>
									<%=rs3.getString("emp_name")%>">
										<%=rs3.getString("emp_name")%>
									</a>
									
								</td>
								<td><%=rs3.getString("emp_job")%></td>
								<td>
									<div><%=rs3.getString("hire_date")%></div>
								</td>
								<td><%=rs3.getString("active")%></td>
							</tr>
						<%
							}
						%>
					</tbody>  --%>

<%--  		<%
			HashMap<String, Object> sm = (HashMap<String , Object>)(session.getAttribute("loginEmp"));
 			if((Integer)(sm.get("grade")) > 0){
		%>
			<a href='/shop/emp/modifyEmpAction.jsp?active=<%=(String)(sm.get("active"))%>&emp_id=<%=(String)(sm.get("emp_id"))%>'><%=(String)(sm.get("active"))%></a>
		<%
				}
		%> --%>
		<%-- <%
			while(rs.next()){
		%>
				<tr>
					<td><a href="/shop/emp/empOne.jsp?emp_name=<%=rs.getString("emp_name")%>"><%=rs.getString("emp_name")%></a></td>
					<td><%=rs.getString("emp_name")%></td>
					<td><%=rs.getString("emp_id") %></td>
					<td><%=rs.getString("emp_job")%></td>
					<td><%=rs.getString("hire_date")%></td>
				</tr>
		<%
			}
		%> --%>
	</table>
</div>
		<div class="col"></div>
</div>
<%-- <table class="table table-hover">
					<thead>
						<tr>
							<th>emp_id</th>
							<th>emp_name</th>
							<th>emp_job</th>
							<th>hire_date</th>
							<th>active</th>
						</tr>
					</thead>
					<tbody>
						<%
							while(rs3.next()){
						%>
							<tr>
								<td><%=rs3.getString("emp_id")%></td>
								<td>
									<a href="/shop/emp/empOne.jsp?emp_id=<%=rs3.getString("emp_id")%>
									<%=rs3.getString("emp_name")%>">
										<%=rs3.getString("emp_name")%>
									</a>
									
								</td>
								<td><%=rs3.getString("emp_job")%></td>
								<td>
									<div><%=rs3.getString("hire_date")%></div>
								</td>
								<td><%=rs3.getString("active")%></td>
							</tr>
						<%
							}
						%>
					</tbody>
				</table> --%>
				

					<!-- 페이징 --> <!-- 페이지 버튼 -->
             	<nav aria-label="Page navigation example">
         			<ul class="pagination justify-content-center">		
         				
					<%
						if(currentPage > 1) {
					%>
						<li class="page-item">
							<a class = "page-link" href="./empList.jsp?currentPage=1">처음페이지</a>
						</li>
						<li class="page-item">
							<a class = "page-link" href="./empList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
						</li>
					<% 		
						} else{
					%>
						<li class="page-item disabled">
							<a class = "page-link" href="./empList.jsp?currentPage=1">처음페이지</a>
						</li>
						<li class="page-item disabled">
							<a class ="page-link" href="./empList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
						</li>
					<%
						}
						if(currentPage < lastPage){
					%>	
							<li class="page-item">
								<a class = "page-link" href="./empList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a>
							</li>
							<li class="page-item">
								<a class = "page-link" href="./empList.jsp?currentPage=<%=lastPage%>">마지막페이지</a>
							</li>
					<%
						}
					%>
					</ul>
					</nav>

</div>
</body>
</html>