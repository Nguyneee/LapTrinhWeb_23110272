package nguyen01.models.services;

import nguyen01.models.UserModel;

public interface IUserSevice {
	UserModel login(String username, String password);
	UserModel FindByUserName(String username);
}
