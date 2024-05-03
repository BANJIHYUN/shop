package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class OrdersDAO {

	public static int addOrders(int goods_no, String mail, String name, String address, int total_amount, int total_price, int state) throws Exception{
		int row1 = 0;
		Connection conn1 = null;
		conn1 = DBHelper.getConnection();
		
		String sql1 = "inset into orders(goods_no, mail, name, address, total_amount, total_price, state) values(?, ?, ?, ?, ?, ?, '주문완료')";
		PreparedStatement stmt1 = null;
		stmt1 = conn1.prepareStatement(sql1);
		stmt1.setInt(1, goods_no);
		stmt1.setString(2, mail);
		stmt1.setString(3, name);
		stmt1.setString(4, address);
		stmt1.setInt(5, total_amount);
		stmt1.setInt(6, total_price);
		
		
		row1 = stmt1.executeUpdate();
		
		conn1.close();

		return row1;
	}

}
