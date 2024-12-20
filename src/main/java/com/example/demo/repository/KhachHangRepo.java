package com.example.demo.repository;

import com.example.demo.entity.KhachHang;
import com.example.demo.entity.KhachHang;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface KhachHangRepo extends JpaRepository<KhachHang, Integer> {
    //    Page<KhachHang> findByTinhTrang(Integer tinhTrang, Pageable pageable);
    KhachHang findBySoDienThoai(String soDienThoai);
    Page<KhachHang> findBytenKhachHangContainingIgnoreCase(String tenKhachHang, Pageable pageable);
    KhachHang findByEmail(String email);
}