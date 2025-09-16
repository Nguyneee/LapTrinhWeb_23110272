package vn.service.implement;

import java.util.List;

import vn.dao.ICategoryDao;
import vn.dao.implement.CategoryDaoImpl;
import vn.entity.Category;
import vn.service.ICategoryService;

public class CategoryService implements ICategoryService {

    ICategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void update(Category category) {
        categoryDao.update(category);
    }

    @Override
    public void delete(int id) throws Exception {
        categoryDao.delete(id);
    }

    @Override
    public Category findById(int id) {
        return categoryDao.findById(id);
    }

    @Override
    public List<Category> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public List<Category> findByName(String name) {
        return categoryDao.findByName(name);
    }

    @Override
    public List<Category> findAll(int page, int pageSize) {
        return categoryDao.findAll(page, pageSize);
    }

    @Override
    public int count() {
        return categoryDao.count();
    }
}
