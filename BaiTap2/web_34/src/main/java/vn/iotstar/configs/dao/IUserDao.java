package vn.iotstar.configs.dao;

import java.util.List;

import vn.iotstar.configs.model.UserModel;

public interface IUserDao {
    List<UserModel> findAll();
    UserModel findById(int id);
    UserModel findByUsername(String username); // <- tên chuẩn
    void insert(UserModel user);
    void update(UserModel user);
    
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
}

