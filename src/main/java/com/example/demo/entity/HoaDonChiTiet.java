package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.util.Date;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "hoa_don_chi_tiet")
public class HoaDonChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_hoa_don_chi_tiet")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_hoa_don",referencedColumnName = "id_hoa_don")
    private HoaDon hoaDon;

    @ManyToOne
    @JoinColumn(name = "id_san_pham",referencedColumnName = "id_san_pham")
    private SanPham sanPham;

    @Column(name = "so_luong")
    private int soLuong;

    @Column(name = "gia_ban")
    private int giaBan;

    @Column(name = "giam_gia")
    private int giamGia;

    @Column(name = "tong_cong")
    private int tongCong;

    @Column(name = "ngay_tao")
    private Date ngayTao;

    @Column(name = "tinh_trang")
    private Boolean tinhTrang;

    public int getTongCong() {
        return (giaBan - giamGia) * soLuong;
    }
}
