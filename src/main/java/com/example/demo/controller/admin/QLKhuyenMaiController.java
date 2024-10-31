package com.example.demo.controller.admin;

import com.example.demo.entity.KhuyenMai;
import com.example.demo.repository.KhuyenMaiRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
@RequestMapping("/khuyen-mai")
public class QLKhuyenMaiController {
    @Autowired
    KhuyenMaiRepo khuyenMaiRepo;

    @GetMapping("/hien-thi")
    public String view(@RequestParam(defaultValue = "0") int page,
                       @RequestParam(defaultValue = "5") int size,
                       @RequestParam(required = false) String maKhuyenMai,
                       @RequestParam(required = false) String tenKhuyenMai,
                       @RequestParam(required = false) Integer giaTriMin,
                       @RequestParam(required = false) Integer giaTriMax,
                       @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate ngayBatDau,
                       @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate ngayKetThuc,
                       Model model) {
        Pageable pageable = PageRequest.of(page, size);

        Page<KhuyenMai> khuyenMaiPage = khuyenMaiRepo.findFiltered(maKhuyenMai, tenKhuyenMai, giaTriMin, giaTriMax, ngayBatDau, ngayKetThuc, pageable);

        model.addAttribute("maKhuyenMai", maKhuyenMai);
        model.addAttribute("tenKhuyenMai", tenKhuyenMai);
        model.addAttribute("giaTriMin", giaTriMin);
        model.addAttribute("giaTriMax", giaTriMax);
        model.addAttribute("ngayBatDau", ngayBatDau);
        model.addAttribute("ngayKetThuc", ngayKetThuc);

        model.addAttribute("listKhuyenMai", khuyenMaiPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", khuyenMaiPage.getTotalPages());

        return "admin/ql_khuyen_mai/index";
    }


    @PostMapping("/them")
    public String add(KhuyenMai khuyenMai){
         khuyenMaiRepo.save(khuyenMai);
        return "redirect:/khuyen-mai/hien-thi";
    }

    @PostMapping("/sua")
    public String update(@RequestParam("id") Integer id, @ModelAttribute KhuyenMai khuyenMai) {
        KhuyenMai existingKhuyenMai = khuyenMaiRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid khuyen mai id: " + id));

        // except id
        existingKhuyenMai.setMaKhuyenMai(khuyenMai.getMaKhuyenMai());
        existingKhuyenMai.setTenKhuyenMai(khuyenMai.getTenKhuyenMai());
        existingKhuyenMai.setGiaTriKhuyenMai(khuyenMai.getGiaTriKhuyenMai());
        existingKhuyenMai.setNgayBatDau(khuyenMai.getNgayBatDau());
        existingKhuyenMai.setNgayKetThuc(khuyenMai.getNgayKetThuc());
        existingKhuyenMai.setTinhTrang(khuyenMai.getTinhTrang());

        khuyenMaiRepo.save(existingKhuyenMai);
        return "redirect:/khuyen-mai/hien-thi";
    }

    @GetMapping("/xoa")
    public String delete(@RequestParam("id") Integer id){
        khuyenMaiRepo.deleteById(id);
        return "redirect:/khuyen-mai/hien-thi";
    }

}

