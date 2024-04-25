<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	String category = request.getParameter("category");
%>

<!-- Model Layout -->
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 상품 5개씩
	int rowPerPage = 5;
	
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	Class.forName("org.mariadb.jdbc.Driver");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String sql = "select category, count(*) cnt from goods group by category order by category asc;";
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	System.out.println(stmt);
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	
	while(rs.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("category", rs.getString("category"));
		m.put("cnt", rs.getInt("cnt"));
		categoryList.add(m);
	}
	// 디버깅
	System.out.println("***");
	System.out.println(categoryList);
	
%>
<%
	String sql3 = "select goods_no, category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date from goods where category = ? order by goods_no desc limit ?, ?";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	System.out.println(stmt3);
	stmt3.setString(1, category);
	stmt3.setInt(2, (currentPage-1)*rowPerPage);
	stmt3.setInt(3, rowPerPage);
	rs3 = stmt3.executeQuery();
	
	// 각각의 상품 리스트
	ArrayList<HashMap<String, Object>> categoryList3 = new ArrayList<HashMap<String, Object>>();
	
	while(rs3.next()){
		HashMap<String, Object> m3 = new HashMap<String, Object>();
		m3.put("goods_no", rs3.getInt("goods_no"));
		m3.put("category", rs3.getString("category"));
		m3.put("emp_id", rs3.getString("emp_id"));
		m3.put("goods_title", rs3.getString("goods_title"));
		m3.put("filename", rs3.getString("filename"));
		m3.put("goods_content", rs3.getString("goods_content"));
		m3.put("goods_price", rs3.getString("goods_price"));
		m3.put("goods_amount", rs3.getString("goods_amount"));
		m3.put("update_date", rs3.getString("update_date"));
		categoryList3.add(m3);
	}
	System.out.println("***");
	System.out.println(categoryList3);
%>
<%
	String sql1 = "select goods_no, category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date from goods order by goods_no desc limit ?, ?";
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	stmt1 = conn.prepareStatement(sql1);
	System.out.println(stmt1);
	stmt1.setInt(1, (currentPage-1)*rowPerPage);
	stmt1.setInt(2, rowPerPage);
	rs1 = stmt1.executeQuery();
	
	
	
	//JDBC API 종속한 자료구조 모델
	ArrayList<HashMap> totalList = new ArrayList<HashMap>();
	
	// rs -> arrayList
	// 전체 상품 리스트
	while(rs1.next()){
		HashMap<String, Object> m1 = new HashMap<String, Object>();
		m1.put("goods_no", rs1.getInt("goods_no"));
		m1.put("category", rs1.getString("category"));
		m1.put("emp_id", rs1.getString("emp_id"));
		m1.put("goods_title", rs1.getString("goods_title"));
		m1.put("filename", rs1.getString("filename"));
		m1.put("goods_content", rs1.getString("goods_content"));
		m1.put("goods_price", rs1.getString("goods_price"));
		m1.put("goods_amount", rs1.getString("goods_amount"));
		m1.put("update_date", rs1.getString("update_date"));
		totalList.add(m1);
	}
	System.out.println("***");
	System.out.println(totalList);
%>
<%
	//int startRow = (currentPage - 1) * rowPerPage;
	
	//select count(*) from goods 전체 행의 수
	String sql2 = "Select count(*) from goods";
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
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

<!-- view -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsList</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="mt-5 col-20 bg-white border shadow-sm p-3 mb-5 bg-body-tertiary rounded">
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/Inc/empMenu.jsp"></jsp:include>
	</div>
	
	<!-- 서브 메뉴 카테고리별 상품 리스트 -->
	<div>
	<table class="table table-hover">
		<h1>목록</h1>
		<span><%=currentPage%>페이지</span><br>
		<tr>
			<th>goods_no</th>
			<th>category</th>
			<th>emp_id</th>
			<th>goods_title</th>
			<th>filename</th>
			<th>goods_content</th>
			<th>goods_price</th>
			<th>goods_amount</th>
			<th>update_date</th>
		</tr>
		<div>애니 종류</div><br>
			<a href="/shop/emp/goodsList.jsp" class="btn btn-primary">전체</a>&nbsp;
			<%
				for(HashMap m : categoryList) {
			%>
					<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>" class="btn btn-primary">
					
								
										<%=(String)(m.get("category"))%>
										:
										<%=(Integer)(m.get("cnt"))%> 				
				 	</a>&nbsp;				 	
			<%
				}
			%> 
			<%	
				if(category == null){
					for(HashMap<String, Object> m1 :totalList){
			%>
			<tr>
				<td><a href="/shop/emp/goodsOne.jsp?goods_no=<%=(Integer)(m1.get("goods_no"))%>"><%=(Integer)(m1.get("goods_no"))%></a></td>
				<td><%=(String)(m1.get("category"))%></a></td>
				<td><%=(String)(m1.get("emp_id")) %></td>
				<td><%=(String)(m1.get("goods_title"))%></a></td>
				<%-- <td><%=(String)(m.get("filename"))%>    --%>
				<td><img src="/shop/upload/<%=(String)(m1.get("filename"))%>"></td>
				<td><%=(String)(m1.get("goods_content")) %></td>
				<td><%=(String)(m1.get("goods_price")) %></td>
				<td><%=(String)(m1.get("goods_amount")) %></td>
				<td><%=(String)(m1.get("update_date")) %></td>
			</tr>
		<%
				}
			}else if(category == category) {
				for(HashMap<String, Object> m3 : categoryList3){
		%>
				<tr>
				<td><a href="/shop/emp/goodsOne.jsp?goods_no=<%=(Integer)(m3.get("goods_no"))%>"><%=(Integer)(m3.get("goods_no"))%></a></td>
				<td><%=(String)(m3.get("category"))%></a></td>
				<td><%=(String)(m3.get("emp_id")) %></td>
				<td><%=(String)(m3.get("goods_title"))%></a></td>
				<%-- <td><%=(String)(m.get("filename"))%>    --%>
				<td><img src="/shop/upload/<%=(String)(m3.get("filename"))%>"></td>
				<td><%=(String)(m3.get("goods_content")) %></td>
				<td><%=(String)(m3.get("goods_price")) %></td>
				<td><%=(String)(m3.get("goods_amount")) %></td>
				<td><%=(String)(m3.get("update_date")) %></td>
			</tr>
			<%
					}
				}
			%>			
					
			<div class="row"></div>
	</table>
				<!-- 페이징 --> <!-- 페이지 버튼 -->
             	<nav aria-label="Page navigation example">
         			<ul class="pagination justify-content-center">		
         				
					<%
						if(currentPage > 1) {
					%>
						<li class="page-item">
							<a class = "page-link" href="/shop/emp/goodsList.jsp?currentPage=1">처음페이지</a>
						</li>
						<li class="page-item">
							<a class = "page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
						</li>
					<% 		
						} else{
					%>
						<li class="page-item disabled">
							<a class = "page-link" href="./shop/emp/goodsList.jsp?currentPage=1">처음페이지</a>
						</li>
						<li class="page-item disabled">
							<a class ="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
						</li>
					<%
						}if(currentPage < lastPage){
					%>	
							<li class="page-item">
								<a class = "page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a>
							</li>
							<li class="page-item">
								<a class = "page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage%>">마지막페이지</a>
							</li>
					<%
						}
					%>
					</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</body>
</html>