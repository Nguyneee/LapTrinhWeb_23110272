package vn.controller.admin;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.entity.Category;
import vn.service.ICategoryService;
import vn.service.implement.CategoryService;
import vn.utils.Constants;

@WebServlet(urlPatterns = "/admin/category/add")
@MultipartConfig(fileSizeThreshold = Constants.FILE_SIZE_THRESHOLD,
                 maxFileSize = Constants.MAX_FILE_SIZE,
                 maxRequestSize = Constants.MAX_REQUEST_SIZE)
public class CategoryAddController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    public ICategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String categoryName = req.getParameter("categoryname");
        String imageUrl = req.getParameter("images"); // URL input
        
        Category category = new Category();
        category.setName(categoryName);

        try {
            String finalImagePath = null;
            
            // Check if file upload is provided
            Part filePart = req.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                // File upload path
                String fileName = getFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    // Create upload directory
                    String uploadPath = getServletContext().getRealPath("") + File.separator + Constants.CATEGORY_IMAGE_PATH;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    
                    // Save file
                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    filePart.write(uploadPath + File.separator + uniqueFileName);
                    
                    // Set relative path for database
                    finalImagePath = Constants.CATEGORY_IMAGE_PATH + "/" + uniqueFileName;
                }
            } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                // Use URL input if no file uploaded
                finalImagePath = imageUrl.trim();
            }
            
            category.setImages(finalImagePath);
            categoryService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi thêm danh mục: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
        }
    }
    
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition == null) {
            return null;
        }
        
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                String fileName = content.substring(content.indexOf("=") + 2, content.length() - 1);
                return fileName.isEmpty() ? null : fileName;
            }
        }
        return null;
    }
}
