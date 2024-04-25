<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@page import="shop.dao.GoodsDAO"%>
<%
	// 인증 분기 세션 변수 이름 : loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	int goods_no = Integer.parseInt(request.getParameter("goods_no"));
	String category = request.getParameter("category");
	String goods_title = request.getParameter("goods_title");
	int goods_price = Integer.parseInt(request.getParameter("goods_price"));
	int goods_amount = Integer.parseInt(request.getParameter("goods_amount"));
	String goods_content = request.getParameter("goods_content");
	String emp_id = request.getParameter("emp_id");
	
	Part part = request.getPart("goodsImg");
	String originalName = part.getSubmittedFileName();
	// 원본이름에서 확장자만 분리
	int dotIdx = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotIdx);	// .png
	
	UUID uuid = UUID.randomUUID();
	String filename = uuid.toString().replace("-", "");
	filename = filename + ext;
	
	System.out.println("goods_no: " + goods_no);
	System.out.println("category: " + category);
	System.out.println("goodsTitle: " + goods_title);
	System.out.println("goodsImage: " + filename);
	System.out.println("goodsPrice: " + goods_price);
	System.out.println("goodsAmount: " + goods_amount);
	System.out.println("goodsContent: " + goods_content);
	System.out.println("emp_id: " + emp_id);
	
	
	
/* 	String sql = "update goods set category= ?, goods_title= ?, filename=?, goods_price=?, goods_amount=?, goods_content=?, emp_id=?, update_date=NOW() where goods_no=?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection c = null;
	c = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = c.prepareStatement(sql);
	
	stmt.setString(1, goods_title);
	stmt.setString(2, category);
	stmt.setString(3, filename);
	stmt.setInt(4, goods_price);
	stmt.setInt(5, goods_amount);
	stmt.setString(6, goods_content);
	stmt.setString(7, emp_id);
	stmt.setInt(8, goods_no);
	stmt.setString(9, update_date); */
	
	
	int UG = GoodsDAO.updateGoods(goods_no, category, goods_title, filename, goods_price, goods_amount, goods_content, emp_id);
	
	if(UG == 1){
		InputStream is = part.getInputStream();
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, filename);	// 빈파일	
		OutputStream os = Files.newOutputStream(f.toPath());	// os + file
		is.transferTo(os);
		
		os.close();
		is.close();
		System.out.println("입력 성공");
		response.sendRedirect("/shop/emp/goodsOne.jsp?goods_no=" + goods_no);
	}else{
		System.out.println("입력 실패");
		response.sendRedirect("/shop/emp/goodsList.jsp?goods_no=" + goods_no);
	}
/* 	int row = 0;
	row = stmt.executeUpdate();
	if(row == 1){	// insert 실패 -> 파일 업로드 진행 안됨.
		// part -> 1.inputStream -> 2.ouputStream -> 3.빈파일
		//1
		InputStream is = part.getInputStream();
		//3 + 2
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, filename);	// 빈파일	
		OutputStream os = Files.newOutputStream(f.toPath());	// os + file
		is.transferTo(os);
		
		os.close();
		is.close();
	} */
	
/* 	if(row == 1){
		System.out.println("입력 성공");
		response.sendRedirect("/shop/emp/goodsOne.jsp?goods_no=" + goods_no);
	}else{
		System.out.println("입력 실패");
		response.sendRedirect("/shop/emp/goodsList.jsp?goods_no=" + goods_no);
	} */
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>

</body>
</html>