package com.example.demo.controller.admin;

import com.example.demo.entity.NhaCungCap;
import com.example.demo.repository.NhaCungCapRepo;
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
@RequestMapping("nha-cung-cap")
public class QLNhaCungCapController {

    @Autowired
    NhaCungCapRepo nhaCungCapRepo;

    @GetMapping
    public String getAllNhaCungCap(@RequestParam(name = "page", defaultValue = "0") int pageNo,
                                   @RequestParam(name = "size", defaultValue = "5") int pageSize,
                                   @RequestParam(name = "search", required = false) String search,
                                   @RequestParam(name = "tinhTrang", required = false) Integer tinhTrang,
                                   Model model) {
        // Trim khoảng trắng ở đầu và cuối của search
        if (search != null) {
            search = search.trim();
        }

        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<NhaCungCap> page;

        if (search != null && !search.isEmpty() && tinhTrang != null) {
            page = nhaCungCapRepo.findByTenNCCContainingAndTinhTrang(search, tinhTrang, pageable);
        } else if (search != null && !search.isEmpty()) {
            page = nhaCungCapRepo.findByTenNCCContaining(search, pageable);
        } else if (tinhTrang != null) {
            page = nhaCungCapRepo.findByTinhTrang(tinhTrang, pageable);
        } else {
            page = nhaCungCapRepo.findAll(pageable);
        }

        model.addAttribute("nhaCungCapList", page.getContent());
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("search", search);
        model.addAttribute("tinhTrang", tinhTrang);
        return "admin/ql_nha_cung_cap/index";
    }


    @PostMapping("/add")
    public String addNhaCungCap(@Valid @ModelAttribute NhaCungCap nhaCungCap, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "redirect:/nha-cung-cap";
        }
        nhaCungCapRepo.save(nhaCungCap);
        redirectAttributes.addFlashAttribute("message", "Thêm thành công!");
        return "redirect:/nha-cung-cap";
    }


//    @GetMapping("/delete/{id}")
//    public String deleteNhaCungCap(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
//        nhaCungCapRepo.deleteById(id);
//        redirectAttributes.addFlashAttribute("message", "Xóa thành công!");
//        return "redirect:/nha-cung-cap";
//    }

    @PostMapping("/update/{id}")
    public String updateNhaCungCap(@PathVariable("id") Integer id, @ModelAttribute NhaCungCap nhaCungCap, RedirectAttributes redirectAttributes) {
        nhaCungCap.setId(id);
        nhaCungCapRepo.save(nhaCungCap);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công!");
        return "redirect:/nha-cung-cap";
    }
}
