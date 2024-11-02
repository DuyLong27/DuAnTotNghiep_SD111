package com.example.demo.controller.customer;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.KhachHang;
import com.example.demo.repository.HoaDonChiTietRepo;
import com.example.demo.repository.HoaDonRepo;
import com.example.demo.repository.KhachHangRepo;
import com.example.demo.repository.SanPhamChiTietRepo;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("doi-tra")
public class DoiTraController {
    @Autowired
    private KhachHangRepo khachHangRepo;

    @Autowired
    private SanPhamChiTietRepo sanPhamChiTietRepo;

    @Autowired
    private HoaDonChiTietRepo hoaDonChiTietRepo;

    @Autowired
    private HoaDonRepo hoaDonRepo;

    @GetMapping("")
    public String danhSachHoaDon(Model model, HttpSession session) {
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        if (khachHang != null) {
            List<HoaDon> hoaDonList = hoaDonRepo.findByKhachHang(khachHang);

            // Lấy chi tiết của từng hóa đơn
            for (HoaDon hoaDon : hoaDonList) {
                hoaDon.setHoaDonChiTietList(hoaDonChiTietRepo.findByHoaDon(hoaDon));
            }

            model.addAttribute("hoaDonList", hoaDonList);
        } else {
            model.addAttribute("errorMessage", "Bạn cần đăng nhập để xem danh sách hóa đơn.");
        }

        return "customer/doi_tra/index";
    }

    @GetMapping("/chi-tiet")
    public String chiTietHoaDon(@RequestParam("id") Integer id, Model model) {
        // Tìm hóa đơn theo ID
        HoaDon hoaDon = hoaDonRepo.findById(id).orElse(null);

        if (hoaDon != null) {
            // Lấy danh sách chi tiết của hóa đơn
            hoaDon.setHoaDonChiTietList(hoaDonChiTietRepo.findByHoaDon(hoaDon));
            model.addAttribute("hoaDon", hoaDon);

            // Thêm thông tin khách hàng
            KhachHang khachHang = hoaDon.getKhachHang();
            model.addAttribute("tenKhachHang", khachHang.getTenKhachHang());
            model.addAttribute("sdtKhachHang", khachHang.getSoDienThoai());
            model.addAttribute("diaChiKhachHang", khachHang.getDiaChi());

            // Tính tiền vận chuyển
            int tienVanChuyen = "Giao Hàng Nhanh".equals(hoaDon.getPhuongThucVanChuyen()) ? 33000 : 20000;
            model.addAttribute("tienVanChuyen", tienVanChuyen);
        } else {
            model.addAttribute("errorMessage", "Không tìm thấy hóa đơn.");
        }

        return "customer/doi_tra/detail";
    }


    @PostMapping("/ly-do-doi-tra")
    public String luuLyDoDoiTra(@RequestParam("hoaDonId") Integer hoaDonId, @RequestParam("lyDo") String lyDo, @RequestParam(value = "otherLyDo", required = false) String otherLyDo) {
        HoaDon hoaDon = hoaDonRepo.findById(hoaDonId).orElse(null);
        if (hoaDon != null) {
            if ("Khác".equals(lyDo) && otherLyDo != null && !otherLyDo.isEmpty()) {
                hoaDon.setLyDo(otherLyDo);
            } else {
                hoaDon.setLyDo(lyDo);
            }
            hoaDon.setTinh_trang(11);
            hoaDonRepo.save(hoaDon);
        }
        return "redirect:/doi-tra";
    }





}
