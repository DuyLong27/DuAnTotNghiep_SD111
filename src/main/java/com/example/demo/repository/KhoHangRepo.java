package com.example.demo.repository;

import com.example.demo.entity.KhoHang;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface KhoHangRepo extends JpaRepository<KhoHang, Integer> {
}
