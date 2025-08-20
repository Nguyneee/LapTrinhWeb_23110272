package nguyen.com.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/loginsession"})
public class LoginServletSession extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html");

        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        if ("nguyen2".equals(user) && "123".equals(pass))  {
            // tạo session
            HttpSession session = req.getSession();
            session.setAttribute("name", user);
            session.setMaxInactiveInterval(60); // tồn tại 1 phút

            // chuyển sang ProfileServlet
            resp.sendRedirect(req.getContextPath() + "/profile");
        } else {
            // quay lại login
        	resp.sendRedirect(req.getContextPath() + "/login-session.html");
        }
    }
}