package com.example.demo.controller.admin;

import com.example.demo.repository.HoaDonChiTietRepo;
import com.example.demo.repository.HoaDonRepo;
import com.example.demo.repository.SanPhamChiTietRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/bao-cao")
public class BaoCaoController {

    @Autowired
    private HoaDonRepo hoaDonRepo;

    @Autowired
    private HoaDonChiTietRepo hoaDonChiTietRepo;

    @Autowired
    private SanPhamChiTietRepo sanPhamChiTietRepo;

    @GetMapping("/hien-thi")
    public String getDailyReport(
            @RequestParam(value = "selectedDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate selectedDate,
            Model model) {

        // Nếu không có giá trị selectedDate, dùng ngày hôm nay làm mặc định
        if (selectedDate == null) {
            selectedDate = LocalDate.now();
        }

        // Tính tổng doanh thu
        BigDecimal tongDoanhThu = hoaDonChiTietRepo.tinhTongDoanhThuTheoNgayVaTinhTrang(selectedDate);

        // Đếm tổng số hóa đơn
        Long tongSoHoaDon = hoaDonRepo.demSoHoaDonTheoNgayVaTinhTrang(selectedDate);

        // Tính tổng sản phẩm bán ra
        Long tongSanPham = hoaDonChiTietRepo.tinhTongSanPhamBanRaTrongNgay(selectedDate);

        // Đưa dữ liệu vào Model
        model.addAttribute("selectedDate", selectedDate);
        model.addAttribute("tongDoanhThu", tongDoanhThu);
        model.addAttribute("tongSoHoaDon", tongSoHoaDon);
        model.addAttribute("tongSanPham", tongSanPham);

        return "admin/bao_cao/BaoCao";
    }


}