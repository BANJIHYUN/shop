<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@ page import="java.net.*"%>
<%@page import="shop.dao.CustomerDAO"%>
<%@page import="shop.dao.commentDAO"%>

<%
	int goods_no = Integer.parseInt(request.getParameter("goods_no"));
	System.out.println("goods_no: " + goods_no);
	int goods_price = Integer.parseInt(request.getParameter("goods_price"));
	System.out.println("goods_price: " + goods_price);
	ArrayList<HashMap<String, Object>> CustomerGoodsOne = CustomerDAO.CuGoodsOne(goods_no, goods_price);
%>

<%
	// 인증 분기 세션 변수 이름 : loginCustomer
	HashMap<String,Object>  loginCustomer = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
%>
<%
	ArrayList<HashMap<String,Object>> addComment = commentDAO.addcomment(goods_no);
%>
<%-- <%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	// 부모글의 댓글리스트 
	String sql2 = "select score, content from comment where goods_no=?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, goods_no);
	rs2 = stmt2.executeQuery();
%> --%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>긋즈 상세 정보</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		.star-rating {
      display: flex;
    }

    .star {
      appearance: none;
      padding: 1px;
    }

    .star::after {
      content: '☆';
      color: hsl(60, 80%, 45%);
      font-size: 20px;
    }

    .star:hover::after,
    .star:has(~ .star:hover)::after,
    .star:checked::after,
    .star:has(~ .star:checked)::after {
      content: '★';
    }

    .star:hover ~ .star::after {
      content: '☆';
    }
	</style>
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
	<%
		if(session.getAttribute("loginCustomer") == null){
	%>
		<a href="/shop/customer/customerGoodsList.jsp" class="btn btn-danger">취소</a>
		<a href="/shop/customer/customerLoginForm.jsp" class="btn btn-danger">주문하기</a>
	<%
		}else{
	%>
		<form method ="post" action="/shop/customer/orderForm.jsp?goods_no=<%=goods_no%>&goods_price=<%=goods_price%>">
							수량:
							<input type="number" name ="total_amount">
							<a href="/shop/customer/customerGoodsList.jsp" class="btn btn-danger">취소</a>
							<button type="submit" class="btn btn-danger">주문하기</button>
		</form>
	<%
		}
	%>
		
	<hr>
	<%
		if(loginCustomer != null){
			if(addComment.size() == 0){		
	%>
	<%
			}else{
	%>
	<h1 style="color:#990085;">REVIEW</h1>
			<form method="post" action="/shop/customer/cuComment.jsp">
					<input type="hidden" name ="goods_no" value="<%=goods_no%>">
					<div>
	  					작성자: <input type="text" name="email" value=<%=(String)(loginCustomer.get("email"))%>>
	  				</div>
						 <div class="star-rating">
						    <input type="radio" class="star" value="1">
						    <input type="radio" class="star" value="2">
						    <input type="radio" class="star" value="3">	
						    <input type="radio" class="star" value="4">
						    <input type="radio" class="star" value="5">
	  					</div>
	  					<textarea rows="3" cols="50" name="memo" style="background-color: #E8D9FF; width: 100%;"></textarea>
					<div>
						<button type="submit">등록</button>
					</div>
			</form>	
		
		<%
					}
		%>	
	<%
		}
	%>
			
</body>
</html>