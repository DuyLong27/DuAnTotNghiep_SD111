package com.example.demo.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "san_pham")
public class SanPham {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_san_pham")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_nha_cung_cap",referencedColumnName = "id_nha_cung_cap")
    private NhaCungCap nhaCungCap;


    @ManyToOne
    @JoinColumn(name = "id_danh_muc",referencedColumnName = "id_danh_muc")
    private DanhMuc danhMuc;

    @Column(name = "ten")
    private String ten;

//    @Column(name = "so_luong")
//    private int soLuong;

    @Column(name = "gia_ban")
    private int giaBan;

    @Column(name = "mo_ta")
    private String moTa;

    @NotNull
    @Digits(integer = 1, fraction = 0)
    @Column(name = "tinh_trang")
    private Integer tinhTrang;
}
