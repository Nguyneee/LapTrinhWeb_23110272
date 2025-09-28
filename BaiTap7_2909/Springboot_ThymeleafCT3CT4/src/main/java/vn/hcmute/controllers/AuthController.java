package vn.hcmute.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.hcmute.entities.User;
import vn.hcmute.services.UserService;

import jakarta.validation.Valid;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error,
                           @RequestParam(value = "logout", required = false) String logout,
                           Model model) {
        
        if (error != null) {
            model.addAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng!");
        }
        
        if (logout != null) {
            model.addAttribute("successMessage", "Bạn đã đăng xuất thành công!");
        }
        
        return "auth/login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("user", new User());
        return "auth/register";
    }

    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("user") User user,
                              BindingResult bindingResult,
                              @RequestParam("confirmPassword") String confirmPassword,
                              Model model,
                              RedirectAttributes redirectAttributes) {
        
        // Check for validation errors
        if (bindingResult.hasErrors()) {
            return "auth/register";
        }
        
        // Check if passwords match
        if (!user.getPassword().equals(confirmPassword)) {
            model.addAttribute("passwordError", "Mật khẩu xác nhận không khớp!");
            return "auth/register";
        }
        
        // Check if username already exists
        if (userService.existsByUsername(user.getUsername())) {
            model.addAttribute("usernameError", "Tên đăng nhập đã tồn tại!");
            return "auth/register";
        }
        
        // Check if email already exists
        if (userService.existsByEmail(user.getEmail())) {
            model.addAttribute("emailError", "Email đã được sử dụng!");
            return "auth/register";
        }
        
        try {
            // Register user
            userService.registerUser(user);
            redirectAttributes.addFlashAttribute("successMessage", 
                "Đăng ký thành công! Bạn có thể đăng nhập ngay bây giờ.");
            return "redirect:/login";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra trong quá trình đăng ký: " + e.getMessage());
            return "auth/register";
        }
    }

    @GetMapping("/forgot-password")
    public String forgotPasswordPage() {
        return "auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam("email") String email,
                                       Model model,
                                       RedirectAttributes redirectAttributes) {
        
        if (userService.findByEmail(email).isPresent()) {
            // In a real application, you would send an email here
            redirectAttributes.addFlashAttribute("successMessage", 
                "Nếu email tồn tại trong hệ thống, chúng tôi đã gửi hướng dẫn đặt lại mật khẩu.");
        } else {
            redirectAttributes.addFlashAttribute("successMessage", 
                "Nếu email tồn tại trong hệ thống, chúng tôi đã gửi hướng dẫn đặt lại mật khẩu.");
        }
        
        return "redirect:/login";
    }
}
