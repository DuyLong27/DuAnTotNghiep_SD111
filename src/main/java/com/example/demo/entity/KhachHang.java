package com.example.demo.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@Entity
@Table(name = "khach_hang")

public class KhachHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_khach_hang")
    private Integer id_khach_hang;

    @Column(name = "ten_khach_hang")
    private String ten_khach_hang;

    @Column(name = "email")
    private String email;

    @Column(name = "mat_khau")
    private String mat_khau;

    @Column(name = "so_dien_thoai")
    private String so_dien_thoai;

    @Column(name = "dia_chi")
    private String dia_chi;

    @Column(name = "diem_tich_luy")
    private Integer diem_tich_luy;

    @Column(name = "ngay_dang_ky")
    private Date ngay_dang_ky;

    @Column(name = "lich_su_mua_hang")
    private String lich_su_mua_hang;

    @Column(name = "khuyen_mai_da_dung")
    private String khuyen_mai_da_dung;

}
