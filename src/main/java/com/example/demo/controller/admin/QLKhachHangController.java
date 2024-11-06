package com.example.demo.controller.admin;

import com.example.demo.entity.KhachHang;
import com.example.demo.repository.KhachHangRepo;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/khach-hang")
public class QLKhachHangController {
    @Autowired
    KhachHangRepo repo;

    @PostMapping("/add")
    public String addNV(Model model, @Valid @ModelAttribute("data") KhachHang khachHang,
                        BindingResult validate, RedirectAttributes redirectAttributes) {
        if (validate.hasErrors()) {
            model.addAttribute("data",khachHang);
            return "admin/ql_khach_hang/QuanLyKhachHang";
        }
        repo.save(khachHang);
        redirectAttributes.addFlashAttribute("message", "Thêm thành công!");
        return "redirect:/khach-hang/hien-thi";
    }

    @GetMapping("/hien-thi")
    public String QuanLyKhachHang(@RequestParam(name = "page", defaultValue = "0") int pageNo,
                                  @RequestParam(name = "size", defaultValue = "5") int pageSize,
//                        @RequestParam(name = "tinhTrang", required = false) Integer tinhTrang,
                                  @RequestParam(name = "tenKhachHang", required = false) String tenKhachHang,
                                  Model model) {
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<KhachHang> page;

//        if (tenKhachHang != null) {
//            tenKhachHang = tenKhachHang.trim().replaceAll("\\s+", " ");
//        }

        // Tìm kiếm theo tên nhà cung cấp
        if (tenKhachHang != null && !tenKhachHang.isEmpty()) {
            page = repo.findBytenKhachHangContainingIgnoreCase(tenKhachHang, pageable);
        }
//        else if (tinhTrang != null) {
//            page = repo.findByTinhTrang(tinhTrang, pageable);
//        }
        else {
            page = repo.findAll(pageable);
        }

        model.addAttribute("data", page);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
//        model.addAttribute("tinhTrang", tinhTrang);
        model.addAttribute("tenKhachHang", tenKhachHang);
        return "admin/ql_khach_hang/QuanLyKhachHang";
    }


    @GetMapping("edit/{id}")
    public String editProduct(@PathVariable("id") Integer id, Model model) {
        KhachHang khachHang = repo.findById(id).orElse(null);
        model.addAttribute("data", khachHang);
        return "admin/ql_khach_hang/QuanLyKhachHang";
    }

    @PostMapping("/update")
    public String updateProduct(@Valid @ModelAttribute("data") KhachHang khachHang, BindingResult validate, Model model, RedirectAttributes redirectAttributes) {
        if (validate.hasErrors()) {
            model.addAttribute("data", khachHang);
            return "admin/ql_khach_hang/QuanLyKhachHang";
        }
        repo.save(khachHang);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công!");
        return "redirect:/khach-hang/hien-thi";
    }
}