package vn.iotstar.configs.service;

import java.util.List;
import vn.iotstar.configs.model.CategoryModel;

public interface ICategoryService {
    void insert(CategoryModel category);
    void edit(CategoryModel category);
    void delete(int id);
    CategoryModel get(int id);
    List<CategoryModel> getAll();
    List<CategoryModel> findAll();
}
