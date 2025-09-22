package vn.khang.app.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import vn.khang.app.dao.UserDAO;
import vn.khang.app.entity.User;

@WebServlet(urlPatterns = {"/login", "/video-admin/login"})
public class LoginServlet extends HttpServlet {
  private final UserDAO userDAO = new UserDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.getRequestDispatcher("/login.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String username = req.getParameter("username");
    String password = req.getParameter("password");

    User u = userDAO.findByUsername(username);
    if (u != null && u.isActive() && password.equals(u.getPassword())) { // TODO: thay bang BCrypt check
      HttpSession session = req.getSession(true);
      session.setAttribute("userId", u.getId());
      session.setAttribute("username", u.getUsername());
      session.setAttribute("role", u.getRole()); // ADMIN/USER
      resp.sendRedirect(req.getContextPath() + "/admin/categories");
    } else {
      req.setAttribute("error", "Sai thong tin dang nhap");
      req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
  }
}
