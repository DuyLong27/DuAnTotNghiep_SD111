package com.example.demo.repository;

import com.example.demo.entity.SanPhamChiTiet;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface SanPhamChiTietRepo extends JpaRepository<SanPhamChiTiet, Integer> {
    // Phương thức lọc theo tình trạng
    Page<SanPhamChiTiet> findByTinhTrang(Integer tinhTrang, Pageable pageable); // Chỉnh sửa kiểu dữ liệu

//    @Modifying
//    @Query("DELETE FROM SanPhamChiTiet s WHERE s.sanPham.id = :sanPhamId")
//    void deleteBySanPhamId(@Param("sanPhamId") int sanPhamId);
}
