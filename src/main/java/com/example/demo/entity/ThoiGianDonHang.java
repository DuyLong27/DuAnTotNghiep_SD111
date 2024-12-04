package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "thoi_gian_don_hang")
public class ThoiGianDonHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_thoi_gian")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_hoa_don",referencedColumnName = "id_hoa_don")
    private HoaDon hoaDon;
    @Column(name = "thoi_gian_tao")
    private LocalDateTime thoiGianTao;
    @Column(name = "thoi_gian_xac_nhan")
    private LocalDateTime thoiGianXacNhan;
    @Column(name = "ban_giao_van_chuyen")
    private LocalDateTime banGiaoVanChuyen;
    @Column(name = "hoan_thanh")
    private LocalDateTime hoanThanh;
    @Column(name = "hoan_tra")
    private LocalDateTime hoanTra;
    @Column(name = "xac_nhan_hoan_tra")
    private LocalDateTime xacNhanHoanTra;
    @Column(name = "da_hoan_tra")
    private LocalDateTime daHoanTra;
    @Column(name = "da_huy")
    private LocalDateTime daHuy;
    @Column(name = "khong_xac_nhan")
    private LocalDateTime khongXacNhan;
    @Column(name = "khong_hoan_tra")
    private LocalDateTime khongHoanTra;
}
