package vn.iotstar.configs.service;

import java.util.List;
import vn.iotstar.configs.model.CategoryModel;

public interface ICategoryService {
	 void insert(CategoryModel c);
	 void update(CategoryModel c);
	 void delete(int id);
	 CategoryModel findById(int id);
	 List<CategoryModel> findAll();
}
