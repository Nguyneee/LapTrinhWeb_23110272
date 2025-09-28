package vn.hcmute;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;

import vn.hcmute.config.StorageProperties;
import vn.hcmute.services.StorageService;

@SpringBootApplication
@EnableConfigurationProperties(StorageProperties.class) // thêm cấu hình storage
public class SpringbootThymeleafCt3Ct4Application {
    public static void main(String[] args) {
        SpringApplication.run(SpringbootThymeleafCt3Ct4Application.class, args);
    }
    
    // thêm cấu hình storage
    @Bean
    CommandLineRunner init(StorageService storageService) {
        return (args -> {
            storageService.init();
        });
    }
}
