package com.example.demo.repository;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.KhachHang;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface HoaDonRepo extends JpaRepository<HoaDon, Integer> {
    List<HoaDon> findByKhachHang(KhachHang khachHang);

    @Query("SELECT h.id FROM HoaDon h WHERE h.id > :currentId ORDER BY h.id ASC")
    List<Integer> findNextId(@Param("currentId") Integer currentId);

    @Query("SELECT h FROM HoaDon h WHERE h.tinh_trang IN :tinhTrangList")
    Page<HoaDon> findByTinhTrangIn(@Param("tinhTrangList") List<Integer> tinhTrangList, Pageable pageable);

    @Query("SELECT h FROM HoaDon h WHERE h.tinh_trang = :tinhTrang")
    Page<HoaDon> findByTinhTrang(@Param("tinhTrang") Integer tinhTrang, Pageable pageable);

    @Query("SELECT h FROM HoaDon h WHERE h.tinh_trang = :tinhTrang")
    List<HoaDon> findByTinhTrang(@Param("tinhTrang") Integer tinhTrang);

    @Query("SELECT h FROM HoaDon h WHERE (:ngayTao IS NULL OR h.ngayTao = :ngayTao)")
    Page<HoaDon> findAll(@Param("ngayTao") java.sql.Date ngayTao, Pageable pageable);

    @Query("SELECT h FROM HoaDon h " +
            "JOIN h.khachHang k " +
            "WHERE (:soHoaDon IS NULL OR h.soHoaDon LIKE %:soHoaDon%) " +
            "AND (:tenKhachHang IS NULL OR k.tenKhachHang LIKE %:tenKhachHang%) " +
            "AND (:ngayTao IS NULL OR h.ngayTao = :ngayTao) " +
            "AND (:dsTinhTrang IS NULL OR h.tinh_trang IN :dsTinhTrang)")
    Page<HoaDon> findByFilters(@Param("soHoaDon") String soHoaDon,
                               @Param("tenKhachHang") String tenKhachHang,
                               @Param("ngayTao") java.sql.Date ngayTao,
                               @Param("dsTinhTrang") List<Integer> dsTinhTrang,
                               Pageable pageable);

    @Query("SELECT h FROM HoaDon h WHERE h.ngayTao = :ngayTao AND h.tinh_trang IN :tinhTrang")
    Page<HoaDon> findByNgayTao(@Param("ngayTao") java.sql.Date ngayTao,
                               @Param("tinhTrang") List<Integer> tinhTrang,
                               Pageable pageable);

    @Query("SELECT h FROM HoaDon h WHERE h.soHoaDon LIKE %:soHoaDon%")
    Page<HoaDon> findBySoHoaDon(@Param("soHoaDon") String soHoaDon, Pageable pageable);

    @Query("SELECT h FROM HoaDon h WHERE (:soHoaDon IS NULL OR h.soHoaDon LIKE %:soHoaDon%) " +
            "AND (:ngayTao IS NULL OR h.ngayTao = :ngayTao)")
    Page<HoaDon> findBySoHoaDonAndNgayTao(@Param("soHoaDon") String soHoaDon,
                                          @Param("ngayTao") java.sql.Date ngayTao,
                                          Pageable pageable);

    @Query("SELECT h FROM HoaDon h WHERE h.khachHang.idKhachHang = :khachHangId")
    List<HoaDon> findByKhachHangId(@Param("khachHangId") Integer khachHangId);

    // Truy vấn tổng doanh thu
    @Query("SELECT SUM(h.tongTien) FROM HoaDon h WHERE h.ngayTao BETWEEN :startDate AND :endDate")
    Integer tinhTongTienHoaDon(@Param("startDate") Date startDate, @Param("endDate") Date endDate);

    @Query("SELECT COUNT(h) FROM HoaDon h WHERE h.tinh_trang = 4 AND h.ngayTao BETWEEN :startDate AND :endDate")
    Integer tinhTongSoHoaDonHoanThanh(@Param("startDate") Date startDate, @Param("endDate") Date endDate);

    @Query("SELECT COUNT(h) FROM HoaDon h WHERE h.tinh_trang = 14 AND h.ngayTao BETWEEN :startDate AND :endDate")
    Integer tinhTongSoHoaDonHuy(@Param("startDate") Date startDate, @Param("endDate") Date endDate);

    @Query(value = "SELECT CONVERT(VARCHAR, h.ngay_tao, 23) AS date, SUM(hdct.gia_san_pham * hdct.so_luong) AS revenue " +
            "FROM hoa_don h " +
            "JOIN hoa_don_chi_tiet hdct ON h.id_hoa_don = hdct.id_hoa_don " +
            "WHERE h.ngay_tao BETWEEN :startDate AND :endDate " +
            "AND h.tinh_trang = 4 " +
            "GROUP BY CONVERT(VARCHAR, h.ngay_tao, 23) " +
            "ORDER BY date", nativeQuery = true)
    List<Object[]> tinhDoanhThuTheoNgay(@Param("startDate") Date startDate, @Param("endDate") Date endDate);

    Optional<HoaDon> findBySoHoaDon(String soHoaDon);

    @Query("SELECT h FROM HoaDon h WHERE h.soDienThoai LIKE %:phoneNumber%")
    Page<HoaDon> findByPhoneNumberContaining(@Param("phoneNumber") String phoneNumber, Pageable pageable);

    @Query("SELECT h FROM HoaDon h WHERE h.soDienThoai LIKE %:phoneNumber% AND h.tinh_trang = :tinhTrang")
    Page<HoaDon> findByPhoneNumberAndTinhTrang(@Param("phoneNumber") String phoneNumber,
                                               @Param("tinhTrang") Integer tinhTrang,
                                               Pageable pageable);
    @Query("SELECT h FROM HoaDon h WHERE h.ngayTao BETWEEN :startDate AND :endDate")
    Page<HoaDon> findByThoiGianTaoBetween(@Param("startDate") LocalDateTime startDate,
                                          @Param("endDate") LocalDateTime endDate,
                                          Pageable pageable);
    @Query("SELECT h FROM HoaDon h WHERE h.ngayTao >= :startDate")
    Page<HoaDon> findByThoiGianTaoAfter(@Param("startDate") LocalDateTime startDate, Pageable pageable);

    @Query("SELECT h FROM HoaDon h WHERE h.ngayTao <= :endDate")
    Page<HoaDon> findByThoiGianTaoBefore(@Param("endDate") LocalDateTime endDate, Pageable pageable);

    @Query(value = "SELECT spChiTiet.hinh_anh_san_pham, sp.ten, COUNT(cthd.id_hoa_don), SUM(cthd.so_luong * cthd.gia_san_pham) " +
            "FROM hoa_don_chi_tiet cthd " +
            "JOIN san_pham_chi_tiet spChiTiet ON spChiTiet.id_san_pham_chi_tiet = cthd.id_san_pham_chi_tiet " +
            "JOIN san_pham sp ON sp.id_san_pham = spChiTiet.id_san_pham " +
            "JOIN hoa_don hd ON hd.id_hoa_don = cthd.id_hoa_don " +
            "WHERE hd.tinh_trang = 4 " +
            "AND CONVERT(DATE, hd.ngay_tao) = :selectedDate " + // Sử dụng CONVERT để so sánh ngày
            "GROUP BY spChiTiet.hinh_anh_san_pham, sp.ten " +
            "ORDER BY SUM(cthd.so_luong * cthd.gia_san_pham) DESC",
            nativeQuery = true)
    List<Object[]> getProductRevenueReport(@Param("selectedDate") java.sql.Date selectedDate);

    @Query(value = "SELECT COUNT(*) AS tong_hoa_don " +
            "FROM hoa_don hd " +
            "WHERE CAST(hd.ngay_tao AS DATE) = :ngay AND hd.tinh_trang = 4", nativeQuery = true)
    Long demSoHoaDonTheoNgayVaTinhTrang(@Param("ngay") LocalDate ngay);
}