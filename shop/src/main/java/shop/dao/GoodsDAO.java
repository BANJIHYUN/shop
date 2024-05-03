package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class GoodsDAO {
	public static ArrayList<HashMap<String, Object>> selectGoodsList(
		int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT *"
				+ "FROM goods"
				+ "order by goods_no desc"
				+ "limit ? , ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
				
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("goods_no", rs.getString("goods_no"));
			m.put("category", rs.getString("category"));
			m.put("emp_id", rs.getString("emp_id"));
			m.put("goods_title", rs.getString("goods_title"));
			m.put("filename", rs.getString("filename"));
			m.put("goods_content", rs.getString("goods_content"));
			m.put("goods_price", rs.getString("goods_price"));
			m.put("goods_amount", rs.getString("goods_amount"));
			m.put("update_date", rs.getString("update_date"));
			
			list.add(m);
		}
		conn.close();
		return list;
	}
	public static ArrayList<HashMap<String, Object>> selectGoodsList1
		(int currentPage, int rowPerPage) throws Exception {
			ArrayList<HashMap<String, Object>> list1 = new ArrayList<HashMap<String, Object>>();

			Connection conn = DBHelper.getConnection();
			String sql = "SELECT category, count(*) cnt "
					+ "FROM goods group by category order by category ASC ";
			PreparedStatement stmt1 = conn.prepareStatement(sql);
			ResultSet rs1 = null;
			rs1 = stmt1.executeQuery();
			System.out.println(stmt1);
			while(rs1.next()){
				HashMap<String, Object> m1 = new HashMap<String, Object>();
				m1.put("category", rs1.getString("category"));
				m1.put("cnt", rs1.getInt("cnt"));
				list1.add(m1);
			}
			return list1;
	}
	public static int addGoods(String category, String emp_id, String goods_title, String filename, 
			String goods_content, int goods_price, int goods_amount, String goods_pw) throws Exception{
		int row1 = 0;
		Connection conn1 = null;
		conn1 = DBHelper.getConnection();
		
		System.out.println("category: " + category);
		System.out.println("emp_id: " + emp_id);
		System.out.println("goods_title: " + goods_title);
		System.out.println("filename" + filename);
		System.out.println("goods_content: " + goods_content);
		System.out.println("goods_price: " + goods_price);
		System.out.println("goods_amount: " + goods_amount);
		System.out.println("goods_pw: " + goods_pw);
		
		String sql1 = "insert into goods(category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, goods_pw) values(?, ?, ?, ?, ?, ?, ?, password(?))"; 
		
		PreparedStatement stmt1 = null;
		stmt1 = conn1.prepareStatement(sql1);
		stmt1.setString(1, category);
		stmt1.setString(2, emp_id);
		stmt1.setString(3, goods_title);
		stmt1.setString(4, filename);
		stmt1.setString(5, goods_content);
		stmt1.setInt(6, goods_price);
		stmt1.setInt(7, goods_amount);
		stmt1.setString(8, goods_pw);
		
		row1 = stmt1.executeUpdate();
		
		conn1.close();
		return row1;
		
	}
	
	public static int updateGoods(int goods_no, String category, String goods_title, String filename, int goods_price, int goods_amount, String goods_content, String emp_id) throws Exception{
		int row2 = 0;
		
		Connection conn2 = null;
		conn2 = DBHelper.getConnection();
	
		System.out.println("goods_no : " + goods_no);
		System.out.println("category: " + category);
		System.out.println("goods_title: " + goods_title);
		System.out.println("filename: " + filename);
		System.out.println("goods_price: " + goods_price);
		System.out.println("goods_amount: " + goods_amount);
		System.out.println("goods_content: " + goods_content);
		System.out.println("emp_id: " + emp_id);

		String sql2 = "update goods set category=?, goods_title= ?, filename=?, goods_price=?, goods_amount=?, goods_content=?, emp_id=?, update_date=NOW() where goods_no=?";
		PreparedStatement stmt2 = null;
		stmt2 = conn2.prepareStatement(sql2);
		stmt2.setString(1, category);
		stmt2.setString(2, goods_title);
		stmt2.setString(3, filename);
		stmt2.setInt(4, goods_price);
		stmt2.setInt(5, goods_amount);
		stmt2.setString(6, goods_content);
		stmt2.setString(7, emp_id);
		stmt2.setInt(8, goods_no);

		
		row2 = stmt2.executeUpdate();
		
		return row2;
	}
	
	  public static int deleteGoods(int goods_no) throws Exception {
		  int row3 = 0;
		  
		  Connection conn3 = null;
		  conn3 = DBHelper.getConnection();
		  
		  System.out.println("goods_no: " + goods_no);
		  
		  String sql3 = "delete from goods where goods_no = ?";
		  PreparedStatement stmt3 = null;
		  stmt3 = conn3.prepareStatement(sql3);
		  stmt3.setInt(1, goods_no);
		  
		  row3 = stmt3.executeUpdate();
		  
		return row3;
	  }
	 
		public static int updateGoodsAmount(int total_amount, int goods_no) throws Exception{
			int row4 = 0;
			String sql4 = "update goods set goods_amount = goods_amount - ? where goods_no =?";
			
			Connection conn4 = DBHelper.getConnection();
			PreparedStatement stmt4 = null;
			stmt4 = conn4.prepareStatement(sql4);
			stmt4.setInt(1, total_amount);
			stmt4.setInt(2, goods_no);
			row4 = stmt4.executeUpdate();
			
			return row4;
		}
	
}
