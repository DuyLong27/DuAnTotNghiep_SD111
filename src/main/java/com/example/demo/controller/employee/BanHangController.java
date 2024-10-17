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
@RequestMapping("/hoa-don")
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
    public String showHoaDon(Model model) {
        List<HoaDon> hoaDonList = hoaDonRepository.findAll();
        List<SanPhamChiTiet> sanPhamChiTietList = sanPhamChiTietRepo.findAll(); // Lấy danh sách SanPhamChiTiet
        model.addAttribute("hoaDonList", hoaDonList);
        model.addAttribute("selectedHoaDonId", null);
        model.addAttribute("sanPhams", sanPhamChiTietList); // Truyền SanPhamChiTiet thay vì SanPham
        return "employee/ban_hang/index";
    }

    @GetMapping("/{id}")
    public String showDetails(@PathVariable Integer id, Model model) {
        List<HoaDon> hoaDonList = hoaDonRepository.findAll();
        List<HoaDonChiTiet> hoaDonChiTiets = hoaDonChiTietRepository.findByHoaDonId(id);
        List<SanPhamChiTiet> sanPhamChiTietList = sanPhamChiTietRepo.findAll();

        String phuongThucThanhToan = hoaDonChiTiets.isEmpty() ? "Tiền mặt" : hoaDonChiTiets.get(0).getPhuong_thuc_thanh_toan();
        model.addAttribute("hoaDonList", hoaDonList);
        model.addAttribute("selectedHoaDonId", id);
        model.addAttribute("hoaDonChiTiets", hoaDonChiTiets);
        model.addAttribute("sanPhams", sanPhamChiTietList);
        model.addAttribute("phuongThucThanhToan", phuongThucThanhToan); // Thêm thuộc tính này
        return "employee/ban_hang/index";
    }



    @PostMapping("/{id}/add-product")
    public String addProductToInvoice(@PathVariable Integer id, @RequestParam Integer sanPhamId) {
        // Lấy hóa đơn theo ID
        HoaDon hoaDon = hoaDonRepository.findById(id).orElseThrow();

        // Tìm sản phẩm chi tiết theo sanPhamId
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamId).orElseThrow();

        // Tìm chi tiết hóa đơn theo hóa đơn ID và sản phẩm chi tiết ID
        HoaDonChiTiet existingDetail = hoaDonChiTietRepository.findByHoaDonIdAndSanPhamChiTietId(id, sanPhamChiTiet.getId());

        if (existingDetail != null) {
            // Nếu đã tồn tại, tăng số lượng lên 1
            existingDetail.setSo_luong(existingDetail.getSo_luong() + 1);
            // Tính toán lại tổng tiền
            existingDetail.setTong_tien(existingDetail.getSo_luong() * sanPhamChiTiet.getGiaBan());
            hoaDonChiTietRepository.save(existingDetail);
        } else {
            // Nếu không tồn tại, tạo mới chi tiết hóa đơn
            HoaDonChiTiet hoaDonChiTiet = new HoaDonChiTiet();
            hoaDonChiTiet.setHoaDon(hoaDon);
            hoaDonChiTiet.setSanPhamChiTiet(sanPhamChiTiet);
            hoaDonChiTiet.setSo_luong(1); // Khởi tạo số lượng là 1
            hoaDonChiTiet.setTong_tien(sanPhamChiTiet.getGiaBan()); // Tính tổng tiền
            hoaDonChiTiet.setPhuong_thuc_thanh_toan("Tiền mặt"); // Gán giá trị mặc định
            hoaDonChiTietRepository.save(hoaDonChiTiet);
        }

        // Cập nhật tổng tiền cho hóa đơn
        List<HoaDonChiTiet> chiTietHoaDons = hoaDonChiTietRepository.findByHoaDonId(id);
        int totalAmount = chiTietHoaDons.stream()
                .mapToInt(HoaDonChiTiet::getTong_tien)
                .sum();

        // Nếu bạn cần cập nhật tổng tiền vào một trường nào đó trong hóa đơn, hãy thêm logic ở đây.

        // Chuyển hướng về chi tiết hóa đơn
        return "redirect:/hoa-don/" + id;
    }





    public String generateRandomId() {
        return "HD" + new Random().nextInt(90000);
    }

    @PostMapping("addHoaDon")
    public String addHoaDon(@ModelAttribute HoaDon hoaDon, Model model) {
        hoaDon.setSo_hoa_don(generateRandomId());
        hoaDon.setTinh_trang(0);
        hoaDon.setNgay_tao(new Timestamp(System.currentTimeMillis())); // Set ngay_phat_hanh với thời gian hiện tại
        hoaDonRepository.save(hoaDon);

        // Chuyển hướng đến trang chi tiết hóa đơn mới được tạo
        return "redirect:/hoa-don/" + hoaDon.getId();
    }


    @PostMapping("/{id}/delete")
    @Transactional
    public String deleteInvoice(@PathVariable Integer id) {
        // Kiểm tra nếu hóa đơn tồn tại
        if (hoaDonRepository.existsById(id)) {
            // Xóa tất cả chi tiết hóa đơn liên quan
            hoaDonChiTietRepository.deleteByHoaDonId(id);

            // Xóa hóa đơn
            hoaDonRepository.deleteById(id);
        }
        return "redirect:/hoa-don";
    }




    @PostMapping("/{hoaDonId}/remove-product/{sanPhamChiTietId}")
    public String removeProductFromInvoice(@PathVariable Integer hoaDonId, @PathVariable Integer sanPhamChiTietId) {
        // Tìm chi tiết hóa đơn theo hóa đơn ID và sản phẩm chi tiết ID
        HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietRepository.findByHoaDonIdAndSanPhamChiTietId(hoaDonId, sanPhamChiTietId);
        if (hoaDonChiTiet != null) {
            if (hoaDonChiTiet.getSo_luong() > 1) {
                // Nếu số lượng lớn hơn 1, trừ đi 1
                hoaDonChiTiet.setSo_luong(hoaDonChiTiet.getSo_luong() - 1);
                // Cập nhật tổng tiền
                hoaDonChiTiet.setTong_tien(hoaDonChiTiet.getSo_luong() * hoaDonChiTiet.getSanPhamChiTiet().getGiaBan());
                hoaDonChiTietRepository.save(hoaDonChiTiet);
            } else {
                // Nếu số lượng là 1, xóa sản phẩm khỏi hóa đơn
                hoaDonChiTietRepository.delete(hoaDonChiTiet);
            }
        }
        // Chuyển hướng về chi tiết hóa đơn
        return "redirect:/hoa-don/" + hoaDonId;
    }



    @PostMapping("/{id}/update-all-payment-method")
    public String updatePaymentMethod(@PathVariable Integer id, @RequestParam String phuongThucThanhToan) {
        // Lấy tất cả chi tiết hóa đơn cho hóa đơn hiện tại
        List<HoaDonChiTiet> hoaDonChiTiets = hoaDonChiTietRepository.findByHoaDonId(id);

        // Cập nhật phương thức thanh toán cho tất cả các chi tiết hóa đơn
        for (HoaDonChiTiet chiTiet : hoaDonChiTiets) {
            chiTiet.setPhuong_thuc_thanh_toan(phuongThucThanhToan);
            hoaDonChiTietRepository.save(chiTiet);
        }

        // Chuyển hướng lại trang chi tiết hóa đơn
        return "redirect:/hoa-don/" + id; // Trở lại trang chi tiết hóa đơn
    }




    @PostMapping("/{hoaDonId}/update-note")
    public String updateNote(@PathVariable Integer hoaDonId, @RequestParam("ghi_chu") String ghiChu) {
        // Nếu ghi chú rỗng hoặc trống, gán giá trị mặc định "Không có ghi chú"
        if (ghiChu == null || ghiChu.trim().isEmpty()) {
            ghiChu = "Không có ghi chú";
        }

        List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepository.findByHoaDonId(hoaDonId);
        if (!hoaDonChiTietList.isEmpty()) {
            // Cập nhật ghi chú cho từng sản phẩm chi tiết trong hóa đơn
            for (HoaDonChiTiet hoaDonChiTiet : hoaDonChiTietList) {
                hoaDonChiTiet.setGhi_chu(ghiChu);
                hoaDonChiTietRepository.save(hoaDonChiTiet);
            }
        }
        return "redirect:/hoa-don/" + hoaDonId;
    }






}