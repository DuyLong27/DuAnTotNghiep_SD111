package com.example.demo.repository;

import com.example.demo.entity.DoiTraChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DoiTraChiTietRepo extends JpaRepository<DoiTraChiTiet, Integer> {
    List<DoiTraChiTiet> findByDoiTra_HoaDon_Id(Integer hoaDonId);
}
