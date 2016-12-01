package com.cyq7on.base;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
	@Test
	public void queryTest() {
		query();
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
	/**
	 * 使用PreparedStatement，防止sql注入
	 * @return
	 */
	private void query() {
		String sql = "select * from student where name=?";
		String url = "jdbc:mysql://localhost:3306/mydb";
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(url, "root", "amm");
			statement = connection.prepareStatement(sql);
			statement.setString(1, "白子画");
			resultSet = statement.executeQuery();
			while (resultSet.next()) {
				System.out.println(resultSet.getInt("stuid"));
				System.out.println(resultSet.getString("name"));
				System.out.println(resultSet.getString("sex"));
				System.out.println("-------------------------");
			}
		} catch (Exception e) {
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
			if (resultSet != null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
}
