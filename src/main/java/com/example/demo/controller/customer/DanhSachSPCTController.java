package com.example.demo.controller.customer;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.HoaDonChiTiet;
import com.example.demo.entity.KhachHang;
import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
                                @RequestParam int sanPhamId) {

        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamId).orElse(null);
        if (sanPhamChiTiet == null) {
            return "redirect:/error";
        }

        int tongTien = soLuong * sanPhamChiTiet.getGiaBan();
        int phiVanChuyen = phuongThucVanChuyen.equals("Giao Hàng Tiêu Chuẩn") ? 20000 : 33000;
        tongTien += phiVanChuyen;

        // Tạo mã số hóa đơn ngẫu nhiên
        String soHoaDon = "HD" + new Random().nextInt(90000);

        // Tạo đối tượng HoaDon và thiết lập các thuộc tính
        HoaDon hoaDon = new HoaDon();
        hoaDon.setPhuong_thuc_thanh_toan(phuongThucThanhToan);
        hoaDon.setPhuongThucVanChuyen(phuongThucVanChuyen);
        hoaDon.setDiaChi(diaChi);
        hoaDon.setSoDienThoai(soDienThoai);
        hoaDon.setNgayTao(new Date());
        hoaDon.setTongTien(tongTien);
        hoaDon.setSoHoaDon(soHoaDon);
        hoaDon.setTinh_trang(0);

        // Kiểm tra người dùng đã đăng nhập hay chưa
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        if (khachHang != null) {
            hoaDon.setKhachHang(khachHang);
        }

        // Lưu hóa đơn vào cơ sở dữ liệu
        hoaDonRepo.save(hoaDon);

        // Tạo và lưu chi tiết hóa đơn
        HoaDonChiTiet hoaDonChiTiet = new HoaDonChiTiet();
        hoaDonChiTiet.setHoaDon(hoaDon);
        hoaDonChiTiet.setSanPhamChiTiet(sanPhamChiTiet);
        hoaDonChiTiet.setSo_luong(soLuong);
        hoaDonChiTiet.setGia_san_pham(sanPhamChiTiet.getGiaBan());
        hoaDonChiTietRepo.save(hoaDonChiTiet);

        // Cập nhật số lượng sản phẩm
        sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() - soLuong);
        sanPhamChiTietRepo.save(sanPhamChiTiet);

        return "redirect:/danh-sach-san-pham-chi-tiet/view-sp/" + sanPhamChiTiet.getId();
    }
}
