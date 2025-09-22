package vn.khang.app.servlet.admin;

import vn.khang.app.dao.CategoryDAO;
import vn.khang.app.entity.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/categories"})
public class CategoryAdminServlet extends HttpServlet {
  private static final long serialVersionUID = 1L; 
  private final CategoryDAO dao = new CategoryDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String action = req.getParameter("action");
    if ("create".equals(action)) {
      req.getRequestDispatcher("/WEB-INF/views/admin/category/form.jsp").forward(req, resp);
      return;
    }
    if ("edit".equals(action)) {
      Long id = Long.valueOf(req.getParameter("id"));
      Category c = dao.findById(id);
      req.setAttribute("item", c);
      req.getRequestDispatcher("/WEB-INF/views/admin/category/form.jsp").forward(req, resp);
      return;
    }
    if ("delete".equals(action)) {
      Long id = Long.valueOf(req.getParameter("id"));
      dao.remove(id);
      resp.sendRedirect(req.getContextPath() + "/admin/categories");
      return;
    }

    // list + search + paging
    String q = req.getParameter("q");
    int page = parseInt(req.getParameter("page"), 0);
    int size = 10;

    List<Category> items = dao.search(q, page, size);
    long total = dao.countSearch(q);

    req.setAttribute("items", items);
    req.setAttribute("q", q);
    req.setAttribute("page", page);
    req.setAttribute("pages", Math.max(0, (int) Math.ceil(total / (double) size)));
    req.getRequestDispatcher("/WEB-INF/views/admin/category/list.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");
    String idStr = req.getParameter("id");
    String name = req.getParameter("name");
    String description = req.getParameter("description");
    boolean active = "on".equals(req.getParameter("active"));

    if (idStr == null || idStr.isBlank()) {
      Category c = new Category();
      c.setName(name);
      c.setDescription(description);
      c.setActive(active);
      dao.persist(c);
    } else {
      Long id = Long.valueOf(idStr);
      Category c = dao.findById(id);
      c.setName(name);
      c.setDescription(description);
      c.setActive(active);
      dao.merge(c);
    }
    resp.sendRedirect(req.getContextPath() + "/admin/categories");
  }

  private int parseInt(String s, int def) {
    try { return Integer.parseInt(s); } catch (Exception e) { return def; }
  }
}
