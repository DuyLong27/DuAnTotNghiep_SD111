package com.example.demo.controller.customer;

import com.example.demo.repository.HoaDonChiTietRepo;
import com.example.demo.repository.HoaDonRepo;
import com.example.demo.repository.ThoiGianDonHangRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Controller
@RequestMapping("/tra-cuu")
public class ThoiGianDonHangController {
    @Autowired
    ThoiGianDonHangRepo thoiGianDonHangRepo;
    @Autowired
    HoaDonRepo hoaDonRepo;

    @Autowired
    HoaDonChiTietRepo hoaDonChiTietRepo;


    @GetMapping("/tim-kiem")
    public String timKiem(String soHoaDon, Model model) {
        if (soHoaDon != null && !soHoaDon.isEmpty()) {
            var hoaDonOptional = hoaDonRepo.findBySoHoaDon(soHoaDon);
            if (hoaDonOptional.isEmpty()) {
                model.addAttribute("error", "Không tìm thấy hóa đơn với số: " + soHoaDon);
            } else {
                var hoaDon = hoaDonOptional.get();
                var thoiGianDonHang = thoiGianDonHangRepo.findByHoaDon_Id(hoaDon.getId());
                var chiTietHoaDons = hoaDonChiTietRepo.findByHoaDon_Id(hoaDon.getId());

                LocalDateTime thoiGianTao = thoiGianDonHang != null ? thoiGianDonHang.getThoiGianTao() : null;
                LocalDateTime thoiGianXacNhan = thoiGianDonHang != null ? thoiGianDonHang.getThoiGianXacNhan() : null;
                LocalDateTime banGiaoVanChuyenDate = thoiGianDonHang != null ? thoiGianDonHang.getBanGiaoVanChuyen() : null;
                LocalDateTime hoanThanhDate = thoiGianDonHang != null ? thoiGianDonHang.getHoanThanh() : null;
                LocalDateTime hoanTraDate = thoiGianDonHang != null ? thoiGianDonHang.getHoanTra() : null;
                LocalDateTime xacNhanHoanTraDate = thoiGianDonHang != null ? thoiGianDonHang.getXacNhanHoanTra() : null;
                LocalDateTime daHoanTraDate = thoiGianDonHang != null ? thoiGianDonHang.getDaHoanTra() : null;

                DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm , dd-MM-yyyy ");

                String thoiGianTaoFormatted = (thoiGianTao != null) ? thoiGianTao.format(dateTimeFormatter) : "Chưa có thông tin";
                String thoiGianXacNhanFormatted = (thoiGianXacNhan != null) ? thoiGianXacNhan.format(dateTimeFormatter) : "Chưa có thông tin";
                String banGiaoVanChuyenFormatted = (banGiaoVanChuyenDate != null) ? banGiaoVanChuyenDate.format(dateTimeFormatter) : "Chưa có thông tin";
                String hoanThanhFormatted = (hoanThanhDate != null) ? hoanThanhDate.format(dateTimeFormatter) : "Chưa có thông tin";
                String hoanTraFormatted = (hoanTraDate != null) ? hoanTraDate.format(dateTimeFormatter) : "Chưa có thông tin";
                String xacNhanHoanTraFormatted = (xacNhanHoanTraDate != null) ? xacNhanHoanTraDate.format(dateTimeFormatter) : "Chưa có thông tin";
                String daHoanTraFormatted = (daHoanTraDate != null) ? daHoanTraDate.format(dateTimeFormatter) : "Chưa có thông tin";

                LocalDateTime thoiGianDuKien = null;
                if (banGiaoVanChuyenDate != null) {
                    if ("Giao Hàng Nhanh".equals(hoaDon.getPhuongThucVanChuyen())) {
                        thoiGianDuKien = banGiaoVanChuyenDate.plusDays(2);
                    } else {
                        thoiGianDuKien = banGiaoVanChuyenDate.plusDays(3);
                    }
                }
                String thoiGianDuKienFormatted = (thoiGianDuKien != null) ? thoiGianDuKien.format(dateFormatter) : "Chưa có thông tin";

                model.addAttribute("hoaDon", hoaDon);
                model.addAttribute("thoiGianDonHang", thoiGianDonHang);
                model.addAttribute("chiTietHoaDons", chiTietHoaDons);
                model.addAttribute("thoiGianTao", thoiGianTaoFormatted);
                model.addAttribute("thoiGianXacNhan", thoiGianXacNhanFormatted);
                model.addAttribute("banGiaoVanChuyen", banGiaoVanChuyenFormatted);
                model.addAttribute("hoanThanh", hoanThanhFormatted);
                model.addAttribute("thoiGianDuKien", thoiGianDuKienFormatted);
                model.addAttribute("hoanTra", hoanTraFormatted);
                model.addAttribute("xacNhanHoanTra", xacNhanHoanTraFormatted);
                model.addAttribute("daHoanTra", daHoanTraFormatted);
            }
        } else {
            model.addAttribute("error", "Vui lòng nhập số hóa đơn để tìm kiếm.");
        }

        return "customer/tra_cuu_don_hang/index";
    }

}
