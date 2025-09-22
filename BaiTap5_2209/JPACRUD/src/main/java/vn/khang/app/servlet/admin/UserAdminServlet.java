package vn.khang.app.servlet.admin;

import vn.khang.app.dao.UserDAO;
import vn.khang.app.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/users"})
public class UserAdminServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;  
  private final UserDAO dao = new UserDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String action = req.getParameter("action");

    if ("create".equals(action)) {
      req.getRequestDispatcher("/WEB-INF/views/admin/user/form.jsp").forward(req, resp);
      return;
    }
    if ("edit".equals(action)) {
      Long id = Long.valueOf(req.getParameter("id"));
      req.setAttribute("item", dao.findById(id));
      req.getRequestDispatcher("/WEB-INF/views/admin/user/form.jsp").forward(req, resp);
      return;
    }
    if ("delete".equals(action)) {
      Long id = Long.valueOf(req.getParameter("id"));
      dao.remove(id);
      resp.sendRedirect(req.getContextPath() + "/admin/users");
      return;
    }

    // list + search
    String q = req.getParameter("q");
    int page = parseInt(req.getParameter("page"), 0);
    int size = 10;

    List<User> items = dao.search(q, page, size);
    long total = dao.countSearch(q);

    req.setAttribute("items", items);
    req.setAttribute("q", q);
    req.setAttribute("page", page);
    req.setAttribute("pages", Math.max(0, (int) Math.ceil(total / (double) size)));
    req.getRequestDispatcher("/WEB-INF/views/admin/user/list.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");

    String idStr = req.getParameter("id");
    String username = req.getParameter("username");
    String password = req.getParameter("password");
    String email = req.getParameter("email");
    String role = req.getParameter("role");
    boolean active = "on".equals(req.getParameter("active"));

    if (idStr == null || idStr.isBlank()) {
      User u = new User();
      u.setUsername(username);
      u.setPassword(password); // TODO: thay bang BCrypt hash
      u.setEmail(email);
      u.setRole(role);
      u.setActive(active);
      dao.persist(u);
    } else {
      Long id = Long.valueOf(idStr);
      User u = dao.findById(id);
      u.setEmail(email);
      u.setRole(role);
      u.setActive(active);

      // neu nhap password moi thi cap nhat
      if (password != null && !password.isBlank()) {
        u.setPassword(password); // TODO: BCrypt
      }
      dao.merge(u);
    }

    resp.sendRedirect(req.getContextPath() + "/admin/users");
  }

  private int parseInt(String s, int def) {
    try { return Integer.parseInt(s); } catch (Exception e) { return def; }
  }
}
