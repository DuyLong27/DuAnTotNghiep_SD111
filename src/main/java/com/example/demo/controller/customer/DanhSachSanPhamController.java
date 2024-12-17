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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
        if (sanPhamChiTiet == null) {
            model.addAttribute("errorMessage", "Sản phẩm không tồn tại.");
            return "customer/error_page";
        }
        if (sanPhamChiTiet.getSoLuong() <= 0) {
            model.addAttribute("errorMessage", "Sản phẩm đã hết hàng.");
            return "customer/error_page";
        }
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        int diemTichLuy = (khachHang != null) ? khachHang.getDiemTichLuy() : 0;
        double discountRate = calculateDiscountRate(diemTichLuy);
        int giaSanPham = (sanPhamChiTiet.getGiaGiamGia() != null && sanPhamChiTiet.getGiaGiamGia() > 0)
                ? sanPhamChiTiet.getGiaGiamGia()
                : sanPhamChiTiet.getGiaBan();
        int discountAmount = calculateDiscountAmount(giaSanPham, discountRate);
        int tongTien = giaSanPham - discountAmount;
        model.addAttribute("sanPhamChiTiet", sanPhamChiTiet);
        model.addAttribute("soLuongTon", sanPhamChiTiet.getSoLuong());
        model.addAttribute("discountRate", discountRate);
        model.addAttribute("discountAmount", discountAmount);
        model.addAttribute("tongTien", tongTien);
        List<SanPhamChiTiet> sanPhamList = sanPhamChiTietRepo.findAll();
        model.addAttribute("listSanPham", sanPhamList);

        return "customer/san_pham/index";
    }
    private double calculateDiscountRate(int diemTichLuy) {
        return Math.min(Math.floor(diemTichLuy / 1000.0) * 5, 30);
    }
    private int calculateDiscountAmount(int giaSanPham, double discountRate) {
        return (int) (giaSanPham * (discountRate / 100.0));
    }



    @PostMapping("/xac-nhan-hoa-don")
    public String xacNhanHoaDon(HttpSession session,
                                @RequestParam String phuongThucThanhToan,
                                @RequestParam String phuongThucVanChuyen,
                                @RequestParam String diaChi,
                                @RequestParam String soDienThoai,
                                @RequestParam int soLuong,
                                @RequestParam int sanPhamId,
                                @RequestParam(required = false) String email,
                                RedirectAttributes redirectAttributes,
                                Model model) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamId).orElse(null);
        if (sanPhamChiTiet == null) {
            redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại.");
            return "redirect:/error";
        }
        if (soLuong <= 0 || soLuong > sanPhamChiTiet.getSoLuong()) {
            redirectAttributes.addFlashAttribute("error", "Số lượng không hợp lệ.");
            return "redirect:/danh-sach-san-pham/hien-thi";
        }
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        if (khachHang != null) {
            model.addAttribute("diaChi", diaChi.isEmpty() ? khachHang.getDiaChi() : diaChi);
            model.addAttribute("soDienThoai", soDienThoai.isEmpty() ? khachHang.getSoDienThoai() : soDienThoai);
        } else {
            model.addAttribute("diaChi", diaChi);
            model.addAttribute("soDienThoai", soDienThoai);
        }
        int giaSanPham = (sanPhamChiTiet.getGiaGiamGia() != null && sanPhamChiTiet.getGiaGiamGia() > 0)
                ? sanPhamChiTiet.getGiaGiamGia()
                : sanPhamChiTiet.getGiaBan();
        int tongTienSanPham = soLuong * giaSanPham;
        int phiVanChuyen = phuongThucVanChuyen.equals("Giao Hàng Tiêu Chuẩn") ? 20000 : 33000;
        int diemTichLuy = khachHang != null ? khachHang.getDiemTichLuy() : 0;
        double discountRate = Math.min(Math.floor(diemTichLuy / 1000) * 0.05, 0.30);
        int discountAmount = (int) (tongTienSanPham * discountRate);
        int tongTienSauGiam = tongTienSanPham - discountAmount;
        int tongTien = tongTienSauGiam + phiVanChuyen;
        HoaDon hoaDon = new HoaDon();
        hoaDon.setPhuong_thuc_thanh_toan(phuongThucThanhToan);
        hoaDon.setPhuongThucVanChuyen(phuongThucVanChuyen);
        hoaDon.setDiaChi(diaChi);
        hoaDon.setSoDienThoai(soDienThoai);
        hoaDon.setNgayTao(new Date());
        hoaDon.setThoiGianTao(LocalDateTime.now());
        hoaDon.setKieuHoaDon(1);
        hoaDon.setTongTien(tongTien);
        hoaDon.setSoHoaDon("HD" + new Random().nextInt(90000));
        hoaDon.setTinh_trang(0);
        if (khachHang != null) hoaDon.setKhachHang(khachHang);
        hoaDonRepo.save(hoaDon);
        HoaDonChiTiet hoaDonChiTiet = new HoaDonChiTiet();
        hoaDonChiTiet.setHoaDon(hoaDon);
        hoaDonChiTiet.setSanPhamChiTiet(sanPhamChiTiet);
        hoaDonChiTiet.setSo_luong(soLuong);
        hoaDonChiTiet.setGia_san_pham((int) (giaSanPham * (1 - discountRate)));
        hoaDonChiTietRepo.save(hoaDonChiTiet);
        sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() - soLuong);
        sanPhamChiTietRepo.save(sanPhamChiTiet);
        if (email != null && !email.isEmpty()) {
            emailService.sendHoaDonMuaNgayEmail(
                    email, hoaDon.getSoHoaDon(), phuongThucThanhToan, phuongThucVanChuyen,
                    diaChi, soDienThoai, soLuong, sanPhamChiTiet.getSanPham().getTen(),
                    giaSanPham, tongTien
            );
        }
        ThoiGianDonHang thoiGianDonHang = new ThoiGianDonHang();
        thoiGianDonHang.setHoaDon(hoaDon);
        thoiGianDonHang.setThoiGianTao(LocalDateTime.now());
        thoiGianDonHangRepo.save(thoiGianDonHang);
        redirectAttributes.addFlashAttribute("message", "Đặt hàng thành công!");
        return "redirect:/danh-sach-san-pham/hien-thi";
    }



}