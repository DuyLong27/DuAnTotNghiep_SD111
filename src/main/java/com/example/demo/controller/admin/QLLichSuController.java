package com.example.demo.controller.admin;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.HoaDonChiTiet;
import com.example.demo.repository.HoaDonChiTietRepo;
import com.example.demo.repository.HoaDonRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.Arrays;
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
                          @RequestParam(name = "dsTinhTrang", required = false) List<Integer> dsTinhTrang,
                          Model model) {

        // Nếu dsTinhTrang không được truyền vào, mặc định lấy [4, 14]
        if (dsTinhTrang == null || dsTinhTrang.isEmpty()) {
            dsTinhTrang = Arrays.asList(4, 13, 14); // Mặc định tình trạng là 4 và 14
        }

        // Khai báo biến ngày tạo
        java.sql.Date ngayTao = null;

        // Chuyển đổi ngày từ chuỗi nếu có tham số ngayTaoStr
        if (ngayTaoStr != null && !ngayTaoStr.isEmpty()) {
            try {
                ngayTao = java.sql.Date.valueOf(ngayTaoStr); // Chuyển đổi ngày từ chuỗi
            } catch (IllegalArgumentException e) {
                model.addAttribute("error", "Ngày tạo không hợp lệ!");
                return "admin/ql_lich_su/index"; // Nếu ngày không hợp lệ, trả về trang hiện tại với lỗi
            }
        } else {
            // Nếu không có tham số ngày tạo, không gán ngayTao là ngày hôm nay
            // mà để cho logic xử lý sau.
        }

        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<HoaDon> hoaDonsPage;

        // Kiểm tra các trường hợp lọc:
        if (soHoaDon != null && !soHoaDon.isEmpty()) {
            // Nếu chỉ có soHoaDon, yêu cầu lọc theo số hóa đơn và tình trạng
            if (ngayTao != null) {
                hoaDonsPage = hoaDonRepo.findBySoHoaDonAndNgayTao(soHoaDon, ngayTao, pageable); // Tìm kiếm theo số hóa đơn và ngày tạo
            } else {
                // Nếu không có ngày tạo, tìm tất cả các hóa đơn với số hóa đơn
                hoaDonsPage = hoaDonRepo.findBySoHoaDon(soHoaDon, pageable);
            }
        } else if (ngayTao != null) {
            // Nếu chỉ có ngày tạo và không có số hóa đơn, tìm các hóa đơn trong ngày này với tình trạng 4 và 14
            hoaDonsPage = hoaDonRepo.findByNgayTao(ngayTao, dsTinhTrang, pageable); // Tìm kiếm theo ngày tạo và tình trạng
        } else {
            // Nếu không có tham số nào, hiển thị hóa đơn trong ngày hôm nay
            LocalDate today = LocalDate.now();
            java.sql.Date todayDate = java.sql.Date.valueOf(today);
            hoaDonsPage = hoaDonRepo.findByNgayTao(todayDate, dsTinhTrang, pageable); // Sử dụng findByNgayTao với tình trạng 4 và 14
        }

        // In ra thông tin để debug
        System.out.println("Số hóa đơn lấy được: " + hoaDonsPage.getTotalElements());
        System.out.println("soHoaDon: " + soHoaDon);
        System.out.println("ngayTao: " + ngayTao);

        // Thêm các thuộc tính vào model để hiển thị trên giao diện
        model.addAttribute("data", hoaDonsPage.getContent());
        model.addAttribute("currentPage", hoaDonsPage.getNumber());
        model.addAttribute("totalPages", hoaDonsPage.getTotalPages());
        model.addAttribute("soHoaDon", soHoaDon);
        model.addAttribute("tenKhachHang", tenKhachHang);
        model.addAttribute("ngayTao", ngayTaoStr);
        model.addAttribute("dsTinhTrang", dsTinhTrang); // Thêm tham số dsTinhTrang vào model

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
