package com.example.demo.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Digits;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "doi_tra")
public class DoiTra {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_doi_tra")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_hoa_don",referencedColumnName = "id_hoa_don")
    private HoaDon hoaDon;

    @Column(name = "ly_do_cu_the")
    private String lyDoCuThe;

    @Column(name = "hinh_thuc")
    private String hinhThuc;

    @Column(name = "tien_phai_hoan")
    private int tienHoan;

    @Column(name = "tien_bu")
    private int tienBu;

    @Column(name = "phuong_thuc_chuyen_tien")
    private String phuongThucChuyenTien;

    @Column(name = "ten_ngan_hang")
    private String tenNganHang;

    @Column(name = "so_ngan_hang")
    private String soNganHang;

    @Column(name = "mo_ta")
    private String moTa;
    @Column(name = "hinh_anh")
    private String hinhAnh;

    @Column(name = "ngay_yeu_cau")
    private Date ngayYeuCau;

    @Digits(integer = 2, fraction = 0)
    @Column(name = "tinh_trang")
    private int tinhTrang;

    @Column(name = "loai_dich_vu")
    private int loaiDichVu;
}
