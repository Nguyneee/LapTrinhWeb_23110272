package nguyen.com.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/logincookie"})
public class LoginServletCookie extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html");

        // lấy dữ liệu từ form
        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        if (user.equals("nguyen1") && pass.equals("123")) {
            // khởi tạo cookie
            Cookie cookie = new Cookie("username", user);
            // set thời gian tồn tại 30 giây
            cookie.setMaxAge(30);
            // thêm cookie vào response
            resp.addCookie(cookie);
            // chuyển hướng HelloServlet
            resp.sendRedirect(req.getContextPath() + "/hello");
        } else {
            // quay lại trang login
        	resp.sendRedirect(req.getContextPath() + "/login-cookie.html");
        }
    }
}
