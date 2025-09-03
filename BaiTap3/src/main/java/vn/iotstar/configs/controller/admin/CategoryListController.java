package vn.iotstar.configs.controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import vn.iotstar.configs.model.CategoryModel;
import vn.iotstar.configs.service.ICategoryService;
import vn.iotstar.configs.service.Impl.CategoryServiceImpl;

@WebServlet("/admin/category/list")
public class CategoryListController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ICategoryService service = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<CategoryModel> list = service.getAll();
        req.setAttribute("cateList", list);
        req.getRequestDispatcher("/views/admin/list-category.jsp").forward(req, resp);
    }
}
