package com.example.demo.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "nhap_hang")
public class NhapHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_nhap_hang")
    private Integer id;

    @Column(name = "ma_phieu_nhap")
    private String maPhieuNhap;

    @ManyToOne
    @JoinColumn(name = "id_nha_cung_cap", referencedColumnName = "id_nha_cung_cap")
    private NhaCungCap nhaCungCap;

    @ManyToOne
    @JoinColumn(name = "id_nhan_vien", referencedColumnName = "id_nhan_vien")
    private NhanVien nhanVien;

    @Column(name = "ngay_nhap")
    private Date ngayNhap;

    @Column(name = "ngay_tao")
    private Date ngayTao;

    @Column(name = "tong_gia_tri")
    private Integer tongGiaTri;

    @Column(name = "ghi_chu")
    private String ghiChu;

    @Column(name = "tinh_trang")
    private Integer tinhTrang;
}
