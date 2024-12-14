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
            soHoaDon = soHoaDon.trim();

            String regex = "^HD\\d+$";
            if (!soHoaDon.matches(regex)) {
                model.addAttribute("error", "Số hóa đơn không hợp lệ");
            } else {
                var hoaDonOptional = hoaDonRepo.findBySoHoaDon(soHoaDon);
                if (hoaDonOptional.isEmpty()) {
                    model.addAttribute("error", "Không tìm thấy hóa đơn với số: " + soHoaDon);
                } else {
                    var hoaDon = hoaDonOptional.get();
                    var thoiGianDonHang = thoiGianDonHangRepo.findByHoaDon_Id(hoaDon.getId());
                    var chiTietHoaDons = hoaDonChiTietRepo.findByHoaDon_Id(hoaDon.getId());

                    DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm , dd-MM-yyyy ");
                    String thoiGianTaoFormatted = (thoiGianDonHang != null && thoiGianDonHang.getThoiGianTao() != null) ?
                            thoiGianDonHang.getThoiGianTao().format(dateTimeFormatter) : "Chưa có thông tin";
                    String thoiGianXacNhanFormatted = (thoiGianDonHang != null && thoiGianDonHang.getThoiGianXacNhan() != null) ?
                            thoiGianDonHang.getThoiGianXacNhan().format(dateTimeFormatter) : "Chưa có thông tin";
                    String banGiaoVanChuyenFormatted = (thoiGianDonHang != null && thoiGianDonHang.getBanGiaoVanChuyen() != null) ?
                            thoiGianDonHang.getBanGiaoVanChuyen().format(dateTimeFormatter) : "Chưa có thông tin";
                    String hoanThanhFormatted = (thoiGianDonHang != null && thoiGianDonHang.getHoanThanh() != null) ?
                            thoiGianDonHang.getHoanThanh().format(dateTimeFormatter) : "Chưa có thông tin";
                    String hoanTraFormatted = (thoiGianDonHang != null && thoiGianDonHang.getHoanTra() != null) ?
                            thoiGianDonHang.getHoanTra().format(dateTimeFormatter) : "Chưa có thông tin";
                    String xacNhanHoanTraFormatted = (thoiGianDonHang != null && thoiGianDonHang.getXacNhanHoanTra() != null) ?
                            thoiGianDonHang.getXacNhanHoanTra().format(dateTimeFormatter) : "Chưa có thông tin";
                    String daHoanTraFormatted = (thoiGianDonHang != null && thoiGianDonHang.getDaHoanTra() != null) ?
                            thoiGianDonHang.getDaHoanTra().format(dateTimeFormatter) : "Chưa có thông tin";
                    String daHuyFormatted = (thoiGianDonHang != null && thoiGianDonHang.getDaHuy() != null) ?
                            thoiGianDonHang.getDaHuy().format(dateTimeFormatter) : "Chưa có thông tin";
                    String khongDoiTraFormatted = (thoiGianDonHang != null && thoiGianDonHang.getKhongHoanTra() != null) ?
                            thoiGianDonHang.getKhongHoanTra().format(dateTimeFormatter) : "Chưa có thông tin";

                    LocalDateTime thoiGianDuKien = null;
                    if (thoiGianDonHang != null && thoiGianDonHang.getBanGiaoVanChuyen() != null) {
                        if ("Giao Hàng Nhanh".equals(hoaDon.getPhuongThucVanChuyen())) {
                            thoiGianDuKien = thoiGianDonHang.getBanGiaoVanChuyen().plusDays(2);
                        } else {
                            thoiGianDuKien = thoiGianDonHang.getBanGiaoVanChuyen().plusDays(3);
                        }
                    }
                    String thoiGianDuKienFormatted = (thoiGianDuKien != null) ? thoiGianDuKien.format(DateTimeFormatter.ofPattern("dd-MM-yyyy")) : "Chưa có thông tin";

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
                    model.addAttribute("daHuy", daHuyFormatted);
                    model.addAttribute("khongDoiTra", khongDoiTraFormatted);
                }
            }
        } else {
            model.addAttribute("error", "Vui lòng nhập số hóa đơn để tìm kiếm.");
        }

        return "customer/tra_cuu_don_hang/index";
    }

}
