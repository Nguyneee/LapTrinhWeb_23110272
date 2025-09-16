package vn.iotstar.configs.controller.admin.category;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import vn.iotstar.configs.model.CategoryModel;
import vn.iotstar.configs.service.ICategoryService;
import vn.iotstar.configs.service.Impl.CategoryServiceImpl;

@WebServlet("/admin/category/add")
public class CategoryAddController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ICategoryService service = new CategoryServiceImpl();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String icon = req.getParameter("icon");

        CategoryModel c = new CategoryModel();
        c.setCateName(name);
        c.setIcons(icon);
        service.insert(c);

        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }
}