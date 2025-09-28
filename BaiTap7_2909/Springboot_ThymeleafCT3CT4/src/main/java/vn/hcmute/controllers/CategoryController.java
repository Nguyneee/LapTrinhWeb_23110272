package vn.hcmute.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.util.StringUtils;

import vn.hcmute.entities.Category;
import vn.hcmute.services.CategoryService;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.annotation.PostConstruct;

@Controller
@RequestMapping("/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    // Upload directory path
    private final String UPLOAD_DIR = "src/main/resources/static/uploads";
    
    // Make sure upload directory exists
    @PostConstruct
    public void init() {
        File uploadDirectory = new File(UPLOAD_DIR);
        if (!uploadDirectory.exists()) {
            uploadDirectory.mkdirs();
        }
    }

    // Danh sách + tìm kiếm + phân trang
    @GetMapping
    public String listCategories(Model model,
                                 @RequestParam(name = "page", defaultValue = "0") int page,
                                 @RequestParam(name = "size", defaultValue = "5") int size,
                                 @RequestParam(name = "keyword", required = false) String keyword) {

        Pageable pageable = PageRequest.of(page, size);
        Page<Category> pageCategories;

        if (keyword != null && !keyword.trim().isEmpty()) {
            pageCategories = categoryService.searchCategories(keyword, pageable);
            model.addAttribute("keyword", keyword);
        } else {
            pageCategories = categoryService.getAllCategories(pageable);
        }

        model.addAttribute("categories", pageCategories.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageCategories.getTotalPages());

        return "categories/list";
    }

    // Form thêm mới
    @GetMapping("/add")
    public String addCategoryForm(Model model) {
        model.addAttribute("category", new Category());
        return "categories/add";
    }

    // Form sửa
    @GetMapping("/edit/{id}")
    public String editCategoryForm(@PathVariable("id") Long id, Model model) {
        Category category = categoryService.getCategoryById(id);
        model.addAttribute("category", category);
        return "categories/edit";
    }

    // Lưu (dùng cho cả thêm + sửa)
    @PostMapping("/save")
    public String saveCategory(@ModelAttribute("category") Category category,
                               @RequestParam("file") MultipartFile file) throws IOException {

        // Nếu có upload ảnh
        if (!file.isEmpty()) {
            String fileName = StringUtils.cleanPath(file.getOriginalFilename());
            String uploadPath = Paths.get(UPLOAD_DIR).toAbsolutePath().toString();
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            file.transferTo(new File(uploadPath + File.separator + fileName));
            category.setImage(fileName);
        } else {
            // Nếu sửa mà không chọn ảnh mới → giữ ảnh cũ
            if (category.getId() != null) {
                Category old = categoryService.getCategoryById(category.getId());
                category.setImage(old.getImage());
            }
        }

        categoryService.saveCategory(category);
        return "redirect:/categories";
    }

    // Xóa
    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable("id") Long id) {
        categoryService.deleteCategory(id);
        return "redirect:/categories";
    }

    // View chi tiết
    @GetMapping("/view/{id}")
    public String viewCategory(@PathVariable("id") Long id, Model model) {
        Category category = categoryService.getCategoryById(id);
        model.addAttribute("category", category);
        return "categories/view"; // cần tạo view.html nếu muốn hiển thị chi tiết
    }
}
