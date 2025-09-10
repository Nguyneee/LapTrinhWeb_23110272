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
    private IUserDao userDao = new UserDaoImpl();

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

        HttpSession session = req.getSession();
        UserModel user = (UserModel) session.getAttribute("account");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        // upload ảnh
        Part filePart = req.getPart("avatar");
        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String uploadPath = req.getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePart.write(uploadPath + File.separator + fileName);
        }

        // cập nhật user
        user.setFullName(fullname);
        user.setPhone(phone);
        if (fileName != null) {
            user.setAvatar("uploads/" + fileName);
        }

        userDao.update(user);
        session.setAttribute("account", user);

        req.setAttribute("message", "Cập nhật thông tin thành công!");
        resp.sendRedirect(req.getContextPath() + "/profile");
    }
}
