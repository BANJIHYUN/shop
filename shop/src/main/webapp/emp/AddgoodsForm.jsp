<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;

	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "select category from category";
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	System.out.println(stmt);
	ArrayList<String> categoryList = new ArrayList<String>();
	
	while(rs.next()){
		categoryList.add(rs.getString("category"));
	}
	// 디버깅
	System.out.println(categoryList);
%>
<%
	HashMap<String, Object> loginMember = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<!-- 메인메뉴 -->
		<div>
			<jsp:include page="/emp/Inc/empMenu.jsp"></jsp:include>
		</div>
	<form method = "post" action="/shop/emp/AddgoodsAction.jsp" enctype="multipart/form-data">
		<h1>상품 등록</h1>
			<div>
				category: 
					<select name="category">
						<option value="">선택</option>
							<%
								for(String c : categoryList){
							%>
								<option value="<%=c%>"><%=c%></option>
							<%
								}
							%>
					</select>
			</div>
			<div>
				goodTitle :
				<input type="text" name="goods_title">
			</div>
			<div>
				 goodsImage :
				<input type="file" name="goodsImg">
			</div>
			<div>
				 goodsPrice : 
				 <input type="number" name="goods_price" >
			</div>
			<div>
				goodsAmount :
					<input type="number" name="goods_amount" >
			</div>
			<div>					
				goodsContent: <br> 
						<textarea rows="7" cols="50" name = "goods_content" ></textarea>
			</div>
			<div style="display:none">
				empId:
					 <input type="text" name="empId" value="<%=(String)(loginMember.get("empId"))%>" >
			</div>
			<div>
				goods_pw:
				<input type="text" name="goods_pw">
			</div>
			<div>
				<button type="submit">상품등록</button>
			</div>
		</form>
</body>
</html> 

