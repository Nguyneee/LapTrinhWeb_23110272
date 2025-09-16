package vn.iotstar.configs.controller;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.configs.dao.IUserDao;
import vn.iotstar.configs.dao.implement.UserDaoImpl;
import vn.iotstar.configs.model.UserModel;

@WebServlet(urlPatterns = {"/profile", "/profile/edit"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserDao userDao = new UserDaoImpl();
    
    // Allowed image extensions
    private static final String[] ALLOWED_EXTENSIONS = {".jpg", ".jpeg", ".png", ".gif", ".bmp"};

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserModel user = (UserModel) session.getAttribute("account");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getServletPath();
        if ("/profile/edit".equals(path)) {
            req.setAttribute("user", user);
            req.getRequestDispatcher("/views/profile/profile-edit.jsp").forward(req, resp);
        } else {
            req.setAttribute("user", user);
            req.getRequestDispatcher("/views/profile/profile.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        UserModel user = (UserModel) session.getAttribute("account");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            String fullname = req.getParameter("fullname");
            String phone = req.getParameter("phone");

            // Validation
            if (fullname == null || fullname.trim().isEmpty()) {
                req.setAttribute("error", "Họ và tên không được để trống!");
                req.setAttribute("user", user);
                req.getRequestDispatcher("/views/profile/profile-edit.jsp").forward(req, resp);
                return;
            }

            if (phone != null && !phone.trim().isEmpty() && !phone.matches("^[0-9]{10,11}$")) {
                req.setAttribute("error", "Số điện thoại không hợp lệ! (10-11 số)");
                req.setAttribute("user", user);
                req.getRequestDispatcher("/views/profile/profile-edit.jsp").forward(req, resp);
                return;
            }

            // Handle file upload
            String fileName = user.getAvatar(); // Keep current avatar if no new upload
            Part filePart = req.getPart("avatar");
            
            if (filePart != null && filePart.getSize() > 0) {
                String originalFileName = filePart.getSubmittedFileName();
                
                // Validate file extension
                if (!isValidImageFile(originalFileName)) {
                    req.setAttribute("error", "Chỉ cho phép upload file ảnh (.jpg, .jpeg, .png, .gif, .bmp)");
                    req.setAttribute("user", user);
                    req.getRequestDispatcher("/views/profile/profile-edit.jsp").forward(req, resp);
                    return;
                }
                
                // Generate unique filename
                String fileExtension = getFileExtension(originalFileName);
                fileName = "avatar_" + user.getId() + "_" + System.currentTimeMillis() + fileExtension;
                
                // Create upload directory
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                // Save file
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                
                // Delete old avatar if it's not default
                if (user.getAvatar() != null && !user.getAvatar().equals("default.png")) {
                    String oldFilePath = uploadPath + File.separator + user.getAvatar();
                    File oldFile = new File(oldFilePath);
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }
            }

            // Update user information
            user.setFullName(fullname.trim());
            user.setPhone(phone != null ? phone.trim() : null);
            if (fileName != null && !fileName.equals(user.getAvatar())) {
                user.setAvatar(fileName);
            }

            // Save to database
            userDao.update(user);
            
            // Update session
            session.setAttribute("account", user);

            req.setAttribute("success", "Cập nhật thông tin cá nhân thành công!");
            resp.sendRedirect(req.getContextPath() + "/profile?success=1");
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin: " + e.getMessage());
            req.setAttribute("user", user);
            req.getRequestDispatcher("/views/profile/profile-edit.jsp").forward(req, resp);
        }
    }
    
    private boolean isValidImageFile(String fileName) {
        if (fileName == null) return false;
        String lowerFileName = fileName.toLowerCase();
        for (String ext : ALLOWED_EXTENSIONS) {
            if (lowerFileName.endsWith(ext)) {
                return true;
            }
        }
        return false;
    }
    
    private String getFileExtension(String fileName) {
        if (fileName == null) return "";
        int lastDotIndex = fileName.lastIndexOf('.');
        return (lastDotIndex > 0) ? fileName.substring(lastDotIndex) : "";
    }
}
