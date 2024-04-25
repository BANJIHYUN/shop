<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
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
	String category = request.getParameter("category");
	String empId = request.getParameter("empId");
	String goods_pw = request.getParameter("goods_pw");
	String goods_title = request.getParameter("goods_title");
	int goods_price = Integer.parseInt(request.getParameter("goods_price"));
	int goods_amount = Integer.parseInt(request.getParameter("goods_amount"));
	String goods_content = request.getParameter("goods_content");
	
	Part part = request.getPart("goodsImg");
	String originalName = part.getSubmittedFileName();
	// 원본이름에서 확장자만 분리
	int dotIdx = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotIdx);	// .png
	
	UUID uuid = UUID.randomUUID();
	String filename = uuid.toString().replace("-", "");
	filename = filename + ext;
	
	System.out.println("category: " + category);
	System.out.println("emp_id: " + empId);
	System.out.println("goods_pw: " + goods_pw);
	System.out.println("goodTitle: " + goods_title);
	System.out.println("filename : " + filename);
	System.out.println("goods_price: " + goods_price);
	System.out.println("goods_amount: " + goods_amount);
	System.out.println("goods_content: " + goods_content);
	
/* 	String sql1 = "insert into goods(category, emp_id, goods_pw, goods_title, filename, goods_price, goods_amount, goods_content, update_date, create_date) values(?, ?, password(?), ?, ?, ?, ?, ?, NOW(), NOW())"; 
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt1 = null;
	stmt1 = conn.prepareStatement(sql1);  
	
	stmt1.setString(1, category);
	stmt1.setString(2, empId);
	stmt1.setString(3, goods_pw);
	stmt1.setString(4, goods_title);
	stmt1.setString(5, filename);
	stmt1.setInt(6, goods_price);
	stmt1.setInt(7, goods_amount);
	stmt1.setString(8, goods_content); 
	
	int row = 0;
	row = stmt1.executeUpdate(); 
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
	}  */
	
/* 		File df = new File(filePath, rs.getString("filename"));
		df.delete();
	 */
	
	int AG = GoodsDAO.addGoods(category, empId, goods_title, filename, goods_content, goods_price, goods_amount, goods_pw);
	
	if(AG == 1){
		InputStream is = part.getInputStream();
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, filename);	// 빈파일	
		OutputStream os = Files.newOutputStream(f.toPath());	// os + file
		is.transferTo(os);
		
		os.close();
		is.close();
		System.out.println("입력 성공");
		
	}else{
		System.out.println("입력 실패");
	}
		response.sendRedirect("/shop/emp/goodsList.jsp"); 
%>

<!-- controller layer -->
<%-- <%	
	if(row == 1){
		System.out.println("입력 성공");
	}else{
		System.out.println("입력 실패");
	}
	response.sendRedirect("/shop/emp/goodsList.jsp");
%>  --%>
