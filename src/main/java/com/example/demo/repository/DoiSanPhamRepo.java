package com.example.demo.repository;

import com.example.demo.entity.DoiSanPham;
import com.example.demo.entity.DoiTra;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DoiSanPhamRepo extends JpaRepository<DoiSanPham,Integer> {
    List<DoiSanPham> findByDoiTra_HoaDon_Id(Integer hoaDonId);
    @Query("SELECT dtc FROM DoiSanPham dtc WHERE dtc.doiTra = :doiTra")
    List<DoiSanPham> findByDoiTra(@Param("doiTra") DoiTra doiTra);
}
