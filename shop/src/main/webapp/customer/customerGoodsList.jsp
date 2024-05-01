<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@ page import="java.net.*"%>
<%@page import="shop.dao.CustomerDAO"%>
<%
	// 인증 분기 세션 변수 이름 : loginCustomer
	HashMap<String,Object>  loginCustomer = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
%>
<!-- Model Layout -->

<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 상품 5개씩
	int rowPerPage = 5;	
	//
	
	/* ArrayList<HashMap<String, Object>> paging = CustomerDAO.paging(); */
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String sql = "select category, count(*) cnt from goods group by category order by category asc;";
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	System.out.println(stmt);
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	String category = request.getParameter("category");
	System.out.println("category: " + category);
	while(rs.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("category", rs.getString("category"));
		m.put("cnt", rs.getInt("cnt"));
		categoryList.add(m);
	}
	// 디버깅
	System.out.println(categoryList);
	
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
<%
	//각각의 상품 리스트
	ArrayList<HashMap<String, Object>> categoryList3 = new ArrayList<HashMap<String, Object>>(); 
	
	String sql3 = "select * from goods where category = ? order by goods_no desc limit ?, ?";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	System.out.println(stmt3);
	stmt3.setString(1, category);
	stmt3.setInt(2, (currentPage-1)*rowPerPage);
	stmt3.setInt(3, rowPerPage);
	rs3 = stmt3.executeQuery(); 

	// 각각의 상품 리스트
	
	/* ArrayList<HashMap<String, Object>> CGL1 = CustomerDAO.customerCategoryList(goods_no, category, goods_title, filename, goods_content, goods_price, goods_amount); */
	
 	while(rs3.next()){
		HashMap<String, Object> CL3 = new HashMap<String, Object>();
		CL3.put("goods_no", rs3.getInt("goods_no"));
		CL3.put("category", rs3.getString("category"));
		CL3.put("goods_title", rs3.getString("goods_title"));
		CL3.put("filename", rs3.getString("filename"));
		CL3.put("goods_content", rs3.getString("goods_content"));
		CL3.put("goods_price", rs3.getString("goods_price"));
		CL3.put("goods_amount", rs3.getString("goods_amount"));
		categoryList3.add(CL3);
	}
 	System.out.println(categoryList3);
%>
<%
	//전체 상품 리스트
	ArrayList<HashMap<String, Object>> totalList = new ArrayList<HashMap<String, Object>>();

	String sql4 = "select * from goods order by goods_no desc limit ?, ?";
	PreparedStatement stmt4 = null;
	ResultSet rs4 = null;
	stmt4 = conn.prepareStatement(sql4);
	System.out.println(stmt4);
	stmt4.setInt(1, (currentPage-1)*rowPerPage);
	stmt4.setInt(2, rowPerPage);
	rs4 = stmt4.executeQuery();
	
	/* ArrayList<HashMap<String, Object>> CGL = CustomerDAO.customerGoodsList(goods_no, category, goods_title, filename, goods_content, goods_price, goods_amount); */
	
	//JDBC API 종속한 자료구조 모델
	
	
	// rs -> arrayList
	// 전체 상품 리스트
	while(rs4.next()){
		HashMap<String, Object> TL = new HashMap<String, Object>();
		TL.put("goods_no", rs4.getInt("goods_no"));
		TL.put("category", rs4.getString("category"));
		TL.put("goods_title", rs4.getString("goods_title"));
		TL.put("filename", rs4.getString("filename"));
		TL.put("goods_content", rs4.getString("goods_content"));
		TL.put("goods_price", rs4.getString("goods_price"));
		TL.put("goods_amount", rs4.getString("goods_amount"));
		totalList.add(TL);
	}
	System.out.println(totalList); 
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
  <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>ILB</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="/shop/customer/mainShop.jsp">ILES</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="#!">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#!">About</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="/shop/customer/customerGoodsList.jsp">All Products</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <li><a class="dropdown-item" href="#!">Popular Items</a></li>
                                <li><a class="dropdown-item" href="#!">New Arrivals</a></li>
                            </ul>
                        </li>
                    </ul>
                    <form class="d-flex">
                        <button class="btn btn-outline-dark" type="submit">
                            <i class="bi-cart-fill me-1"></i>
                            Cart
                            <span class="badge bg-dark text-white ms-1 rounded-pill">0</span>
                        </button>
                        &nbsp;
                        <button class="btn btn-outline-dark" type="submit">
                            <i class="bi-cart-fill me-1"><a href="/shop/customer/customerLoginForm.jsp">LOGIN</a></i> 
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
							  	<li style="float:right"><a class="active" href="/shop/emp/empLoginForm.jsp">관리자 로그인</a></li>
							    	
							<%
							  	}
							%>
                        </button>
                    </form>
                </div>
            </div>
        </nav>
        

<%-- <ul class="ul_1">
        
      <jsp:include page="/customer/Inc/customerMenu.jsp"></jsp:include>
</ul> --%>
  				  
         <!-- Section-->
             <h1 style="">목록</h1>
        			<span><%=currentPage%>페이지</span><br>
        			<div>굿즈 종류</div><br>
        			<a href="/shop/customer/customerGoodsList.jsp" class="btn btn-primary">전체</a>&nbsp;
			        	<%
							for(HashMap m : categoryList) {
						%>
								<a href="/shop/customer/customerGoodsList.jsp?category=<%=(String)(m.get("category"))%>" class="btn btn-primary">
								
											
													<%=(String)(m.get("category"))%>
													:
													<%=(Integer)(m.get("cnt"))%> 				
							 	</a>&nbsp;			 	
						<%
							}
						%> 
						<br>
						<br>
						<!-- 카테고리 전체 리스트 -->
         			<div style="float:left;">				
						<%	
							if(category == null){
								for(HashMap<String, Object> TL :totalList){	
						%>
						
										  <div class="card" style="float:left; margin-left:10px">
										   <!-- Product image-->
										   <img class="card-img-top" src="/shop/upload/<%=(String)(TL.get("filename"))%>" width="200" height="200">
										  	<!-- Product details-->
					                            <div class="card-body p-4">
					                                <div class="text-center">
					                                	 <div class="text-center">
						                                    <!-- Product name-->
						                                   <h5 class="fw-bolder"><%=(String)(TL.get("goods_title"))%></h5>
						                                    <!-- Product price-->
						                                     <%=(String)(TL.get("goods_price"))%>
						                                </div>
						                                 <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
				                               				 <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="/shop/customer/customerGoodsOne.jsp?goods_no=<%=(TL.get("goods_no"))%>&goods_price=<%=(TL.get("goods_price"))%>">View options</a></div> 
				                        				</div>
						                            </div>
						                        </div>
						                    </div>  
								<%
												}
								%>
								
					                   		</div> 
								<%}	
							else if(category == category) {
					for(HashMap<String, Object> CL3 : categoryList3){
			%>
							<div class="card" style="float:left; margin-left:10px">
							 <!-- Product image-->
							 <img class="card-img-top" src="/shop/upload/<%=(String)(CL3.get("filename"))%>" width="200" height="200">
							  <!-- Product details-->
							  <div class="card-body p-4">
							   <div class="text-center">
							   <h5 class="fw-bolder"><%=(String)(CL3.get("goods_title"))%></h5>
							     <%=(String)(CL3.get("goods_price"))%>
							     <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="/shop/customer/customerGoodsOne.jsp?goods_no=<%=(CL3.get("goods_no"))%>&goods_price=<%=(CL3.get("goods_price"))%>">View options</a></div>
								</div>
							</div>
							</div>
				<%
						}
					}
				%>	

 			
<%-- <div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="mt-5 col-20 bg-white border shadow-sm p-3 mb-5 bg-body-tertiary rounded">
	
	<!-- 서브 메뉴 카테고리별 상품 리스트 -->
	<div>
	<table class="table table-hover">
		<h1>목록</h1>
		<span><%=currentPage%>페이지</span><br>
		<tr>
			<th>goods_no</th>
			<th>goods_title</th>
			<th>filename</th>
			<th>goods_price</th>
		</tr>
		<div>굿즈 종류</div><br>
			<a href="/shop/customer/customerGoodsList.jsp" class="btn btn-primary">전체</a>&nbsp;
			<%
				for(HashMap m : categoryList) {
			%>
					<a href="/shop/customer/customerGoodsList.jsp?category=<%=(String)(m.get("category"))%>" class="btn btn-primary">
					
								
										<%=(String)(m.get("category"))%>
										:
										<%=(Integer)(m.get("cnt"))%> 				
				 	</a>&nbsp;			 	
			<%
				}
			%> 
			<%	
				if(category == null){
					for(HashMap<String, Object> TL :totalList){
			%>
			<tr>
				<td><a href="/shop/customer/customerGoodsOne.jsp?goods_no=<%=(TL.get("goods_no"))%>&goods_price=<%=(TL.get("goods_price"))%>"><%=(TL.get("goods_no"))%></a></td>
				<td><%=(String)(TL.get("goods_title"))%></td>
				<td><img src="/shop/upload/<%=(String)(TL.get("filename"))%>"></td>
				<td><%=(String)(TL.get("goods_price")) %></td>
			</tr>
		<%
					}	
			}else if(category == category) {
				for(HashMap<String, Object> CL3 : categoryList3){
		%>
				<tr>
				<td><a href="/shop/customer/customerGoodsOne.jsp?goods_no=<%=(CL3.get("goods_no"))%>&goods_price=<%=(CL3.get("goods_price"))%>"><%=(CL3.get("goods_no"))%></a></td>
				<td><%=(String)(CL3.get("goods_title"))%></td>
				<td><img src="/shop/upload/<%=(String)(CL3.get("filename"))%>"></td>
				<td><%=(String)(CL3.get("goods_price")) %></td>
				<td><input type="number" name="buy_amount">개</td>
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
							<a class = "page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=1">처음페이지</a>
						</li>
						<li class="page-item">
							<a class = "page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
						</li>
					<% 		
						} else{
					%>
						<li class="page-item disabled">
							<a class = "page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=1">처음페이지</a>
						</li>
						<li class="page-item disabled">
							<a class ="page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
						</li>
					<%
						}if(currentPage < lastPage){
					%>	
							<li class="page-item">
								<a class = "page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a>
							</li>
							<li class="page-item">
								<a class = "page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=lastPage%>">마지막페이지</a>
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
   --%>
<!-- 
        Footer
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        Bootstrap core JS
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        Core theme JS
        <script src="js/scripts.js"></script>
         <script>
			function subOpen(){
				document.querySelector('#subNavbar').style.display = 'block'
			}
			
			function subClose(){
				document.querySelector('#subNavbar').style.display = 'none'
			}
        </script> -->
        
	
</body>
</html>