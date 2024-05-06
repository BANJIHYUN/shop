package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class commentDAO {
	public static ArrayList<HashMap<String,Object>> addcomment (int goods_no)throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection con = DBHelper.getConnection();
		String sql = "SELECT o.orders_no ordersNo,o.mail mail, "
				+ "c.score, c.content, c.create_date createDate FROM orders o INNER JOIN comment c "
				+ "ON o.orders_no = c.orders_no WHERE o.goods_no = ? ORDER BY o.orders_no DESC;";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1,goods_no);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			
			m.put("goods_no",rs.getInt("goods_no"));
			m.put("mail", rs.getString("mail"));
			m.put("score", rs.getInt("score"));
			m.put("content", rs.getString("content"));
			m.put("createDate", rs.getString("createDate"));
			
			list.add(m);
		}
		
		con.close();
		return list;
	}

}
