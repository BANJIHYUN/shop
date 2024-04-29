<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@ page import="java.net.*"%>
<%@page import="shop.dao.CustomerDAO"%>

<%
	int goods_no = Integer.parseInt(request.getParameter("goods_no"));
	System.out.println("goods_no: " + goods_no);
	int goods_price = Integer.parseInt(request.getParameter("goods_price"));
	System.out.println("goods_price: " + goods_price);
	ArrayList<HashMap<String, Object>> CustomerGoodsOne = CustomerDAO.CuGoodsOne(goods_no, goods_price);
%>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	// 부모글의 댓글리스트 
	String sql2 = "select score, content from comment where goods_no=?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, goods_no);
	rs2 = stmt2.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>긋즈 상세 정보</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1>상세 정보</h1>
	
		<%
			for(HashMap<String, Object> m: CustomerGoodsOne) { 
		%>
		
			<table>
				<tr>
					<td>GoodsNo: </td>
					<td><%=(m.get("goods_no"))%></td>
				</tr>
				<tr>
					<td>category: </td>
					<td><%=(m.get("category"))%></td>
				</tr>
				<tr>
					<td>제목: </td>
					<td><%=(m.get("goods_title"))%></td>
				</tr>
				<tr>
					<img src="/shop/upload/<%=(m.get("filename"))%>">
				</tr>
				<tr>
					<td>내용: </td>
					<td><%=(m.get("goods_content"))%></td>
				</tr>
				<tr>
					<td>가격: </td>
					<td><%=(m.get("goods_price"))%></td>
				</tr>
			</table>	
		<%
			}
		%>
	<a href="/shop/customer/customerGoodsList.jsp" class="btn btn-danger">취소</a>
	<%
		if(session.getAttribute("loginCustomer") == null){
	%>
		<a href="/shop/customer/customerLoginForm.jsp" class="btn btn-danger">주문하기</a>
	<%
		}else{
	%>
		<a href='/shop/customer/orderForm.jsp?goods_no=<%=goods_no%>&goods_price=<%=goods_price%>' class="btn btn-danger">주문하기</a>
	<%
		}
	%>
	<hr>
	<h1 style="color:#990085;">REVIEW</h1>
			<form method="post" action="/shop/customer/cucomment.jsp">
				<input type="hidden" name ="goods_no" value="<%=goods_no%>">
				<textarea rows="3" cols="50" name="memo"  style="background-color: #E8D9FF; width: 100%;"></textarea>
				<div>
				<button type="submit">등록</button>
				</div>
			</form>	
			<br>
			<!-- 댓글리스트 -->
			<h1 style="color:#990085;">댓글</h1>
			<%
				while(rs2.next()){
					System.out.println(rs2.getString("memo"));
			%>
				<hr>
				<form method="post" action="./deleteCommentAction.jsp">
					<input type="hidden" name ="commentno" value="<%=rs2.getString("commentno")%>">
					<input type="hidden" name ="goods_no" value="<%=goods_no%>">
				<div style="background-color: #E8D9FF;">댓글: <%=rs2.getString("memo")%></div>
					<button type="submit">삭제</button>
				</form>
				<div>수정할 내용을 입력하세요.</div>
				<form  method ="post" action ="./updateCommentAction.jsp">
					<input type="hidden" name ="commentno" value="<%=rs2.getString("commentno")%>">
					<input type="hidden" name ="goods_no" value="<%=goods_no%>">
					<textarea rows="3" cols="50" name="memo"  style="background-color: #E8D9FF; width: 100%;"></textarea>
					<button type="submit">수정</button>
				</form>
				<%
				}
				%>
					<div>
						<a href="/shop/customer/customerList.jsp">취소</a>
					</div>
			
	
	
</body>
</html>