package com.example.demo.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "ca_lam_viec")
public class CaLamViec {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_nhan_vien")
    private Integer idNhanVien;

    @Column(name = "ngay_lam_viec")
    private LocalDate ngayLamViec;

    @Column(name = "gio_bat_dau")
    private Integer gioBatDau;

    @Column(name = "gio_ket_thuc")
    private Integer gioKetThuc;

    @Column(name = "vi_tri_lam_viec")
    private String viTriLamViec;

    @Column(name = "trach_nhiem")
    private String trachNhiem;

    @Column(name = "ghi_chu")
    private String ghiChu;
}
