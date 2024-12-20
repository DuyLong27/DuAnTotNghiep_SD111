package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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

    @ManyToOne
    @JoinColumn(name = "id_nhan_vien", referencedColumnName = "id_nhan_vien")
    private NhanVien nhanVien;

    @Column(name = "so_hoa_don")
    private String soHoaDon;

    @Column(name = "tong_tien")
    private int tongTien;

    @Column(name = "phuong_thuc_thanh_toan")
    private String phuong_thuc_thanh_toan;

    @Column(name = "ghi_chu")
    private String ghiChu;

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

    @Column(name = "thoi_gian_tao")
    private LocalDateTime thoiGianTao;

    @PrePersist
    protected void onCreate() {
        this.thoiGianTao = LocalDateTime.now();
    }

    @Column(name = "kieu_hoa_don")
    private Integer kieuHoaDon;

    @Column(name = "tinh_trang")
    private Integer tinh_trang;

    @OneToMany(mappedBy = "hoaDon", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<HoaDonChiTiet> hoaDonChiTietList;

    // Phương thức để tính tổng số tiền hóa đơn
    public void calculateTotalAmount() {
        this.tongTien = hoaDonChiTietList.stream()
                .mapToInt(detail -> detail.getGia_san_pham() * detail.getSo_luong())
                .sum();
    }
    @Transient
    private String thoiGianTaoFormatted;

    public String getThoiGianTaoFormatted() {
        if (this.thoiGianTao != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss, dd-MM-yyyy");
            return this.thoiGianTao.format(formatter);
        }
        return null;
    }
}