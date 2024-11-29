package com.example.demo.repository;

import com.example.demo.entity.NhanVien;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface NhanVienRepo extends JpaRepository<NhanVien, Integer> {
    Page<NhanVien> findByTinhTrang(Integer tinhTrang, Pageable pageable);

    Page<NhanVien> findByTenNhanVienContainingIgnoreCase(String nhaCungCapTen, Pageable pageable);
}
