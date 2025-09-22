package vn.khang.app.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;

import vn.khang.app.dao.UserDAO;
import vn.khang.app.entity.User;

@WebServlet(urlPatterns = {"/profile"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Long uid = (Long) req.getSession().getAttribute("userId");
        User u = userDAO.findById(uid);
        req.setAttribute("user", u);
        req.getRequestDispatcher("/WEB-INF/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        Long uid = (Long) req.getSession().getAttribute("userId");
        if (uid == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User u = userDAO.findById(uid);
        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        // Validation
        if (fullname == null || fullname.trim().isEmpty()) {
            req.setAttribute("error", "Full name is required");
            req.setAttribute("user", u);
            req.getRequestDispatcher("/WEB-INF/profile.jsp").forward(req, resp);
            return;
        }

        // xử lý upload file
        Part filePart = req.getPart("image");
        String fileName = getFileName(filePart);

        if (fileName != null && !fileName.trim().isEmpty()) {
            // Validate file type
            String contentType = filePart.getContentType();
            if (!contentType.startsWith("image/")) {
                req.setAttribute("error", "Please upload only image files");
                req.setAttribute("user", u);
                req.getRequestDispatcher("/WEB-INF/profile.jsp").forward(req, resp);
                return;
            }

            // Validate file size (max 5MB)
            if (filePart.getSize() > 5 * 1024 * 1024) {
                req.setAttribute("error", "File size must be less than 5MB");
                req.setAttribute("user", u);
                req.getRequestDispatcher("/WEB-INF/profile.jsp").forward(req, resp);
                return;
            }

            try {
                String uploadPath = req.getServletContext().getRealPath("/uploads");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // Generate unique filename to avoid conflicts
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                String filePath = uploadPath + File.separator + uniqueFileName;
                filePart.write(filePath);

                u.setImage("uploads/" + uniqueFileName); // lưu đường dẫn vào DB
            } catch (Exception e) {
                req.setAttribute("error", "Error uploading file: " + e.getMessage());
                req.setAttribute("user", u);
                req.getRequestDispatcher("/WEB-INF/profile.jsp").forward(req, resp);
                return;
            }
        }

        u.setFullname(fullname.trim());
        u.setPhone(phone != null ? phone.trim() : null);
        
        try {
            userDAO.merge(u);
            req.setAttribute("success", "Profile updated successfully!");
        } catch (Exception e) {
            req.setAttribute("error", "Error updating profile: " + e.getMessage());
        }

        req.setAttribute("user", u);
        req.getRequestDispatcher("/WEB-INF/profile.jsp").forward(req, resp);
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String cd : contentDisp.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf("=") + 2, cd.length() - 1);
            }
        }
        return null;
    }
}
