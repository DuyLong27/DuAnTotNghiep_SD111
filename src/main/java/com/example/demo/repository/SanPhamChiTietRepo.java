package com.example.demo.repository;

import com.example.demo.entity.SanPhamChiTiet;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Repository
public interface SanPhamChiTietRepo extends JpaRepository<SanPhamChiTiet, Integer> {
    Page<SanPhamChiTiet> findByTinhTrang(Integer tinhTrang, Pageable pageable);

//    @Modifying
//    @Query("DELETE FROM SanPhamChiTiet s WHERE s.sanPham.id = :sanPhamId")
//    void deleteBySanPhamId(@Param("sanPhamId") int sanPhamId);



    List<SanPhamChiTiet> findByThuongHieuId(Integer thuongHieuId);
    List<SanPhamChiTiet> findByLoaiCaPheId(Integer loaiCaPheId);
    List<SanPhamChiTiet> findByHuongViId(Integer huongViId);
    List<SanPhamChiTiet> findByLoaiHatId(Integer loaiHatId);
    List<SanPhamChiTiet> findByMucDoRangId(Integer mucDoRangId);
    List<SanPhamChiTiet> findByGiaBanBetween(Integer minPrice, Integer maxPrice);
    List<SanPhamChiTiet> findAllByOrderByGiaBanAsc();
    List<SanPhamChiTiet> findAllByOrderByGiaBanDesc();

    @Query("SELECT sp.ten, SUM(hdct.so_luong) AS totalSold "
            + "FROM HoaDonChiTiet hdct "
            + "JOIN hdct.sanPhamChiTiet spct "
            + "JOIN spct.sanPham sp "
            + "JOIN hdct.hoaDon hd "
            + "WHERE hd.ngayTao BETWEEN :startDate AND :endDate "
            + "GROUP BY sp.ten "
            + "ORDER BY totalSold DESC")
    List<Object[]> findBestSellingProduct(@Param("startDate") Date startDate, @Param("endDate") Date endDate);


    @Query("SELECT sp FROM SanPhamChiTiet sp " +
            "LEFT JOIN FETCH sp.khuyenMaiChiTietList kmct " +
            "LEFT JOIN FETCH kmct.khuyenMai " +
            "WHERE sp.tinhTrang = 1")
    List<SanPhamChiTiet> findAllWithPromotions();

}
