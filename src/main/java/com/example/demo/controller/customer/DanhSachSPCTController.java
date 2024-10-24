package com.example.demo.controller.customer;

import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/danh-sach-san-pham-chi-tiet")
public class DanhSachSPCTController {
    @Autowired
    SanPhamChiTietRepo sanPhamChiTietRepo;

    @Autowired
    CanNangRepo canNangRepo;

    @Autowired
    ThuongHieuRepo thuongHieuRepo;

    @Autowired
    LoaiHatRepo loaiHatRepo;

    @Autowired
    LoaiCaPheRepo loaiCaPheRepo;

    @Autowired
    LoaiTuiRepo loaiTuiRepo;

    @Autowired
    HuongViRepo huongViRepo;

    @Autowired
    MucDoRangRepo mucDoRangRepo;

    @GetMapping("/hien-thi")
    public String hienThi(Model model) {
        model.addAttribute("sanPhamList", sanPhamChiTietRepo.findAll());
        model.addAttribute("loaiCaPheList", loaiCaPheRepo.findAll());
        model.addAttribute("canNangList", canNangRepo.findAll());
        model.addAttribute("loaiHatList", loaiHatRepo.findAll());
        model.addAttribute("loaiTuiList", loaiTuiRepo.findAll());
        model.addAttribute("mucDoRangList", mucDoRangRepo.findAll());
        model.addAttribute("huongViList", huongViRepo.findAll());
        model.addAttribute("thuongHieuList", thuongHieuRepo.findAll());

        return "customer/san_pham_chi_tiet/index";
    }

    @GetMapping("/view-sp/{id}")
    public String viewUpdateGioHang(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("sanPhamChiTiet", sanPhamChiTietRepo.findById(id).get());
        model.addAttribute("loaiCaPheList", loaiCaPheRepo.findAll());
        model.addAttribute("canNangList", canNangRepo.findAll());
        model.addAttribute("loaiHatList", loaiHatRepo.findAll());
        model.addAttribute("loaiTuiList", loaiTuiRepo.findAll());
        model.addAttribute("mucDoRangList", mucDoRangRepo.findAll());
        model.addAttribute("huongViList", huongViRepo.findAll());
        model.addAttribute("thuongHieuList", thuongHieuRepo.findAll());
        return "customer/san_pham_chi_tiet/index";
    }
}
