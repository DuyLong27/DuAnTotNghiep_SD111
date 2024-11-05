package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "hoa_don")
public class HoaDon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_hoa_don")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_khach_hang", referencedColumnName = "id_khach_hang")
    private KhachHang khachHang;


    @Column(name = "so_hoa_don")
    private String soHoaDon;

    @Column(name = "tong_tien")
    private int tong_tien;

    @Column(name = "phuong_thuc_thanh_toan")
    private String phuong_thuc_thanh_toan;

    @Column(name = "ghi_chu")
    private String ghi_chu;

    @Column(name = "so_dien_thoai")
    private String soDienThoai;
    @Column(name = "dia_chi_cu_the")
    private String diaChi;

    @Column(name = "phuong_thuc_van_chuyen")
    private String phuongThucVanChuyen;

    @Column(name = "ly_do_doi_tra")
    private String lyDo;

    @Column(name = "ngay_tao")
    private Date ngayTao;

    @Column(name = "tinh_trang")
    private Integer tinh_trang;

    @OneToMany(mappedBy = "hoaDon", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<HoaDonChiTiet> hoaDonChiTietList;

    // Phương thức để tính tổng số tiền hóa đơn
    public void calculateTotalAmount() {
        this.tong_tien = hoaDonChiTietList.stream()
                .mapToInt(detail -> detail.getGia_san_pham() * detail.getSo_luong())
                .sum();
    }
}