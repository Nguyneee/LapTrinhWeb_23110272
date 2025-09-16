package vn.controller.admin;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.utils.Constants;

@WebServlet("/uploadfile")
@MultipartConfig(fileSizeThreshold = Constants.FILE_SIZE_THRESHOLD, // 2MB
                 maxFileSize = Constants.MAX_FILE_SIZE,            // 10MB
                 maxRequestSize = Constants.MAX_REQUEST_SIZE)      // 50MB
public class UploadFileController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/upload-file.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String uploadPath = getServletContext().getRealPath("") + File.separator + Constants.UPLOAD_DIRECTORY;
        
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        
        try {
            String fileName = "";
            for (Part part : request.getParts()) {
                fileName = getFileName(part);
                if (fileName != null && !fileName.isEmpty()) {
                    part.write(uploadPath + File.separator + fileName);
                }
            }
            request.setAttribute("message", "File " + fileName + " has uploaded successfully!");
        } catch (FileNotFoundException fne) {
            request.setAttribute("message", "There was an error: " + fne.getMessage());
        } catch (Exception e) {
            request.setAttribute("message", "There was an error: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/views/admin/upload-result.jsp").forward(request, response);
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition == null) {
            return Constants.DEFAULT_FILENAME;
        }
        
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                String fileName = content.substring(content.indexOf("=") + 2, content.length() - 1);
                return fileName.isEmpty() ? Constants.DEFAULT_FILENAME : fileName;
            }
        }
        return Constants.DEFAULT_FILENAME;
    }
}
