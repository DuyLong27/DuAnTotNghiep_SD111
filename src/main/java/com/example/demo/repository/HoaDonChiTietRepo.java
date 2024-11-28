package com.example.demo.repository;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.HoaDonChiTiet;
import com.example.demo.entity.SanPhamChiTiet;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface HoaDonChiTietRepo extends JpaRepository<HoaDonChiTiet, Integer> {
    List<HoaDonChiTiet> findByHoaDonId(Integer hoaDonId);
    HoaDonChiTiet findByHoaDonIdAndSanPhamChiTietId(Integer hoaDonId, Integer sanPhamChiTietId);
    void deleteByHoaDonId(Integer hoaDonId);

    List<HoaDonChiTiet> findByHoaDon(HoaDon hoaDon);

    @Query("SELECT SUM(hdct.so_luong) FROM HoaDonChiTiet hdct JOIN hdct.hoaDon h WHERE h.tinh_trang = 4 AND h.ngayTao BETWEEN :startDate AND :endDate")
    Integer tinhTongSoLuongSanPhamTrongHoaDonHoanThanh(@Param("startDate") Date startDate, @Param("endDate") Date endDate);

    HoaDonChiTiet findByHoaDonAndSanPhamChiTiet(HoaDon hoaDon, SanPhamChiTiet sanPhamChiTiet);

    List<HoaDonChiTiet> findByHoaDon_Id(Integer idHoaDon);


    @Query("SELECT h.sanPhamChiTiet, SUM(h.so_luong) AS total " +
            "FROM HoaDonChiTiet h " +
            "GROUP BY h.sanPhamChiTiet " +
            "ORDER BY total DESC")
    List<Object[]> findTopSellingProducts(Pageable pageable);

}
