package com.example.websocketchat.config;

import com.example.websocketchat.entity.User;
import com.example.websocketchat.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Override
    public void run(String... args) throws Exception {
        // Create some sample support agents
        if (userRepository.count() == 0) {
            User supportAgent1 = new User("admin", "Admin Support", User.UserRole.SUPPORT_AGENT);
            User supportAgent2 = new User("support1", "Nguyễn Văn A", User.UserRole.SUPPORT_AGENT);
            User supportAgent3 = new User("support2", "Trần Thị B", User.UserRole.SUPPORT_AGENT);
            
            userRepository.save(supportAgent1);
            userRepository.save(supportAgent2);
            userRepository.save(supportAgent3);
            
            System.out.println("Sample support agents created successfully!");
        }
    }
}
