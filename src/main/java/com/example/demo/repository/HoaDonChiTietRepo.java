package com.example.demo.repository;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.HoaDonChiTiet;
import com.example.demo.entity.SanPhamChiTiet;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Repository
public interface HoaDonChiTietRepo extends JpaRepository<HoaDonChiTiet, Integer> {
    List<HoaDonChiTiet> findByHoaDonId(Integer hoaDonId);
    HoaDonChiTiet findByHoaDonIdAndSanPhamChiTietId(Integer hoaDonId, Integer sanPhamChiTietId);
    void deleteByHoaDonId(Integer hoaDonId);

    List<HoaDonChiTiet> findByHoaDon(HoaDon hoaDon);

    @Query("SELECT SUM(hdct.so_luong) " +
            "FROM HoaDonChiTiet hdct " +
            "JOIN hdct.hoaDon h " +
            "WHERE h.tinh_trang IN (4, 13) " +
            "AND h.ngayTao BETWEEN :startDate AND :endDate")
    Integer tinhTongSoLuongSanPhamTrongHoaDonHoanThanhVaDoiTra(
            @Param("startDate") Date startDate,
            @Param("endDate") Date endDate);


    HoaDonChiTiet findByHoaDonAndSanPhamChiTiet(HoaDon hoaDon, SanPhamChiTiet sanPhamChiTiet);

    List<HoaDonChiTiet> findByHoaDon_Id(Integer idHoaDon);


    @Query("SELECT hct.sanPhamChiTiet, SUM(hct.so_luong) FROM HoaDonChiTiet hct " +
            "JOIN hct.hoaDon hd " +
            "WHERE hd.tinh_trang IN (4, 13) " +
            "GROUP BY hct.sanPhamChiTiet " +
            "ORDER BY SUM(hct.so_luong) DESC")
    List<Object[]> findTopSellingProducts(Pageable pageable);

    @Query(value = "SELECT SUM(hdct.so_luong * hdct.gia_san_pham - hdct.giam_gia) AS tong_doanh_thu " +
            "FROM hoa_don_chi_tiet hdct " +
            "JOIN hoa_don hd ON hdct.id_hoa_don = hd.id_hoa_don " +
            "WHERE CAST(hd.ngay_tao AS DATE) = :ngay AND hd.tinh_trang IN(4,13)", nativeQuery = true)
    BigDecimal tinhTongDoanhThuTheoNgayVaTinhTrang(@Param("ngay") LocalDate ngay);

    @Query(value = "SELECT SUM(hdct.so_luong) AS tong_san_pham " +
            "FROM hoa_don_chi_tiet hdct " +
            "JOIN hoa_don hd ON hdct.id_hoa_don = hd.id_hoa_don " +  // Sửa từ hoa_don_id thành id_hoa_don
            "WHERE CAST(hd.ngay_tao AS DATE) = :ngay AND hd.tinh_trang IN(4,13)", nativeQuery = true)
    Long tinhTongSanPhamBanRaTrongNgay(@Param("ngay") LocalDate ngay);
}
