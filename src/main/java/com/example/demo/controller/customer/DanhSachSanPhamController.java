package com.example.demo.controller.customer;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.HoaDonChiTiet;
import com.example.demo.entity.KhachHang;
import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/danh-sach-san-pham")
public class DanhSachSanPhamController {
    @Autowired
    private KhachHangRepo khachHangRepo;
    @Autowired
    HoaDonRepo hoaDonRepo;

    @Autowired
    HoaDonChiTietRepo hoaDonChiTietRepo;

    @Autowired
    SanPhamChiTietRepo sanPhamChiTietRepo;

    @Autowired
    ThuongHieuRepo thuongHieuRepo;

    @Autowired
    LoaiCaPheRepo loaiCaPheRepo;

    @Autowired
    LoaiHatRepo loaiHatRepo;

    @Autowired
    MucDoRangRepo mucDoRangRepo;

    @Autowired
    HuongViRepo huongViRepo;

    @Autowired
    private GioHangChiTietRepo gioHangChiTietRepo;

    @GetMapping("/hien-thi")
    public String hienThi(Model model,
                          @RequestParam(required = false) Integer thuongHieuId,
                          @RequestParam(required = false) Integer loaiCaPheId,
                          @RequestParam(required = false) Integer huongViId,
                          @RequestParam(required = false) Integer loaiHatId,
                          @RequestParam(required = false) Integer mucDoRangId,
                          @RequestParam(required = false) Integer minPrice,
                          @RequestParam(required = false) Integer maxPrice,
                          @RequestParam(required = false, defaultValue = "none") String sort
    ) {
        List<SanPhamChiTiet> sanPhamList;

        if (thuongHieuId != null) {
            sanPhamList = sanPhamChiTietRepo.findByThuongHieuId(thuongHieuId);
        } else if (loaiCaPheId != null) {
            sanPhamList = sanPhamChiTietRepo.findByLoaiCaPheId(loaiCaPheId);
        } else if (huongViId != null) {
            sanPhamList = sanPhamChiTietRepo.findByHuongViId(huongViId);
        } else if (loaiHatId != null) {
            sanPhamList = sanPhamChiTietRepo.findByLoaiHatId(loaiHatId);
        } else if (mucDoRangId != null) {
            sanPhamList = sanPhamChiTietRepo.findByMucDoRangId(mucDoRangId);
        } else if (minPrice != null || maxPrice != null) {
            if (minPrice != null && maxPrice != null) {
                sanPhamList = sanPhamChiTietRepo.findByGiaBanBetween(minPrice, maxPrice);
            } else if (minPrice != null) {
                sanPhamList = sanPhamChiTietRepo.findByGiaBanBetween(minPrice, Integer.MAX_VALUE);
            } else {
                sanPhamList = sanPhamChiTietRepo.findByGiaBanBetween(Integer.MIN_VALUE, maxPrice);
            }
        } else {
            sanPhamList = sanPhamChiTietRepo.findAll();
        }

        if (sort.equals("asc")) {
            sanPhamList = sanPhamChiTietRepo.findAllByOrderByGiaBanAsc();
        } else if (sort.equals("desc")) {
            sanPhamList = sanPhamChiTietRepo.findAllByOrderByGiaBanDesc();
        }

        model.addAttribute("listSanPham", sanPhamList);
        model.addAttribute("listThuongHieu", thuongHieuRepo.findAll());
        model.addAttribute("listHuongVi", huongViRepo.findAll());
        model.addAttribute("listLoaiHat", loaiHatRepo.findAll());
        model.addAttribute("listMucDoRang", mucDoRangRepo.findAll());
        model.addAttribute("listLoaiCaPhe", loaiCaPheRepo.findAll());

        model.addAttribute("listGioHang",gioHangChiTietRepo.findAll());

        return "customer/san_pham/index";
    }

    @GetMapping("/mua-ngay")
    public String muaNgay(@RequestParam("productId") Integer productId, Model model) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(productId).orElse(null);
        model.addAttribute("sanPhamChiTiet", sanPhamChiTiet);
        List<SanPhamChiTiet> sanPhamList = sanPhamChiTietRepo.findAll();
        model.addAttribute("listSanPham", sanPhamList);
        return "customer/san_pham/index";
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
        hoaDon.setNgay_tao(new Date());
        hoaDon.setTong_tien(tongTien);
        hoaDon.setSo_hoa_don(soHoaDon);
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

        return "redirect:/danh-sach-san-pham/hien-thi";
    }
}