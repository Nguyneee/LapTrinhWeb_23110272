package nguyen.com.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/hello", "/xin-chao"})
public class HelloServletCookie extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter printWriter = resp.getWriter();

        String name = "";
        // nhận cookie
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("username")) {
                    name = c.getValue();
                }
            }
        }

        if (name.equals("")) {
            // chưa login → quay về login.html
        	resp.sendRedirect(req.getContextPath() + "/login-cookie.html");
        } else {
            // hiển thị chào
            printWriter.println("Xin chào " + name);
        }
    }
}
