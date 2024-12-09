package com.example.demo.controller.customer;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import com.example.demo.service.EmailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/danh-sach-san-pham")
public class DanhSachSanPhamController {
    @Autowired
    private KhachHangRepo khachHangRepo;
    @Autowired
    HoaDonRepo hoaDonRepo;

    @Autowired
    HoaDonChiTietRepo hoaDonChiTietRepo;

    @Autowired
    SanPhamChiTietRepo sanPhamChiTietRepo;

    @Autowired
    ThuongHieuRepo thuongHieuRepo;

    @Autowired
    LoaiCaPheRepo loaiCaPheRepo;

    @Autowired
    LoaiHatRepo loaiHatRepo;

    @Autowired
    MucDoRangRepo mucDoRangRepo;

    @Autowired
    HuongViRepo huongViRepo;

    @Autowired
    private GioHangChiTietRepo gioHangChiTietRepo;

    @Autowired
    private ThoiGianDonHangRepo thoiGianDonHangRepo;
    @Autowired
    private EmailService emailService;

    public List<SanPhamChiTiet> getSanPhamWithKhuyenMai() {
        return sanPhamChiTietRepo.findAllWithPromotions();
    }

    @GetMapping("/hien-thi")
    public String hienThi(Model model,
                          @RequestParam(required = false) Integer thuongHieuId,
                          @RequestParam(required = false) Integer loaiCaPheId,
                          @RequestParam(required = false) Integer huongViId,
                          @RequestParam(required = false) Integer loaiHatId,
                          @RequestParam(required = false) Integer mucDoRangId,
                          @RequestParam(required = false) Integer minPrice,
                          @RequestParam(required = false) Integer maxPrice,
                          @RequestParam(required = false, defaultValue = "none") String sort
    ) {
        List<SanPhamChiTiet> sanPhamList;

        if (thuongHieuId != null) {
            sanPhamList = sanPhamChiTietRepo.findByThuongHieuId(thuongHieuId);
        } else if (loaiCaPheId != null) {
            sanPhamList = sanPhamChiTietRepo.findByLoaiCaPheId(loaiCaPheId);
        } else if (huongViId != null) {
            sanPhamList = sanPhamChiTietRepo.findByHuongViId(huongViId);
        } else if (loaiHatId != null) {
            sanPhamList = sanPhamChiTietRepo.findByLoaiHatId(loaiHatId);
        } else if (mucDoRangId != null) {
            sanPhamList = sanPhamChiTietRepo.findByMucDoRangId(mucDoRangId);
        } else if (minPrice != null || maxPrice != null) {
            if (minPrice != null && maxPrice != null) {
                sanPhamList = sanPhamChiTietRepo.findByGiaBanBetween(minPrice, maxPrice);
            } else if (minPrice != null) {
                sanPhamList = sanPhamChiTietRepo.findByGiaBanBetween(minPrice, Integer.MAX_VALUE);
            } else {
                sanPhamList = sanPhamChiTietRepo.findByGiaBanBetween(Integer.MIN_VALUE, maxPrice);
            }
        } else {
            sanPhamList = sanPhamChiTietRepo.findAll();
        }

        if (sort.equals("asc")) {
            sanPhamList = sanPhamChiTietRepo.findAllByOrderByGiaBanAsc();
        } else if (sort.equals("desc")) {
            sanPhamList = sanPhamChiTietRepo.findAllByOrderByGiaBanDesc();
        }

        model.addAttribute("listSanPham", sanPhamList);
        model.addAttribute("listThuongHieu", thuongHieuRepo.findAll());
        model.addAttribute("listHuongVi", huongViRepo.findAll());
        model.addAttribute("listLoaiHat", loaiHatRepo.findAll());
        model.addAttribute("listMucDoRang", mucDoRangRepo.findAll());
        model.addAttribute("listLoaiCaPhe", loaiCaPheRepo.findAll());

        model.addAttribute("listGioHang",gioHangChiTietRepo.findAll());

        return "customer/san_pham/index";
    }

    @GetMapping("/mua-ngay")
    public String muaNgay(@RequestParam("productId") Integer productId, Model model, HttpSession session) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(productId).orElse(null);
        model.addAttribute("sanPhamChiTiet", sanPhamChiTiet);
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        int diemTichLuy = khachHang != null ? khachHang.getDiemTichLuy() : 0;
        double discountRate = Math.min(Math.floor(diemTichLuy / 1000.0) * 5, 30);
        int giaSanPham = (sanPhamChiTiet.getGiaGiamGia() != null && sanPhamChiTiet.getGiaGiamGia() > 0)
                ? sanPhamChiTiet.getGiaGiamGia()
                : sanPhamChiTiet.getGiaBan();
        int discountAmount = (int) (giaSanPham * (discountRate / 100.0));
        model.addAttribute("discountRate", discountRate);
        model.addAttribute("discountAmount", discountAmount);
        model.addAttribute("tongTien", giaSanPham - discountAmount);

        List<SanPhamChiTiet> sanPhamList = sanPhamChiTietRepo.findAll();
        model.addAttribute("listSanPham", sanPhamList);

        return "customer/san_pham/index";
    }



    @PostMapping("/xac-nhan-hoa-don")
    public String xacNhanHoaDon(HttpSession session,
                                @RequestParam String phuongThucThanhToan,
                                @RequestParam String phuongThucVanChuyen,
                                @RequestParam String diaChi,
                                @RequestParam String soDienThoai,
                                @RequestParam int soLuong,
                                @RequestParam int sanPhamId,
                                @RequestParam(required = false) String email) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamId).orElse(null);
        if (sanPhamChiTiet == null) {
            return "redirect:/error";
        }
        int giaSanPham = (sanPhamChiTiet.getGiaGiamGia() != null && sanPhamChiTiet.getGiaGiamGia() > 0)
                ? sanPhamChiTiet.getGiaGiamGia()
                : sanPhamChiTiet.getGiaBan();
        int tongTienSanPham = soLuong * giaSanPham;
        int phiVanChuyen = phuongThucVanChuyen.equals("Giao Hàng Tiêu Chuẩn") ? 20000 : 33000;
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        int diemTichLuy = khachHang != null ? khachHang.getDiemTichLuy() : 0;
        double discountRate = Math.min(Math.floor(diemTichLuy / 1000) * 0.05, 0.30);
        double discountAmount = tongTienSanPham * discountRate;
        int tongTienSauGiam = tongTienSanPham - (int) discountAmount;
        int tongTien = tongTienSauGiam + phiVanChuyen;
        String soHoaDon = "HD" + new Random().nextInt(90000);
        HoaDon hoaDon = new HoaDon();
        hoaDon.setPhuong_thuc_thanh_toan(phuongThucThanhToan);
        hoaDon.setPhuongThucVanChuyen(phuongThucVanChuyen);
        hoaDon.setDiaChi(diaChi);
        hoaDon.setSoDienThoai(soDienThoai);
        hoaDon.setNgayTao(new Date());
        hoaDon.setThoiGianTao(LocalDateTime.now());
        hoaDon.setKieuHoaDon(1);
        hoaDon.setTongTien(tongTien);
        hoaDon.setSoHoaDon(soHoaDon);
        hoaDon.setTinh_trang(0);
        if (khachHang != null) {
            hoaDon.setKhachHang(khachHang);
        } else if (email != null && !email.isEmpty()) {
            emailService.sendHoaDonMuaNgayEmail(
                    email,
                    soHoaDon,
                    phuongThucThanhToan,
                    phuongThucVanChuyen,
                    diaChi,
                    soDienThoai,
                    soLuong,
                    sanPhamChiTiet.getSanPham().getTen(),
                    giaSanPham,
                    tongTien
            );
        } else {
            return "redirect:/error";
        }
        hoaDonRepo.save(hoaDon);
        HoaDonChiTiet hoaDonChiTiet = new HoaDonChiTiet();
        hoaDonChiTiet.setHoaDon(hoaDon);
        hoaDonChiTiet.setSanPhamChiTiet(sanPhamChiTiet);
        hoaDonChiTiet.setSo_luong(soLuong);
        int giaSanPhamSauGiam = (int) (giaSanPham * (1 - discountRate));
        hoaDonChiTiet.setGia_san_pham(giaSanPhamSauGiam);
        hoaDonChiTietRepo.save(hoaDonChiTiet);
        sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() - soLuong);
        sanPhamChiTietRepo.save(sanPhamChiTiet);
        ThoiGianDonHang thoiGianDonHang = new ThoiGianDonHang();
        thoiGianDonHang.setHoaDon(hoaDon);
        thoiGianDonHang.setThoiGianTao(LocalDateTime.now());
        thoiGianDonHangRepo.save(thoiGianDonHang);
        return "redirect:/danh-sach-san-pham/hien-thi";
    }

}