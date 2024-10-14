package com.example.demo.controller.admin;

import com.example.demo.entity.NhanVien;
import com.example.demo.repository.NhanVienRepo;
import jakarta.servlet.http.HttpSession;
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
@RequestMapping("/nhan-vien")
public class QLNhanVienController {
    @Autowired
    NhanVienRepo nhanVienRepo;

    @PostMapping("/add")
    public String addNV(Model model, @Valid @ModelAttribute("data") NhanVien nhanVien,
                        BindingResult validate, RedirectAttributes redirectAttributes) {
        if (validate.hasErrors()) {
            model.addAttribute("data",nhanVien);
            return "admin/ql_nhan_vien/index";
        }
        nhanVienRepo.save(nhanVien);
        redirectAttributes.addFlashAttribute("message", "Thêm thành công!");
        return "redirect:admin/ql_nhan_vien/index";
    }

    @GetMapping("hien-thi")
    public String index(@RequestParam(name = "page", defaultValue = "0") int pageNo,
                        @RequestParam(name = "size", defaultValue = "5") int pageSize,
                        @RequestParam(name = "tinhTrang", required = false) Integer tinhTrang,
                        @RequestParam(name = "tenNhanVien", required = false) String tenNhanVien,
                        Model model) {
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<NhanVien> page;

        // Xử lý đầu vào tìm kiếm tên nhà cung cấp
        if (tenNhanVien != null) {
            // Loại bỏ dấu cách ở đầu và cuối, và thay thế nhiều dấu cách liên tiếp
            tenNhanVien = tenNhanVien.trim().replaceAll("\\s+", " ");
        }

        // Tìm kiếm theo tên nhà cung cấp
        if (tenNhanVien != null && !tenNhanVien.isEmpty()) {
            page = nhanVienRepo.findByTenNhanVienContainingIgnoreCase(tenNhanVien, pageable);
        } else if (tinhTrang != null) {
            page = nhanVienRepo.findByTinhTrang(tinhTrang, pageable);
        } else {
            page = nhanVienRepo.findAll(pageable);
        }

        model.addAttribute("data", page);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("tinhTrang", tinhTrang);
        model.addAttribute("tenNhanVien", tenNhanVien); // Để giữ trạng thái tìm kiếm
        return "admin/ql_nhan_vien/index";
    }





    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        nhanVienRepo.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa thành công!");
        return "redirect:admin/ql_nhan_vien/index";
    }



    @GetMapping("edit/{id}")
    public String editProduct(@PathVariable("id") Integer id, Model model) {
        NhanVien nhanVien = nhanVienRepo.findById(id).orElse(null);
        model.addAttribute("data", nhanVien);
        return "admin/ql_nhan_vien/index"; // Tạo một trang mới hoặc trả về index với modal
    }

    @PostMapping("/update")
    public String updateProduct(@Valid @ModelAttribute("data") NhanVien nhanVien, BindingResult validate, Model model, RedirectAttributes redirectAttributes) {
        if (validate.hasErrors()) {
            model.addAttribute("data", nhanVien);
            return "admin/ql_nhan_vien/index"; // Hoặc trả về một trang cụ thể
        }
        nhanVienRepo.save(nhanVien);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công!");
        return "redirect:admin/ql_nhan_vien/index";
    }
}
