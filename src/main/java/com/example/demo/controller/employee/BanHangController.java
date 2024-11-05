package com.example.demo.controller.employee;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.HoaDonChiTiet;
import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.*;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/ban-hang")
public class BanHangController {
    @Autowired
    private SanPhamRepo sanPhamRepository;

    @Autowired
    private SanPhamChiTietRepo sanPhamChiTietRepo;
    @Autowired
    private HoaDonRepo hoaDonRepository;

    @Autowired
    private HoaDonChiTietRepo hoaDonChiTietRepository;

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
        model.addAttribute("tongTien", totalAmount); // Truyền tổng tiền vào model
        return "admin/ban_hang/index";
    }


    @PostMapping("/{id}/add-product")
    public String addProductToInvoice(@PathVariable Integer id, @RequestParam Integer sanPhamId) {
        HoaDon hoaDon = hoaDonRepository.findById(id).orElseThrow();
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamId).orElseThrow();
        HoaDonChiTiet existingDetail = hoaDonChiTietRepository.findByHoaDonIdAndSanPhamChiTietId(id, sanPhamChiTiet.getId());

        if (sanPhamChiTiet.getSoLuong() <= 0) {
            // Nếu không còn đủ số lượng sản phẩm trong kho thì báo lỗi
            return "redirect:/ban-hang/" + id + "?error=InsufficientStock";
        }

        if (existingDetail != null) {
            // Tăng số lượng sản phẩm chi tiết
            existingDetail.setSo_luong(existingDetail.getSo_luong() + 1);
            hoaDonChiTietRepository.save(existingDetail);
        } else {
            HoaDonChiTiet hoaDonChiTiet = new HoaDonChiTiet();
            hoaDonChiTiet.setHoaDon(hoaDon);
            hoaDonChiTiet.setSanPhamChiTiet(sanPhamChiTiet);
            hoaDonChiTiet.setSo_luong(1);
            hoaDonChiTiet.setGia_san_pham(sanPhamChiTiet.getGiaBan());
            hoaDonChiTietRepository.save(hoaDonChiTiet);
        }

        // Trừ số lượng sản phẩm trong kho sau khi thêm vào hóa đơn
        sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() - 1);
        sanPhamChiTietRepo.save(sanPhamChiTiet);

        return "redirect:/ban-hang/" + id;
    }


    public String generateRandomId() {
        return "HD" + new Random().nextInt(90000);
    }

    @PostMapping("addHoaDon")
    public String addHoaDon(@ModelAttribute HoaDon hoaDon, Model model) {
        hoaDon.setSoHoaDon(generateRandomId());
        hoaDon.setTinh_trang(0);
        hoaDon.setNgayTao(new Timestamp(System.currentTimeMillis()));
        hoaDon.setPhuong_thuc_thanh_toan("Tiền mặt"); // Đặt mặc định là "Tiền mặt"
        hoaDonRepository.save(hoaDon);

        // Chuyển hướng đến trang chi tiết hóa đơn mới được tạo
        return "redirect:/ban-hang/" + hoaDon.getId();
    }


    @PostMapping("/{id}/delete")
    @Transactional
    public String deleteHoaDon(@PathVariable Integer id, Model model) {
        List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepository.findByHoaDonId(id);
        // Hoàn trả số lượng sản phẩm trước khi xóa
        for (HoaDonChiTiet hoaDonChiTiet : hoaDonChiTietList) {
            SanPhamChiTiet sanPhamChiTiet = hoaDonChiTiet.getSanPhamChiTiet();
            sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() + hoaDonChiTiet.getSo_luong());
            sanPhamChiTietRepo.save(sanPhamChiTiet); // Cập nhật số lượng sản phẩm trong cơ sở dữ liệu
        }
        hoaDonChiTietRepository.deleteAll(hoaDonChiTietList);
        // Xóa hóa đơn
        hoaDonRepository.deleteById(id);

        // Tìm ID hóa đơn kế tiếp
        List<Integer> nextIds = hoaDonRepository.findNextId(id);
        Integer nextHoaDonId = nextIds.isEmpty() ? null : nextIds.get(0);

        // Nếu không có hóa đơn kế tiếp, lấy hóa đơn đầu tiên trong danh sách
        if (nextHoaDonId == null) {
            List<HoaDon> remainingHoaDons = hoaDonRepository.findAll();
            if (!remainingHoaDons.isEmpty()) {
                nextHoaDonId = remainingHoaDons.get(0).getId();
            }
        }

        // Nếu còn hóa đơn, chuyển hướng đến hóa đơn đó
        return nextHoaDonId != null
                ? "redirect:/ban-hang/" + nextHoaDonId
                : "redirect:/ban-hang";
    }


    @PostMapping("/{hoaDonId}/remove-product/{sanPhamChiTietId}")
    public String removeProductFromInvoice(@PathVariable Integer hoaDonId, @PathVariable Integer sanPhamChiTietId) {
        HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietRepository.findByHoaDonIdAndSanPhamChiTietId(hoaDonId, sanPhamChiTietId);
        if (hoaDonChiTiet != null) {
            SanPhamChiTiet sanPhamChiTiet = hoaDonChiTiet.getSanPhamChiTiet();

            if (hoaDonChiTiet.getSo_luong() > 1) {
                hoaDonChiTiet.setSo_luong(hoaDonChiTiet.getSo_luong() - 1);
                hoaDonChiTiet.setGia_san_pham(hoaDonChiTiet.getSo_luong() * sanPhamChiTiet.getGiaBan());
                hoaDonChiTietRepository.save(hoaDonChiTiet);
            } else {
                hoaDonChiTietRepository.delete(hoaDonChiTiet);
            }

            // Cộng lại số lượng sản phẩm khi xóa khỏi hóa đơn
            sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() + 1);
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
                             @RequestParam("ghi_chu") String ghiChu) {
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
    public String goToConfirmOrder(@PathVariable Integer id, @RequestParam("ghi_chu") String ghiChu, Model model) {
        HoaDon hoaDon1 = hoaDonRepository.findById(id).orElseThrow();
        List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepository.findByHoaDonId(id);
        model.addAttribute("hoaDon", hoaDon1);
        model.addAttribute("chiTietList", hoaDonChiTietList);
        // Tìm hóa đơn theo ID
        HoaDon hoaDon = hoaDonRepository.findById(id).orElse(null);
        if (hoaDon != null) {
            // Cập nhật ghi chú cho hóa đơn
            hoaDon.setGhiChu(ghiChu);
            hoaDonRepository.save(hoaDon);
        }
        model.addAttribute("hoaDon", hoaDon);
        return "admin/ban_hang/confirm-order";
    }


    @PostMapping("/{id}/confirm-order")
    public String confirmOrder(@PathVariable Integer id) {
        HoaDon hoaDon = hoaDonRepository.findById(id).orElseThrow();
        List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepository.findByHoaDonId(id);
        // Cập nhật trạng thái hóa đơn
        hoaDon.setTinh_trang(4);  // Đánh dấu hóa đơn đã xác nhận
        hoaDonRepository.save(hoaDon);
        // Tìm hóa đơn tiếp theo có tình trạng là 0
        List<HoaDon> remainingHoaDons = hoaDonRepository.findAll();
        Integer nextHoaDonId = remainingHoaDons.stream()
                .filter(hd -> hd.getTinh_trang() == 0)
                .map(HoaDon::getId)
                .findFirst()
                .orElse(null);
        return nextHoaDonId != null
                ? "redirect:/ban-hang/" + nextHoaDonId
                : "redirect:/ban-hang";
    }


}