package vn.controller.admin;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.entity.Category;
import vn.service.ICategoryService;
import vn.service.implement.CategoryService;

@WebServlet(urlPatterns = "/admin/categories")
public class CategoryListController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    public ICategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fname = req.getParameter("fname");
        List<Category> list;

        if (fname != null) {
            list = categoryService.findByName(fname);
        } else {
            list = categoryService.findAll();
        }

        req.setAttribute("listcate", list);
        req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
