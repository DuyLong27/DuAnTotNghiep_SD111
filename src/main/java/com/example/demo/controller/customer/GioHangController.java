package com.example.demo.controller.customer;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import com.example.demo.service.EmailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.*;

@Controller
@RequestMapping("gio-hang")
public class GioHangController {
    @Autowired
    private HoaDonChiTietRepo hoaDonChiTietRepo;
    @Autowired
    private HoaDonRepo hoaDonRepo;
    @Autowired
    private GioHangRepo gioHangRepo;

    @Autowired
    private GioHangChiTietRepo gioHangChiTietRepo;

    @Autowired
    private SanPhamChiTietRepo sanPhamChiTietRepo;

    @Autowired
    private ThoiGianDonHangRepo thoiGianDonHangRepo;

    @Autowired
    private EmailService emailService;

    @PostMapping("/add")
    public String addCart(@RequestParam("sanPhamId") int sanPhamId, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
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
        redirectAttributes.addFlashAttribute("message","Thêm sản phẩm vào giỏ hàng thành công");
        return "redirect:/danh-sach-san-pham/hien-thi";
    }



    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model) {
        // Kiểm tra người dùng đã đăng nhập hay chưa
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        GioHang cart;

        if (khachHang != null) {
            // Nếu đã đăng nhập, tìm giỏ hàng của khách hàng
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHang(khachHang);
            cart = existingCart.orElse(new GioHang()); // Nếu không có, tạo mới
        } else {
            // Nếu chưa đăng nhập, tìm giỏ hàng có khách hàng là null
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();
            cart = existingCart.orElse(new GioHang()); // Nếu không có, tạo mới
        }

        // Lấy các chi tiết giỏ hàng liên quan đến giỏ hàng này
        List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);

        // Tính tổng tiền và tổng số lượng
        int tongTien = 0;
        int tongSoLuong = 0;
        for (GioHangChiTiet detail : cartDetails) {
            tongSoLuong += detail.getSoLuong();
            tongTien += detail.getSoLuong() * detail.getGiaBan();
        }

        // Gán các giá trị vào model để gửi sang view
        model.addAttribute("listGioHang", cartDetails);
        model.addAttribute("tongSoLuong", tongSoLuong);
        model.addAttribute("tongTien", tongTien);

        // Trả về trang xem giỏ hàng
        return "customer/gio_hang/index";
    }


    @PostMapping("/remove")
    public String removeCartItem(HttpSession session, @RequestParam("sanPhamId") int sanPhamId, RedirectAttributes redirectAttributes) {
        // Kiểm tra khách hàng đã đăng nhập hay chưa
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        GioHang cart;

        // Xác định giỏ hàng dựa trên trạng thái đăng nhập
        if (khachHang != null) {
            // Khách hàng đã đăng nhập -> tìm giỏ hàng của khách hàng này
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHang(khachHang);
            if (!existingCart.isPresent()) {
                return "redirect:/gio-hang/cart"; // Nếu không có giỏ hàng, chuyển hướng về trang giỏ hàng
            }
            cart = existingCart.get();
        } else {
            // Khách hàng chưa đăng nhập -> tìm giỏ hàng có KhachHang là null
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();
            if (!existingCart.isPresent()) {
                return "redirect:/gio-hang/cart"; // Nếu không có giỏ hàng, chuyển hướng về trang giỏ hàng
            }
            cart = existingCart.get();
        }

        // Tìm sản phẩm chi tiết cần xóa trong giỏ hàng này
        Optional<SanPhamChiTiet> sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamId);
        if (sanPhamChiTiet.isPresent()) {
            Optional<GioHangChiTiet> cartDetail = gioHangChiTietRepo.findByGioHangAndSanPhamChiTiet(cart, sanPhamChiTiet.get());
            if (cartDetail.isPresent()) {
                // Xóa sản phẩm chi tiết khỏi giỏ hàng
                gioHangChiTietRepo.delete(cartDetail.get());

                // Tính lại tổng số lượng và tổng tiền của giỏ hàng
                int tongSoLuong = 0;
                int tongTien = 0;
                List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);
                for (GioHangChiTiet detail : cartDetails) {
                    tongSoLuong += detail.getSoLuong();
                    tongTien += detail.getSoLuong() * detail.getGiaBan();
                }

                // Cập nhật lại giỏ hàng
                cart.setTongSoLuong(tongSoLuong);
                cart.setTongTien(tongTien);
                gioHangRepo.save(cart); // Lưu giỏ hàng đã cập nhật
            }
        }
        redirectAttributes.addFlashAttribute("message","Sản phẩm đã được xóa khỏi giỏ hàng");
        // Chuyển hướng về trang giỏ hàng
        return "redirect:/gio-hang/cart";
    }


    @PostMapping("/updateQuantity")
    public String updateQuantity(HttpSession session, @RequestParam("sanPhamId") int sanPhamId, @RequestParam("soLuong") int soLuong) {
        if (soLuong < 1) {
            return "redirect:/gio-hang/cart";
        }
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        GioHang cart;
        if (khachHang != null) {
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHang(khachHang);
            if (!existingCart.isPresent()) {
                return "redirect:/gio-hang/cart"; // Nếu không có giỏ hàng, chuyển hướng về trang giỏ hàng
            }
            cart = existingCart.get();
        } else {
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();
            if (!existingCart.isPresent()) {
                return "redirect:/gio-hang/cart"; // Nếu không có giỏ hàng, chuyển hướng về trang giỏ hàng
            }
            cart = existingCart.get();
        }

        // Tìm sản phẩm chi tiết trong giỏ hàng này
        Optional<SanPhamChiTiet> sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamId);
        if (sanPhamChiTiet.isPresent()) {
            Optional<GioHangChiTiet> cartDetail = gioHangChiTietRepo.findByGioHangAndSanPhamChiTiet(cart, sanPhamChiTiet.get());
            if (cartDetail.isPresent()) {
                GioHangChiTiet detail = cartDetail.get();
                detail.setSoLuong(soLuong); // Cập nhật số lượng
                gioHangChiTietRepo.save(detail); // Lưu chi tiết giỏ hàng đã cập nhật

                // Tính lại tổng số lượng và tổng tiền của giỏ hàng
                int tongSoLuong = 0;
                int tongTien = 0;
                List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);
                for (GioHangChiTiet item : cartDetails) {
                    tongSoLuong += item.getSoLuong();
                    tongTien += item.getSoLuong() * item.getGiaBan();
                }

                // Cập nhật giỏ hàng với thông tin mới
                cart.setTongSoLuong(tongSoLuong);
                cart.setTongTien(tongTien);
                gioHangRepo.save(cart);
            }
        }

        return "redirect:/gio-hang/cart";
    }


    @PostMapping("/calculateTotal")
    @ResponseBody
    public int calculateTotal(HttpSession session, @RequestParam("selectedIds") List<Integer> selectedIds) {
        int totalValue = 0;
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        GioHang cart;

        if (khachHang != null) {
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHang(khachHang);
            if (!existingCart.isPresent()) {
                return totalValue;
            }
            cart = existingCart.get();
        } else {
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();
            if (!existingCart.isPresent()) {
                return totalValue;
            }
            cart = existingCart.get();
        }

        List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);
        for (GioHangChiTiet detail : cartDetails) {
            if (selectedIds.contains(detail.getSanPhamChiTiet().getId())) {
                int giaBanThucTe = (detail.getSanPhamChiTiet().getGiaGiamGia() != null
                        && detail.getSanPhamChiTiet().getGiaGiamGia() > 0)
                        ? detail.getSanPhamChiTiet().getGiaGiamGia()
                        : detail.getSanPhamChiTiet().getGiaBan();

                totalValue += detail.getSoLuong() * giaBanThucTe;
            }
        }
        return totalValue;
    }


    @PostMapping("/checkout")
    public String checkout(@RequestParam(value = "selectedItems", required = false) List<Integer> selectedIds,
                           @RequestParam(value = "phuongThucVanChuyen", required = false) String phuongThucVanChuyen,
                           HttpSession session, Model model) {
        if (selectedIds == null || selectedIds.isEmpty()) {
            model.addAttribute("errorMessage", "Bạn chưa chọn sản phẩm nào.");
            return "customer/gio_hang/index";
        }

        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        GioHang cart;
        if (khachHang != null) {
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHang(khachHang);
            if (!existingCart.isPresent()) {
                model.addAttribute("errorMessage", "Không tìm thấy giỏ hàng của bạn.");
                return "customer/gio_hang/index";
            }
            cart = existingCart.get();
        } else {
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();
            if (!existingCart.isPresent()) {
                model.addAttribute("errorMessage", "Không tìm thấy giỏ hàng.");
                return "customer/gio_hang/index";
            }
            cart = existingCart.get();
        }

        List<GioHangChiTiet> selectedCartDetails = new ArrayList<>();
        List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);
        int tongTien = 0;

        for (GioHangChiTiet detail : cartDetails) {
            if (selectedIds.contains(detail.getSanPhamChiTiet().getId())) {
                selectedCartDetails.add(detail);
                tongTien += detail.getSoLuong() * detail.getGiaBan();
            }
        }
        int giamGia = 0;
        int phanTramGiam = 0;
        String rank = "Thành viên";
        int phiVanChuyen = 0;

        if (phuongThucVanChuyen != null) {
            if ("Giao Hàng Tiêu Chuẩn".equals(phuongThucVanChuyen)) {
                phiVanChuyen = 20000;
            } else if ("Giao Hàng Nhanh".equals(phuongThucVanChuyen)) {
                phiVanChuyen = 33000;
            }
        }
        if (khachHang != null) {
            int diemTichLuy = khachHang.getDiemTichLuy();
            if (diemTichLuy >= 5000) {
                rank = "VIP";
                phanTramGiam = 25;
            } else if (diemTichLuy >= 4000) {
                rank = "Kim Cương";
                phanTramGiam = 20;
            } else if (diemTichLuy >= 3000) {
                rank = "Bạch Kim";
                phanTramGiam = 15;
            } else if (diemTichLuy >= 2000) {
                rank = "Lục Bảo";
                phanTramGiam = 10;
            } else if (diemTichLuy >= 1000) {
                rank = "Vàng";
                phanTramGiam = 5;
            } else {
                rank = "Bạc";
                phanTramGiam = 0;
            }
            giamGia = (tongTien * phanTramGiam) / 100;
        } else {
            rank = "Không có";
            giamGia = 0;
        }
        int tongTienCuThe = tongTien + phiVanChuyen;
        int tongTienSauGiam = tongTien - giamGia + phiVanChuyen;
        model.addAttribute("selectedItems", selectedCartDetails);
        model.addAttribute("tongTien", tongTien + phiVanChuyen);
        model.addAttribute("giamGia", giamGia); // Tiền giảm
        model.addAttribute("tongTienCuThe", tongTienCuThe);
        model.addAttribute("tongTienSauGiam", tongTienSauGiam);
        model.addAttribute("rank", rank);
        model.addAttribute("diemTichLuy", khachHang != null ? khachHang.getDiemTichLuy() : 0);
        model.addAttribute("phanTramGiam", phanTramGiam);
        model.addAttribute("khachHang", khachHang);

        return "customer/gio_hang/confirm_cart";
    }

    @PostMapping("/xac-nhan-hoa-don")
    public String confirm(
            @RequestParam(value = "selectedItems", required = false) List<Integer> selectedIds,
            @RequestParam("phuongThucThanhToan") String phuongThucThanhToan,
            @RequestParam("phuongThucVanChuyen") String phuongThucVanChuyen,
            @RequestParam("diaChi") String diaChi,
            @RequestParam("soDienThoai") String soDienThoai,
            @RequestParam(value = "email", required = false) String email,
            HttpSession session,
            Model model, RedirectAttributes redirectAttributes) {
        if (selectedIds == null || selectedIds.isEmpty()) {
            model.addAttribute("errorMessage", "Bạn chưa chọn sản phẩm nào.");
            return "customer/gio_hang/index";
        }
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        Optional<GioHang> existingCart = khachHang != null
                ? gioHangRepo.findByKhachHang(khachHang)
                : gioHangRepo.findByKhachHangIsNull();
        if (existingCart.isPresent()) {
            GioHang cart = existingCart.get();
            int totalProductAmount = 0;
            List<HoaDonChiTiet> invoiceDetails = new ArrayList<>();
            List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);
            for (GioHangChiTiet detail : cartDetails) {
                if (selectedIds.contains(detail.getSanPhamChiTiet().getId())) {
                    totalProductAmount += detail.getSoLuong() * detail.getGiaBan();
                    HoaDonChiTiet invoiceDetail = new HoaDonChiTiet();
                    invoiceDetail.setSanPhamChiTiet(detail.getSanPhamChiTiet());
                    invoiceDetail.setSo_luong(detail.getSoLuong());
                    invoiceDetail.setGia_san_pham(detail.getGiaBan());
                    invoiceDetails.add(invoiceDetail);
                    SanPhamChiTiet sanPham = detail.getSanPhamChiTiet();
                    sanPham.setSoLuong(sanPham.getSoLuong() - detail.getSoLuong());
                    sanPhamChiTietRepo.save(sanPham);
                    gioHangChiTietRepo.delete(detail);
                }
            }
            int phiVanChuyen = 0;
            if (phuongThucVanChuyen.equals("Giao Hàng Tiêu Chuẩn")) {
                phiVanChuyen = 20000;
            } else if (phuongThucVanChuyen.equals("Giao Hàng Nhanh")) {
                phiVanChuyen = 33000;
            }
            int diemTichLuy = khachHang != null ? khachHang.getDiemTichLuy() : 0;
            double discountRate = Math.min(Math.floor(diemTichLuy / 1000) * 0.05, 0.30);
            double discountAmount = totalProductAmount * discountRate;
            int totalAmount = totalProductAmount - (int) discountAmount;
            totalAmount += phiVanChuyen;
            model.addAttribute("diemTichLuy", diemTichLuy);
            model.addAttribute("discountRate", discountRate * 100);
            model.addAttribute("discountAmount", discountAmount);
            model.addAttribute("totalAmount", totalAmount);
            model.addAttribute("phuongThucThanhToan", phuongThucThanhToan);
            model.addAttribute("phuongThucVanChuyen", phuongThucVanChuyen);
            model.addAttribute("diaChi", diaChi);
            model.addAttribute("soDienThoai", soDienThoai);
            int adjustedTotalProductAmount = 0; // Tổng giá sau khi điều chỉnh
            for (HoaDonChiTiet invoiceDetail : invoiceDetails) {
                int productPrice = invoiceDetail.getGia_san_pham();
                double adjustedPrice = productPrice * (1 - discountRate);
                invoiceDetail.setGia_san_pham((int) adjustedPrice);
                adjustedTotalProductAmount += invoiceDetail.getGia_san_pham() * invoiceDetail.getSo_luong();
            }
            if (adjustedTotalProductAmount + phiVanChuyen != totalAmount) {
                throw new RuntimeException("Tổng tiền sản phẩm không khớp với tổng tiền hóa đơn.");
            }
            HoaDon invoice = new HoaDon();
            invoice.setTongTien(totalAmount);
            invoice.setNgayTao(new Date());
            invoice.setThoiGianTao(LocalDateTime.now());
            invoice.setKieuHoaDon(1);
            invoice.setPhuong_thuc_thanh_toan(phuongThucThanhToan);
            invoice.setPhuongThucVanChuyen(phuongThucVanChuyen);
            invoice.setDiaChi(diaChi);
            invoice.setSoDienThoai(soDienThoai);
            invoice.setSoHoaDon("HD" + new Random().nextInt(90000));
            invoice.setTinh_trang(0);
            if (khachHang != null) {
                invoice.setKhachHang(khachHang);
            }
            hoaDonRepo.save(invoice);
            ThoiGianDonHang thoiGianDonHang = new ThoiGianDonHang();
            thoiGianDonHang.setHoaDon(invoice);
            thoiGianDonHang.setThoiGianTao(LocalDateTime.now());
            thoiGianDonHangRepo.save(thoiGianDonHang);

            for (HoaDonChiTiet invoiceDetail : invoiceDetails) {
                invoiceDetail.setHoaDon(invoice);
            }
            hoaDonChiTietRepo.saveAll(invoiceDetails);

            // Gửi email cho khách hàng nếu là khách vãng lai và có email
            if (email != null && !email.isEmpty()) {
                emailService.sendHoaDonMuaNhieuSanPhamEmail(email, invoice.getSoHoaDon(), phuongThucThanhToan,
                        phuongThucVanChuyen, diaChi, soDienThoai, invoiceDetails, totalAmount);
            }
        }
        redirectAttributes.addFlashAttribute("message","Đặt hàng thành công");
        return "redirect:/danh-sach-san-pham/hien-thi";
    }




}