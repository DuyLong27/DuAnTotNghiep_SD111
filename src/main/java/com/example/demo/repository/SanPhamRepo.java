package com.example.demo.repository;

import com.example.demo.entity.SanPham;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SanPhamRepo extends JpaRepository<SanPham, Integer> {
    Page<SanPham> findByTinhTrang(Integer tinhTrang, Pageable pageable);
    Page<SanPham> findByDanhMucId(Integer danhMucId, Pageable pageable);
    Page<SanPham> findByTinhTrangAndDanhMucId(Integer tinhTrang, Integer danhMucId, Pageable pageable);

    Page<SanPham> findByNhaCungCap_TenNCCContainingIgnoreCase(String nhaCungCapTen, Pageable pageable);
}
