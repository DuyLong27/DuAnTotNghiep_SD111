package com.example.demo.repository;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.KhachHang;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HoaDonRepo extends JpaRepository<HoaDon, Integer> {
    List<HoaDon> findByKhachHang(KhachHang khachHang);

    @Query("SELECT h.id FROM HoaDon h WHERE h.id > :currentId ORDER BY h.id ASC")
    List<Integer> findNextId(@Param("currentId") Integer currentId);


    @Query("SELECT h FROM HoaDon h WHERE h.tinh_trang = :tinhTrang")
    List<HoaDon> findByTinhTrang(@Param("tinhTrang") Integer tinhTrang);

}
