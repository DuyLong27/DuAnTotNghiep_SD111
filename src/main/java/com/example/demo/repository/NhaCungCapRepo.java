package com.example.demo.repository;

import com.example.demo.entity.NhaCungCap;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NhaCungCapRepo extends JpaRepository<NhaCungCap,Integer> {
    // Tìm kiếm theo tên nhà cung cấp
    Page<NhaCungCap> findByTenNCCContaining(String tenNCC, Pageable pageable);

    // Tìm kiếm theo tên nhà cung cấp và tình trạng
    Page<NhaCungCap> findByTenNCCContainingAndTinhTrang(String tenNCC, Integer tinhTrang, Pageable pageable);

    // Lọc theo tình trạng
    Page<NhaCungCap> findByTinhTrang(Integer tinhTrang, Pageable pageable);
}
