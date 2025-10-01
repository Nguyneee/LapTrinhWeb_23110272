// ✅ CategoryListController.java - Hiển thị danh sách danh mục
package vn.iotstar.configs.controller.admin.category;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;


import vn.iotstar.configs.model.CategoryModel;
import vn.iotstar.configs.service.ICategoryService;
import vn.iotstar.configs.service.Impl.CategoryServiceImpl;


	@WebServlet(urlPatterns = "/admin/category/list")
	public class CategoryListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ICategoryService cateService = new CategoryServiceImpl();


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {
	List<CategoryModel> cateList = cateService.findAll();
	req.setAttribute("cateList", cateList);
	req.getRequestDispatcher("/views/admin/list-category.jsp").forward(req, resp);
	}
	}