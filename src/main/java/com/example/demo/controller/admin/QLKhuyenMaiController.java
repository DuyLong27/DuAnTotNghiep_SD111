package com.example.demo.controller.admin;

import com.example.demo.entity.KhuyenMai;
import com.example.demo.entity.KhuyenMaiChiTiet;
import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.KhuyenMaiChiTietRepo;
import com.example.demo.repository.KhuyenMaiRepo;
import com.example.demo.repository.SanPhamChiTietRepo;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/quan-ly-khuyen-mai")
public class QLKhuyenMaiController {
    @Autowired
    KhuyenMaiChiTietRepo khuyenMaiChiTietRepo;
    @Autowired
    SanPhamChiTietRepo sanPhamChiTietRepo;
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

        if (maKhuyenMai != null) {
            maKhuyenMai = maKhuyenMai.trim().toLowerCase();
        }

        if (tenKhuyenMai != null) {
            tenKhuyenMai = tenKhuyenMai.toLowerCase();
        }

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
    public String add(KhuyenMai khuyenMai, RedirectAttributes redirectAttributes){
        khuyenMaiRepo.save(khuyenMai);
        redirectAttributes.addFlashAttribute("message", "Thêm thành công!");
        return "redirect:/quan-ly-khuyen-mai/hien-thi";
    }




    @PostMapping("/sua")
    public String update(@RequestParam("id") Integer id, @ModelAttribute KhuyenMai khuyenMai,
                         RedirectAttributes redirectAttributes) {
        KhuyenMai existingKhuyenMai = khuyenMaiRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid khuyen mai id: " + id));
        existingKhuyenMai.setMaKhuyenMai(khuyenMai.getMaKhuyenMai());
        existingKhuyenMai.setTenKhuyenMai(khuyenMai.getTenKhuyenMai());
        existingKhuyenMai.setGiaTriKhuyenMai(khuyenMai.getGiaTriKhuyenMai());
        existingKhuyenMai.setNgayBatDau(khuyenMai.getNgayBatDau());
        existingKhuyenMai.setNgayKetThuc(khuyenMai.getNgayKetThuc());
        existingKhuyenMai.setTinhTrang(khuyenMai.getTinhTrang());
        khuyenMaiRepo.save(existingKhuyenMai);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công!");
        return "redirect:/quan-ly-khuyen-mai/hien-thi";
    }

    @GetMapping("/chi-tiet")
    public String chiTietKhuyenMai(
            @RequestParam(required = false) String tenKhuyenMai,
            @RequestParam(required = false) Integer giaTriFrom,
            @RequestParam(required = false) Integer giaTriTo,
            Model model) {
        List<KhuyenMai> listKhuyenMai = khuyenMaiRepo.findAll().stream()
                .filter(km -> km.getTinhTrang() == 1)
                .collect(Collectors.toList());

        if (tenKhuyenMai != null && !tenKhuyenMai.isEmpty()) {
            listKhuyenMai = listKhuyenMai.stream()
                    .filter(km -> km.getTenKhuyenMai().toLowerCase().contains(tenKhuyenMai.toLowerCase()))
                    .collect(Collectors.toList());
        }
        if (giaTriFrom != null) {
            listKhuyenMai = listKhuyenMai.stream()
                    .filter(km -> km.getGiaTriKhuyenMai() >= giaTriFrom)
                    .collect(Collectors.toList());
        }
        if (giaTriTo != null) {
            listKhuyenMai = listKhuyenMai.stream()
                    .filter(km -> km.getGiaTriKhuyenMai() <= giaTriTo)
                    .collect(Collectors.toList());
        }
        List<SanPhamChiTiet> listSanPhamChiTiet = sanPhamChiTietRepo.findAll().stream()
                .filter(sp -> sp.getTinhTrang() == 1)
                .collect(Collectors.toList());
        List<KhuyenMaiChiTiet> listKhuyenMaiChiTiet = khuyenMaiChiTietRepo.findAll();

        Map<Integer, Long> khuyenMaiCounts = listKhuyenMai.stream()
                .collect(Collectors.toMap(
                        km -> km.getIdKhuyenMai(),
                        km -> listKhuyenMaiChiTiet.stream()
                                .filter(kmct -> kmct.getKhuyenMai().getIdKhuyenMai().equals(km.getIdKhuyenMai()))
                                .count(),
                        (existing, replacement) -> existing));

        model.addAttribute("listKhuyenMai", listKhuyenMai);
        model.addAttribute("listSanPhamChiTiet", listSanPhamChiTiet);
        model.addAttribute("listKhuyenMaiChiTiet", listKhuyenMaiChiTiet);
        model.addAttribute("khuyenMaiCounts", khuyenMaiCounts);
        model.addAttribute("tenKhuyenMai", tenKhuyenMai);
        model.addAttribute("giaTriFrom", giaTriFrom);
        model.addAttribute("giaTriTo", giaTriTo);

        return "admin/ql_khuyen_mai/detail";
    }






    @PostMapping("/apply")
    public String applyKhuyenMai(@RequestParam("khuyenMaiId") Integer khuyenMaiId,
                                 @RequestParam List<Integer> sanPhamChiTietIds,
                                 RedirectAttributes redirectAttributes) {
        KhuyenMai khuyenMai = khuyenMaiRepo.findById(khuyenMaiId)
                .orElseThrow(() -> new IllegalArgumentException("Khuyến mãi không hợp lệ"));
        for (Integer sanPhamId : sanPhamChiTietIds) {
            SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamId)
                    .orElseThrow(() -> new IllegalArgumentException("Sản phẩm không hợp lệ"));
            if (!khuyenMaiChiTietRepo.existsByKhuyenMaiAndSanPhamChiTiet(khuyenMai, sanPhamChiTiet)) {
                int giaTriKhuyenMai = khuyenMai.getGiaTriKhuyenMai();
                int giaBan = sanPhamChiTiet.getGiaBan();

                if (giaBan <= 0) {
                    throw new IllegalArgumentException("Giá bán không hợp lệ cho sản phẩm có ID: " + sanPhamId);
                }
                double giaGiamGia = giaBan * (giaTriKhuyenMai / 100.0);
                int giaGiamGiaInt = (int) Math.round(giaGiamGia);
                int giaSauKhuyenMai = giaBan - giaGiamGiaInt;
                sanPhamChiTiet.setGiaGiamGia(giaGiamGiaInt);
                sanPhamChiTiet.setGiaGiamGia(giaSauKhuyenMai);
                sanPhamChiTietRepo.save(sanPhamChiTiet);
                KhuyenMaiChiTiet khuyenMaiChiTiet = new KhuyenMaiChiTiet();
                khuyenMaiChiTiet.setKhuyenMai(khuyenMai);
                khuyenMaiChiTiet.setSanPhamChiTiet(sanPhamChiTiet);
                khuyenMaiChiTietRepo.save(khuyenMaiChiTiet);
            }
        }
        redirectAttributes.addFlashAttribute("message", "Áp dụng thành công!");
        return "redirect:/quan-ly-khuyen-mai/chi-tiet";
    }


    @PostMapping("/xoa-san-pham")
    public String deleteSanPhamFromKhuyenMai(@RequestParam("khuyenMaiChiTietId") Integer khuyenMaiChiTietId) {
        KhuyenMaiChiTiet khuyenMaiChiTiet = khuyenMaiChiTietRepo.findById(khuyenMaiChiTietId)
                .orElseThrow(() -> new IllegalArgumentException("Sản phẩm không hợp lệ"));
        SanPhamChiTiet sanPhamChiTiet = khuyenMaiChiTiet.getSanPhamChiTiet();
        sanPhamChiTiet.setGiaGiamGia(0);
        sanPhamChiTietRepo.save(sanPhamChiTiet);
        khuyenMaiChiTietRepo.delete(khuyenMaiChiTiet);
        return "redirect:/quan-ly-khuyen-mai/chi-tiet";
    }



}