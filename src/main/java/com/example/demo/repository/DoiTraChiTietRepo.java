package com.example.demo.repository;

import com.example.demo.entity.DoiTraChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DoiTraChiTietRepo extends JpaRepository<DoiTraChiTiet, Integer> {
}
