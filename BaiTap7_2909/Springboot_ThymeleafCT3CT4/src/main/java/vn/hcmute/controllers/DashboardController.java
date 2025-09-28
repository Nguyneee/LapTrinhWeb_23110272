package vn.hcmute.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.hcmute.entities.User;
import vn.hcmute.services.CategoryService;
import vn.hcmute.services.UserService;

@Controller
public class DashboardController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private CategoryService categoryService;

    @GetMapping("/")
    public String home() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !auth.getName().equals("anonymousUser")) {
            return "redirect:/dashboard";
        }
        return "redirect:/login";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        
        // Get current user
        User currentUser = userService.findByUsername(username).orElse(null);
        model.addAttribute("currentUser", currentUser);
        
        // Dashboard statistics
        long totalCategories = categoryService.findAll().size();
        long totalUsers = userService.countActiveUsers();
        long totalAdmins = userService.countUsersByRole(User.Role.ADMIN);
        long totalManagers = userService.countUsersByRole(User.Role.MANAGER);
        long totalRegularUsers = userService.countUsersByRole(User.Role.USER);
        
        model.addAttribute("totalCategories", totalCategories);
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalAdmins", totalAdmins);
        model.addAttribute("totalManagers", totalManagers);
        model.addAttribute("totalRegularUsers", totalRegularUsers);
        
        // Recent data
        model.addAttribute("recentCategories", categoryService.findAll().stream().limit(5));
        model.addAttribute("recentUsers", userService.getAllUsers(
            org.springframework.data.domain.PageRequest.of(0, 5)).getContent());
        
        // Additional dashboard data
        model.addAttribute("currentTime", java.time.LocalDateTime.now());
        model.addAttribute("systemUptime", "99.9%");
        model.addAttribute("todayLogins", 12);
        model.addAttribute("newUsersToday", 3);
        model.addAttribute("newCategoriesToday", 1);
        
        return "dashboard";
    }
}
