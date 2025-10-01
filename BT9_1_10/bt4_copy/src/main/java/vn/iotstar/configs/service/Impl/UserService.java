package vn.iotstar.configs.service.Impl;

import java.util.List;

import vn.iotstar.configs.dao.IUserDao;
import vn.iotstar.configs.dao.implement.UserDaoImpl;
import vn.iotstar.configs.model.UserModel;
import vn.iotstar.configs.service.IUserService;

public class UserService implements IUserService {
	IUserDao userDao = new UserDaoImpl();
	
	@Override
	public UserModel login(String username, String password) {
		UserModel user = this.FindByUsername(username);
		if (user != null && password.equals(user.getPassWord())) {
			return user;
		}
		return null;
	}

	@Override
	public UserModel FindByUsername(String username) {
		// Check if there's a direct method in DAO first
		UserModel user = userDao.findByUsername(username);
		if (user != null) {
			return user;
		}
		// Fallback to searching through all users
		List<UserModel> users = userDao.findAll();
		for (UserModel u : users) {
			if (username.equals(u.getUserName())) {
				return u;
			}
		}
		return null;
	}

	@Override
	public boolean register(String username, String password, String email, String fullname, String phone) {
		if (checkExistEmail(email) || checkExistUsername(username) || checkExistPhone(phone)) {
			return false;
		}
		UserModel user = new UserModel();
		user.setUserName(username);
		user.setPassWord(password);
		user.setEmail(email);
		user.setFullName(fullname);
		user.setPhone(phone);
		user.setAvatar(null); // hoặc set avatar mặc định nếu có
		user.setRoleid(1); // 1: user thông thường, tuỳ hệ thống
		user.setCreatedDate(new java.sql.Date(System.currentTimeMillis()));
		try {
			userDao.insert(user);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean checkExistEmail(String email) {
		return userDao.checkExistEmail(email);
	}

	@Override
	public boolean checkExistUsername(String username) {
		return userDao.checkExistUsername(username);
	}

	@Override
	public boolean checkExistPhone(String phone) {
		return userDao.checkExistPhone(phone);
	}

	@Override
	public void insert(UserModel user) {
		userDao.insert(user);
	}
}