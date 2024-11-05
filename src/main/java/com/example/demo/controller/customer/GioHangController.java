package com.example.demo.controller.customer;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
<<<<<<< HEAD
=======
import jakarta.servlet.http.HttpSession;
>>>>>>> main
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;
<<<<<<< HEAD
import java.util.stream.Collectors;
=======
>>>>>>> main

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
<<<<<<< HEAD
    public String addCart(@RequestParam("sanPhamId") int sanPhamId, Model model) {
=======
    public String addCart(@RequestParam("sanPhamId") int sanPhamId, HttpSession session, Model model) {
>>>>>>> main
        // Tìm sản phẩm chi tiết theo ID
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid product ID: " + sanPhamId));

<<<<<<< HEAD
        // Tìm giỏ hàng hiện tại (nếu có)
        Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull(); // Tìm giỏ hàng có khách hàng là null

        GioHang cart;
        if (existingCart.isPresent()) {
            cart = existingCart.get();
        } else {
            // Nếu chưa có giỏ hàng, tạo mới giỏ hàng
            cart = new GioHang();
            gioHangRepo.save(cart); // Lưu giỏ hàng mới
=======
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
>>>>>>> main
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

<<<<<<< HEAD
        // Tính tổng tiền và tổng số lượng
=======
        // Cập nhật tổng tiền và tổng số lượng
>>>>>>> main
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


<<<<<<< HEAD
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

=======

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

>>>>>>> main
        // Trả về trang xem giỏ hàng
        return "customer/gio_hang/index";
    }

<<<<<<< HEAD
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

=======

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
>>>>>>> main
                for (GioHangChiTiet detail : cartDetails) {
                    tongSoLuong += detail.getSoLuong();
                    tongTien += detail.getSoLuong() * detail.getGiaBan();
                }

<<<<<<< HEAD
                // Cập nhật giỏ hàng với thông tin mới
=======
                // Cập nhật lại giỏ hàng
>>>>>>> main
                cart.setTongSoLuong(tongSoLuong);
                cart.setTongTien(tongTien);
                gioHangRepo.save(cart); // Lưu giỏ hàng đã cập nhật
            }
        }

        // Chuyển hướng về trang giỏ hàng
        return "redirect:/gio-hang/cart";
    }

<<<<<<< HEAD
    @PostMapping("/updateQuantity")
    public String updateQuantity(@RequestParam("sanPhamId") int sanPhamId, @RequestParam("action") String action) {
        // Tìm giỏ hàng hiện tại (nếu có)
        Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();

        if (existingCart.isPresent()) {
            GioHang cart = existingCart.get();

            // Tìm chi tiết giỏ hàng có chứa sản phẩm cần cập nhật
            Optional<GioHangChiTiet> cartDetail = gioHangChiTietRepo.findByGioHangAndSanPhamChiTiet(cart, sanPhamChiTietRepo.findById(sanPhamId).get());

            if (cartDetail.isPresent()) {
                GioHangChiTiet detail = cartDetail.get();

                // Kiểm tra action để tăng hoặc giảm số lượng
                if (action.equals("increase")) {
                    detail.setSoLuong(detail.getSoLuong() + 1);
                    gioHangChiTietRepo.save(detail); // Lưu sau khi tăng số lượng
                } else if (action.equals("decrease")) {
                    detail.setSoLuong(detail.getSoLuong() - 1);
                    // Nếu số lượng về 0, xóa sản phẩm khỏi giỏ hàng
                    if (detail.getSoLuong() == 0) {
                        gioHangChiTietRepo.delete(detail);
                    } else {
                        gioHangChiTietRepo.save(detail); // Lưu sau khi giảm số lượng
                    }
                }

                // Cập nhật lại tổng số lượng và tổng tiền của giỏ hàng sau khi thay đổi
                int tongSoLuong = 0;
                int tongTien = 0;
                List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);

=======

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
>>>>>>> main
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

<<<<<<< HEAD
        // Chuyển hướng về trang giỏ hàng
        return "redirect:/gio-hang/cart";
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
=======
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
>>>>>>> main
            }
        }

        return totalValue; // Trả về tổng giá trị
    }

<<<<<<< HEAD
    @PostMapping("/checkout")
    public String checkout(@RequestParam(value = "selectedItems", required = false) List<Integer> selectedIds, Model model) {
=======

    @PostMapping("/checkout")
    public String checkout(@RequestParam(value = "selectedItems", required = false) List<Integer> selectedIds, HttpSession session, Model model) {
>>>>>>> main
        if (selectedIds == null || selectedIds.isEmpty()) {
            // Xử lý trường hợp không có sản phẩm nào được chọn
            model.addAttribute("errorMessage", "Bạn chưa chọn sản phẩm nào.");
            return "customer/gio_hang/index"; // Trả về trang giỏ hàng với thông báo lỗi
        }

<<<<<<< HEAD
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

=======
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
>>>>>>> main

    @PostMapping("/xac-nhan-hoa-don")
    public String confirm(
            @RequestParam(value = "selectedItems", required = false) List<Integer> selectedIds,
            @RequestParam("phuongThucThanhToan") String phuongThucThanhToan,
            @RequestParam("phuongThucVanChuyen") String phuongThucVanChuyen,
            @RequestParam("diaChi") String diaChi,
            @RequestParam("soDienThoai") String soDienThoai,
<<<<<<< HEAD
=======
            HttpSession session,
>>>>>>> main
            Model model) {

        if (selectedIds == null || selectedIds.isEmpty()) {
            model.addAttribute("errorMessage", "Bạn chưa chọn sản phẩm nào.");
            return "customer/gio_hang/index"; // Trả về trang giỏ hàng với thông báo lỗi
        }

<<<<<<< HEAD
        Optional<GioHang> existingCart = gioHangRepo.findByKhachHangIsNull();
=======
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
>>>>>>> main

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
<<<<<<< HEAD

=======
>>>>>>> main
                    invoiceDetails.add(invoiceDetail);

                    // Cập nhật số lượng sản phẩm trong kho
                    SanPhamChiTiet sanPham = detail.getSanPhamChiTiet();
<<<<<<< HEAD
                    sanPham.setSoLuong(sanPham.getSoLuong() - detail.getSoLuong()); // Giảm số lượng
                    sanPhamChiTietRepo.save(sanPham); // Lưu thay đổi vào kho

                    // Xóa chi tiết giỏ hàng đã chọn
                    gioHangChiTietRepo.delete(detail); // Xóa sản phẩm khỏi giỏ hàng
                }
            }

            // Tạo hóa đơn mới
            HoaDon invoice = new HoaDon();
            invoice.setTong_tien(totalAmount);
            invoice.setNgayTao(new java.util.Date());
            invoice.setPhuong_thuc_thanh_toan(phuongThucThanhToan); // Gán phương thức thanh toán
            invoice.setPhuongThucVanChuyen(phuongThucVanChuyen); // Gán phương thức vận chuyển
            invoice.setDiaChi(diaChi); // Gán địa chỉ cụ thể
            invoice.setSoDienThoai(soDienThoai); // Gán số điện thoại
            // Tạo số hóa đơn ngẫu nhiên
            String soHoaDon = "HD" + new Random().nextInt(90000);
            invoice.setSoHoaDon(soHoaDon);
            invoice.setTinh_trang(0);
            hoaDonRepo.save(invoice);

            // Gán hóa đơn cho chi tiết hóa đơn
            for (HoaDonChiTiet invoiceDetail : invoiceDetails) {
                invoiceDetail.setHoaDon(invoice);
            }

=======
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
            invoice.setTong_tien(totalAmount);
            invoice.setNgay_tao(new java.util.Date());
            invoice.setPhuong_thuc_thanh_toan(phuongThucThanhToan);
            invoice.setPhuongThucVanChuyen(phuongThucVanChuyen);
            invoice.setDiaChi(diaChi);
            invoice.setSoDienThoai(soDienThoai);
            invoice.setSo_hoa_don("HD" + new Random().nextInt(90000));
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
>>>>>>> main
            hoaDonChiTietRepo.saveAll(invoiceDetails);
        }

        return "redirect:/danh-sach-san-pham/hien-thi";
    }
<<<<<<< HEAD





=======
>>>>>>> main
}