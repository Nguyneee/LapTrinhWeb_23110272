package vn.iotstar.configs.dao.implement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import vn.iotstar.configs.DBConnect;
import vn.iotstar.configs.dao.IUserDao;
import vn.iotstar.configs.model.UserModel;

public class UserDaoImpl extends DBConnect implements IUserDao{
	
	@Override
	public List<UserModel> findAll() {
		List<UserModel> users = new ArrayList<>();
		String sql = "SELECT * FROM Users";
		
		try (Connection conn = getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql);
			 ResultSet rs = stmt.executeQuery()) {
			
			while (rs.next()) {
				UserModel user = new UserModel();
				user.setId(rs.getInt("id"));
				user.setUserName(rs.getString("username"));
				user.setEmail(rs.getString("email"));
				user.setPassWord(rs.getString("password"));
				user.setFullName(rs.getString("fullname"));
				user.setAvatar(rs.getString("avatar"));
				user.setRoleid(rs.getInt("roleid"));
				user.setPhone(rs.getString("phone"));
				user.setCreatedDate(rs.getDate("createDate"));
				users.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return users;
	}

	@Override
	public UserModel findById(int id) {
		UserModel user = null;
		String sql = "SELECT * FROM Users WHERE id = ?";
		
		try (Connection conn = getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			
			if (rs.next()) {
				user = new UserModel();
				user.setId(rs.getInt("id"));
				user.setUserName(rs.getString("username"));
				user.setEmail(rs.getString("email"));
				user.setPassWord(rs.getString("password"));
				user.setFullName(rs.getString("fullname"));
				user.setAvatar(rs.getString("avatar"));
				user.setRoleid(rs.getInt("roleid"));
				user.setPhone(rs.getString("phone"));
				user.setCreatedDate(rs.getDate("createDate"));
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}

	@Override
	public UserModel findByUsername(String username) {
		UserModel user = null;
		String sql = "SELECT * FROM Users WHERE username = ?";
		
		try (Connection conn = getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			
			if (rs.next()) {
				user = new UserModel();
				user.setId(rs.getInt("id"));
				user.setUserName(rs.getString("username"));
				user.setEmail(rs.getString("email"));
				user.setPassWord(rs.getString("password"));
				user.setFullName(rs.getString("fullname"));
				user.setAvatar(rs.getString("avatar"));
				user.setRoleid(rs.getInt("roleid"));
				user.setPhone(rs.getString("phone"));
				user.setCreatedDate(rs.getDate("createDate"));
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}

	@Override
	public void insert(UserModel user) {
		String sql = "INSERT INTO Users (username, email, password, fullname, avatar, roleid, phone, createDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try (Connection conn = getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, user.getUserName());
			stmt.setString(2, user.getEmail());
			stmt.setString(3, user.getPassWord());
			stmt.setString(4, user.getFullName());
			stmt.setString(5, user.getAvatar());
			stmt.setInt(6, user.getRoleid());
			stmt.setString(7, user.getPhone());
			stmt.setDate(8, user.getCreatedDate());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean checkExistEmail(String email) {
		boolean duplicate = false;
		String query = "SELECT * FROM Users WHERE email = ?";
		try (Connection conn = getConnection();
			 PreparedStatement ps = conn.prepareStatement(query)) {
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				duplicate = true;
			}
			rs.close();
		} catch (Exception ex) {}
		return duplicate;
	}

	@Override
	public boolean checkExistUsername(String username) {
		boolean duplicate = false;
		String query = "SELECT * FROM Users WHERE username = ?";
		try (Connection conn = getConnection();
			 PreparedStatement ps = conn.prepareStatement(query)) {
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				duplicate = true;
			}
			rs.close();
		} catch (Exception ex) {}
		return duplicate;
	}

	@Override
	public boolean checkExistPhone(String phone) {
		boolean duplicate = false;
		String query = "SELECT * FROM Users WHERE phone = ?";
		try (Connection conn = getConnection();
			 PreparedStatement ps = conn.prepareStatement(query)) {
			ps.setString(1, phone);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				duplicate = true;
			}
			rs.close();
		} catch (Exception ex) {}
		return duplicate;
	}


	@Override
	public void update(UserModel user) {
		String sql = "UPDATE Users SET username = ?, email = ?, password = ?, fullname = ?, avatar = ?, roleid = ?, phone = ?, createDate = ? WHERE id = ?";
		
		try (Connection conn = getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			
			stmt.setString(1, user.getUserName());
			stmt.setString(2, user.getEmail());
			stmt.setString(3, user.getPassWord());
			stmt.setString(4, user.getFullName());
			stmt.setString(5, user.getAvatar());
			stmt.setInt(6, user.getRoleid());
			stmt.setString(7, user.getPhone());
			stmt.setDate(8, user.getCreatedDate());
			stmt.setInt(9, user.getId());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public UserModel findByEmail(String email) {
		UserModel user = null;
	    String sql = "SELECT * FROM Users WHERE email = ?";
	    try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, email);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            user = new UserModel();
	            user.setId(rs.getInt("id"));
	            user.setUserName(rs.getString("username"));
	            user.setEmail(rs.getString("email"));
	            user.setPassWord(rs.getString("password"));
	            user.setFullName(rs.getString("fullname"));
	            user.setAvatar(rs.getString("avatar"));
	            user.setRoleid(rs.getInt("roleid"));
	            user.setPhone(rs.getString("phone"));
	            user.setCreatedDate(rs.getDate("createDate"));
	        }
	        rs.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return user;
	}
	
}