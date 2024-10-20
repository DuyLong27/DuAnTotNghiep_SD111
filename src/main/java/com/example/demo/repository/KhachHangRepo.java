package com.example.demo.repository;

import com.example.demo.entity.KhachHang;
<<<<<<< HEAD
=======
import com.example.demo.entity.KhachHang;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
>>>>>>> main
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface KhachHangRepo extends JpaRepository<KhachHang, Integer> {
<<<<<<< HEAD
=======
    Page<KhachHang> findByTinhTrang(Integer tinhTrang, Pageable pageable);

    Page<KhachHang> findBytenKhachHangContainingIgnoreCase(String tenKhachHang, Pageable pageable);
>>>>>>> main
}
