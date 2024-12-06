package com.example.demo.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
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
    @Size(min = 3, max = 20, message = "Tên sản phẩm phải từ 3 đến 20 ký tự!")
    @Pattern(regexp = "^[a-zA-Z0-9\\s]+$", message = "Tên sản phẩm không được chứa ký tự đặc biệt!")
    private String ten;


    @Column(name = "gia_ban")
    @Min(value = 60000, message = "Giá bán phải lớn hơn hoặc bằng 60000!")
    private int giaBan;


    @Column(name = "mo_ta")
    @Size(min = 10, max = 50, message = "Mô tả phải từ 10 đến 50 ký tự!")
    private String moTa;


    @NotNull
    @Digits(integer = 1, fraction = 0)
    @Column(name = "tinh_trang")
    private Integer tinhTrang;
}
