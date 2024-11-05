package com.example.demo.controller.admin;

import com.example.demo.entity.KhoHang;
import com.example.demo.repository.KhoHangRepo;
import com.example.demo.repository.NhanVienRepo;
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
@RequestMapping("/kho-hang")
public class QLKhoHangController {
    @Autowired
    KhoHangRepo khoHangRepo;

    @Autowired
    NhanVienRepo nhanVienRepo;

    @GetMapping("hien-thi")
    public String index(@RequestParam(name = "page", defaultValue = "0") int pageNo,
                        @RequestParam(name = "size", defaultValue = "5") int pageSize,
                        Model model) {

        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<KhoHang> page = khoHangRepo.findAll(pageable);

        model.addAttribute("data", page);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        return "admin/ql_kho_hang/index";
    }

    @PostMapping("/add")
    public String addNV(@PathVariable("id") Integer id, Model model , @Valid @ModelAttribute("data") KhoHang khoHang,
                        BindingResult validate, RedirectAttributes redirectAttributes) {
        model.addAttribute("gioHang", khoHangRepo.findById(id).get());
        if (validate.hasErrors()) {
            model.addAttribute("data", khoHang);
            return "admin/ql_nhan_vien/index";
        }
        khoHangRepo.save(khoHang);
        redirectAttributes.addFlashAttribute("message", "Thêm số lượng thành công!");
        return "redirect:/kho-hang/hien-thi";
    }
}
