package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class CategoryDAO{
	
	public static int addCategory(String category, String category_pw) throws Exception {
		int row1 = 0;
		
		Connection conn1 = null;
		conn1 = DBHelper.getConnection();
		
		String sql1 = "insert into category(category, category_pw) values(?, password(?))";
		PreparedStatement stmt1 = null;
		stmt1 = conn1.prepareStatement(sql1);
		stmt1.setString(1, category);
		stmt1.setString(2, category_pw);
		row1 = stmt1.executeUpdate();
			
		conn1.close();
		return row1;	
	}
	
	public static int deleteCategory(String category) throws Exception {
		int row2 = 0;
		
		Connection conn2 = null;
		conn2 = DBHelper.getConnection();
		
		String sql2 = "delete from category where category = ?";
		PreparedStatement stmt2 = null;
		stmt2 = conn2.prepareStatement(sql2);
		stmt2.setString(1, category);
		row2 = stmt2.executeUpdate();
		
		conn2.close();
		return row2;
	}
	
	public static int updateCategory(String category, String category_pw) throws Exception {
		int row3 = 0;
		Connection conn3 = null;
		conn3 = DBHelper.getConnection();
		
		String sql3 = "update category set create_date =now(), category_pw=? where category =?";
		PreparedStatement stmt3 = null;
		stmt3 = conn3.prepareStatement(sql3);
		stmt3.setString(1, category_pw);
		stmt3.setString(2, category);
		
		row3 = stmt3.executeUpdate();
		
		conn3.close();
		return row3;
	}
}
