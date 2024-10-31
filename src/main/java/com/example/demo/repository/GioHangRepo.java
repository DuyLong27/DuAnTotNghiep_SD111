package com.example.demo.repository;

import com.example.demo.entity.GioHang;
import com.example.demo.entity.GioHangChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;


@Repository
public interface GioHangRepo extends JpaRepository<GioHang, Integer> {
    Optional<GioHang> findByKhachHangIsNull();
}
