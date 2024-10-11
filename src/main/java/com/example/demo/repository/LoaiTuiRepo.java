package com.example.demo.repository;

import com.example.demo.entity.LoaiTui;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LoaiTuiRepo extends JpaRepository<LoaiTui, Integer> {
}
