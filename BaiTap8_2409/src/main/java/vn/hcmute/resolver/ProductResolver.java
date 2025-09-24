package vn.hcmute.resolver;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;
import vn.hcmute.entity.Product;
import vn.hcmute.entity.User;
import vn.hcmute.entity.Category;
import vn.hcmute.repository.ProductRepository;
import vn.hcmute.repository.UserRepository;
import vn.hcmute.repository.CategoryRepository;

import java.util.List;
import java.util.Optional;

@Controller
public class ProductResolver {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @QueryMapping
    public List<Product> allProducts() {
        return productRepository.findAll();
    }
    
    @QueryMapping
    public List<Product> productsByPriceAsc() {
        return productRepository.findAllOrderByPriceAsc();
    }
    
    @QueryMapping
    public List<Product> productsByCategory(@Argument Long categoryId) {
        return productRepository.findByCategoryId(categoryId);
    }
    
    @QueryMapping
    public Optional<Product> product(@Argument Long id) {
        return productRepository.findById(id);
    }
    
    @MutationMapping
    public Product createProduct(@Argument ProductInput input) {
        Product product = new Product();
        product.setTitle(input.getTitle());
        product.setQuantity(input.getQuantity());
        product.setDescription(input.getDescription());
        product.setPrice(input.getPrice());
        
        User user = userRepository.findById(input.getUserId())
            .orElseThrow(() -> new RuntimeException("User not found"));
        product.setUser(user);
        
        Category category = categoryRepository.findById(input.getCategoryId())
            .orElseThrow(() -> new RuntimeException("Category not found"));
        product.setCategory(category);
        
        return productRepository.save(product);
    }
    
    @MutationMapping
    public Product updateProduct(@Argument Long id, @Argument ProductInput input) {
        Product product = productRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Product not found"));
        
        product.setTitle(input.getTitle());
        product.setQuantity(input.getQuantity());
        product.setDescription(input.getDescription());
        product.setPrice(input.getPrice());
        
        User user = userRepository.findById(input.getUserId())
            .orElseThrow(() -> new RuntimeException("User not found"));
        product.setUser(user);
        
        Category category = categoryRepository.findById(input.getCategoryId())
            .orElseThrow(() -> new RuntimeException("Category not found"));
        product.setCategory(category);
        
        return productRepository.save(product);
    }
    
    @MutationMapping
    public Boolean deleteProduct(@Argument Long id) {
        try {
            productRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    // Input class for Product mutations
    public static class ProductInput {
        private String title;
        private Integer quantity;
        private String description;
        private Double price;
        private Long userId;
        private Long categoryId;
        
        // Getters and setters
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        
        public Integer getQuantity() { return quantity; }
        public void setQuantity(Integer quantity) { this.quantity = quantity; }
        
        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }
        
        public Double getPrice() { return price; }
        public void setPrice(Double price) { this.price = price; }
        
        public Long getUserId() { return userId; }
        public void setUserId(Long userId) { this.userId = userId; }
        
        public Long getCategoryId() { return categoryId; }
        public void setCategoryId(Long categoryId) { this.categoryId = categoryId; }
    }
}
