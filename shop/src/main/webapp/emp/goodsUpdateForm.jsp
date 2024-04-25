<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	String goods_no = request.getParameter("goods_no");
	// 디버깅
	System.out.println("goods_no: " + goods_no);
	
	String sql = "select goods_no, category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date from goods where goods_no=?;";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, goods_no);
	rs = stmt.executeQuery();
	if(rs.next()){
%>
<%
	ArrayList<String> categoryList = new ArrayList<String>();
%>

<%
	HashMap<String, Object> loginMember = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- 구글 폰트 -->
</head>
<body>
	<form method="post" action="/shop/emp/goodsUpdateAction.jsp" enctype="multipart/form-data">
		<h1>상세 정보 수정</h1>
		<div>
			goods_no :
			<input type ="number" name="goods_no" value="<%=rs.getString("goods_no")%>" readonly="readonly">
		</div>
						category:  &nbsp;
						<select name="category">
					<%
						if(rs.getString("category").equals("KIA")){
					%>
							<option value="KIA" selected>KIA</option>
							<option value="KT">KT</option>
							<option value="LG">LG</option>
							<option value="NC">NC</option>
							<option value="SSG">SSG</option>
							<option value="두산">두산</option>
							<option value="롯데">롯데</option>
							<option value="삼성">삼성</option>
							<option value="키움">키움</option>
							<option value="한화">한화</option>
					<% 
						}else if(rs.getString("category").equals("KT")){
					%>
							<option value="KIA">KIA</option>
							<option value="KT" selected>KT</option>
							<option value="LG">LG</option>
							<option value="NC">NC</option>
							<option value="SSG">SSG</option>
							<option value="두산">두산</option>
							<option value="롯데">롯데</option>
							<option value="삼성">삼성</option>
							<option value="키움">키움</option>
							<option value="한화">한화</option>
					<% 
						}else if(rs.getString("category").equals("LG")){
					%>
							<option value="KIA">KIA</option>
							<option value="KT">KT</option>
							<option value="LG" selected>LG</option>
							<option value="NC">NC</option>
							<option value="SSG">SSG</option>
							<option value="두산">두산</option>
							<option value="롯데">롯데</option>
							<option value="삼성">삼성</option>
							<option value="키움">키움</option>
							<option value="한화">한화</option>
					<% 	
						}else if(rs.getString("category").equals("NC")){
					%>
							<option value="KIA">KIA</option>
							<option value="KT">KT</option>
							<option value="LG">LG</option>
							<option value="NC" selected>NC</option>
							<option value="SSG">SSG</option>
							<option value="두산">두산</option>
							<option value="롯데">롯데</option>
							<option value="삼성">삼성</option>
							<option value="키움">키움</option>
							<option value="한화">한화</option>
					<% 	
						}else if(rs.getString("category").equals("SSG")){		
					%>
							<option value="KIA">KIA</sption>
							<option value="KT">KT</option>
							<option value="LG">LG</option>
							<option value="NC">NC</option>
							<option value="SSG" selected>SSG</option>
							<option value="두산">두산</option>
							<option value="롯데">롯데</option>
							<option value="삼성">삼성</option>
							<option value="키움">키움</option>
							<option value="한화">한화</option>
					<%
						}else if(rs.getString("category").equals("두산")){
					%>
							<option value="KIA">KIA</option>
							<option value="KT">KT</option>
							<option value="LG">LG</option>
							<option value="NC">NC</option>
							<option value="SSG">SSG</option>
							<option value="두산" selected>두산</option>
							<option value="롯데">롯데</option>
							<option value="삼성">삼성</option>
							<option value="키움">키움</option>
							<option value="한화">한화</option>
					<%
						}else if(rs.getString("category").equals("롯데")){
					%>
							<option value="KIA">KIA</sption>
							<option value="KT">KT</option>
							<option value="LG">LG</option>
							<option value="NC">NC</option>
							<option value="SSG">SSG</option>
							<option value="두산">두산</option>
							<option value="롯데" selected>롯데</option>
							<option value="삼성">삼성</option>
							<option value="키움">키움</option>
							<option value="한화">한화</option>
					<%
						}else if(rs.getString("category").equals("삼성")){
					%>
							<option value="KIA">KIA</sption>
							<option value="KT">KT</option>
							<option value="LG">LG</option>
							<option value="NC">NC</option>
							<option value="SSG">SSG</option>
							<option value="두산">두산</option>
							<option value="롯데">롯데</option>
							<option value="삼성" selected>삼성</option>
							<option value="키움">키움</option>
							<option value="한화">한화</option>
					<%
						}else if(rs.getString("category").equals("키움")){
					%>
						<option value="KIA">KIA</sption>
							<option value="KT">KT</option>
							<option value="LG">LG</option>
							<option value="NC">NC</option>
							<option value="SSG">SSG</option>
							<option value="두산">두산</option>
							<option value="롯데">롯데</option>
							<option value="삼성">삼성</option>
							<option value="키움" selected>키움</option>
							<option value="한화">한화</option>
					<%
						} else if(rs.getString("category").equals("한화")){
					%>
							<option value="KIA">KIA</sption>
							<option value="KT">KT</option>
							<option value="LG">LG</option>
							<option value="NC">NC</option>
							<option value="SSG">SSG</option>
							<option value="두산">두산</option>
							<option value="롯데">롯데</option>
							<option value="삼성">삼성</option>
							<option value="키움">키움</option>
							<option value="한화" selected>한화</option>
					<%
						}
					%>
					
				</select>
							
					
			
			<div>
				goodsTitle :
				<input type="text" name="goods_title" value="<%=rs.getString("goods_title")%>">
			</div>
			<div>
				 goodsImage :
				<input type="file" name="goodsImg" value="<%=rs.getString("filename")%>">
			</div>
<%-- 			<div>
				filename :
				<%=rs.getString("filename")%>
			</div> --%>
			<div>
				 goodsPrice : 
				 <input type="number" name="goods_price"  value="<%=rs.getString("goods_price")%>">
			</div>
			<div>
				goodsAmount :
					<input type="number" name="goods_amount"  value="<%=rs.getString("goods_amount")%>">
			</div> 
			<div>					
				goodsContent: <br> 
						<textarea rows="7" cols="50" name = "goods_content" ><%=rs.getString("goods_content")%></textarea>
			</div>
			<div style="display:none">
				empId:
					 <input type="text" name="emp_id" value="<%=(String)(loginMember.get("empId"))%>" >
			</div>
			<div>
				<button type="submit" class="btn btn-outline-info">수정하기</button>
				<button type="submit" class="btn btn-outline-info"><a href="/shop/emp/goodsList.jsp">취소</a></button>	
			</div>
	</form>
</body>
</html>
<%
	}
%>