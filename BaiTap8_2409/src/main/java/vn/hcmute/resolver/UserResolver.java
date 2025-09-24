package vn.hcmute.resolver;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;
import vn.hcmute.entity.User;
import vn.hcmute.repository.UserRepository;

import java.util.List;
import java.util.Optional;

@Controller
public class UserResolver {
    
    @Autowired
    private UserRepository userRepository;
    
    @QueryMapping
    public List<User> allUsers() {
        return userRepository.findAll();
    }
    
    @QueryMapping
    public Optional<User> user(@Argument Long id) {
        return userRepository.findById(id);
    }
    
    @MutationMapping
    public User createUser(@Argument UserInput input) {
        User user = new User();
        user.setFullname(input.getFullname());
        user.setEmail(input.getEmail());
        user.setPassword(input.getPassword());
        user.setPhone(input.getPhone());
        return userRepository.save(user);
    }
    
    @MutationMapping
    public User updateUser(@Argument Long id, @Argument UserInput input) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("User not found"));
        
        user.setFullname(input.getFullname());
        user.setEmail(input.getEmail());
        user.setPassword(input.getPassword());
        user.setPhone(input.getPhone());
        return userRepository.save(user);
    }
    
    @MutationMapping
    public Boolean deleteUser(@Argument Long id) {
        try {
            userRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    // Input class for User mutations
    public static class UserInput {
        private String fullname;
        private String email;
        private String password;
        private String phone;
        
        // Getters and setters
        public String getFullname() { return fullname; }
        public void setFullname(String fullname) { this.fullname = fullname; }
        
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
        
        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }
    }
}
