package nguyen01.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import nguyen01.configs.DBConnectSQL;
import nguyen01.dao.IUserDao;
import nguyen01.models.UserModel;

public class UserDaoImpl extends DBConnectSQL implements IUserDao {
	public Connection conn = null;
	public PreparedStatement ps = null;
	public ResultSet rs = null;
	@Override
	public List<UserModel> findAll() {
		List<UserModel> list = new ArrayList<>();
	    String sql = "SELECT * FROM Users";
	    try {
	        conn = super.getConnection();
	        ps = conn.prepareStatement(sql);
	        rs = ps.executeQuery();
	        while (rs.next()) {
	            list.add(new UserModel(
	                rs.getInt("id"),
	                rs.getString("username"),
	                rs.getString("password"),
	                rs.getString("images"),
	                rs.getString("fullname"),
	                rs.getString("email"),
	                rs.getString("phone"),
	                rs.getInt("roleid"),
	                rs.getDate("createDate")
	            ));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
		
		
	}

	@Override
	public UserModel findById(int id) {
		String sql = "SELECT * FROM Users WHERE id = ?";
	    try {
	        conn = super.getConnection();
	        ps = conn.prepareStatement(sql);
	        ps.setInt(1, id);
	        rs = ps.executeQuery();
	        if (rs.next()) {
	            return new UserModel(
	                rs.getInt("id"),
	                rs.getString("username"),
	                rs.getString("password"),
	                rs.getString("images"),
	                rs.getString("fullname"),
	                rs.getString("email"),
	                rs.getString("phone"),
	                rs.getInt("roleid"),
	                rs.getDate("createDate")
	            );
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	

	@Override
	public void insert(UserModel user) {
		String sql = "INSERT INTO Users (email, username, fullname, password, avatar, roleid,phone,createddate) VALUES (?,?,?,?,?,?,?,?)";
				try {
				conn = new DBConnectSQL().getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, user.getEmail());
				ps.setString(2, user.getUsername());
				ps.setString(3, user.getFullname());
				ps.setString(4, user.getPassword());
				ps.setString(5, user.getImages());
				ps.setInt(6,user.getRoleid());
				ps.setString(7,user.getPhone());
				ps.setDate(8, user.getCreateDate());
				ps.executeUpdate();
				} catch (Exception e) {e.printStackTrace();
				}
				
	}

	

	@Override
	public UserModel findByUserName(String username) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM Users WHERE username = ? ";
		try {
		conn = new DBConnectSQL().getConnection();
		ps = conn.prepareStatement(sql);
		ps.setString(1, username);
		rs = ps.executeQuery();
		while (rs.next()) {
		UserModel user = new UserModel();
		user.setId(rs.getInt("id"));
		user.setEmail(rs.getString("email"));
		user.setUsername(rs.getString("username"));
		user.setFullname(rs.getString("fullname"));
		user.setPassword(rs.getString("password"));
		user.setImages(rs.getString("avatar"));
		user.setRoleid(Integer.parseInt(rs.getString("roleid")));
		user.setPhone(rs.getString("phone"));
		user.setCreateDate(rs.getDate("createdDate"));
		return user;}
		} catch 
		(Exception e) 
		{
			e.printStackTrace();
		}
		
		
		return null;
		
		
	}
	public static void main(String[] args) {
	    UserDaoImpl userDao = new UserDaoImpl();
	    List<UserModel> list = userDao.findAll();

	    for (UserModel user : list) {
	        System.out.println(user);
	    }
	}


 
}
