package vn.hcmute.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import vn.hcmute.services.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Set;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private UserService userService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, 
                                      Authentication authentication) throws IOException, ServletException {
        
        // Update last login time
        String username = authentication.getName();
        userService.updateLastLogin(username);
        
        // Determine redirect URL based on user role
        Set<String> roles = AuthorityUtils.authorityListToSet(authentication.getAuthorities());
        
        String redirectURL = request.getContextPath();
        
        if (roles.contains("ROLE_ADMIN")) {
            redirectURL += "/dashboard";
        } else if (roles.contains("ROLE_MANAGER")) {
            redirectURL += "/dashboard";
        } else if (roles.contains("ROLE_USER")) {
            redirectURL += "/dashboard";
        } else {
            redirectURL += "/";
        }
        
        response.sendRedirect(redirectURL);
    }
}
