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

    @GetMapping("/edit/{id}")
    public String editProduct(@PathVariable("id") Integer id, Model model) {
        KhoHang khoHang = khoHangRepo.findById(id).orElse(null);
        if (khoHang == null) {
            // Nếu không tìm thấy kho hàng, bạn có thể điều hướng đến trang lỗi hoặc trang danh sách kho hàng
            return "redirect:/kho-hang/hien-thi"; // Quay lại trang danh sách
        }
        model.addAttribute("data", khoHang); // Truyền đối tượng kho hàng vào model
        return "admin/ql_kho_hang/edit"; // Trang chỉnh sửa kho hàng (chắc chắn là form chỉnh sửa)
    }

    @PostMapping("/update")
    public String updateProduct(@Valid @ModelAttribute("data") KhoHang khoHang, BindingResult validate, Model model, RedirectAttributes redirectAttributes) {
        if (validate.hasErrors()) {
            model.addAttribute("data", khoHang);

            return "admin/ql_kho_hang/index"; // Hoặc trả về một trang cụ thể
        }
        khoHangRepo.save(khoHang);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công!");
        return "redirect:/kho-hang/hien-thi";
    }
}
