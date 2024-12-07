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
@Table(name = "nha_cung_cap")
public class NhaCungCap {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_nha_cung_cap")
    private Integer id;
    @Pattern(regexp = "^[A-Za-zÀ-ÖØ-öø-ÿ\\s]+$", message = "Tên khách hàng không chứa ký tự đặc biệt.")
    @Size(max = 30, message = "Tên khách hàng không được quá dài.")
    @Column(name = "ten_nha_cung_cap")
    private String tenNCC;

    @Pattern(regexp = "^0\\d{9,10}$", message = "Số điện thoại không hợp lệ. Phải bắt đầu bằng 0 và có từ 10-11 chữ số.")
    @Column(name = "so_dien_thoai")
    private String soDienThoai;
    @Email(message = "Email không hợp lệ.")
    @Size(max = 30, message = "Email không được quá dài.")
    @Column(name = "email")
    private String email;
    @Size(max = 50, message = "Địa chỉ không được quá dài.")
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
