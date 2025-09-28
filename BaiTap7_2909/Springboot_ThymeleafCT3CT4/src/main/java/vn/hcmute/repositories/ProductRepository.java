package vn.hcmute.repositories;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hcmute.entities.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    
    // Tìm kiếm theo nội dung tên
    List<Product> findByProductNameContaining(String name);
    
    // Tìm kiếm và phân trang
    Page<Product> findByProductNameContaining(String name, Pageable pageable);
    
    // Tìm theo tên sản phẩm chính xác
    Optional<Product> findByProductName(String name);
    
    // Tìm theo ngày tạo
    Optional<Product> findByCreateDate(Date createDate);
    
    // Tìm theo category
    List<Product> findByCategoryId(Long categoryId);
    
    // Tìm theo category với phân trang
    Page<Product> findByCategoryId(Long categoryId, Pageable pageable);
    
    // Tìm theo status
    List<Product> findByStatus(short status);
    
    // Tìm theo status với phân trang
    Page<Product> findByStatus(short status, Pageable pageable);
}
