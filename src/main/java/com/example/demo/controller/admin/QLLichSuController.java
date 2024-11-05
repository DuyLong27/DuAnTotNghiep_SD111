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
                          @RequestParam(name = "ngayTao", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date ngayTao,
                          Model model) {
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<HoaDon> page ;

        if (soHoaDon != null && !soHoaDon.isEmpty()) {
            page = hoaDonRepo.findBySoHoaDon(soHoaDon, pageable);
        } else if (ngayTao != null) {
            page = hoaDonRepo.findByNgayTao(ngayTao, pageable);
        } else {
            page= hoaDonRepo.findAll(pageable);
        }

        model.addAttribute("data", page);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("soHoaDon", soHoaDon);
        model.addAttribute("tenKhachHang", tenKhachHang); // Có thể thêm thông tin về idKhachHang vào model nếu cần
        model.addAttribute("ngayTao", ngayTao); // Đưa ngày tạo vào model để giữ giá trị khi quay lại trang

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
