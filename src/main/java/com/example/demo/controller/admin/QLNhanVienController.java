package com.example.demo.controller.admin;

import com.example.demo.entity.NhanVien;
import com.example.demo.repository.NhanVienRepo;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/nhan-vien")
public class QLNhanVienController {
    @Autowired
    NhanVienRepo nhanVienRepo;

    @GetMapping("/hien-thi")
    public String hienThi(HttpSession session,
                          @RequestParam(name = "page", defaultValue = "0") int pageNo,
                          @RequestParam(name = "size", defaultValue = "5") int pageSize,
                          Model model) {
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<NhanVien> page = nhanVienRepo.findAll(pageable);
        model.addAttribute("nv", page);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        return "/admin/ql_nhan_vien/index";
    }

    @GetMapping("/search")
    public String search(HttpSession session,
                         @RequestParam(name = "page", defaultValue = "0") int pageNo,
                         @RequestParam(name = "size", defaultValue = "5") int pageSize,
                         @RequestParam(name = "keyword", required = false) String keyword,
                         Model model) {
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<NhanVien> page;
        if (keyword != null && !keyword.isEmpty()) {
            page = nhanVienRepo.findByTenNhanVienContainingIgnoreCase(keyword, pageable);
        } else {
            page = nhanVienRepo.findAll(pageable);
        }
        model.addAttribute("nv", page);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("keyword", keyword);
        return "/admin/ql_nhan_vien/index";
    }

    @PostMapping("/add")
    public String addNhanVien(NhanVien nhanVien) {
        nhanVienRepo.save(nhanVien);
        return "redirect:/nhan-vien/hien-thi";
    }

    @GetMapping("/view-update/{id}")
    public String viewUpdateGioHang(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("nhanVien", nhanVienRepo.findById(id).get());
        model.addAttribute("listNhanVien", nhanVienRepo.findAll());
        return "/admin/QLNV/update";
    }

    @PostMapping("/update")
    public String updateGioHang(NhanVien nhanVien) {
        nhanVienRepo.save(nhanVien);
        return "redirect:/nhan-vien/hien-thi";
    }

    @GetMapping("/delete/{id}")
    public String deleteGiohang(@PathVariable("id") Integer id) {
        nhanVienRepo.deleteById(id);
        return "redirect:/nhan-vien/hien-thi";
    }
}
