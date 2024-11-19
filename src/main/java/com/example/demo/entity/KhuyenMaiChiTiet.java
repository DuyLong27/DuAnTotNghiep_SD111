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
@Table(name = "khuyen_mai_chi_tiet")
public class KhuyenMaiChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_khuyen_mai_chi_tiet")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_khuyen_mai", referencedColumnName = "id_khuyen_mai")
    private KhuyenMai khuyenMai;

    @ManyToOne
    @JoinColumn(name = "id_san_pham_chi_tiet", referencedColumnName = "id_san_pham_chi_tiet")
    private SanPhamChiTiet sanPhamChiTiet;
}
