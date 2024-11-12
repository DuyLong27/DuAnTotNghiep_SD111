package com.example.demo.repository;

import com.example.demo.entity.NhapHangChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NhapHangChiTietRepo extends JpaRepository<NhapHangChiTiet, Integer> {
    List<NhapHangChiTiet> findByNhapHangId(Integer nhapHangId);

}
