package com.example.demo.repository;

import com.example.demo.entity.NhanVien;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NhanVienRepo extends JpaRepository<NhanVien, Integer> {
    Page<NhanVien> findByTinhTrang(Integer tinhTrang, Pageable pageable);

    Page<NhanVien> findByTenNhanVienContainingIgnoreCase(String nhaCungCapTen, Pageable pageable);

    NhanVien findByEmail(String email);
}
