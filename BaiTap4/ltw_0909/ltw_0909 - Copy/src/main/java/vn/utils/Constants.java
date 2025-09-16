package vn.utils;

public class Constants {
    // Upload file configuration
    public static final String UPLOAD_DIRECTORY = "uploads";
    public static final String DEFAULT_FILENAME = "default-file.txt";
    
    // File size limits
    public static final int MAX_FILE_SIZE = 1024 * 1024 * 10;      // 10MB
    public static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50;   // 50MB
    public static final int FILE_SIZE_THRESHOLD = 1024 * 1024 * 2; // 2MB
    
    // Image file extensions
    public static final String[] ALLOWED_EXTENSIONS = {".jpg", ".jpeg", ".png", ".gif", ".bmp", ".webp"};
    
    // Image upload path for category images
    public static final String CATEGORY_IMAGE_PATH = "category-images";
}
