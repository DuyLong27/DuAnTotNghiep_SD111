package com.example.demo.repository;

import com.example.demo.entity.HoaDonChiTiet;
import com.example.demo.entity.NhapHang;
import com.example.demo.entity.NhapHangChiTiet;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface NhapHangChiTietRepo extends JpaRepository<NhapHangChiTiet, Integer> {
    List<NhapHangChiTiet> findByNhapHangId(Integer nhapHangId);

    Page<NhapHangChiTiet> findByNhapHang_NhanVien_TenNhanVienContainingIgnoreCase(String tenNhanVien, Pageable pageable);

    Page<NhapHangChiTiet> findByNhapHang_NgayTaoEquals(Date ngayTao, Pageable pageable);

    Page<NhapHangChiTiet> findBySanPhamId(Integer sanPhamId, Pageable pageable);
}
