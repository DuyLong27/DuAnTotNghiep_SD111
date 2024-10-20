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
@Table(name = "nha_cung_cap")
public class NhaCungCap {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_nha_cung_cap")
    private Integer id;

    @Column(name = "ten_nha_cung_cap")
    private String tenNCC;


    @Column(name = "so_dien_thoai")
    private String soDienThoai;

    @Column(name = "email")
    private String email;

    @Column(name = "dia_chi")
    private String diaChi;

    @Column(name = "danh_sach_san_pham_cung_cap")
    private String sanPhamCungCap;

    @Column(name = "nguon_goc_xuat_xu")
    private String nguonGoc;

    @NotNull
    @Digits(integer = 1, fraction = 0)
    @Column(name = "tinh_trang")
    private Integer tinhTrang;
}
