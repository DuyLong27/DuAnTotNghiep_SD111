package com.example.demo.controller.admin;

import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Calendar;
@Controller
@RequestMapping("spct")
public class QLSanPhamChiTietController {
    @Autowired
    SanPhamChiTietRepo sanPhamChiTietRepo;

    @Autowired
    SanPhamRepo sanPhamRepo;
    @Autowired
    CanNangRepo canNangRepo;

    @Autowired
    ThuongHieuRepo thuongHieuRepo;

    @Autowired
    LoaiHatRepo loaiHatRepo;

    @Autowired
    LoaiCaPheRepo loaiCaPheRepo;

    @Autowired
    LoaiTuiRepo loaiTuiRepo;

    @Autowired
    HuongViRepo huongViRepo;

    @Autowired
    MucDoRangRepo mucDoRangRepo;

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "0") int pageNo,
                        @RequestParam(name = "size", defaultValue = "5") int pageSize,
                        @RequestParam(name = "tinhTrang", required = false) String tinhTrang, // Thêm tham số tình trạng
                        Model model) {
        Pageable pageable = PageRequest.of(pageNo, pageSize);

        // Kiểm tra nếu có tình trạng thì lọc theo tình trạng
        Page<SanPhamChiTiet> sanPhamChiTietPage;
        if (tinhTrang != null && !tinhTrang.isEmpty()) {
            Integer status = Integer.parseInt(tinhTrang); // Chuyển đổi sang Integer
            sanPhamChiTietPage = sanPhamChiTietRepo.findByTinhTrang(status, pageable); // Gọi phương thức lọc
        } else {
            sanPhamChiTietPage = sanPhamChiTietRepo.findAll(pageable);
        }

        model.addAttribute("sanPhamChiTietList", sanPhamChiTietPage.getContent());
        model.addAttribute("currentPage", sanPhamChiTietPage.getNumber());
        model.addAttribute("totalPages", sanPhamChiTietPage.getTotalPages());
        model.addAttribute("data", sanPhamChiTietPage);

        // Thêm danh sách cho các khóa phụ
        model.addAttribute("sanPhamList", sanPhamRepo.findAll());
        model.addAttribute("loaiCaPheList", loaiCaPheRepo.findAll());
        model.addAttribute("canNangList", canNangRepo.findAll());
        model.addAttribute("loaiHatList", loaiHatRepo.findAll());
        model.addAttribute("loaiTuiList", loaiTuiRepo.findAll());
        model.addAttribute("mucDoRangList", mucDoRangRepo.findAll());
        model.addAttribute("huongViList", huongViRepo.findAll());
        model.addAttribute("thuongHieuList", thuongHieuRepo.findAll());

        return "admin/ql_san_pham_chi_tiet/index";
    }




    @PostMapping("/add")
    public String addSanPhamChiTiet(@ModelAttribute SanPhamChiTiet sanPhamChiTiet, RedirectAttributes redirectAttributes) {
        // Tính toán ngày hết hạn là 3 tháng sau
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, 3);
        sanPhamChiTiet.setNgayHetHan(calendar.getTime());

        // Lưu sản phẩm chi tiết vào database
        sanPhamChiTietRepo.save(sanPhamChiTiet);
        redirectAttributes.addFlashAttribute("message", "Thêm thành công!");
        return "redirect:/spct/index";
    }


    @GetMapping("/delete/{id}")
    public String deleteSanPhamChiTiet(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        // Xóa sản phẩm chi tiết theo ID
        sanPhamChiTietRepo.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa thành công!");
        return "redirect:/spct/index";
    }

    @PostMapping("/update")
    public String updateSanPhamChiTiet(@ModelAttribute SanPhamChiTiet sanPhamChiTiet, RedirectAttributes redirectAttributes) {
        // Tính toán ngày hết hạn là 3 tháng sau
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, 3);
        sanPhamChiTiet.setNgayHetHan(calendar.getTime());

        // Lưu sản phẩm chi tiết vào database
        sanPhamChiTietRepo.save(sanPhamChiTiet);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công!");
        return "redirect:/spct/index";
    }
}
