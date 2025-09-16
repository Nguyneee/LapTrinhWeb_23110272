package vn.iotstar.configs.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/test")
public class TestController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        out.println("<html><body>");
        out.println("<h1>Test Servlet Working!</h1>");
        out.println("<p>Context Path: " + req.getContextPath() + "</p>");
        out.println("<p>Servlet Path: " + req.getServletPath() + "</p>");
        out.println("<p>Request URI: " + req.getRequestURI() + "</p>");
        out.println("<a href='" + req.getContextPath() + "/login'>Go to Login</a>");
        out.println("</body></html>");
    }
}