package com.example.demo.repository;

import com.example.demo.entity.DoiTra;
import com.example.demo.entity.HoaDon;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DoiTraRepo extends JpaRepository<DoiTra, Integer> {
    DoiTra findFirstByHoaDon_Id(Integer idHoaDon);
    // Tìm tất cả DoiTra theo HoaDon
    @Query("SELECT d FROM DoiTra d WHERE d.hoaDon = :hoaDon")
    List<DoiTra> findByHoaDon(@Param("hoaDon") HoaDon hoaDon);

    @Modifying
    @Transactional
    @Query("DELETE FROM DoiTra d WHERE d.hoaDon = :hoaDon")
    void deleteByHoaDon(@Param("hoaDon") HoaDon hoaDon);
}
