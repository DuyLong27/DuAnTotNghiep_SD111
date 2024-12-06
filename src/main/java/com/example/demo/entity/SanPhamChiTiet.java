package com.example.demo.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "san_pham_chi_tiet")
public class SanPhamChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_san_pham_chi_tiet")
    private Integer id;
    @Size(min = 3, max = 20, message = "Mã sản phẩm phải từ 3 đến 20 ký tự!")
    @Pattern(regexp = "^[a-zA-Z0-9\\s]+$", message = "Mã sản phẩm không được chứa ký tự đặc biệt!")
    @Column(name = "ma_san_pham_chi_tiet")
    private String ma;

    @Column(name = "hinh_anh_san_pham")
    private String hinhAnh;

    @Column(name = "ngay_tao")
    private Date ngayTao;

    @Column(name = "ngay_het_han")
    private Date ngayHetHan;

    @Column(name = "danh_gia_san_pham")
    private String danhGia;

    @Column(name = "so_luong")
    @Min(value = 1, message = "Số lượng phải lớn hơn 0")
    private int soLuong;

    @Min(value = 60000, message = "Giá bán phải lớn hơn hoặc bằng 60000!")
    @Column(name = "gia_ban")
    private int giaBan;

    @Column(name = "gia_giam_gia")
    private Integer giaGiamGia;

    @Digits(integer = 1, fraction = 0)
    @Column(name = "tinh_trang")
    private int tinhTrang;

    @ManyToOne
    @JoinColumn(name = "id_san_pham", referencedColumnName = "id_san_pham")
    private SanPham sanPham;

    @ManyToOne
    @JoinColumn(name = "id_loai_ca_phe", referencedColumnName = "id_loai_ca_phe")
    private LoaiCaPhe loaiCaPhe;

    @ManyToOne
    @JoinColumn(name = "id_can_nang", referencedColumnName = "id_can_nang")
    private CanNang canNang;

    @ManyToOne
    @JoinColumn(name = "id_loai_hat", referencedColumnName = "id_loai_hat")
    private LoaiHat loaiHat;

    @ManyToOne
    @JoinColumn(name = "id_loai_tui", referencedColumnName = "id_loai_tui")
    private LoaiTui loaiTui;

    @ManyToOne
    @JoinColumn(name = "id_muc_do_rang", referencedColumnName = "id_muc_do_rang")
    private MucDoRang mucDoRang;

    @ManyToOne
    @JoinColumn(name = "id_huong_vi", referencedColumnName = "id_huong_vi")
    private HuongVi huongVi;

    @ManyToOne
    @JoinColumn(name = "id_thuong_hieu", referencedColumnName = "id_thuong_hieu")
    private ThuongHieu thuongHieu;


    @OneToMany(mappedBy = "sanPhamChiTiet", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<KhuyenMaiChiTiet> khuyenMaiChiTietList;
}
