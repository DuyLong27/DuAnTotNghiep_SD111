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
@Table(name = "nhap_hang_chi_tiet")
public class NhapHangChiTiet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_nhap_hang_chi_tiet")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_nhap_hang", referencedColumnName = "id_nhap_hang")
    private NhapHang nhapHang;

    @ManyToOne
    @JoinColumn(name = "id_san_pham", referencedColumnName = "id_san_pham")
    private SanPham sanPham;

    @Column(name = "so_luong")
    private Integer soLuong;

    @Column(name = "gia_nhap")
    private Integer giaNhap;

    @Column(name = "tong_tien")
    private Integer tongTien;

    @Column(name = "han_su_dung")
    private Date hanSuDung;

    @Column(name = "ngay_san_xuat")
    private Date ngaySanXuat;

}
