package vn.hcmute.services;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetailsService;
import vn.hcmute.entities.User;
import java.util.Optional;

public interface UserService extends UserDetailsService {
    
    User registerUser(User user);
    
    Optional<User> findByUsername(String username);
    
    Optional<User> findByEmail(String email);
    
    Optional<User> findByUsernameOrEmail(String usernameOrEmail);
    
    boolean existsByUsername(String username);
    
    boolean existsByEmail(String email);
    
    User saveUser(User user);
    
    User updateUser(User user);
    
    void deleteUser(Long id);
    
    User getUserById(Long id);
    
    Page<User> getAllUsers(Pageable pageable);
    
    Page<User> searchUsers(String keyword, Pageable pageable);
    
    Page<User> getUsersByRole(User.Role role, Pageable pageable);
    
    long countUsersByRole(User.Role role);
    
    long countActiveUsers();
    
    void updateLastLogin(String username);
}
