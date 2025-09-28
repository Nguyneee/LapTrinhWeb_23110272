package vn.hcmute.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.util.StringUtils;

import vn.hcmute.entities.User;
import vn.hcmute.services.UserService;

import jakarta.validation.Valid;
import jakarta.annotation.PostConstruct;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@Controller
@RequestMapping("/users")
@PreAuthorize("hasRole('ADMIN')")
public class UserController {

    @Autowired
    private UserService userService;

    // Upload directory path for avatars
    private final String UPLOAD_DIR = "src/main/resources/static/uploads/avatars";
    
    // Make sure upload directory exists
    @PostConstruct
    public void init() {
        File uploadDirectory = new File(UPLOAD_DIR);
        if (!uploadDirectory.exists()) {
            uploadDirectory.mkdirs();
        }
    }

    // List users with search and pagination
    @GetMapping
    public String listUsers(Model model,
                           @RequestParam(name = "page", defaultValue = "0") int page,
                           @RequestParam(name = "size", defaultValue = "10") int size,
                           @RequestParam(name = "keyword", required = false) String keyword,
                           @RequestParam(name = "role", required = false) String role) {

        Pageable pageable = PageRequest.of(page, size);
        Page<User> pageUsers;

        if (keyword != null && !keyword.trim().isEmpty()) {
            pageUsers = userService.searchUsers(keyword, pageable);
            model.addAttribute("keyword", keyword);
        } else if (role != null && !role.trim().isEmpty()) {
            try {
                User.Role userRole = User.Role.valueOf(role.toUpperCase());
                pageUsers = userService.getUsersByRole(userRole, pageable);
                model.addAttribute("selectedRole", role);
            } catch (IllegalArgumentException e) {
                pageUsers = userService.getAllUsers(pageable);
            }
        } else {
            pageUsers = userService.getAllUsers(pageable);
        }

        model.addAttribute("users", pageUsers.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageUsers.getTotalPages());
        model.addAttribute("totalElements", pageUsers.getTotalElements());
        
        // Statistics
        model.addAttribute("totalUsers", userService.countActiveUsers());
        model.addAttribute("totalAdmins", userService.countUsersByRole(User.Role.ADMIN));
        model.addAttribute("totalManagers", userService.countUsersByRole(User.Role.MANAGER));
        model.addAttribute("totalRegularUsers", userService.countUsersByRole(User.Role.USER));

        return "users/list";
    }

    // Add user form
    @GetMapping("/add")
    public String addUserForm(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("roles", User.Role.values());
        return "users/add";
    }

    // Edit user form
    @GetMapping("/edit/{id}")
    public String editUserForm(@PathVariable("id") Long id, Model model) {
        User user = userService.getUserById(id);
        model.addAttribute("user", user);
        model.addAttribute("roles", User.Role.values());
        return "users/edit";
    }

    // View user details
    @GetMapping("/view/{id}")
    public String viewUser(@PathVariable("id") Long id, Model model) {
        User user = userService.getUserById(id);
        model.addAttribute("user", user);
        return "users/view";
    }

    // Save user (for both add and edit)
    @PostMapping("/save")
    public String saveUser(@Valid @ModelAttribute("user") User user,
                          BindingResult bindingResult,
                          @RequestParam("avatarFile") MultipartFile file,
                          @RequestParam(value = "newPassword", required = false) String newPassword,
                          Model model,
                          RedirectAttributes redirectAttributes) {

        // Check for validation errors
        if (bindingResult.hasErrors()) {
            model.addAttribute("roles", User.Role.values());
            return user.getId() == null ? "users/add" : "users/edit";
        }

        // Check if username already exists (for new users or when changing username)
        if (user.getId() == null || !userService.getUserById(user.getId()).getUsername().equals(user.getUsername())) {
            if (userService.existsByUsername(user.getUsername())) {
                model.addAttribute("usernameError", "Tên đăng nhập đã tồn tại!");
                model.addAttribute("roles", User.Role.values());
                return user.getId() == null ? "users/add" : "users/edit";
            }
        }

        // Check if email already exists (for new users or when changing email)
        if (user.getId() == null || !userService.getUserById(user.getId()).getEmail().equals(user.getEmail())) {
            if (userService.existsByEmail(user.getEmail())) {
                model.addAttribute("emailError", "Email đã được sử dụng!");
                model.addAttribute("roles", User.Role.values());
                return user.getId() == null ? "users/add" : "users/edit";
            }
        }

        try {
            // Handle avatar upload
            if (!file.isEmpty()) {
                String originalFileName = file.getOriginalFilename();
                if (originalFileName == null || originalFileName.isEmpty()) {
                    throw new IOException("Invalid file name");
                }
                
                String fileName = StringUtils.cleanPath(originalFileName);
                String uploadPath = Paths.get(UPLOAD_DIR).toAbsolutePath().toString();
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                // Generate unique filename
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName.replaceAll("[^a-zA-Z0-9.]", "_");
                
                file.transferTo(new File(uploadPath + File.separator + uniqueFileName));
                user.setAvatar(uniqueFileName);
            } else if (user.getId() != null) {
                // Keep existing avatar if no new file uploaded
                User existingUser = userService.getUserById(user.getId());
                user.setAvatar(existingUser.getAvatar());
            }

            // Handle password
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                user.setPassword(newPassword);
            } else if (user.getId() != null) {
                // Keep existing password if no new password provided
                User existingUser = userService.getUserById(user.getId());
                user.setPassword(existingUser.getPassword());
            }

            // Save user
            if (user.getId() == null) {
                userService.registerUser(user);
                redirectAttributes.addFlashAttribute("successMessage", "Thêm người dùng thành công!");
            } else {
                userService.updateUser(user);
                redirectAttributes.addFlashAttribute("successMessage", "Cập nhật người dùng thành công!");
            }
            
            return "redirect:/users";
        } catch (IOException e) {
            model.addAttribute("errorMessage", "Lỗi khi upload ảnh: " + e.getMessage());
            model.addAttribute("roles", User.Role.values());
            return user.getId() == null ? "users/add" : "users/edit";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            model.addAttribute("roles", User.Role.values());
            return user.getId() == null ? "users/add" : "users/edit";
        }
    }

    // Delete user
    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        try {
            userService.deleteUser(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa người dùng thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa người dùng: " + e.getMessage());
        }
        return "redirect:/users";
    }

    // Toggle user status
    @PostMapping("/toggle-status/{id}")
    @ResponseBody
    public String toggleUserStatus(@PathVariable("id") Long id) {
        try {
            User user = userService.getUserById(id);
            user.setActive(!user.getActive());
            userService.updateUser(user);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }

    // Bulk operations
    @PostMapping("/bulk-action")
    public String bulkAction(@RequestParam("action") String action,
                            @RequestParam("userIds") Long[] userIds,
                            RedirectAttributes redirectAttributes) {
        try {
            switch (action) {
                case "activate":
                    for (Long id : userIds) {
                        User user = userService.getUserById(id);
                        user.setActive(true);
                        userService.updateUser(user);
                    }
                    redirectAttributes.addFlashAttribute("successMessage", "Kích hoạt " + userIds.length + " người dùng thành công!");
                    break;
                case "deactivate":
                    for (Long id : userIds) {
                        User user = userService.getUserById(id);
                        user.setActive(false);
                        userService.updateUser(user);
                    }
                    redirectAttributes.addFlashAttribute("successMessage", "Vô hiệu hóa " + userIds.length + " người dùng thành công!");
                    break;
                case "delete":
                    for (Long id : userIds) {
                        userService.deleteUser(id);
                    }
                    redirectAttributes.addFlashAttribute("successMessage", "Xóa " + userIds.length + " người dùng thành công!");
                    break;
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        return "redirect:/users";
    }
}
