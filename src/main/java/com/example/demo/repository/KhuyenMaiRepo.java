package com.example.demo.repository;

import com.example.demo.entity.KhuyenMai;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;

@Repository
public interface KhuyenMaiRepo extends JpaRepository<KhuyenMai,Integer> {
    @Query("SELECT k FROM KhuyenMai k WHERE "
            + "(:maKhuyenMai IS NULL OR k.maKhuyenMai LIKE %:maKhuyenMai%) "
            + "AND (:tenKhuyenMai IS NULL OR k.tenKhuyenMai LIKE %:tenKhuyenMai%) "
            + "AND (:giaTriMin IS NULL OR k.giaTriKhuyenMai >= :giaTriMin) "
            + "AND (:giaTriMax IS NULL OR k.giaTriKhuyenMai <= :giaTriMax) "
            + "AND (:ngayBatDau IS NULL OR k.ngayBatDau >= :ngayBatDau) "
            + "AND (:ngayKetThuc IS NULL OR k.ngayKetThuc <= :ngayKetThuc)")
    Page<KhuyenMai> findFiltered(
            @Param("maKhuyenMai") String maKhuyenMai,
            @Param("tenKhuyenMai") String tenKhuyenMai,
            @Param("giaTriMin") Integer giaTriMin,
            @Param("giaTriMax") Integer giaTriMax,
            @Param("ngayBatDau") LocalDate ngayBatDau,
            @Param("ngayKetThuc") LocalDate ngayKetThuc,
            Pageable pageable);

}
