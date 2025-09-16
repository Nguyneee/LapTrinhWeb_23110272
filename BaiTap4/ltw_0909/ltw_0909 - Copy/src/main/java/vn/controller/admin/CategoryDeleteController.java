package vn.controller.admin;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.service.ICategoryService;
import vn.service.implement.CategoryService;

@WebServlet(urlPatterns = "/admin/category/delete")
public class CategoryDeleteController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    public ICategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");

        try {
            if (id != null && !id.isEmpty()) {
                categoryService.delete(Integer.parseInt(id));
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/categories?error=delete_failed");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
