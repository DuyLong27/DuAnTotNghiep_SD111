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
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Random;

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
        // Lấy sản phẩm chi tiết
        Optional<SanPhamChiTiet> optionalSanPhamChiTiet = sanPhamChiTietRepo.findById(id);

        if (optionalSanPhamChiTiet.isPresent()) {
            model.addAttribute("sanPhamChiTiet", optionalSanPhamChiTiet.get());
        } else {
            model.addAttribute("sanPhamChiTiet", null); // Trường hợp không tìm thấy sản phẩm
        }

        // Lấy danh sách sản phẩm liên quan
        Pageable pageable = PageRequest.of(0, 4); // Giới hạn số lượng sản phẩm liên quan
        Page<SanPhamChiTiet> relatedProductsPage = sanPhamChiTietRepo.findAll(pageable);

        // Thêm sản phẩm liên quan vào model
        model.addAttribute("data", relatedProductsPage);
        model.addAttribute("listGioHang",gioHangChiTietRepo.findAll());

        return "customer/san_pham_chi_tiet/index";
    }

    public String showProductList(@RequestParam(name = "page", defaultValue = "0") int pageNo,
                                  @RequestParam(name = "size", defaultValue = "4") int pageSize,
                                  Model model) {

        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<SanPhamChiTiet> page = sanPhamChiTietRepo.findAll(pageable);

        model.addAttribute("data", page); // Dữ liệu sản phẩm phân trang
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());

        return "customer/san_pham_chi_tiet/index"; // Trả về JSP
    }

    @PostMapping("/add")
    public String addCart(@RequestParam("sanPhamId") int sanPhamId, HttpSession session, Model model) {
        // Tìm sản phẩm chi tiết theo ID
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamId)
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
        return "redirect:/danh-sach-san-pham-chi-tiet/view-sp/" + sanPhamChiTiet.getId();
    }

    @GetMapping("/mua-ngay")
    public String muaNgay(@RequestParam("productId") Integer productId, Model model) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(productId).orElse(null);
        model.addAttribute("sanPhamChiTiet", sanPhamChiTiet);
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

        String tenSanPham = sanPhamChiTiet.getSanPham().getTen();

        int giaSanPham = (sanPhamChiTiet.getGiaGiamGia() != null && sanPhamChiTiet.getGiaGiamGia() > 0)
                ? sanPhamChiTiet.getGiaGiamGia()
                : sanPhamChiTiet.getGiaBan();
        int tongTien = soLuong * giaSanPham;
        int phiVanChuyen = phuongThucVanChuyen.equals("Giao Hàng Tiêu Chuẩn") ? 20000 : 33000;
        tongTien += phiVanChuyen;

        String soHoaDon = "HD" + new Random().nextInt(90000);

        HoaDon hoaDon = new HoaDon();
        hoaDon.setPhuong_thuc_thanh_toan(phuongThucThanhToan);
        hoaDon.setPhuongThucVanChuyen(phuongThucVanChuyen);
        hoaDon.setDiaChi(diaChi);
        hoaDon.setSoDienThoai(soDienThoai);
        hoaDon.setNgayTao(new Date());
        hoaDon.setTongTien(tongTien);
        hoaDon.setSoHoaDon(soHoaDon);
        hoaDon.setTinh_trang(0);

        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
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
                    tenSanPham,
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
        hoaDonChiTiet.setGia_san_pham(giaSanPham);
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
