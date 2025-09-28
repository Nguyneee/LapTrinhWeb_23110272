package vn.hcmute.controllers.api;

import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import vn.hcmute.entities.Category;
import vn.hcmute.model.Response;
import vn.hcmute.services.CategoryService;
import vn.hcmute.services.StorageService;

@RestController
@RequestMapping(path = "/api/category")
public class CategoryAPIController {
    
    @Autowired
    private CategoryService categoryService;
    
    @Autowired
    private StorageService storageService;

    @GetMapping
    public ResponseEntity<?> getAllCategory() {
        return new ResponseEntity<Response>(new Response(true, "Thành công", 
                categoryService.findAll()), HttpStatus.OK);
    }

    @PostMapping(path = "/getCategory")
    public ResponseEntity<?> getCategory(@Validated @RequestParam("id") Long id) {
        Optional<Category> category = categoryService.findById(id);
        if (category.isPresent()) {
            return new ResponseEntity<Response>(new Response(true, "Thành công", 
                    category.get()), HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(new Response(false, "Thất bại", 
                    null), HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping(path = "/addCategory")
    public ResponseEntity<?> addCategory(@Validated @RequestParam("categoryName") String categoryName,
                                       @Validated @RequestParam("icon") MultipartFile icon) {
        Optional<Category> optCategory = categoryService.findByName(categoryName);
        if (optCategory.isPresent()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Category đã tồn tại trong hệ thống");
        } else {
            Category category = new Category();
            // kiểm tra tồn tại file, lưu file
            if (!icon.isEmpty()) {
                UUID uuid = UUID.randomUUID();
                String uuString = uuid.toString();
                // lưu file vào trường Images
                category.setImage(storageService.getStorageFilename(icon, uuString));
                storageService.store(icon, category.getImage());
            }
            category.setName(categoryName);
            categoryService.saveCategory(category);
            return new ResponseEntity<Response>(new Response(true, "Thêm Thành công", 
                    category), HttpStatus.OK);
        }
    }

    @PutMapping(path = "/updateCategory")
    public ResponseEntity<?> updateCategory(@Validated @RequestParam("categoryId") Long categoryId,
                                          @Validated @RequestParam("categoryName") String categoryName,
                                          @Validated @RequestParam("icon") MultipartFile icon) {
        Optional<Category> optCategory = categoryService.findById(categoryId);
        if (optCategory.isEmpty()) {
            return new ResponseEntity<Response>(new Response(false, "Không tìm thấy Category", 
                    null), HttpStatus.BAD_REQUEST);
        } else if (optCategory.isPresent()) {
            // kiểm tra tồn tại file, lưu file
            if (!icon.isEmpty()) {
                UUID uuid = UUID.randomUUID();
                String uuString = uuid.toString();
                // lưu file vào trường Images
                optCategory.get().setImage(storageService.getStorageFilename(icon, uuString));
                storageService.store(icon, optCategory.get().getImage());
            }
            optCategory.get().setName(categoryName);
            categoryService.saveCategory(optCategory.get());
            return new ResponseEntity<Response>(new Response(true, "Cập nhật Thành công", 
                    optCategory.get()), HttpStatus.OK);
        }
        return null;
    }

    @DeleteMapping(path = "/deleteCategory")
    public ResponseEntity<?> deleteCategory(@Validated @RequestParam("categoryId") Long categoryId) {
        Optional<Category> optCategory = categoryService.findById(categoryId);
        if (optCategory.isEmpty()) {
            return new ResponseEntity<Response>(new Response(false, "Không tìm thấy Category", 
                    null), HttpStatus.BAD_REQUEST);
        } else if (optCategory.isPresent()) {
            categoryService.deleteCategory(optCategory.get().getId());
            return new ResponseEntity<Response>(new Response(true, "Xóa Thành công", 
                    optCategory.get()), HttpStatus.OK);
        }
        return null;
    }
}
