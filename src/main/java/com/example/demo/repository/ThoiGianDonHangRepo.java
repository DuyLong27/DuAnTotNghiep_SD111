package com.example.demo.repository;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.ThoiGianDonHang;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ThoiGianDonHangRepo extends JpaRepository<ThoiGianDonHang, Integer> {
    ThoiGianDonHang findByHoaDon_Id(Integer idHoaDon);

    Optional<ThoiGianDonHang> findByHoaDonId(Integer hoaDonId);

    ThoiGianDonHang findByHoaDon(HoaDon hoaDon);

}
