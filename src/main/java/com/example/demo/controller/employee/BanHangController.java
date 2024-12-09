package com.example.demo.controller.employee;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import org.apache.coyote.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/ban-hang")
public class BanHangController {
    @Autowired
    private KhachHangRepo khachHangRepo;
    @Autowired
    private SanPhamRepo sanPhamRepository;

    @Autowired
    private SanPhamChiTietRepo sanPhamChiTietRepo;
    @Autowired
    private HoaDonRepo hoaDonRepository;

    @Autowired
    private HoaDonChiTietRepo hoaDonChiTietRepository;

    public List<SanPhamChiTiet> getSanPhamWithKhuyenMai() {
        return sanPhamChiTietRepo.findAllWithPromotions();
    }

    @GetMapping("")
    public String showHoaDon(Model model,
                             @RequestParam(required = false) Integer tinhTrang) {
        List<HoaDon> hoaDonList;
        if (tinhTrang != null) {
            hoaDonList = hoaDonRepository.findByTinhTrang(tinhTrang);
        } else {
            hoaDonList = hoaDonRepository.findAll();
        }
        List<SanPhamChiTiet> sanPhamChiTietList = sanPhamChiTietRepo.findAll(); // Lấy danh sách SanPhamChiTiet
        model.addAttribute("hoaDonList", hoaDonList);
        model.addAttribute("selectedHoaDonId", null);
        model.addAttribute("sanPhams", sanPhamChiTietList); // Truyền SanPhamChiTiet thay vì SanPham
        return "admin/ban_hang/index";
    }

    @GetMapping("/{id}")
    public String showDetails(@PathVariable Integer id, Model model) {
        List<HoaDon> hoaDonList = hoaDonRepository.findAll();
        List<HoaDonChiTiet> hoaDonChiTiets = hoaDonChiTietRepository.findByHoaDonId(id);
        List<SanPhamChiTiet> sanPhamChiTietList = sanPhamChiTietRepo.findAll();
        HoaDon hoaDon = hoaDonRepository.findById(id).orElseThrow();
        int totalAmount = hoaDonChiTietRepository.findByHoaDonId(id).stream()
                .mapToInt(detail -> detail.getGia_san_pham() * detail.getSo_luong())
                .sum();
        hoaDon.setTongTien(totalAmount);
        hoaDonRepository.save(hoaDon);
        String phuongThucThanhToan = hoaDon.getPhuong_thuc_thanh_toan();
        model.addAttribute("hoaDonList", hoaDonList);
        model.addAttribute("selectedHoaDonId", id);
        model.addAttribute("hoaDonChiTiets", hoaDonChiTiets);
        model.addAttribute("sanPhams", sanPhamChiTietList);
        model.addAttribute("phuongThucThanhToan", phuongThucThanhToan);
        model.addAttribute("tongTien", totalAmount);
        return "admin/ban_hang/index";
    }



    @PostMapping("/{id}/add-product")
    public String addProductToInvoice(@PathVariable Integer id, @RequestParam Integer sanPhamId) {
        HoaDon hoaDon = hoaDonRepository.findById(id).orElseThrow();
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamId).orElseThrow();
        HoaDonChiTiet existingDetail = hoaDonChiTietRepository.findByHoaDonIdAndSanPhamChiTietId(id, sanPhamChiTiet.getId());
        if (sanPhamChiTiet.getSoLuong() <= 0) {
            return "redirect:/ban-hang/" + id + "?error=InsufficientStock";
        }
        int giaApDung = (sanPhamChiTiet.getGiaGiamGia() != null && sanPhamChiTiet.getGiaGiamGia() > 0)
                ? sanPhamChiTiet.getGiaGiamGia()
                : sanPhamChiTiet.getGiaBan();

        if (existingDetail != null) {
            existingDetail.setSo_luong(existingDetail.getSo_luong() + 1);
            hoaDonChiTietRepository.save(existingDetail);
        } else {
            HoaDonChiTiet hoaDonChiTiet = new HoaDonChiTiet();
            hoaDonChiTiet.setHoaDon(hoaDon);
            hoaDonChiTiet.setSanPhamChiTiet(sanPhamChiTiet);
            hoaDonChiTiet.setSo_luong(1);
            hoaDonChiTiet.setGia_san_pham(giaApDung);
            hoaDonChiTietRepository.save(hoaDonChiTiet);
        }
        sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() - 1);
        sanPhamChiTietRepo.save(sanPhamChiTiet);
        return "redirect:/ban-hang/" + id;
    }




    public String generateRandomId() {
        return "HD" + new Random().nextInt(90000);
    }

    @PostMapping("addHoaDon")
    public String addHoaDon(@ModelAttribute HoaDon hoaDon, HttpSession session) {
        NhanVien nhanVien = (NhanVien) session.getAttribute("khachHang");
        if (nhanVien == null || !(nhanVien instanceof NhanVien)) {
            return "redirect:/auth/login";
        }
        hoaDon.setSoHoaDon(generateRandomId());
        hoaDon.setTinh_trang(0);
        hoaDon.setKieuHoaDon(0);
        hoaDon.setNgayTao(new Date()); // Ngày tạo
        hoaDon.setPhuong_thuc_thanh_toan("Tiền mặt");
        hoaDon.setNhanVien(nhanVien);
        hoaDonRepository.save(hoaDon);
        return "redirect:/ban-hang/" + hoaDon.getId();
    }




    @PostMapping("/{id}/delete")
    @Transactional
    public String cancelHoaDon(@PathVariable Integer id, Model model) {
        HoaDon hoaDon = hoaDonRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Hóa đơn không tồn tại"));
        hoaDon.setTinh_trang(14);
        hoaDon.setGhiChu("Nhân viên vô tình tạo ra");
        hoaDonRepository.save(hoaDon);
        List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepository.findByHoaDonId(id);
        for (HoaDonChiTiet hoaDonChiTiet : hoaDonChiTietList) {
            SanPhamChiTiet sanPhamChiTiet = hoaDonChiTiet.getSanPhamChiTiet();
            sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() + hoaDonChiTiet.getSo_luong());
            sanPhamChiTietRepo.save(sanPhamChiTiet);
        }
        List<Integer> nextIds = hoaDonRepository.findNextId(id);
        Integer nextHoaDonId = nextIds.isEmpty() ? null : nextIds.get(0);
        if (nextHoaDonId == null) {
            List<HoaDon> remainingHoaDons = hoaDonRepository.findAll();
            if (!remainingHoaDons.isEmpty()) {
                nextHoaDonId = remainingHoaDons.get(0).getId();
            }
        }
        return nextHoaDonId != null
                ? "redirect:/ban-hang/" + nextHoaDonId
                : "redirect:/ban-hang";
    }



    @PostMapping("/{hoaDonId}/remove-product/{sanPhamChiTietId}")
    public String removeProductFromInvoice(@PathVariable Integer hoaDonId, @PathVariable Integer sanPhamChiTietId) {
        HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietRepository.findByHoaDonIdAndSanPhamChiTietId(hoaDonId, sanPhamChiTietId);
        if (hoaDonChiTiet != null) {
            SanPhamChiTiet sanPhamChiTiet = hoaDonChiTiet.getSanPhamChiTiet();
            int soLuong = hoaDonChiTiet.getSo_luong();
            hoaDonChiTietRepository.delete(hoaDonChiTiet);
            sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() + soLuong);
            sanPhamChiTietRepo.save(sanPhamChiTiet);
        }
        return "redirect:/ban-hang/" + hoaDonId;
    }



    @PostMapping("/{hoaDonId}/update-all-payment-method")
    public String updatePaymentMethod(@PathVariable("hoaDonId") Integer hoaDonId,
                                      @RequestParam("phuongThucThanhToan") String phuongThucThanhToan) {
        HoaDon hoaDon = hoaDonRepository.findById(hoaDonId).orElse(null);
        if (hoaDon != null) {
            hoaDon.setPhuong_thuc_thanh_toan(phuongThucThanhToan);
            hoaDonRepository.save(hoaDon);
        }
        return "redirect:/ban-hang/" + hoaDonId;
    }


    @PostMapping("/{hoaDonId}/update-note")
    public String updateNote(@PathVariable("hoaDonId") Integer hoaDonId,
                             @RequestParam("ghiChu") String ghiChu) {
        HoaDon hoaDon = hoaDonRepository.findById(hoaDonId).orElse(null);
        if (hoaDon != null) {
            if (ghiChu != null && !ghiChu.trim().isEmpty()) {
                hoaDon.setGhiChu(ghiChu);
            } else {
                hoaDon.setGhiChu(null);
            }
            hoaDonRepository.save(hoaDon);
        }
        return "redirect:/ban-hang/" + hoaDonId;
    }


    @PostMapping("/{id}/confirm")
    public String goToConfirmOrder(@PathVariable Integer id, @RequestParam("ghiChu") String ghiChu,
                                   @RequestParam("soDienThoai") String soDienThoai, HttpSession session, Model model) {
        HoaDon hoaDon = hoaDonRepository.findById(id).orElse(null);
        if (hoaDon != null) {
            hoaDon.setGhiChu(ghiChu);
            KhachHang khachHang = khachHangRepo.findBySoDienThoai(soDienThoai);
            if (khachHang != null) {
                hoaDon.setKhachHang(khachHang);
            } else {
                hoaDon.setKhachHang(null);
            }
            int diemTichLuy = khachHang != null ? khachHang.getDiemTichLuy() : 0;
            int discountRate = diemTichLuy / 1000 * 5;
            discountRate = Math.min(discountRate, 30);
            int totalOriginalPrice = 0;
            int discountAmount = 0;
            for (HoaDonChiTiet hoaDonChiTiet : hoaDon.getHoaDonChiTietList()) {
                SanPhamChiTiet sanPhamChiTiet = hoaDonChiTiet.getSanPhamChiTiet();
                int priceAfterPromotion = sanPhamChiTiet.getGiaGiamGia() != null && sanPhamChiTiet.getGiaGiamGia() > 0 ?
                        sanPhamChiTiet.getGiaGiamGia() : sanPhamChiTiet.getGiaBan();
                hoaDonChiTiet.setGia_san_pham(priceAfterPromotion);
                hoaDonChiTietRepository.save(hoaDonChiTiet);
                totalOriginalPrice += priceAfterPromotion * hoaDonChiTiet.getSo_luong();
            }
            discountAmount = totalOriginalPrice * discountRate / 100;
            int totalAmountAfterDiscount = totalOriginalPrice - discountAmount;
            hoaDon.setTongTien(totalAmountAfterDiscount);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss, dd/MM/yyyy");
            String formattedThoiGianTao = hoaDon.getThoiGianTao().format(formatter);
            hoaDonRepository.save(hoaDon);
            session.setAttribute("soDienThoai", soDienThoai);
            session.setAttribute("ghiChu", ghiChu);
            List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepository.findByHoaDonId(id);
            model.addAttribute("hoaDon", hoaDon);
            model.addAttribute("formattedThoiGianTao", formattedThoiGianTao);
            model.addAttribute("chiTietList", hoaDonChiTietList);
            model.addAttribute("discountAmount", discountAmount);
        }

        return "admin/ban_hang/confirm-order";
    }








    @PostMapping("/{id}/confirm-order")
    public String confirmOrder(@PathVariable Integer id,
                               @RequestParam("ghiChu") String ghiChu,
                               @RequestParam("soDienThoai") String soDienThoai) {
        HoaDon hoaDon = hoaDonRepository.findById(id).orElseThrow();
        hoaDon.setGhiChu(ghiChu);
        hoaDon.setSoDienThoai(soDienThoai);
        KhachHang khachHang = khachHangRepo.findBySoDienThoai(soDienThoai);
        if (khachHang != null) {
            hoaDon.setKhachHang(khachHang);
            int totalOriginalPrice = 0;
            for (HoaDonChiTiet hoaDonChiTiet : hoaDon.getHoaDonChiTietList()) {
                SanPhamChiTiet sanPhamChiTiet = hoaDonChiTiet.getSanPhamChiTiet();
                int priceAfterPromotion = sanPhamChiTiet.getGiaGiamGia() != null && sanPhamChiTiet.getGiaGiamGia() > 0 ?
                        sanPhamChiTiet.getGiaGiamGia() : sanPhamChiTiet.getGiaBan();
                hoaDonChiTiet.setGia_san_pham(priceAfterPromotion);
                hoaDonChiTietRepository.save(hoaDonChiTiet);
                totalOriginalPrice += priceAfterPromotion * hoaDonChiTiet.getSo_luong();
            }
            int diemTichLuy = khachHang.getDiemTichLuy();
            int discountRate = diemTichLuy / 1000 * 5;
            discountRate = Math.min(discountRate, 30);
            int discountAmount = totalOriginalPrice * discountRate / 100;
            int totalAmountAfterDiscount = totalOriginalPrice - discountAmount;
            hoaDon.setTongTien(totalAmountAfterDiscount);
            int remainingAmount = totalAmountAfterDiscount;
            for (HoaDonChiTiet hoaDonChiTiet : hoaDon.getHoaDonChiTietList()) {
                int originalPrice = hoaDonChiTiet.getGia_san_pham() * hoaDonChiTiet.getSo_luong();
                double productDiscount = (double) originalPrice / totalOriginalPrice * discountAmount;
                int newPriceAfterDiscount = originalPrice - (int) productDiscount;
                hoaDonChiTiet.setGia_san_pham(newPriceAfterDiscount / hoaDonChiTiet.getSo_luong());
                hoaDonChiTietRepository.save(hoaDonChiTiet);
                remainingAmount -= newPriceAfterDiscount;
            }
            int pointsToAdd = totalOriginalPrice / 10000;
            khachHang.setDiemTichLuy(khachHang.getDiemTichLuy() + pointsToAdd);
            khachHangRepo.save(khachHang);
        } else {
            hoaDon.setKhachHang(null);
        }
        hoaDon.setTinh_trang(4);
        hoaDonRepository.save(hoaDon);
        Integer nextHoaDonId = hoaDonRepository.findAll().stream()
                .filter(hd -> hd.getTinh_trang() == 0)
                .map(HoaDon::getId)
                .findFirst()
                .orElse(null);
        return nextHoaDonId != null
                ? "redirect:/ban-hang/" + nextHoaDonId
                : "redirect:/ban-hang";
    }


    @PostMapping("/{id}/update-quantity/{sanPhamChiTietId}")
    public String updateQuantityInInvoice(@PathVariable Integer id,
                                          @PathVariable Integer sanPhamChiTietId,
                                          @RequestParam Integer soLuong) {
        HoaDon hoaDon = hoaDonRepository.findById(id).orElseThrow();
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamChiTietId).orElseThrow();
        HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietRepository.findByHoaDonIdAndSanPhamChiTietId(id, sanPhamChiTiet.getId());
        if (hoaDonChiTiet != null) {
            int oldQuantity = hoaDonChiTiet.getSo_luong();
            if (soLuong < 1 || soLuong > sanPhamChiTiet.getSoLuong() + oldQuantity) {
                return "redirect:/ban-hang/" + id + "?error=InvalidQuantity";
            }
            hoaDonChiTiet.setSo_luong(soLuong);
            hoaDonChiTietRepository.save(hoaDonChiTiet);
            int quantityChange = soLuong - oldQuantity;
            if (quantityChange > 0) {
                sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() - quantityChange);
            } else {
                sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() - quantityChange);
            }
            sanPhamChiTietRepo.save(sanPhamChiTiet);
        }
        return "redirect:/ban-hang/" + id;
    }


    @GetMapping("/check-phone")
    @ResponseBody
    public ResponseEntity<Map<String, String>> checkPhone(@RequestParam String soDienThoai) {
        Map<String, String> response = new HashMap<>();
        KhachHang khachHang = khachHangRepo.findBySoDienThoai(soDienThoai);

        if (khachHang != null) {
            int diemTichLuy = khachHang.getDiemTichLuy();
            String rank = getRankFromDiemTichLuy(diemTichLuy);
            int discountRate = getDiscountRateFromDiemTichLuy(diemTichLuy);

            response.put("tenKhachHang", khachHang.getTenKhachHang());
            response.put("diemTichLuy", String.valueOf(diemTichLuy));
            response.put("rank", rank);
            response.put("discountRate", String.valueOf(discountRate));
        } else {
            response.put("tenKhachHang", "Khách lẻ");
            response.put("diemTichLuy", "0");
            response.put("rank", "Khách lẻ");
            response.put("discountRate", "0");
        }

        return ResponseEntity.ok(response);
    }

    private String getRankFromDiemTichLuy(int diemTichLuy) {
        if (diemTichLuy >= 5000) return "VIP";
        if (diemTichLuy >= 4000) return "Kim Cương";
        if (diemTichLuy >= 3000) return "Bạch Kim";
        if (diemTichLuy >= 2000) return "Lục Bảo";
        if (diemTichLuy >= 1000) return "Vàng";
        if (diemTichLuy < 1000) return "Bạc";
        return "Khách lẻ";
    }

    private int getDiscountRateFromDiemTichLuy(int diemTichLuy) {
        int discount = diemTichLuy / 1000 * 5;
        return Math.min(discount, 30);
    }



}