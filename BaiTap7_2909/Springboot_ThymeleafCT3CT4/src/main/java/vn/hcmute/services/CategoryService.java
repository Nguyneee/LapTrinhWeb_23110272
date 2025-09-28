package vn.hcmute.services;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.hcmute.entities.Category;
import java.util.List;
import java.util.Optional;

public interface CategoryService {
    Page<Category> getAllCategories(Pageable pageable);
    Page<Category> searchCategories(String keyword, Pageable pageable);
    Category getCategoryById(Long id);
    Optional<Category> findById(Long id);
    Optional<Category> findByName(String name);
    Category saveCategory(Category category);
    void deleteCategory(Long id);
    List<Category> findAll();
}
