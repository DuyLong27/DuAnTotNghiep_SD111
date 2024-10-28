package com.example.demo.controller.customer;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

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
    public String addCart(@RequestParam("sanPhamId") int sanPhamId, Model model) {
        // Tìm sản phẩm chi tiết theo ID
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid product ID: " + sanPhamId));

        // Tìm giỏ hàng hiện tại (nếu có)
        Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull(); // Tìm giỏ hàng có khách hàng là null

        GioHang cart;
        if (existingCart.isPresent()) {
            cart = existingCart.get();
        } else {
            // Nếu chưa có giỏ hàng, tạo mới giỏ hàng
            cart = new GioHang();
            gioHangRepo.save(cart); // Lưu giỏ hàng mới
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
            newDetail.setGiaBan(sanPhamChiTiet.getGiaBan());

            gioHangChiTietRepo.save(newDetail);
        }

        // Tính tổng tiền và tổng số lượng
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
    public String viewCart(Model model) {
        // Tìm giỏ hàng hiện tại (nếu có)
        Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();

        if (existingCart.isPresent()) {
            GioHang cart = existingCart.get();
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
        } else {
            model.addAttribute("listGioHang", new ArrayList<>()); // Không có sản phẩm trong giỏ
            model.addAttribute("tongSoLuong", 0);
            model.addAttribute("tongTien", 0);
        }

        // Trả về trang xem giỏ hàng
        return "customer/gio_hang/index";
    }

    // Phương thức mới để xóa sản phẩm khỏi giỏ hàng
    @PostMapping("/remove")
    public String removeCartItem(@RequestParam("sanPhamId") int sanPhamId) {
        // Tìm giỏ hàng hiện tại (nếu có)
        Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();

        if (existingCart.isPresent()) {
            GioHang cart = existingCart.get();

            // Tìm chi tiết giỏ hàng có chứa sản phẩm cần xóa
            Optional<GioHangChiTiet> cartDetail = gioHangChiTietRepo.findByGioHangAndSanPhamChiTiet(cart, sanPhamChiTietRepo.findById(sanPhamId).get());

            if (cartDetail.isPresent()) {
                // Xóa chi tiết giỏ hàng
                gioHangChiTietRepo.delete(cartDetail.get());

                // Cập nhật lại tổng số lượng và tổng tiền của giỏ hàng
                int tongSoLuong = 0;
                int tongTien = 0;
                List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);

                for (GioHangChiTiet detail : cartDetails) {
                    tongSoLuong += detail.getSoLuong();
                    tongTien += detail.getSoLuong() * detail.getGiaBan();
                }

                // Cập nhật giỏ hàng với thông tin mới
                cart.setTongSoLuong(tongSoLuong);
                cart.setTongTien(tongTien);
                gioHangRepo.save(cart); // Lưu giỏ hàng đã cập nhật
            }
        }

        // Chuyển hướng về trang giỏ hàng
        return "redirect:/gio-hang/cart";
    }

    @PostMapping("/updateQuantity")
    public String updateQuantity(@RequestParam("sanPhamId") int sanPhamId, @RequestParam("soLuong") int soLuong) {
        if (soLuong < 1) {
            return "redirect:/gio-hang/cart";
        }
        // Tìm giỏ hàng hiện tại (nếu có)
        Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();

        if (existingCart.isPresent()) {
            GioHang cart = existingCart.get();

            // Tìm chi tiết giỏ hàng có chứa sản phẩm cần cập nhật
            Optional<GioHangChiTiet> cartDetail = gioHangChiTietRepo.findByGioHangAndSanPhamChiTiet(cart, sanPhamChiTietRepo.findById(sanPhamId).get());

            if (cartDetail.isPresent()) {
                GioHangChiTiet detail = cartDetail.get();
                detail.setSoLuong(soLuong); // Cập nhật số lượng
                gioHangChiTietRepo.save(detail); // Lưu sau khi cập nhật số lượng

                // Cập nhật lại tổng số lượng và tổng tiền của giỏ hàng sau khi thay đổi
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

        // Chuyển hướng về trang giỏ hàng
        return "redirect:/gio-hang/cart"; // Có thể thay đổi tùy ý
    }

    @PostMapping("/calculateTotal")
    @ResponseBody // Để trả về dữ liệu JSON
    public int calculateTotal(@RequestParam("selectedIds") List<Integer> selectedIds) {
        int totalValue = 0;

        // Tìm giỏ hàng hiện tại
        Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();
        if (existingCart.isPresent()) {
            GioHang cart = existingCart.get();
            List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);

            for (GioHangChiTiet detail : cartDetails) {
                if (selectedIds.contains(detail.getSanPhamChiTiet().getId())) {
                    totalValue += detail.getSoLuong() * detail.getGiaBan(); // Tính tổng giá trị hóa đơn
                }
            }
        }

        return totalValue; // Trả về tổng giá trị
    }

    @PostMapping("/checkout")
    public String checkout(@RequestParam(value = "selectedItems", required = false) List<Integer> selectedIds, Model model) {
        if (selectedIds == null || selectedIds.isEmpty()) {
            // Xử lý trường hợp không có sản phẩm nào được chọn
            model.addAttribute("errorMessage", "Bạn chưa chọn sản phẩm nào.");
            return "customer/gio_hang/index"; // Trả về trang giỏ hàng với thông báo lỗi
        }

        // Xử lý bình thường khi có sản phẩm được chọn
        Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();

        if (existingCart.isPresent()) {
            GioHang cart = existingCart.get();
            List<GioHangChiTiet> selectedCartDetails = new ArrayList<>();

            List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);
            for (GioHangChiTiet detail : cartDetails) {
                if (selectedIds.contains(detail.getSanPhamChiTiet().getId())) {
                    selectedCartDetails.add(detail);
                }
            }

            int tongTien = 0;
            for (GioHangChiTiet detail : selectedCartDetails) {
                tongTien += detail.getSoLuong() * detail.getGiaBan();
            }

            model.addAttribute("selectedItems", selectedCartDetails);
            model.addAttribute("tongTien", tongTien);
        }

        return "customer/gio_hang/confirm_cart";
    }


    @PostMapping("/xac-nhan-hoa-don")
    public String confirm(
            @RequestParam(value = "selectedItems", required = false) List<Integer> selectedIds,
            @RequestParam("phuongThucThanhToan") String phuongThucThanhToan,
            @RequestParam("phuongThucVanChuyen") String phuongThucVanChuyen,
            @RequestParam("diaChi") String diaChi,
            @RequestParam("soDienThoai") String soDienThoai,
            Model model) {

        if (selectedIds == null || selectedIds.isEmpty()) {
            model.addAttribute("errorMessage", "Bạn chưa chọn sản phẩm nào.");
            return "customer/gio_hang/index"; // Trả về trang giỏ hàng với thông báo lỗi
        }

        Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();

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
                    sanPham.setSoLuong(sanPham.getSoLuong() - detail.getSoLuong()); // Giảm số lượng
                    sanPhamChiTietRepo.save(sanPham); // Lưu thay đổi vào kho

                    // Xóa chi tiết giỏ hàng đã chọn
                    gioHangChiTietRepo.delete(detail); // Xóa sản phẩm khỏi giỏ hàng
                }
            }

            // Tạo hóa đơn mới
            HoaDon invoice = new HoaDon();
            invoice.setTong_tien(totalAmount);
            invoice.setNgay_tao(new java.util.Date());
            invoice.setPhuong_thuc_thanh_toan(phuongThucThanhToan); // Gán phương thức thanh toán
            invoice.setPhuongThucVanChuyen(phuongThucVanChuyen); // Gán phương thức vận chuyển
            invoice.setDiaChi(diaChi); // Gán địa chỉ cụ thể
            invoice.setSoDienThoai(soDienThoai); // Gán số điện thoại
            // Tạo số hóa đơn ngẫu nhiên
            String soHoaDon = "HD" + new Random().nextInt(90000);
            invoice.setSo_hoa_don(soHoaDon);
            invoice.setTinh_trang(0);
            hoaDonRepo.save(invoice);

            // Gán hóa đơn cho chi tiết hóa đơn
            for (HoaDonChiTiet invoiceDetail : invoiceDetails) {
                invoiceDetail.setHoaDon(invoice);
            }

            hoaDonChiTietRepo.saveAll(invoiceDetails);
        }

        return "redirect:/danh-sach-san-pham/hien-thi";
    }





}