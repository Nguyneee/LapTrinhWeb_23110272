package vn.iotstar.configs.service.Impl;

import java.util.List;
import vn.iotstar.configs.dao.ICategoryDao;
import vn.iotstar.configs.dao.implement.CategoryDaoImpl;
import vn.iotstar.configs.model.CategoryModel;
import vn.iotstar.configs.service.ICategoryService;

public class CategoryServiceImpl implements ICategoryService {
    ICategoryDao dao = new CategoryDaoImpl();

    @Override public void insert(CategoryModel c) { dao.insert(c); }
    @Override public void edit(CategoryModel c) { dao.edit(c); }
    @Override public void delete(int id) { dao.delete(id); }
    @Override public CategoryModel get(int id) { return dao.get(id); }
    @Override public List<CategoryModel> getAll() { return dao.getAll(); }
}
