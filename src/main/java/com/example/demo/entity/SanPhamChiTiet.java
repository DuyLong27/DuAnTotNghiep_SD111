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
@Table(name = "san_pham_chi_tiet")
public class SanPhamChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_san_pham_chi_tiet")
    private Integer id;
    @Column(name = "ma_san_pham_chi_tiet")
    private String ma;


    @Column(name = "hinh_anh_san_pham")
    private String hinhAnh;

    @Column(name = "ngay_het_han")
    private Date ngayHetHan;
    @Column(name = "danh_gia_san_pham")
    private String danhGia;
    @Column(name = "so_luong")
    private int soLuong;

    @Column(name = "gia_ban")
    private int giaBan;

    @Digits(integer = 1, fraction = 0)
    @Column(name = "tinh_trang")
    private int tinhTrang;

    @ManyToOne
    @JoinColumn(name = "id_san_pham", referencedColumnName = "id_san_pham")
    private SanPham sanPham;

    @ManyToOne
    @JoinColumn(name = "id_loai_ca_phe", referencedColumnName = "id_loai_ca_phe")
    private LoaiCaPhe loaiCaPhe;

    @ManyToOne
    @JoinColumn(name = "id_can_nang", referencedColumnName = "id_can_nang")
    private CanNang canNang;

    @ManyToOne
    @JoinColumn(name = "id_loai_hat", referencedColumnName = "id_loai_hat")
    private LoaiHat loaiHat;

    @ManyToOne
    @JoinColumn(name = "id_loai_tui", referencedColumnName = "id_loai_tui")
    private LoaiTui loaiTui;

    @ManyToOne
    @JoinColumn(name = "id_muc_do_rang", referencedColumnName = "id_muc_do_rang")
    private MucDoRang mucDoRang;

    @ManyToOne
    @JoinColumn(name = "id_huong_vi", referencedColumnName = "id_huong_vi")
    private HuongVi huongVi;

    @ManyToOne
    @JoinColumn(name = "id_thuong_hieu", referencedColumnName = "id_thuong_hieu")
    private ThuongHieu thuongHieu;
}
