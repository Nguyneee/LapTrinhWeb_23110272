package vn.iotstar.configs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConnect {
	private final String serverName = "localhost";
	private final String dbName = "LTWEB01";
	private final String portNumber = "1433";
	private final String instance = ""; // "SQLEXPRESS" nếu có
	private final String userID = "sa";
	private final String password = "1";

	public Connection getConnection() throws Exception {
		String url;
		if (instance == null || instance.trim().isEmpty()) {
			url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName=" + dbName
					+ ";encrypt=false;trustServerCertificate=true";
		} else {
			url = "jdbc:sqlserver://" + serverName + "\\" + instance + ":" + portNumber + ";databaseName=" + dbName
					+ ";encrypt=false;trustServerCertificate=true";
		}

		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		return DriverManager.getConnection(url, userID, password);
	}

	public static void main(String[] args) {
		String sqlInsert = "INSERT INTO Users (username, email, password, fullname, images) VALUES (?, ?, ?, ?, ?)";
		String selectAll = "SELECT * FROM Users";

		try (Connection conn = new DBConnect().getConnection()) {

			// Insert dữ liệu
			PreparedStatement stmt = conn.prepareStatement(sqlInsert);
			stmt.setString(1, "nguyen");
			stmt.setString(2, "n@gmail.com");
			stmt.setString(3, "123");
			stmt.setString(4, "Hoang Nguyen");
			stmt.setString(5, null);
			stmt.executeUpdate();
			stmt.close();

			// Lấy tất cả dữ liệu
			stmt = conn.prepareStatement(selectAll);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				System.out.println(rs.getInt("id") + " - " + rs.getString("username") + " - " + rs.getString("email")
						+ " - " + rs.getString("fullname"));
			}
			rs.close();
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
