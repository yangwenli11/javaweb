package dbutil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Dbconn {
	
	private Connection conn;
	public  Connection getConnection() throws SQLException{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase?useSSL=false&characterEncoding=UTF-8", "root","123456");
		} catch (ClassNotFoundException e) {
			System.out.println("获取数据库连接失败");
			e.printStackTrace();
		}
		return conn;
	}
	
	public void closeAll(Connection conn,Statement stat,ResultSet rs){
		if(rs!=null){
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				if(stat!=null){
					try {
						stat.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}finally{
						if(conn!=null){
							try {
								conn.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
						}
					}
				}
			}
		}
	}
	
}
