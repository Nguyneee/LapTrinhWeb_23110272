package nguyen.com.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/profile"})
public class ProfileServletSession extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("name") != null) {
            String name = (String) session.getAttribute("name");
            out.println("Xin chào (SESSION), " + name);
            out.println("<br/><a href='logout'>Đăng xuất</a>");
        } else {
            resp.sendRedirect("/NguyenSV/login-session.html");
        }
    }
}
