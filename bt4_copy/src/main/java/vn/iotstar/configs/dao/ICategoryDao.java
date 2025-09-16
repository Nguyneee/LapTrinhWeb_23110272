package vn.iotstar.configs.dao;

import java.util.List;
import vn.iotstar.configs.model.CategoryModel;

public interface ICategoryDao {
	 void insert(CategoryModel category);
	    void update(CategoryModel category);
	    void delete(int id);
	    CategoryModel findById(int id);
	    List<CategoryModel> findAll();
}