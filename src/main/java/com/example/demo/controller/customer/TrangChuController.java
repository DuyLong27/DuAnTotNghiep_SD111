package com.example.demo.controller.customer;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import com.example.demo.service.EmailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.stream.Collectors;

@Controller
@RequestMapping("trang-chu")
public class TrangChuController {
    @Autowired
    private HoaDonChiTietRepo hoaDonChiTietRepository;

    @Autowired
    private KhuyenMaiRepo khuyenMaiRepository;

    @Autowired
    private SanPhamChiTietRepo sanPhamChiTietRepository;

    @Autowired
    private ThoiGianDonHangRepo thoiGianDonHangRepo;

    @Autowired
    private EmailService emailService;

    @Autowired
    HoaDonRepo hoaDonRepo;

    @Autowired
    HoaDonChiTietRepo hoaDonChiTietRepo;

    @Autowired
    private GioHangChiTietRepo gioHangChiTietRepo;

    @Autowired
    private GioHangRepo gioHangRepo;

    @GetMapping("")
    public String homePage(Model model) {
        Pageable pageable = PageRequest.of(0, 4);
        List<Object[]> topSellingProducts = hoaDonChiTietRepository.findTopSellingProducts(pageable);
        List<SanPhamChiTiet> bestSellers = topSellingProducts.stream()
                .map(obj -> (SanPhamChiTiet) obj[0])
                .collect(Collectors.toList());

        List<SanPhamChiTiet> allProducts = sanPhamChiTietRepository.findAll();
        List<SanPhamChiTiet> newestProducts = sanPhamChiTietRepository.findByOrderByNgayTaoDesc(pageable);

        List<KhuyenMai> khuyenMais = khuyenMaiRepository.findAll();
        List<KhuyenMai> validKhuyenMais = khuyenMais.stream()
                .filter(khuyenMai -> khuyenMai.getKhuyenMaiChiTietList() != null && !khuyenMai.getKhuyenMaiChiTietList().isEmpty())
                .collect(Collectors.toList());

        model.addAttribute("bestSellers", bestSellers);
        model.addAttribute("newestProducts", newestProducts);
        model.addAttribute("validKhuyenMais", validKhuyenMais);
        model.addAttribute("allProducts", allProducts);
        model.addAttribute("listGioHang",gioHangChiTietRepo.findAll());
        return "customer/trang_chu/index";
    }


    @GetMapping("/mua-ngay")
    public String muaNgay(@RequestParam("productId") Integer productId, Model model, HttpSession session) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(productId).orElse(null);
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
        List<SanPhamChiTiet> sanPhamList = sanPhamChiTietRepository.findAll();
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
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(sanPhamId).orElse(null);
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
        sanPhamChiTietRepository.save(sanPhamChiTiet);
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


    @PostMapping("/add")
    public String addCart(@RequestParam("sanPhamId") int sanPhamId, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(sanPhamId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid product ID: " + sanPhamId));
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        GioHang cart;

        if (khachHang != null) {
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHang(khachHang);
            if (existingCart.isPresent()) {
                cart = existingCart.get();
            } else {
                cart = new GioHang();
                cart.setKhachHang(khachHang);
                gioHangRepo.save(cart);
            }
        } else {
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();
            if (existingCart.isPresent()) {
                cart = existingCart.get();
            } else {
                cart = new GioHang();
                gioHangRepo.save(cart);
            }
        }
        Optional<GioHangChiTiet> existingDetail = gioHangChiTietRepo.findByGioHangAndSanPhamChiTiet(cart, sanPhamChiTiet);
        if (existingDetail.isPresent()) {
            GioHangChiTiet cartDetail = existingDetail.get();
            cartDetail.setSoLuong(cartDetail.getSoLuong() + 1);
            gioHangChiTietRepo.save(cartDetail);
        } else {
            GioHangChiTiet newDetail = new GioHangChiTiet();
            newDetail.setGioHang(cart);
            newDetail.setSanPhamChiTiet(sanPhamChiTiet);
            newDetail.setSoLuong(1);
            int giaSanPham = (sanPhamChiTiet.getGiaGiamGia() != null && sanPhamChiTiet.getGiaGiamGia() > 0)
                    ? sanPhamChiTiet.getGiaGiamGia()
                    : sanPhamChiTiet.getGiaBan();
            newDetail.setGiaBan(giaSanPham);

            gioHangChiTietRepo.save(newDetail);
        }
        int tongTien = 0;
        int tongSoLuong = 0;
        List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);
        for (GioHangChiTiet detail : cartDetails) {
            tongSoLuong += detail.getSoLuong();
            tongTien += detail.getSoLuong() * detail.getGiaBan();
        }
        cart.setTongSoLuong(tongSoLuong);
        cart.setTongTien(tongTien);
        gioHangRepo.save(cart);

        redirectAttributes.addFlashAttribute("message","Thêm sản phẩm vào giỏ hàng thành công");
        return "redirect:/trang-chu";
    }
}
