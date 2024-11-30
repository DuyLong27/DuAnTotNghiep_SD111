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

        List<KhuyenMai> khuyenMais = khuyenMaiRepository.findAll();
        List<KhuyenMai> validKhuyenMais = khuyenMais.stream()
                .filter(khuyenMai -> khuyenMai.getKhuyenMaiChiTietList() != null && !khuyenMai.getKhuyenMaiChiTietList().isEmpty())
                .collect(Collectors.toList());

        model.addAttribute("bestSellers", bestSellers);
        model.addAttribute("validKhuyenMais", validKhuyenMais);
        model.addAttribute("allProducts", allProducts);

        model.addAttribute("listGioHang",gioHangChiTietRepo.findAll());
        return "customer/trang_chu/index";
    }

    @GetMapping("/mua-ngay")
    public String muaNgay(@RequestParam("productId") Integer productId, Model model, HttpSession session) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(productId).orElse(null);
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

        Pageable pageable = PageRequest.of(0, 4);
        List<Object[]> topSellingProducts = hoaDonChiTietRepository.findTopSellingProducts(pageable);

        List<SanPhamChiTiet> bestSellers = topSellingProducts.stream()
                .map(obj -> (SanPhamChiTiet) obj[0])
                .collect(Collectors.toList());

        List<SanPhamChiTiet> allProducts = sanPhamChiTietRepository.findAll();

        List<KhuyenMai> khuyenMais = khuyenMaiRepository.findAll();
        List<KhuyenMai> validKhuyenMais = khuyenMais.stream()
                .filter(khuyenMai -> khuyenMai.getKhuyenMaiChiTietList() != null && !khuyenMai.getKhuyenMaiChiTietList().isEmpty())
                .collect(Collectors.toList());

        model.addAttribute("bestSellers", bestSellers);
        model.addAttribute("validKhuyenMais", validKhuyenMais);
        model.addAttribute("allProducts", allProducts);

        return "customer/trang_chu/index";
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
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(sanPhamId).orElse(null);
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
        hoaDon.setNgayTao(LocalDateTime.now());
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
        sanPhamChiTietRepository.save(sanPhamChiTiet);
        ThoiGianDonHang thoiGianDonHang = new ThoiGianDonHang();
        thoiGianDonHang.setHoaDon(hoaDon);
        thoiGianDonHang.setThoiGianTao(LocalDateTime.now());
        thoiGianDonHangRepo.save(thoiGianDonHang);
        return "redirect:/trang-chu";
    }

    @PostMapping("/add")
    public String addCart(@RequestParam("sanPhamId") int sanPhamId, HttpSession session, Model model) {
        // Tìm sản phẩm chi tiết theo ID
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(sanPhamId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid product ID: " + sanPhamId));

        // Kiểm tra người dùng đã đăng nhập hay chưa
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        GioHang cart;

        if (khachHang != null) {
            // Nếu khách hàng đã đăng nhập, tìm giỏ hàng của họ
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHang(khachHang);
            if (existingCart.isPresent()) {
                cart = existingCart.get();
            } else {
                // Nếu chưa có giỏ hàng, tạo mới giỏ hàng và gán cho khách hàng
                cart = new GioHang();
                cart.setKhachHang(khachHang);
                gioHangRepo.save(cart); // Lưu giỏ hàng mới
            }
        } else {
            // Nếu chưa đăng nhập, tìm giỏ hàng có khách hàng là null
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();
            if (existingCart.isPresent()) {
                cart = existingCart.get();
            } else {
                // Nếu chưa có giỏ hàng, tạo mới giỏ hàng
                cart = new GioHang();
                gioHangRepo.save(cart); // Lưu giỏ hàng mới
            }
        }

        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        Optional<GioHangChiTiet> existingDetail = gioHangChiTietRepo.findByGioHangAndSanPhamChiTiet(cart, sanPhamChiTiet);
        if (existingDetail.isPresent()) {
            // Nếu sản phẩm đã có trong giỏ hàng, chỉ cần tăng số lượng
            GioHangChiTiet cartDetail = existingDetail.get();
            cartDetail.setSoLuong(cartDetail.getSoLuong() + 1);
            gioHangChiTietRepo.save(cartDetail);
        } else {
            // Nếu sản phẩm chưa có trong giỏ hàng, thêm sản phẩm mới vào giỏ hàng
            GioHangChiTiet newDetail = new GioHangChiTiet();
            newDetail.setGioHang(cart);
            newDetail.setSanPhamChiTiet(sanPhamChiTiet);
            newDetail.setSoLuong(1); // Số lượng ban đầu

            // Kiểm tra giá giảm, nếu có thì dùng giaGiamGia, nếu không thì dùng giaBan
            int giaSanPham = (sanPhamChiTiet.getGiaGiamGia() != null && sanPhamChiTiet.getGiaGiamGia() > 0)
                    ? sanPhamChiTiet.getGiaGiamGia()
                    : sanPhamChiTiet.getGiaBan();
            newDetail.setGiaBan(giaSanPham); // Set giá bán

            gioHangChiTietRepo.save(newDetail);
        }

        // Cập nhật tổng tiền và tổng số lượng
        int tongTien = 0;
        int tongSoLuong = 0;

        // Lấy tất cả chi tiết giỏ hàng liên quan đến giỏ hàng này
        List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);
        for (GioHangChiTiet detail : cartDetails) {
            tongSoLuong += detail.getSoLuong();
            tongTien += detail.getSoLuong() * detail.getGiaBan(); // Cộng dồn tiền
        }

        // Cập nhật giỏ hàng với tổng tiền và tổng số lượng
        cart.setTongSoLuong(tongSoLuong);
        cart.setTongTien(tongTien);
        gioHangRepo.save(cart); // Lưu giỏ hàng đã cập nhật

        // Chuyển hướng đến trang chi tiết hóa đơn mới được tạo
        return "redirect:/trang-chu";
    }
}
