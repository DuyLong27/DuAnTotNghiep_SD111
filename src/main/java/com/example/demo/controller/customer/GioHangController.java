package com.example.demo.controller.customer;


import com.example.demo.entity.GioHang;
import com.example.demo.entity.GioHangChiTiet;
import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.GioHangChiTietRepo;
import com.example.demo.repository.GioHangRepo;
import com.example.demo.repository.SanPhamChiTietRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("gio-hang")
public class GioHangController {
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
    @GetMapping("/hien-thi")
    public String hienThi(Model model){
        model.addAttribute("listGioHang",gioHangChiTietRepo.findAll());
        return "customer/gio_hang/index";
    }
    @PostMapping("/tam-tinh")
    public String calculateTamTinh(@RequestParam(value = "selectedProducts", required = false) List<Integer> selectedIds, Model model) {
        int tamTinh = 0;

        // Nếu có sản phẩm được chọn
        if (selectedIds != null && !selectedIds.isEmpty()) {
            // Lấy các sản phẩm được chọn từ DB
            List<GioHangChiTiet> selectedProducts = gioHangChiTietRepo.findAllById(selectedIds);

            // Tính tổng tạm tính
            for (GioHangChiTiet item : selectedProducts) {
                tamTinh += item.getSoLuong() * item.getGiaBan();
            }

            // Đưa danh sách sản phẩm đã chọn vào model để hiển thị lại khi reload
            model.addAttribute("selectedIds", selectedIds);
        }

        // Đưa giá trị tạm tính vào model
        model.addAttribute("tamTinh", tamTinh);

        // Hiển thị lại danh sách giỏ hàng (cùng với tổng tạm tính)
        model.addAttribute("listGioHang", gioHangChiTietRepo.findAll());

        return "customer/gio_hang/index"; // Trả về trang JSP đã cập nhật
    }

    @PostMapping("/xoa-san-pham")
    public String xoaSanPham(@RequestParam("id") int id, Model model) {
        // Tìm sản phẩm chi tiết trong giỏ hàng
        Optional<GioHangChiTiet> gioHangChiTiet = gioHangChiTietRepo.findById(id);
        if (gioHangChiTiet.isPresent()) {
            // Xóa sản phẩm khỏi giỏ hàng
            gioHangChiTietRepo.delete(gioHangChiTiet.get());
        }

        // Cập nhật giỏ hàng sau khi xóa
        GioHang cart = gioHangChiTiet.get().getGioHang();
        List<GioHangChiTiet> cartDetails = gioHangChiTietRepo.findByGioHang(cart);

        // Tính lại tổng tiền và tổng số lượng
        int tongTien = 0;
        int tongSoLuong = 0;
        for (GioHangChiTiet detail : cartDetails) {
            tongSoLuong += detail.getSoLuong();
            tongTien += detail.getSoLuong() * detail.getGiaBan();
        }

        // Cập nhật giỏ hàng
        cart.setTongSoLuong(tongSoLuong);
        cart.setTongTien(tongTien);
        gioHangRepo.save(cart); // Lưu giỏ hàng đã cập nhật

        // Chuyển hướng lại về trang giỏ hàng
        return "redirect:/gio-hang/hien-thi";
    }
}
