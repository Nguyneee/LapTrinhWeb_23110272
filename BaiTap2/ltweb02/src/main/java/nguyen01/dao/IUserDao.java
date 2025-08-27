package nguyen01.dao;

import java.util.List;

import nguyen01.models.UserModel;
public interface IUserDao {
	List<UserModel> findAll();
	
	UserModel findById(int id);
	void insert(UserModel user);
	UserModel findByUserName(String username);
	
}
