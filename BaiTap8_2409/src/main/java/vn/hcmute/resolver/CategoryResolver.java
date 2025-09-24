package vn.hcmute.resolver;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;
import vn.hcmute.entity.Category;
import vn.hcmute.repository.CategoryRepository;

import java.util.List;
import java.util.Optional;

@Controller
public class CategoryResolver {
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @QueryMapping
    public List<Category> allCategories() {
        return categoryRepository.findAll();
    }
    
    @QueryMapping
    public Optional<Category> category(@Argument Long id) {
        return categoryRepository.findById(id);
    }
    
    @MutationMapping
    public Category createCategory(@Argument CategoryInput input) {
        Category category = new Category();
        category.setName(input.getName());
        category.setImages(input.getImages());
        return categoryRepository.save(category);
    }
    
    @MutationMapping
    public Category updateCategory(@Argument Long id, @Argument CategoryInput input) {
        Category category = categoryRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Category not found"));
        
        category.setName(input.getName());
        category.setImages(input.getImages());
        return categoryRepository.save(category);
    }
    
    @MutationMapping
    public Boolean deleteCategory(@Argument Long id) {
        try {
            categoryRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    // Input class for Category mutations
    public static class CategoryInput {
        private String name;
        private String images;
        
        // Getters and setters
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        
        public String getImages() { return images; }
        public void setImages(String images) { this.images = images; }
    }
}
