package com.example.demo.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "nhan_vien")
public class NhanVien {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_nhan_vien")
    private Integer id;
    @Pattern(regexp = "^[A-Za-zÀ-ÖØ-öø-ÿ\\s]+$", message = "Tên nhân viên không chứa ký tự đặc biệt.")
    @Size(max = 30, message = "Tên nhân viên không được quá dài.")
    @Column(name = "ten_nhan_vien")
    private String tenNhanVien;
    @Email(message = "Email không hợp lệ.")
    @Size(max = 30, message = "Email không được quá dài.")
    @Column(name = "email")
    private String email;

    @Column(name = "mat_khau")
    private String matKhau;

    @Column(name = "so_dien_thoai")
    private String soDienThoai;
    @Pattern(regexp = "^[A-Za-zÀ-ÖØ-öø-ÿ\\s]+$", message = "Chức vụ không chứa ký tự đặc biệt.")
    @Size(max = 30, message = "Chức vụ không được quá dài.")
    @Column(name = "chuc_vu")
    private String chucVu;

    @Column(name = "ngay_di_lam")
    private Date ngayDiLam;

    @NotNull
    @Digits(integer = 1, fraction = 0)
    @Column(name = "tinh_trang")
    private Integer tinhTrang;

    @Column(name = "role", nullable = false)
    private int role = 1;

}
