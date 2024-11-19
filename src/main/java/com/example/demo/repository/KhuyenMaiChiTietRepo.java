package com.example.demo.repository;

import com.example.demo.entity.KhuyenMai;
import com.example.demo.entity.KhuyenMaiChiTiet;
import com.example.demo.entity.SanPhamChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface KhuyenMaiChiTietRepo extends JpaRepository<KhuyenMaiChiTiet, Integer> {
    boolean existsByKhuyenMaiAndSanPhamChiTiet(KhuyenMai khuyenMai, SanPhamChiTiet sanPhamChiTiet);

}
