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

import java.util.List;
import java.time.LocalDate;

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
        List<KhoHang> khoHangList = khoHangRepo.findAll();
        model.addAttribute("data", khoHang); // Truyền đối tượng kho hàng vào model
        model.addAttribute("khoHangList", khoHangList);
        return "admin/ql_kho_hang/edit"; // Trang chỉnh sửa kho hàng (chắc chắn là form chỉnh sửa)
    }

    @PostMapping("/update")
    public String updateProduct(@RequestParam("idKhoHang") Integer idKhoHang,
                                @RequestParam("slTonKho") Integer slTonKho,
                                @RequestParam("ngayThayDoiTonKho") String ngayThayDoiTonKho,
                                RedirectAttributes redirectAttributes) {
        // Tìm kho hàng theo ID
        KhoHang khoHang = khoHangRepo.findById(idKhoHang).orElse(null);

        if (khoHang == null) {
            redirectAttributes.addFlashAttribute("error", "Kho hàng không tồn tại!");
            return "redirect:/kho-hang/hien-thi";
        }

        // Chuyển đổi ngày từ String thành LocalDate
        LocalDate ngayThayDoi = LocalDate.parse(ngayThayDoiTonKho);  // Chuyển đổi từ String sang LocalDate

        // Cập nhật số lượng tồn kho và ngày thay đổi
        khoHang.setSlTonKho(slTonKho);
        khoHang.setNgayThayDoiTonKho(ngayThayDoi);

        // Lưu lại kho hàng đã sửa
        khoHangRepo.save(khoHang);

        redirectAttributes.addFlashAttribute("message", "Cập nhật số lượng tồn kho thành công!");
        return "redirect:/kho-hang/hien-thi";
    }
}
