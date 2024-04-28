package shop.dao;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.sql.Connection;

// emp 테이블을 CRUD 하는 STATIC 메서드의 컨테이너
public class EmpDAO {
	
	// 로그인
	// HashMap<String, object> = null 로그인 실패, 아니면 성공
	// 사용자가 입력하는 값 empId, empPw
	public static HashMap<String, Object> empLogin(String empId, String empPw) throws Exception{
		int row = 0;
		HashMap<String, Object> resultMap = null;
		
		// DB 코드
		Class.forName("org.mariadb.jdbc.Driver");
		java.sql.Connection conn1 = null;
		conn1 = DBHelper.getConnection();
		
		
		String sql1 = "select emp_id empId, emp_name empName, grade from emp where active='ON' and emp_id=? and emp_pw= password(?)";
		PreparedStatement  stmt1 = conn1.prepareStatement(sql1);
		ResultSet rs1 = null;
		stmt1.setString(1, empId);
		stmt1.setString(2, empPw);
		rs1 = stmt1.executeQuery();
		if(rs1.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("empId", rs1.getString("empId"));
			resultMap.put("empName", rs1.getString("empName"));
			resultMap.put("grade", rs1.getInt("grade"));	
		}
		conn1.close();
		return resultMap;
	}
	
	public static int addEmp(String empId, int grade,
			String emp_name,  String empPw, String emp_job, String hire_date, String active) throws Exception{
		
		int row2 = 0;
		Connection conn2 = null;
		conn2 = DBHelper.getConnection();
		System.out.println("emp_id:" + empId);
		System.out.println("grade:" + grade);
		System.out.println("emp_name:" + emp_name);
		System.out.println("empPw:" + empPw);
		System.out.println("emp_job:" + emp_job);
		System.out.println("emp_id:" + hire_date);
		System.out.println("emp_id:" + active);
		
		String sql2 = "insert into emp(emp_id, grade, emp_name, emp_pw, emp_job, hire_date, active) values(?, ?, ?, password(?), ?, ?, ?)";
		PreparedStatement stmt2 = conn2.prepareStatement(sql2);
		stmt2.setString(1, empId);
		stmt2.setInt(2, grade);
		stmt2.setString(3, emp_name);
		stmt2.setString(4, empPw);
		stmt2.setString(5, emp_job);
		stmt2.setString(6, hire_date);
		stmt2.setString(7, active);
		
		row2 = stmt2.executeUpdate();
		
		conn2.close();
		return row2;
		
	}
	
	 public static int deleteEmp(String emp_id, String emp_pw) throws Exception{
		 
		int row3 = 0;
		Connection conn3 = null;
		conn3 = DBHelper.getConnection();
		System.out.println("emp_id: " + emp_id);
		System.out.println("emp_pw: " + emp_pw);
		 
		String sql3 = "delete from emp where emp_id =? and emp_pw=password(?)";
		 
		PreparedStatement stmt3 = conn3.prepareStatement(sql3);
		stmt3.setString(1, emp_id);
		stmt3.setString(2, emp_pw);
		
		row3 = stmt3.executeUpdate();
		
		conn3.close();
		return row3;
	 }
	 
	 public static int updateEmp(String emp_id, int grade, String emp_pw, String emp_name, String emp_job, String hire_date) throws Exception{
		int row4 = 0;
		
		Connection conn4 = null;
		conn4 = DBHelper.getConnection();
		
		System.out.println("emp_id: " + emp_id);
		System.out.println("grade: " + grade);
		System.out.println("emp_pw: " + emp_pw);
		System.out.println("emp_name: " + emp_name);
		System.out.println("emp_job: " + emp_job);
		System.out.println("hire_date: " + hire_date);
		
		String sql4 = "update emp set grade =?, emp_pw =?, emp_name=?, emp_job=?, hire_date=? where emp_id=?";
		
		PreparedStatement stmt4 = null;
		stmt4 = conn4.prepareStatement(sql4);
		stmt4.setInt(1, grade);
		stmt4.setString(2, emp_pw);
		stmt4.setString(3, emp_name);
		stmt4.setString(4, emp_job);
		stmt4.setString(5, hire_date);
		stmt4.setString(6, emp_id);
		
		conn4.close();
		return row4;
	 }
	 
	public static ArrayList<HashMap<String, Object>> selectedCustomerList(String email, String name) throws Exception{
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		Connection conn5 = DBHelper.getConnection();
		String sql5 = "SELECT email, name from customer order by email";
		
		PreparedStatement stmt5 = null;
		stmt5 = conn5.prepareStatement(sql5);
		ResultSet rs5 = stmt5.executeQuery();
		
		while(rs5.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("email", rs5.getString("email"));
			m.put("name", rs5.getString("name"));
			list.add(m);

		}
		
		conn5.close();
		return list;

	}
	//empOne 정보보기
	public static ArrayList<HashMap<String, Object>> empOne(String empId, String emp_name, int grade)throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		String sql2 = "SELECT emp_id empId, emp_name, emp_job, hire_date, active FROM emp WHERE emp_id = ? AND emp_name = ? AND grade = ?";
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null; 
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, empId);
		stmt2.setString(2, emp_name);
		stmt2.setInt(3, grade);
		
		rs2 = stmt2.executeQuery();
		
		ArrayList<HashMap<String, Object>> empList = new ArrayList<HashMap<String, Object>>();
		
		while(rs2.next()){
			HashMap<String, Object> list = new HashMap<String, Object>();
			list.put("empId", rs2.getString("empid"));
			list.put("emp_name", rs2.getString("emp_name"));
			list.put("emp_job", rs2.getString("emp_job"));
			list.put("hire_date", rs2.getString("hire_date"));
			list.put("active", rs2.getString("active"));
			empList.add(list);
		}
		
		conn.close();
		return empList;
	}
	
	
}
