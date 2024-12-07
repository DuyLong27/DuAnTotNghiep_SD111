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

import java.time.LocalDate;
import java.util.Date;

@Controller
@RequestMapping("/quan-ly-khach-hang")
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
        khachHang.setDiemTichLuy(0);
        khachHang.setRole(2);
        khachHang.setNgayDangKy(LocalDate.now());
        repo.save(khachHang);
        redirectAttributes.addFlashAttribute("message", "Thêm thành công!");
        return "redirect:/quan-ly-khach-hang/hien-thi";
    }

    @GetMapping("/hien-thi")
    public String QuanLyKhachHang(@RequestParam(name = "page", defaultValue = "0") int pageNo,
                                  @RequestParam(name = "size", defaultValue = "5") int pageSize,
                                  @RequestParam(name = "tenKhachHang", required = false) String tenKhachHang,
                                  Model model) {
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<KhachHang> page;

        if (tenKhachHang != null && !tenKhachHang.isEmpty()) {
            page = repo.findBytenKhachHangContainingIgnoreCase(tenKhachHang, pageable);
        }
        else {
            page = repo.findAll(pageable);
        }

        model.addAttribute("data", page);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
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
        KhachHang existingKhachHang = repo.findById(khachHang.getIdKhachHang()).orElse(null);
        if (existingKhachHang != null) {
            khachHang.setDiemTichLuy(existingKhachHang.getDiemTichLuy());
            khachHang.setNgayDangKy(existingKhachHang.getNgayDangKy());
        }
        repo.save(khachHang);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công!");
        return "redirect:/quan-ly-khach-hang/hien-thi";
    }

}