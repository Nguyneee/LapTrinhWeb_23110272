package vn.hcmute.controllers.api;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import vn.hcmute.entities.Category;
import vn.hcmute.entities.Product;
import vn.hcmute.model.Response;
import vn.hcmute.services.CategoryService;
import vn.hcmute.services.ProductService;
import vn.hcmute.services.StorageService;

@RestController
@RequestMapping(path = "/api/product")
public class ProductAPIController {
    
    @Autowired
    private ProductService productService;
    
    @Autowired
    private CategoryService categoryService;
    
    @Autowired
    private StorageService storageService;

    @GetMapping
    public ResponseEntity<?> getAllProduct() {
        return new ResponseEntity<Response>(new Response(true, "Thành công", 
                productService.findAll()), HttpStatus.OK);
    }

    @PostMapping(path = "/getProduct")
    public ResponseEntity<?> getProduct(@Validated @RequestParam("id") Long id) {
        Optional<Product> product = productService.findById(id);
        if (product.isPresent()) {
            return new ResponseEntity<Response>(new Response(true, "Thành công", 
                    product.get()), HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(new Response(false, "Thất bại", 
                    null), HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping(path = "/addProduct")
    public ResponseEntity<?> addProduct(@Validated @RequestParam("productName") String productName,
                                      @RequestParam("imageFile") MultipartFile productImages,
                                      @Validated @RequestParam("unitPrice") Double productPrice,
                                      @Validated @RequestParam("discount") Double promotionalPrice,
                                      @Validated @RequestParam("description") String productDescription,
                                      @Validated @RequestParam("categoryId") Long categoryId,
                                      @Validated @RequestParam("quantity") Integer quantity,
                                      @Validated @RequestParam("status") Short status) {
        Optional<Product> optProduct = productService.findByProductName(productName);
        if (optProduct.isPresent()) {
            return new ResponseEntity<Response>(
                    new Response(false, "Sản phẩm này đã tồn tại trong hệ thống", 
                            optProduct.get()), HttpStatus.BAD_REQUEST);
        } else {
            Product product = new Product();
            Timestamp timestamp = new Timestamp(new Date(System.currentTimeMillis()).getTime());
            
            try {
                // Xử lý category liên quan product
                Optional<Category> categoryOpt = categoryService.findById(categoryId);
                if (categoryOpt.isPresent()) {
                    product.setCategory(categoryOpt.get());
                }
                
                // Kiểm tra tồn tại file, lưu file
                if (!productImages.isEmpty()) {
                    UUID uuid = UUID.randomUUID();
                    String uuString = uuid.toString();
                    // Lưu file vào trường Images
                    product.setImages(storageService.getStorageFilename(productImages, uuString));
                    storageService.store(productImages, product.getImages());
                }
                
                product.setProductName(productName);
                product.setUnitPrice(productPrice);
                product.setDiscount(promotionalPrice);
                product.setDescription(productDescription);
                product.setQuantity(quantity);
                product.setStatus(status);
                product.setCreateDate(timestamp);
                
                productService.save(product);
                optProduct = productService.findByCreateDate(timestamp);
            } catch (Exception e) {
                e.printStackTrace();
                return new ResponseEntity<Response>(
                        new Response(false, "Có lỗi xảy ra: " + e.getMessage(), 
                                null), HttpStatus.INTERNAL_SERVER_ERROR);
            }
            
            return new ResponseEntity<Response>(new Response(true, "Thành công", 
                    optProduct.get()), HttpStatus.OK);
        }
    }

    @PutMapping(path = "/updateProduct")
    public ResponseEntity<?> updateProduct(@Validated @RequestParam("productId") Long productId,
                                         @Validated @RequestParam("productName") String productName,
                                         @RequestParam("imageFile") MultipartFile productImages,
                                         @Validated @RequestParam("unitPrice") Double productPrice,
                                         @Validated @RequestParam("discount") Double promotionalPrice,
                                         @Validated @RequestParam("description") String productDescription,
                                         @Validated @RequestParam("categoryId") Long categoryId,
                                         @Validated @RequestParam("quantity") Integer quantity,
                                         @Validated @RequestParam("status") Short status) {
        Optional<Product> optProduct = productService.findById(productId);
        if (optProduct.isEmpty()) {
            return new ResponseEntity<Response>(new Response(false, "Không tìm thấy Product", 
                    null), HttpStatus.BAD_REQUEST);
        } else if (optProduct.isPresent()) {
            try {
                // Xử lý category liên quan product
                Optional<Category> categoryOpt = categoryService.findById(categoryId);
                if (categoryOpt.isPresent()) {
                    optProduct.get().setCategory(categoryOpt.get());
                }
                
                // Kiểm tra tồn tại file, lưu file
                if (!productImages.isEmpty()) {
                    UUID uuid = UUID.randomUUID();
                    String uuString = uuid.toString();
                    // Lưu file vào trường Images
                    optProduct.get().setImages(storageService.getStorageFilename(productImages, uuString));
                    storageService.store(productImages, optProduct.get().getImages());
                }
                
                optProduct.get().setProductName(productName);
                optProduct.get().setUnitPrice(productPrice);
                optProduct.get().setDiscount(promotionalPrice);
                optProduct.get().setDescription(productDescription);
                optProduct.get().setQuantity(quantity);
                optProduct.get().setStatus(status);
                
                productService.save(optProduct.get());
                return new ResponseEntity<Response>(new Response(true, "Cập nhật Thành công", 
                        optProduct.get()), HttpStatus.OK);
            } catch (Exception e) {
                e.printStackTrace();
                return new ResponseEntity<Response>(
                        new Response(false, "Có lỗi xảy ra: " + e.getMessage(), 
                                null), HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
        return null;
    }

    @DeleteMapping(path = "/deleteProduct")
    public ResponseEntity<?> deleteProduct(@Validated @RequestParam("productId") Long productId) {
        Optional<Product> optProduct = productService.findById(productId);
        if (optProduct.isEmpty()) {
            return new ResponseEntity<Response>(new Response(false, "Không tìm thấy Product", 
                    null), HttpStatus.BAD_REQUEST);
        } else if (optProduct.isPresent()) {
            productService.delete(optProduct.get());
            return new ResponseEntity<Response>(new Response(true, "Xóa Thành công", 
                    optProduct.get()), HttpStatus.OK);
        }
        return null;
    }
}
