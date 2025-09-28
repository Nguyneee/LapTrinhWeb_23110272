package vn.hcmute.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import java.nio.file.Path;
import java.nio.file.Paths;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Map URL /uploads/** to the actual uploads directory
        Path uploadDir = Paths.get("src/main/resources/static/uploads");
        String uploadPath = uploadDir.toFile().getAbsolutePath();
        
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:" + uploadPath + "/");
                
        // Add resource handler for avatars
        Path avatarDir = Paths.get("src/main/resources/static/uploads/avatars");
        String avatarPath = avatarDir.toFile().getAbsolutePath();
        
        registry.addResourceHandler("/uploads/avatars/**")
                .addResourceLocations("file:" + avatarPath + "/");
                
        // Add additional resource handlers if needed
        registry.addResourceHandler("/images/**")
                .addResourceLocations("classpath:/static/images/");
                
        // Add CSS and JS resources
        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/static/css/");
                
        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/static/js/");
    }
}
