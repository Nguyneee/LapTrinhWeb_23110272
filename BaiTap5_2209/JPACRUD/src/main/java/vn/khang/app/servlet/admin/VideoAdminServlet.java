package vn.khang.app.servlet.admin;

import vn.khang.app.dao.VideoDAO;
import vn.khang.app.dao.CategoryDAO;
import vn.khang.app.dao.UserDAO;
import vn.khang.app.entity.Video;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/videos"})
public class VideoAdminServlet extends HttpServlet {
  private static final long serialVersionUID = 1L; 
  private final VideoDAO videoDAO = new VideoDAO();
  private final CategoryDAO categoryDAO = new CategoryDAO();
  private final UserDAO userDAO = new UserDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String action = req.getParameter("action");

    if ("create".equals(action)) {
      req.setAttribute("categories", categoryDAO.findAll());
      req.getRequestDispatcher("/WEB-INF/views/admin/video/form.jsp").forward(req, resp);
      return;
    }
    if ("edit".equals(action)) {
      Long id = Long.valueOf(req.getParameter("id"));
      req.setAttribute("item", videoDAO.findById(id));
      req.setAttribute("categories", categoryDAO.findAll());
      req.getRequestDispatcher("/WEB-INF/views/admin/video/form.jsp").forward(req, resp);
      return;
    }
    if ("delete".equals(action)) {
      Long id = Long.valueOf(req.getParameter("id"));
      videoDAO.remove(id);
      resp.sendRedirect(req.getContextPath() + "/admin/videos");
      return;
    }

    // list + search
    String q = req.getParameter("q");
    Long cid = null;
    try {
      String cidStr = req.getParameter("categoryId");
      if (cidStr != null && !cidStr.isBlank()) cid = Long.valueOf(cidStr);
    } catch (Exception ignored) {}

    int page = parseInt(req.getParameter("page"), 0);
    int size = 10;

    List<Video> items = videoDAO.search(q, cid, page, size);
    long total = videoDAO.countSearch(q, cid);

    // Ensure safe pagination values
    int totalPages = 0;
    if (total > 0) {
      totalPages = (int) Math.ceil(total / (double) size);
    }
    
    // Ensure page is within valid range
    if (page >= totalPages && totalPages > 0) {
      page = totalPages - 1;
    }
    if (page < 0) {
      page = 0;
    }

    req.setAttribute("categories", categoryDAO.findAll());
    req.setAttribute("items", items);
    req.setAttribute("q", q);
    req.setAttribute("categoryId", cid);
    req.setAttribute("page", page);
    req.setAttribute("pages", totalPages);
    req.getRequestDispatcher("/WEB-INF/views/admin/video/list.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");

    String idStr = req.getParameter("id");
    String title = req.getParameter("title");
    String description = req.getParameter("description");
    String url = req.getParameter("url");
    String thumbnail = req.getParameter("thumbnail");
    Long categoryId = Long.valueOf(req.getParameter("categoryId"));

    if (idStr == null || idStr.isBlank()) {
      Video v = new Video();
      v.setTitle(title);
      v.setDescription(description);
      v.setUrl(url);
      v.setThumbnail(thumbnail);
      v.setCategory(categoryDAO.findById(categoryId));

      // lay uploader tu session
      Long uid = (Long) req.getSession().getAttribute("userId");
      if (uid != null) {
        v.setUploader(userDAO.findById(uid));
      }
      videoDAO.persist(v);
    } else {
      Long id = Long.valueOf(idStr);
      Video v = videoDAO.findById(id);
      v.setTitle(title);
      v.setDescription(description);
      v.setUrl(url);
      v.setThumbnail(thumbnail);
      v.setCategory(categoryDAO.findById(categoryId));
      videoDAO.merge(v);
    }

    resp.sendRedirect(req.getContextPath() + "/admin/videos");
  }

  private int parseInt(String s, int def) {
    try { return Integer.parseInt(s); } catch (Exception e) { return def; }
  }
}
