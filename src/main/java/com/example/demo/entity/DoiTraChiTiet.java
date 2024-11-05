package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "doi_tra_chi_tiet")
public class DoiTraChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_doi_tra_chi_tiet")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_doi_tra",referencedColumnName = "id_doi_tra")
    private DoiTra doiTra;

    @ManyToOne
    @JoinColumn(name = "id_san_pham_chi_tiet",referencedColumnName = "id_san_pham_chi_tiet")
    private SanPhamChiTiet sanPhamChiTiet;


    @Column(name = "gia_san_pham")
    private int giaSanPham;

    @Column(name = "so_luong")
    private int soLuong;
}
