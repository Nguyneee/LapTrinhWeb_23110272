package vn.hcmute.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.hcmute.entities.User;
import vn.hcmute.services.CategoryService;
import vn.hcmute.services.UserService;

@Controller
@RequestMapping("/admin")
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private CategoryService categoryService;

    @GetMapping
    public String adminPanel(Model model) {
        // System statistics
        long totalUsers = userService.countActiveUsers();
        long totalCategories = categoryService.findAll().size();
        long totalAdmins = userService.countUsersByRole(User.Role.ADMIN);
        long totalManagers = userService.countUsersByRole(User.Role.MANAGER);
        long totalRegularUsers = userService.countUsersByRole(User.Role.USER);
        
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalCategories", totalCategories);
        model.addAttribute("totalAdmins", totalAdmins);
        model.addAttribute("totalManagers", totalManagers);
        model.addAttribute("totalRegularUsers", totalRegularUsers);
        
        // Recent data
        model.addAttribute("recentUsers", userService.getAllUsers(org.springframework.data.domain.PageRequest.of(0, 5)).getContent());
        model.addAttribute("recentCategories", categoryService.findAll().stream().limit(5));
        
        return "admin/panel";
    }

    @GetMapping("/settings")
    public String systemSettings(Model model) {
        return "admin/settings";
    }

    @GetMapping("/reports")
    public String systemReports(Model model) {
        return "admin/reports";
    }

    @GetMapping("/logs")
    public String systemLogs(Model model) {
        return "admin/logs";
    }
}
