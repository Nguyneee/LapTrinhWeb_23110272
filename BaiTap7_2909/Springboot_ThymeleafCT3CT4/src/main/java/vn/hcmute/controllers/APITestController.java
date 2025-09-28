package vn.hcmute.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class APITestController {
    
    @GetMapping("/api-test")
    public String apiTestPage() {
        return "api-test";
    }
}
