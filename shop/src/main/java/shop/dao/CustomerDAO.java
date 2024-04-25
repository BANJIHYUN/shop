package shop.dao;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.sql.Connection;

public class CustomerDAO {
	public static int addCustomer(String user_id, String user_pw, String user_name, String user_birth, String user_gender) throws Exception{
		
		int row1 = 0;
		Connection conn1 = null;
		conn1 = DBHelper.getConnection();
		
		String sql1 = "insert into customer(email, pw, name, birth, gender, update_date, create_date) values(?, password(?), ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt1 = null;
		stmt1 = conn1.prepareStatement(sql1);
		stmt1.setString(1, user_id);
		stmt1.setString(2, user_pw);
		stmt1.setString(3, user_name);
		stmt1.setString(4, user_birth);
		stmt1.setString(5, user_gender);
		row1 = stmt1.executeUpdate();
			
		conn1.close();
		return row1;	
	}
	
	public static boolean customerCheckId(String checkId) throws Exception {
		boolean result = false;
		
		Connection conn2 = null;
		conn2 = DBHelper.getConnection();
		
		String sql2 = "select email from customer where email=?";
		PreparedStatement stmt2 = null;
		stmt2 = conn2.prepareStatement(sql2);
		stmt2.setString(1, checkId);
		ResultSet rs2 = stmt2.executeQuery();
		if(!rs2.next()) { // 사용불가
			result = true;
		}
		
		conn2.close();
		return result;
	}
	
	public static int deleteCustomer(String email) throws Exception {
		int row3 = 0;
		
		Connection conn3 = null;
		conn3 = DBHelper.getConnection();
		
		String sql3 = "delete from customer where email =?";
		PreparedStatement stmt3 = null;
		stmt3 = conn3.prepareStatement(sql3);
		stmt3.setString(1, email);
		row3 = stmt3.executeUpdate();
		
		conn3.close();
		return row3;
	}
	
	public static HashMap<String, String> login(String email, String pw) throws Exception {
		HashMap<String, String> map = null;
		
		Connection conn4 = null;
		conn4 = DBHelper.getConnection();
		String sql4 = "select email, pw from customer where email=? and pw= password(?)";
		PreparedStatement stmt4 = null;
		stmt4 = conn4.prepareStatement(sql4);
		stmt4.setString(1, email);
		stmt4.setString(2, pw);
		
		ResultSet rs4 = stmt4.executeQuery();
		if(rs4.next()) {
			map = new HashMap<String, String>();
			map.put("email", rs4.getString("email"));
			map.put("pw", rs4.getString("pw"));
		}
		
		return map;
	}
	
	public static int modifyCustomer(String email, String user_pw, String user_name, String user_birth, String user_gender) throws Exception{
		int row5 = 0;
		
		Connection conn5 = null;
		conn5 = DBHelper.getConnection();
		String sql5 = "update customer set pw=?, name=?, birth=?, gender=?, update_date=NOW(), create_date=NOW() where email=? "; 
		PreparedStatement stmt5 = null;
		stmt5 = conn5.prepareStatement(sql5);
		stmt5.setString(1, user_pw);
		stmt5.setString(2, user_name);
		stmt5.setString(3, user_birth);
		stmt5.setString(4, user_gender);
		stmt5.setString(5, email);
		
		row5 =stmt5.executeUpdate();
		
		conn5.close();
		return row5;
	}
	
	/*
	 * public static ArrayList<HashMap<String, Object>> customerGoodsList(int
	 * goods_no, String category, String goods_title, String filename, String
	 * goods_content, String goods_price, String goods_amount) throws Exception{
	 * ArrayList<HashMap<String, Object>> list = new ArrayList<>(); Connection conn6
	 * = DBHelper.getConnection(); String sql6 =
	 * "select goods_no, category, goods_title, filename, goods_content, goods_price, goods_amount, update_date from goods order by goods_no desc"
	 * ; PreparedStatement stmt6 = null; stmt6 = conn6.prepareStatement(sql6);
	 * 
	 * ResultSet rs6 = stmt6.executeQuery();
	 * 
	 * while(rs6.next()) { HashMap<String, Object> m = new HashMap<String,
	 * Object>(); m.put("goods_no", rs6.getInt("goods_no")); m.put("category",
	 * rs6.getString("category")); m.put("emp_id", rs6.getString("emp_id"));
	 * m.put("goods_title", rs6.getString("goods_title")); m.put("filename",
	 * rs6.getString("filename")); m.put("goods_content",
	 * rs6.getString("goods_content")); m.put("goods_price",
	 * rs6.getString("goods_price")); m.put("goods_amount",
	 * rs6.getString("goods_amount")); list.add(m);
	 * 
	 * }
	 * 
	 * conn6.close(); return list; }
	 * 
	 * public static ArrayList<HashMap<String, Object>> customerCategoryList(int
	 * goods_no, String category, String goods_title, String filename, String
	 * goods_content, String goods_price, String goods_amount) throws Exception{
	 * ArrayList<HashMap<String, Object>> list7 = new ArrayList<>(); Connection
	 * conn7 = DBHelper.getConnection(); String sql7 =
	 * "select goods_no, category, goods_title, filename, goods_content, goods_price, goods_amount, update_date from goods where category = ? order by goods_no desc limit ?, ?"
	 * ; PreparedStatement stmt7 = null; stmt7 = conn7.prepareStatement(sql7);
	 * ResultSet rs7 = stmt7.executeQuery(); while(rs7.next()) { HashMap<String,
	 * Object> m7 = new HashMap<String, Object>(); m7.put("goods_no",
	 * rs7.getInt("goods_no")); m7.put("category", rs7.getString("category"));
	 * m7.put("emp_id", rs7.getString("emp_id")); m7.put("goods_title",
	 * rs7.getString("goods_title")); m7.put("filename", rs7.getString("filename"));
	 * m7.put("goods_content", rs7.getString("goods_content"));
	 * m7.put("goods_price", rs7.getString("goods_price")); m7.put("goods_amount",
	 * rs7.getString("goods_amount")); list7.add(m7);
	 * 
	 * } conn7.close(); return list7; }
	 */
}
