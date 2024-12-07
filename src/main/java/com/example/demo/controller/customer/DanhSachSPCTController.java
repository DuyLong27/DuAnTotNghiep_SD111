package com.example.demo.controller.customer;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import com.example.demo.service.EmailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;

@Controller
@RequestMapping("/danh-sach-san-pham-chi-tiet")
public class DanhSachSPCTController {
    @Autowired
    SanPhamChiTietRepo sanPhamChiTietRepo;

    @Autowired
    HoaDonRepo hoaDonRepo;

    @Autowired
    HoaDonChiTietRepo hoaDonChiTietRepo;

    @Autowired
    SanPhamRepo sanPhamRepo;

    @Autowired
    CanNangRepo canNangRepo;

    @Autowired
    ThuongHieuRepo thuongHieuRepo;

    @Autowired
    LoaiHatRepo loaiHatRepo;

    @Autowired
    LoaiCaPheRepo loaiCaPheRepo;

    @Autowired
    LoaiTuiRepo loaiTuiRepo;

    @Autowired
    HuongViRepo huongViRepo;

    @Autowired
    MucDoRangRepo mucDoRangRepo;

    @Autowired
    GioHangChiTietRepo gioHangChiTietRepo;

    @Autowired
    GioHangRepo gioHangRepo;

    @Autowired
    private EmailService emailService;

    @Autowired
    private ThoiGianDonHangRepo thoiGianDonHangRepo;

    @GetMapping("/view-sp/{id}")
    public String viewProduct(@PathVariable("id") Integer id, Model model) {
        Optional<SanPhamChiTiet> optionalSanPhamChiTiet = sanPhamChiTietRepo.findById(id);

        if (optionalSanPhamChiTiet.isPresent()) {
            model.addAttribute("sanPhamChiTiet", optionalSanPhamChiTiet.get());
        } else {
            model.addAttribute("sanPhamChiTiet", null);
        }

        List<Object[]> bestSellingProducts = hoaDonChiTietRepo.findBestSellingProducts();

        List<SanPhamChiTiet> products = new ArrayList<>();
        for (Object[] objects : bestSellingProducts) {
            SanPhamChiTiet product = (SanPhamChiTiet) objects[0];
            products.add(product);
        }

        model.addAttribute("bestSellingProducts", products);

        model.addAttribute("listGioHang", gioHangChiTietRepo.findAll());

        return "customer/san_pham_chi_tiet/index";
    }


    @PostMapping("/add")
    public String addCart(@RequestParam("sanPhamId") int sanPhamId,
                          @RequestParam("soLuong") int soLuong,
                          HttpSession session, Model model) {
        // Tìm sản phẩm chi tiết theo ID
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid product ID: " + sanPhamId));

        if (soLuong < 1 || soLuong > sanPhamChiTiet.getSoLuong()) {
            model.addAttribute("errorMessage", "Số lượng không hợp lệ. Vui lòng chọn số lượng từ 1 đến " + sanPhamChiTiet.getSoLuong());
            return "redirect:/danh-sach-san-pham-chi-tiet/view-sp/" + sanPhamChiTiet.getId();
        }

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
            // Nếu sản phẩm đã có trong giỏ hàng, cập nhật số lượng
            GioHangChiTiet cartDetail = existingDetail.get();
            cartDetail.setSoLuong(cartDetail.getSoLuong() + soLuong);  // Cập nhật số lượng
            gioHangChiTietRepo.save(cartDetail);
        } else {
            // Nếu sản phẩm chưa có trong giỏ hàng, thêm sản phẩm mới vào giỏ hàng
            GioHangChiTiet newDetail = new GioHangChiTiet();
            newDetail.setGioHang(cart);
            newDetail.setSanPhamChiTiet(sanPhamChiTiet);
            newDetail.setSoLuong(soLuong);  // Cập nhật số lượng từ tham số

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
        return "redirect:/danh-sach-san-pham-chi-tiet/view-sp/" + sanPhamChiTiet.getId();
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
        return "customer/san_pham_chi_tiet/index";
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

        return "redirect:/danh-sach-san-pham-chi-tiet/view-sp/" + sanPhamChiTiet.getId();
    }
}
