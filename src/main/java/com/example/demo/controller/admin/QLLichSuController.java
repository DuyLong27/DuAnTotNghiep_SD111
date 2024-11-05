package com.example.demo.controller.admin;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.HoaDonChiTiet;
import com.example.demo.entity.KhachHang;
import com.example.demo.repository.HoaDonChiTietRepo;
import com.example.demo.repository.HoaDonRepo;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/lich-su")
public class QLLichSuController {

    @Autowired
    HoaDonRepo hoaDonRepo;

    @Autowired
    private HoaDonChiTietRepo hoaDonChiTietRepository;


    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(name = "page", defaultValue = "0") int pageNo,
                          @RequestParam(name = "size", defaultValue = "5") int pageSize,
                          @RequestParam(name = "soHoaDon", required = false) String soHoaDon,
                          @RequestParam(name = "tenKhachHang", required = false) String tenKhachHang,
                          @RequestParam(name = "ngayTao", required = false) String ngayTaoStr,
                          Model model) {

        java.sql.Date ngayTao = null;
        if (ngayTaoStr != null && !ngayTaoStr.isEmpty()) {
            try {
                ngayTao = java.sql.Date.valueOf(ngayTaoStr);
            } catch (IllegalArgumentException e) {
                // Xử lý lỗi nếu cần
            }
        } else {
            // Nếu không có ngày tạo, thì bạn có thể thiết lập nó thành ngày hiện tại
            LocalDate today = LocalDate.now();
            ngayTao = java.sql.Date.valueOf(today);
        }

        // Tạo đối tượng Pageable với thông tin trang hiện tại và kích thước trang
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<HoaDon> hoaDonsPage;

        // Nếu không có tiêu chí tìm kiếm nào được cung cấp
        if (soHoaDon == null && tenKhachHang == null && ngayTao == null) {
            // Lấy hóa đơn trong ngày hôm nay
            LocalDate today = LocalDate.now();
            java.sql.Date todayDate = java.sql.Date.valueOf(today);
            hoaDonsPage = hoaDonRepo.findByNgayTao(todayDate, pageable); // Phương thức lấy hóa đơn theo ngày
        } else if (soHoaDon != null && !soHoaDon.isEmpty()) {
            // Nếu có số hóa đơn, tìm kiếm theo số hóa đơn
            hoaDonsPage = hoaDonRepo.findBySoHoaDon(soHoaDon, pageable);
        } else if (ngayTao != null) {
            // Nếu có ngày tạo, tìm kiếm hóa đơn theo ngày
            hoaDonsPage = hoaDonRepo.findByNgayTao(ngayTao, pageable);
        } else {
            // Nếu có các tiêu chí tìm kiếm khác, tìm kiếm theo tất cả các tiêu chí
            hoaDonsPage = hoaDonRepo.findByFilters(soHoaDon, tenKhachHang, ngayTao, pageable);
        }

        System.out.println("Số hóa đơn lấy được: " + hoaDonsPage.getTotalElements());

        // Thêm dữ liệu vào model để sử dụng trong JSP
        model.addAttribute("data", hoaDonsPage.getContent());
        model.addAttribute("currentPage", hoaDonsPage.getNumber());
        model.addAttribute("totalPages", hoaDonsPage.getTotalPages());
        model.addAttribute("soHoaDon", soHoaDon);
        model.addAttribute("tenKhachHang", tenKhachHang);
        model.addAttribute("ngayTao", ngayTaoStr); // Đưa tham số ngày vào model để hiển thị

        return "admin/ql_lich_su/index";
    }

    @GetMapping("/detail/{id}")
    public String chiTiet(@PathVariable("id") Integer id, Model model) {
        List<HoaDonChiTiet> hoaDonChiTiets = hoaDonChiTietRepository.findByHoaDonId(id);
        model.addAttribute("hoaDon", hoaDonRepo.findById(id).get());
        model.addAttribute("hoaDonChiTiets", hoaDonChiTiets);
        return "/admin/ql_lich_su/detail";
    }
}
