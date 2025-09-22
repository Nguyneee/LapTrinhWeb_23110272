package vn.khang.app.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = {"/debug"})
public class DebugServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        resp.setContentType("text/html; charset=UTF-8");
        PrintWriter out = resp.getWriter();
        
        out.println("<html><head><title>Debug Info</title></head><body>");
        out.println("<h2>Debug Information</h2>");
        
        // Test pagination calculation
        long total = 0;
        int size = 10;
        int pages = Math.max(0, (int) Math.ceil(total / (double) size));
        
        out.println("<p>Total: " + total + "</p>");
        out.println("<p>Size: " + size + "</p>");
        out.println("<p>Pages: " + pages + "</p>");
        out.println("<p>Pages-1: " + (pages - 1) + "</p>");
        
        out.println("<h3>Test pagination loop:</h3>");
        if (pages > 0) {
            for (int i = 0; i < pages; i++) {
                out.println("<span>[" + (i+1) + "] </span>");
            }
        } else {
            out.println("<p>No pagination needed</p>");
        }
        
        out.println("</body></html>");
    }
}
