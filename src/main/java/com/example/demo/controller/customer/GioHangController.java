package com.example.demo.controller.customer;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
    public String removeCartItem(HttpSession session, @RequestParam("sanPhamId") int sanPhamId) {
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

        // Kiểm tra người dùng đã đăng nhập hay chưa
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang"); // Giả sử session này lưu khách hàng đã đăng nhập
        GioHang cart;

        // Lấy giỏ hàng dựa trên trạng thái đăng nhập
        if (khachHang != null) {
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHang(khachHang);
            if (!existingCart.isPresent()) {
                return totalValue; // Nếu không có giỏ hàng, trả về 0
            }
            cart = existingCart.get();
        } else {
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();
            if (!existingCart.isPresent()) {
                return totalValue; // Nếu không có giỏ hàng, trả về 0
            }
            cart = existingCart.get();
        }

        // Tính tổng giá trị dựa trên các sản phẩm đã chọn
        List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);
        for (GioHangChiTiet detail : cartDetails) {
            if (selectedIds.contains(detail.getSanPhamChiTiet().getId())) {
                totalValue += detail.getSoLuong() * detail.getGiaBan(); // Tính tổng giá trị tạm tính
            }
        }

        return totalValue; // Trả về tổng giá trị
    }


    @PostMapping("/checkout")
    public String checkout(@RequestParam(value = "selectedItems", required = false) List<Integer> selectedIds, HttpSession session, Model model) {
        if (selectedIds == null || selectedIds.isEmpty()) {
            // Xử lý trường hợp không có sản phẩm nào được chọn
            model.addAttribute("errorMessage", "Bạn chưa chọn sản phẩm nào.");
            return "customer/gio_hang/index"; // Trả về trang giỏ hàng với thông báo lỗi
        }

        // Kiểm tra người dùng đã đăng nhập hay chưa
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang"); // Giả sử session lưu trữ khách hàng đăng nhập trong "user"
        GioHang cart;

        if (khachHang != null) {
            // Nếu có tài khoản đăng nhập, lấy giỏ hàng của người dùng
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHang(khachHang);
            if (!existingCart.isPresent()) {
                model.addAttribute("errorMessage", "Không tìm thấy giỏ hàng của bạn.");
                return "customer/gio_hang/index"; // Trả về trang giỏ hàng nếu không có giỏ hàng
            }
            cart = existingCart.get();
        } else {
            // Nếu không đăng nhập, tìm giỏ hàng có `khachHang` là null
            Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();
            if (!existingCart.isPresent()) {
                model.addAttribute("errorMessage", "Không tìm thấy giỏ hàng.");
                return "customer/gio_hang/index"; // Trả về trang giỏ hàng nếu không có giỏ hàng
            }
            cart = existingCart.get();
        }

        // Lấy danh sách chi tiết giỏ hàng cho sản phẩm đã chọn
        List<GioHangChiTiet> selectedCartDetails = new ArrayList<>();
        List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);
        int tongTien = 0;

        for (GioHangChiTiet detail : cartDetails) {
            if (selectedIds.contains(detail.getSanPhamChiTiet().getId())) {
                selectedCartDetails.add(detail);
                tongTien += detail.getSoLuong() * detail.getGiaBan(); // Tính tổng tiền của các sản phẩm đã chọn
            }
        }

        model.addAttribute("selectedItems", selectedCartDetails);
        model.addAttribute("tongTien", tongTien);

        return "customer/gio_hang/confirm_cart"; // Trả về trang xác nhận giỏ hàng
    }

    @PostMapping("/xac-nhan-hoa-don")
    public String confirm(
            @RequestParam(value = "selectedItems", required = false) List<Integer> selectedIds,
            @RequestParam("phuongThucThanhToan") String phuongThucThanhToan,
            @RequestParam("phuongThucVanChuyen") String phuongThucVanChuyen,
            @RequestParam("diaChi") String diaChi,
            @RequestParam("soDienThoai") String soDienThoai,
            HttpSession session,
            Model model) {

        if (selectedIds == null || selectedIds.isEmpty()) {
            model.addAttribute("errorMessage", "Bạn chưa chọn sản phẩm nào.");
            return "customer/gio_hang/index"; // Trả về trang giỏ hàng với thông báo lỗi
        }

        // Kiểm tra khách hàng đã đăng nhập
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        Optional<GioHang> existingCart;

        if (khachHang != null) {
            // Nếu có khách hàng đăng nhập, lấy giỏ hàng của khách hàng
            existingCart = gioHangRepo.findByKhachHang(khachHang);
        } else {
            // Nếu không có khách hàng đăng nhập, lấy giỏ hàng với khachHangIsNull
            existingCart = gioHangRepo.findByKhachHangIsNull();
        }

        if (existingCart.isPresent()) {
            GioHang cart = existingCart.get();
            int totalAmount = 0;
            List<HoaDonChiTiet> invoiceDetails = new ArrayList<>();

            // Lấy tất cả chi tiết giỏ hàng
            List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);
            for (GioHangChiTiet detail : cartDetails) {
                if (selectedIds.contains(detail.getSanPhamChiTiet().getId())) {
                    // Tính tổng tiền
                    totalAmount += detail.getSoLuong() * detail.getGiaBan();

                    // Tạo chi tiết hóa đơn
                    HoaDonChiTiet invoiceDetail = new HoaDonChiTiet();
                    invoiceDetail.setSanPhamChiTiet(detail.getSanPhamChiTiet());
                    invoiceDetail.setSo_luong(detail.getSoLuong());
                    invoiceDetail.setGia_san_pham(detail.getGiaBan());
                    invoiceDetails.add(invoiceDetail);

                    // Cập nhật số lượng sản phẩm trong kho
                    SanPhamChiTiet sanPham = detail.getSanPhamChiTiet();
                    sanPham.setSoLuong(sanPham.getSoLuong() - detail.getSoLuong());
                    sanPhamChiTietRepo.save(sanPham);

                    // Xóa chi tiết giỏ hàng đã chọn
                    gioHangChiTietRepo.delete(detail);
                }
            }

            // Xác định phí vận chuyển
            int phiVanChuyen = 0;
            if (phuongThucVanChuyen.equals("Giao Hàng Tiêu Chuẩn")) {
                phiVanChuyen = 20000;
            } else if (phuongThucVanChuyen.equals("Giao Hàng Nhanh")) {
                phiVanChuyen = 33000;
            }

            // Cộng phí vận chuyển vào tổng tiền
            totalAmount += phiVanChuyen;

            // Tạo hóa đơn mới
            HoaDon invoice = new HoaDon();
            invoice.setTongTien(totalAmount);
            invoice.setNgayTao(new java.util.Date());
            invoice.setPhuong_thuc_thanh_toan(phuongThucThanhToan);
            invoice.setPhuongThucVanChuyen(phuongThucVanChuyen);
            invoice.setDiaChi(diaChi);
            invoice.setSoDienThoai(soDienThoai);
            invoice.setSoHoaDon("HD" + new Random().nextInt(90000));
            invoice.setTinh_trang(0);

            // Gán khách hàng vào hóa đơn nếu khách hàng đăng nhập
            if (khachHang != null) {
                invoice.setKhachHang(khachHang);
            }

            hoaDonRepo.save(invoice);

            // Gán hóa đơn cho chi tiết hóa đơn và lưu
            for (HoaDonChiTiet invoiceDetail : invoiceDetails) {
                invoiceDetail.setHoaDon(invoice);
            }
            hoaDonChiTietRepo.saveAll(invoiceDetails);
        }

        return "redirect:/danh-sach-san-pham/hien-thi";
    }
}