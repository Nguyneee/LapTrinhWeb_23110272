package nguyen01.models.services.impl;

import nguyen01.dao.IUserDao;
import nguyen01.dao.impl.UserDaoImpl;
import nguyen01.models.UserModel;
import nguyen01.models.services.IUserSevice;

public class UserService implements IUserSevice {
	IUserDao userDao = new UserDaoImpl();
	@Override
	public UserModel login(String username, String password) {
		UserModel user = this.FindByUserName(username);
		if (user != null && password.equals(user.getPassword())) {
		return user;
		}
		return null;
	}

	@Override
	public UserModel FindByUserName(String username) {
		// TODO Auto-generated method stub
		return userDao.findByUserName(username);
	}

}
