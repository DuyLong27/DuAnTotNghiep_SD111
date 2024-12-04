package com.example.demo.repository;

import com.example.demo.entity.DoiSanPham;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DoiSanPhamRepo extends JpaRepository<DoiSanPham,Integer> {
}
