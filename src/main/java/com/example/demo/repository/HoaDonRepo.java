package com.example.demo.repository;

import com.example.demo.entity.HoaDon;
<<<<<<< HEAD
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
=======
import com.example.demo.entity.KhachHang;
>>>>>>> main
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface HoaDonRepo extends JpaRepository<HoaDon, Integer> {
<<<<<<< HEAD

    @Query("SELECT h.id FROM HoaDon h WHERE h.id > :currentId ORDER BY h.id ASC")
    List<Integer> findNextId(@Param("currentId") Integer currentId);
<<<<<<< Updated upstream
=======
=======
    List<HoaDon> findByKhachHang(KhachHang khachHang);

    @Query("SELECT h.id FROM HoaDon h WHERE h.id > :currentId ORDER BY h.id ASC")
    List<Integer> findNextId(@Param("currentId") Integer currentId);
>>>>>>> main


    @Query("SELECT h FROM HoaDon h WHERE h.tinh_trang = :tinhTrang")
    List<HoaDon> findByTinhTrang(@Param("tinhTrang") Integer tinhTrang);

<<<<<<< HEAD
//    Page<HoaDon> findAllByTinhTrang(Integer tinhTrang);

    Page<HoaDon> findBySoHoaDon(String soHoaDon, Pageable pageable);


    Page<HoaDon> findByNgayTao(Date ngayTao, Pageable pageable);


>>>>>>> Stashed changes
=======
>>>>>>> main
}
