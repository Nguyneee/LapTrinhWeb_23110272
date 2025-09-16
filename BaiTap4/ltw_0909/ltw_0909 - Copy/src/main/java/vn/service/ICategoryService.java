package vn.service;

import java.util.List;

import vn.entity.Category;

public interface ICategoryService {
    void insert(Category category);
    void update(Category category);
    void delete(int id) throws Exception;
    Category findById(int id);
    List<Category> findAll();
    List<Category> findByName(String name);
    List<Category> findAll(int page, int pageSize);
    int count();
}
