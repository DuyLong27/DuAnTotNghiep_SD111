package com.example.demo.entity;

import jakarta.persistence.*;
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
@Table(name = "hoa_don_chi_tiet")
public class HoaDonChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_hoa_don_chi_tiet")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_hoa_don",referencedColumnName = "id_hoa_don")
    private HoaDon hoaDon;

    @ManyToOne
    @JoinColumn(name = "id_san_pham_chi_tiet",referencedColumnName = "id_san_pham_chi_tiet")
    private SanPhamChiTiet sanPhamChiTiet;

    @Column(name = "tong_tien")
    private int tong_tien;

    @Column(name = "phuong_thuc_thanh_toan")
    private String phuong_thuc_thanh_toan;

    @Column(name = "so_luong")
    private int so_luong;

    @Column(name = "giam_gia")
    private int giam_gia;


    @Column(name = "ghi_chu")
    private String ghi_chu;

    @Column(name = "tinh_trang")
    private Boolean tinhTrang;

}
