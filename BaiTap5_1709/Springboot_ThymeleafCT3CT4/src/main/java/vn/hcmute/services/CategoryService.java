package vn.hcmute.services;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.hcmute.entities.Category;
import java.util.List;

public interface CategoryService {
    Page<Category> getAllCategories(Pageable pageable);
    Page<Category> searchCategories(String keyword, Pageable pageable);
    Category getCategoryById(Long id);
    Category saveCategory(Category category);
    void deleteCategory(Long id);
    List<Category> findAll();
}
