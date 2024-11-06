package com.example.demo.repository;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.KhachHang;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface HoaDonRepo extends JpaRepository<HoaDon, Integer> {
    List<HoaDon> findByKhachHang(KhachHang khachHang);

    @Query("SELECT h.id FROM HoaDon h WHERE h.id > :currentId ORDER BY h.id ASC")
    List<Integer> findNextId(@Param("currentId") Integer currentId);


    @Query("SELECT h FROM HoaDon h WHERE h.tinh_trang = :tinhTrang")
    List<HoaDon> findByTinhTrang(@Param("tinhTrang") Integer tinhTrang);

    @Query("SELECT h FROM HoaDon h WHERE (:ngayTao IS NULL OR h.ngayTao = :ngayTao)")
    Page<HoaDon> findAll(@Param("ngayTao") java.sql.Date ngayTao, Pageable pageable);

    @Query("SELECT h FROM HoaDon h " +
            "JOIN h.khachHang k " +
            "WHERE (:soHoaDon IS NULL OR h.soHoaDon LIKE %:soHoaDon%) " +
            "AND (:tenKhachHang IS NULL OR k.tenKhachHang LIKE %:tenKhachHang%) " +
            "AND (:ngayTao IS NULL OR h.ngayTao = :ngayTao)")
    Page<HoaDon> findByFilters(@Param("soHoaDon") String soHoaDon,
                               @Param("tenKhachHang") String tenKhachHang,
                               @Param("ngayTao") java.sql.Date ngayTao,
                               Pageable pageable);

    @Query("SELECT h FROM HoaDon h WHERE h.ngayTao = :ngayTao")
    Page<HoaDon> findByNgayTao(@Param("ngayTao") Date ngayTao, Pageable pageable);

    @Query("SELECT h FROM HoaDon h WHERE h.soHoaDon LIKE %:soHoaDon%")
    Page<HoaDon> findBySoHoaDon(@Param("soHoaDon") String soHoaDon, Pageable pageable);

    @Query("SELECT h FROM HoaDon h WHERE h.khachHang.tenKhachHang LIKE %:tenKhachHang%")
    Page<HoaDon> findByTenKhachHang(@Param("tenKhachHang") String tenKhachHang, Pageable pageable);

}