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
    public String showRevenueReport(Model model) {
        // Tính toán thời gian thực để hiển thị
        LocalDateTime currentTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd/MM/yyyy");
        String formattedCurrentTime = currentTime.format(formatter);

        // Tính toán startDate và endDate cho tháng hiện tại
        LocalDate now = LocalDate.now();
        LocalDate startDateLocal = now.with(TemporalAdjusters.firstDayOfMonth());  // Ngày bắt đầu tháng
        LocalDate endDateLocal = now.with(TemporalAdjusters.lastDayOfMonth());     // Ngày kết thúc tháng
        Date startDate = java.sql.Date.valueOf(startDateLocal);
        Date endDate = java.sql.Date.valueOf(endDateLocal);

        // Lấy tổng doanh thu từ startDate đến endDate
        Integer totalRevenue = hoaDonRepo.tinhTongTienHoaDon(startDate, endDate);

        // Lấy số hóa đơn hoàn thành từ startDate đến endDate
        Integer completedInvoices = hoaDonRepo.tinhTongSoHoaDonHoanThanh(startDate, endDate);

        // Lấy số hóa đơn hủy từ startDate đến endDate
        Integer cancelledInvoices = hoaDonRepo.tinhTongSoHoaDonHuy(startDate, endDate);

        List<Object[]> bestSellingProducts = sanPhamChiTietRepo.findBestSellingProduct(startDate, endDate);
        String bestProductName = bestSellingProducts.isEmpty() ? "Không có" : (String) bestSellingProducts.get(0)[0];
        Integer bestProductQuantity = bestSellingProducts.isEmpty() ? 0 : ((Long) bestSellingProducts.get(0)[1]).intValue();


        // Lấy tổng số mặt hàng bán được ra từ startDate đến endDate
        Integer totalItemsSold = hoaDonChiTietRepo.tinhTongSoLuongSanPhamTrongHoaDonHoanThanh(startDate, endDate);

        // Lấy doanh thu theo từng ngày trong khoảng thời gian
        List<Object[]> dailyRevenueData = hoaDonRepo.tinhDoanhThuTheoNgay(startDate, endDate);
        List<Integer> dailyRevenue = new ArrayList<>(Collections.nCopies(endDateLocal.getDayOfMonth(), 0));  // Mảng chứa doanh thu cho từng ngày, mặc định là 0

        // Cập nhật doanh thu vào từng ngày
        int totalDailyRevenue = 0;  // Tổng doanh thu trong tháng
        for (Object[] data : dailyRevenueData) {
            String date = (String) data[0]; // Ngày dưới dạng "yyyy-MM-dd"
            int day = Integer.parseInt(date.substring(8, 10)); // Lấy ngày trong tháng từ chuỗi (ngày 01, 02,...)
            int revenue = ((Number) data[1]).intValue(); // Doanh thu

            // Cập nhật doanh thu vào mảng doanh thu theo ngày
            dailyRevenue.set(day - 1, revenue); // Lưu doanh thu vào vị trí ngày tương ứng
            totalDailyRevenue += revenue;  // Cộng dồn tổng doanh thu
        }

        // Tính trung bình doanh thu mỗi ngày trong tháng
        double averageDailyRevenue = dailyRevenue.size() > 0 ? (double) totalDailyRevenue / dailyRevenue.size() : 0;

        // Ép kiểu sang int (làm tròn xuống)
        int roundedAverageRevenue = (int) averageDailyRevenue;


        // Truyền tất cả dữ liệu vào model
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("completedInvoices", completedInvoices);
        model.addAttribute("cancelledInvoices", cancelledInvoices);
        model.addAttribute("totalItemsSold", totalItemsSold);
        model.addAttribute("currentTime", formattedCurrentTime);
        model.addAttribute("dailyRevenue", dailyRevenue);
        model.addAttribute("bestProductName", bestProductName);
        model.addAttribute("bestProductQuantity", bestProductQuantity);
        model.addAttribute("averageDailyRevenue", roundedAverageRevenue); // Trung bình doanh thu mỗi ngày

        return "admin/bao_cao/DoanhThu"; // Trả về view
    }

    // Hiển thị giao diện nhập thông tin báo cáo
    @GetMapping("/hang-ngay")
    public String getReportForm() {
        return "admin/bao_cao/BaoCao"; // Trả về view chứa form
    }

    @GetMapping("/hang-ngay/xem")
    public String getDailyReport(
            @RequestParam("selectedDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate selectedDate,
            @RequestParam("reportType") String reportType,
            Model model) {

        // Chuyển LocalDate sang java.sql.Date
        java.sql.Date sqlDate = java.sql.Date.valueOf(selectedDate);  // Chuyển đổi đúng cách

        List<Object[]> reportData;

        // Nếu báo cáo là Doanh thu theo thu ngân
        if ("Doanh thu theo thu ngân".equals(reportType)) {
            // Gọi repo để lấy dữ liệu theo Doanh thu theo thu ngân
            reportData = hoaDonRepo.getEmployeeRevenueReport(sqlDate);  // Truyền java.sql.Date
        } else {
            // Gọi repo để lấy dữ liệu theo Doanh thu theo sản phẩm
            reportData = hoaDonRepo.getProductRevenueReport(sqlDate);  // Truyền java.sql.Date
        }

        // Thêm dữ liệu vào model để hiển thị trên view
        model.addAttribute("reportData", reportData);
        model.addAttribute("reportType", reportType);

        // Trả về view hiển thị báo cáo
        return "admin/bao_cao/BaoCao";
    }

}

