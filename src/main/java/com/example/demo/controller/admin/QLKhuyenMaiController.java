package com.example.demo.controller.admin;

import com.example.demo.entity.KhuyenMai;
import com.example.demo.repository.KhuyenMaiRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/khuyen-mai")
public class QLKhuyenMaiController {
    @Autowired
    KhuyenMaiRepo khuyenMaiRepo;

    @GetMapping("/hien-thi")
    public String view(@RequestParam(defaultValue = "0") int page,
                          @RequestParam(defaultValue = "5") int size, Model model) {

        Pageable pageable = PageRequest.of(page, size);
        Page<KhuyenMai> khuyenMaiPage = khuyenMaiRepo.findAll(pageable);

        model.addAttribute("listKhuyenMai", khuyenMaiPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", khuyenMaiPage.getTotalPages());
        return "admin/ql_khuyen_mai/khuyen-mai";
    }

    @GetMapping("/chi-tiet")
    public String detailPage(@RequestParam("id")Integer id, Model model){
        model.addAttribute("khuyenMaiDetail",khuyenMaiRepo.findById(id).get());
        return "admin/ql_khuyen_mai/chi-tiet";
    }

    @GetMapping ("/sua/{id}")
    public String editPage(@PathVariable("id") Integer id, Model model){
        model.addAttribute("khuyenMaiEdit",khuyenMaiRepo.findById(id).get());
        return "admin/ql_khuyen_mai/sua";
    }

    @PostMapping("/them")
    public String add(KhuyenMai khuyenMai){
        khuyenMaiRepo.save(khuyenMai);
        return "redirect:/khuyen-mai/hien-thi";
    }

    @GetMapping("/xoa")
    public String delete(@RequestParam("id") Integer id){
        khuyenMaiRepo.deleteById(id);
        return "redirect:/khuyen-mai/hien-thi";
    }

    @PostMapping("/sua/{id}")
    public String edit(@PathVariable("id") Integer id, KhuyenMai khuyenMai){
        khuyenMai.setIdKhuyenMai(id);
        khuyenMaiRepo.save(khuyenMai);
        return "redirect:/khuyen-mai/hien-thi";
    }
}

