package vn.hcmute.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.hcmute.entities.Category;
import java.util.Optional;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
    // tìm kiếm theo tên
    Page<Category> findByNameContainingIgnoreCase(String keyword, Pageable pageable);
    
    // tìm theo tên chính xác
    Optional<Category> findByName(String name);
}
