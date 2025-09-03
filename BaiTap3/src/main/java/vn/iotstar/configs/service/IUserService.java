package vn.iotstar.configs.service;

import vn.iotstar.configs.model.UserModel;

public interface IUserService {
	UserModel login(String username, String password);
	UserModel FindByUsername(String username);
	boolean register(String username, String password, String email, String fullname, String phone);
	boolean checkExistEmail(String email);
	boolean checkExistUsername(String username);
	boolean checkExistPhone(String phone);
	void insert(UserModel user);
}