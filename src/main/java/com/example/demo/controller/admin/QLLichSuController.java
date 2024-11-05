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

            }
        } else {
            LocalDate today = LocalDate.now();
            ngayTao = java.sql.Date.valueOf(today);
        }

        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<HoaDon> hoaDonsPage;

        if (soHoaDon == null && tenKhachHang == null && ngayTao == null) {
            LocalDate today = LocalDate.now();
            java.sql.Date todayDate = java.sql.Date.valueOf(today);
            hoaDonsPage = hoaDonRepo.findByNgayTao(todayDate, pageable);
        } else if (soHoaDon != null && !soHoaDon.isEmpty()) {
            hoaDonsPage = hoaDonRepo.findBySoHoaDon(soHoaDon, pageable);
        } else if (ngayTao != null) {
            hoaDonsPage = hoaDonRepo.findByNgayTao(ngayTao, pageable);
        } else {
            hoaDonsPage = hoaDonRepo.findByFilters(soHoaDon, tenKhachHang, ngayTao, pageable);
        }

        System.out.println("Số hóa đơn lấy được: " + hoaDonsPage.getTotalElements());

        model.addAttribute("data", hoaDonsPage.getContent());
        model.addAttribute("currentPage", hoaDonsPage.getNumber());
        model.addAttribute("totalPages", hoaDonsPage.getTotalPages());
        model.addAttribute("soHoaDon", soHoaDon);
        model.addAttribute("tenKhachHang", tenKhachHang);
        model.addAttribute("ngayTao", ngayTaoStr);

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
