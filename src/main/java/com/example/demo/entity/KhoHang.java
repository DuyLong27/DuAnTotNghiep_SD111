package com.example.demo.entity;

import jakarta.persistence.*;
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
@Table(name = "kho_hang")
public class KhoHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_kho_hang")
    private Integer id;

    @Column(name = "ten_kho")
    private String tenKho;

    @Column(name = "dia_chi")
    private String diaChi;

    @Column(name = "san_pham_trong_kho")
    private String spTrongKho;

    @Column(name = "so_luong_ton_kho")
    private Integer slTonKho;

    @Column(name = "ngay_thay_doi_ton_kho")
    private LocalDate ngayThayDoiTonKho;

    @ManyToOne
    @JoinColumn(name = "id_nhan_vien", referencedColumnName = "id_nhan_vien")
    private NhanVien nhanVien;
}
