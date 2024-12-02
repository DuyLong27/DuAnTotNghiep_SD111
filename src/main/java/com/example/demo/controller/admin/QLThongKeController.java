package com.example.demo.controller.admin;

import com.example.demo.repository.HoaDonChiTietRepo;
import com.example.demo.repository.HoaDonRepo;
import com.example.demo.repository.SanPhamChiTietRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/doanh-thu")
public class QLThongKeController {

    @Autowired
    private HoaDonRepo hoaDonRepo;

    @Autowired
    private HoaDonChiTietRepo hoaDonChiTietRepo;

    @Autowired
    private SanPhamChiTietRepo sanPhamChiTietRepo;

    @GetMapping("/hien-thi")
    public String showRevenueReport(Model model) {
        // Thời gian thực để hiển thị
        LocalDateTime currentTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd/MM/yyyy");
        String formattedCurrentTime = currentTime.format(formatter);

        // Tính toán startDate và endDate cho tháng hiện tại
        LocalDate now = LocalDate.now();
        LocalDate startDateLocal = now.with(TemporalAdjusters.firstDayOfMonth());  // Ngày đầu tiên của tháng
        LocalDate endDateLocal = now.with(TemporalAdjusters.lastDayOfMonth());    // Ngày cuối cùng của tháng
        Date startDate = java.sql.Date.valueOf(startDateLocal);
        Date endDate = java.sql.Date.valueOf(endDateLocal);

        // Tổng doanh thu từ startDate đến endDate
        Integer totalRevenue = hoaDonRepo.tinhTongTienHoaDon(startDate, endDate);

        // Tổng số lượng hóa đơn hoàn thành từ startDate đến endDate
        Integer completedInvoices = hoaDonRepo.tinhTongSoHoaDonHoanThanh(startDate, endDate);

        // Tổng số lượng hóa đơn hủy từ startDate đến endDate
        Integer cancelledInvoices = hoaDonRepo.tinhTongSoHoaDonHuy(startDate, endDate);

        // Sản phẩm bán chạy nhất trong khoảng thời gian
        List<Object[]> bestSellingProducts = sanPhamChiTietRepo.findBestSellingProduct(startDate, endDate);
        String bestProductName = bestSellingProducts.isEmpty() ? "Không có" : (String) bestSellingProducts.get(0)[0];
        Integer bestProductQuantity = bestSellingProducts.isEmpty() ? 0 : ((Long) bestSellingProducts.get(0)[1]).intValue();

        // Tổng số mặt hàng đã bán được (bao gồm hóa đơn hoàn thành và đổi trả)
        Integer totalItemsSold = hoaDonChiTietRepo.tinhTongSoLuongSanPhamTrongHoaDonHoanThanhVaDoiTra(startDate, endDate);

        // Doanh thu theo từng ngày trong khoảng thời gian
        List<Object[]> dailyRevenueData = hoaDonRepo.tinhDoanhThuTheoNgay(startDate, endDate);
        List<Integer> dailyRevenue = new ArrayList<>(Collections.nCopies(endDateLocal.getDayOfMonth(), 0)); // Mảng doanh thu mặc định là 0

        // Cập nhật doanh thu vào mảng từng ngày
        int totalDailyRevenue = 0; // Tổng doanh thu trong tháng
        for (Object[] data : dailyRevenueData) {
            String date = (String) data[0]; // Ngày (dưới dạng "yyyy-MM-dd")
            int day = Integer.parseInt(date.substring(8, 10)); // Lấy ngày (01, 02, ...)
            int revenue = ((Number) data[1]).intValue(); // Doanh thu

            dailyRevenue.set(day - 1, revenue); // Gán doanh thu vào đúng ngày trong mảng
            totalDailyRevenue += revenue; // Cộng dồn tổng doanh thu
        }

        // Tính trung bình doanh thu mỗi ngày
        double averageDailyRevenue = dailyRevenue.size() > 0 ? (double) totalDailyRevenue / dailyRevenue.size() : 0;

        // Làm tròn trung bình doanh thu (ép kiểu sang int)
        int roundedAverageRevenue = (int) averageDailyRevenue;

        // Truyền dữ liệu vào model
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("completedInvoices", completedInvoices);
        model.addAttribute("cancelledInvoices", cancelledInvoices);
        model.addAttribute("totalItemsSold", totalItemsSold);
        model.addAttribute("currentTime", formattedCurrentTime);
        model.addAttribute("dailyRevenue", dailyRevenue);
        model.addAttribute("bestProductName", bestProductName);
        model.addAttribute("bestProductQuantity", bestProductQuantity);
        model.addAttribute("averageDailyRevenue", roundedAverageRevenue);

        return "admin/bao_cao/DoanhThu"; // Trả về view
    }
}
