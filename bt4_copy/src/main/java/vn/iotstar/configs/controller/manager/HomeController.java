package vn.iotstar.configs.controller.manager;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.ServletException;

@WebServlet(urlPatterns = {"/manager/home"})
public class HomeController extends HttpServlet {
	@Override
	protected void doGet(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp)
			throws jakarta.servlet.ServletException, java.io.IOException {
		req.getRequestDispatcher("/views/manager/home.jsp").forward(req, resp);
	}
}
