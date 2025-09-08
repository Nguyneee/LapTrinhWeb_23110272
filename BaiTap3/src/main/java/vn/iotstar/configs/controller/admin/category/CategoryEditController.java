package vn.iotstar.configs.controller.admin.category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import vn.iotstar.configs.model.CategoryModel;
import vn.iotstar.configs.service.ICategoryService;
import vn.iotstar.configs.service.Impl.CategoryServiceImpl;

@WebServlet(urlPatterns = "/admin/category/edit")
public class CategoryEditController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ICategoryService cateService = new CategoryServiceImpl();

    // Hiển thị form edit
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id")); // id truyền trên URL
            CategoryModel cate = cateService.findById(id);
            req.setAttribute("cate", cate); // gửi đối tượng sang JSP
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
        }
    }

    // Xử lý cập nhật
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");

            int cateId = Integer.parseInt(req.getParameter("cateId"));
            String cateName = req.getParameter("cateName");
            String icons = req.getParameter("icons");

            CategoryModel cate = new CategoryModel(cateId, cateName, icons);
            cateService.update(cate);

            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi cập nhật danh mục!");
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
        }
    }
}
