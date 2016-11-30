package com.cyq7on.base;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.Test;

import com.mysql.jdbc.Driver;

public class CRUDTest {
	@Test
	public void insert() {
		update("INSERT INTO student VALUES(5,'白子画','男')");
	}
	@Test
	public void delete() {
		update("delete from student where stuid=5");
	}
	@Test
	public void update() {
		update("update student set name = '花千骨 from java' where name = '花千骨'");
	}
	
	private int update(String sql) {
		int rows = 0;
		String url = "jdbc:mysql://localhost:3306/mydb";
		Connection connection = null;
		Statement statement = null;
		try {
			DriverManager.registerDriver(new Driver());
			connection = DriverManager.getConnection(url, "root", "amm");
			statement = connection.createStatement();
			rows = statement.executeUpdate(sql);
			System.out.println(String.format("%d行受影响", rows));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return rows;
	}
}
