package com.example.demo.repository;

import com.example.demo.entity.NhapHang;
import com.example.demo.entity.NhapHangChiTiet;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public interface NhapHangRepo extends JpaRepository<NhapHang, Integer> {
    Page<NhapHang> findByNhanVien_TenNhanVienContainingIgnoreCase(String tenNhanVien, Pageable pageable);

    Page<NhapHang> findByNgayTaoEquals(Date ngayTao, Pageable pageable);

    Page<NhapHang> findByNhaCungCapId(Integer nhaCungCapId, Pageable pageable);
}
