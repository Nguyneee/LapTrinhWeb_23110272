package vn.khang.app.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*"})
public class AuthAdminFilter implements Filter {
  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
      throws IOException, ServletException {
    HttpServletRequest req = (HttpServletRequest) request;
    HttpServletResponse resp = (HttpServletResponse) response;
    HttpSession session = req.getSession(false);

    String role = (session == null) ? null : (String) session.getAttribute("role");
    if (role == null) {
      resp.sendRedirect(req.getContextPath() + "/login");
      return;
    }
    if (!"ADMIN".equalsIgnoreCase(role)) {
      resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
      return;
    }
    chain.doFilter(request, response);
  }
}
