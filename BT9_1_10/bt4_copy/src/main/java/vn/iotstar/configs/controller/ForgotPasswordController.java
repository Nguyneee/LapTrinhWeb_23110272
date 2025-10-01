package vn.iotstar.configs.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.configs.dao.IUserDao;
import vn.iotstar.configs.dao.implement.UserDaoImpl;
import vn.iotstar.configs.model.UserModel;

@WebServlet("/forgot")
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserDao userDao = new UserDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        String email = req.getParameter("email").trim();

        if ("find".equals(action)) {
            // Tìm email
            UserModel user = userDao.findByEmail(email);
            if (user != null) {
                req.setAttribute("foundEmail", email);
            } else {
                req.setAttribute("error", "Email không tồn tại.");
            }
        } else if ("reset".equals(action)) {
            String newPassword = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");

            if (!newPassword.equals(confirmPassword)) {
                req.setAttribute("error", "Mật khẩu nhập lại không khớp.");
                req.setAttribute("foundEmail", email); // giữ lại form reset
            } else {
                UserModel user = userDao.findByEmail(email);
                if (user != null) {
                    user.setPassWord(newPassword);
                    userDao.update(user);
                    req.setAttribute("message", "Đặt lại mật khẩu thành công. Vui lòng đăng nhập lại.");
                } else {
                    req.setAttribute("error", "Email không tồn tại.");
                }
            }
        }

        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }
}