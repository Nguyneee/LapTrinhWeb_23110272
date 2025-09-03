package vn.iotstar.configs.dao;

import java.util.List;
import vn.iotstar.configs.model.CategoryModel;

public interface ICategoryDao {
	 List<CategoryModel> findAll();
	    CategoryModel findById(int id);
	    void insert(CategoryModel category);
	    void update(CategoryModel category);
	    void delete(int id);
}