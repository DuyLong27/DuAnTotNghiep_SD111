package com.example.demo.repository;

import com.example.demo.entity.DoiTra;
import com.example.demo.entity.DoiTraChiTiet;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DoiTraChiTietRepo extends JpaRepository<DoiTraChiTiet, Integer> {
    List<DoiTraChiTiet> findByDoiTra_HoaDon_Id(Integer hoaDonId);
    @Query("SELECT dtc FROM DoiTraChiTiet dtc WHERE dtc.doiTra = :doiTra")
    List<DoiTraChiTiet> findByDoiTra(@Param("doiTra") DoiTra doiTra);

    @Modifying
    @Transactional
    @Query("DELETE FROM DoiTraChiTiet dtc WHERE dtc.doiTra = :doiTra")
    void deleteByDoiTra(@Param("doiTra") DoiTra doiTra);
}
