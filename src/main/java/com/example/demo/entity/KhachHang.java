package com.example.demo.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "khach_hang")

public class KhachHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_khach_hang")
    private Integer idKhachHang;
    @Pattern(regexp = "^[A-Za-zÀ-ÖØ-öø-ÿ\\s]+$", message = "Tên khách hàng không chứa ký tự đặc biệt.")
    @Size(max = 30, message = "Tên khách hàng không được quá dài.")
    @Column(name = "ten_khach_hang")
    private String tenKhachHang;
    @Email(message = "Email không hợp lệ.")
    @Size(max = 30, message = "Email không được quá dài.")
    @Column(name = "email")
    private String email;

    @Column(name = "mat_khau")
    private String matKhau;
    @Pattern(regexp = "^0\\d{9,10}$", message = "Số điện thoại không hợp lệ. Phải bắt đầu bằng 0 và có từ 10-11 chữ số.")
    @Column(name = "so_dien_thoai")
    private String soDienThoai;
    @Size(max = 50, message = "Địa chỉ không được quá dài.")
    @Column(name = "dia_chi")
    private String diaChi;

    @Column(name = "diem_tich_luy")
    private Integer diemTichLuy;

    @Column(name = "ngay_dang_ky")
    private LocalDate ngayDangKy;

    @Column(name = "role", nullable = false)
    private int role = 2;
}
