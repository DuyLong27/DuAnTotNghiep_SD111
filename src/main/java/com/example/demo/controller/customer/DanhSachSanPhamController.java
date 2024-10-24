package com.example.demo.controller.customer;

import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/danh-sach-san-pham")
public class DanhSachSanPhamController {

    @Autowired
    SanPhamChiTietRepo sanPhamChiTietRepo;

    @Autowired
    ThuongHieuRepo thuongHieuRepo;

    @Autowired
    LoaiCaPheRepo loaiCaPheRepo;

    @Autowired
    LoaiHatRepo loaiHatRepo;

    @Autowired
    MucDoRangRepo mucDoRangRepo;

    @Autowired
    HuongViRepo huongViRepo;

    @Autowired
    private GioHangChiTietRepo gioHangChiTietRepo;

    @Autowired
    private GioHangRepo gioHangRepo;

    @GetMapping("/hien-thi")
    public String hienThi(Model model,
                          @RequestParam(required = false) Integer thuongHieuId,
                          @RequestParam(required = false) Integer loaiCaPheId,
                          @RequestParam(required = false) Integer huongViId,
                          @RequestParam(required = false) Integer loaiHatId,
                          @RequestParam(required = false) Integer mucDoRangId,
                          @RequestParam(required = false) Integer minPrice,
                          @RequestParam(required = false) Integer maxPrice,
                          @RequestParam(required = false, defaultValue = "none") String sort
    ) {
        List<SanPhamChiTiet> sanPhamList;

        if (thuongHieuId != null) {
            sanPhamList = sanPhamChiTietRepo.findByThuongHieuId(thuongHieuId);
        } else if (loaiCaPheId != null) {
            sanPhamList = sanPhamChiTietRepo.findByLoaiCaPheId(loaiCaPheId);
        } else if (huongViId != null) {
            sanPhamList = sanPhamChiTietRepo.findByHuongViId(huongViId);
        } else if (loaiHatId != null) {
            sanPhamList = sanPhamChiTietRepo.findByLoaiHatId(loaiHatId);
        } else if (mucDoRangId != null) {
            sanPhamList = sanPhamChiTietRepo.findByMucDoRangId(mucDoRangId);
        } else if (minPrice != null || maxPrice != null) {
            if (minPrice != null && maxPrice != null) {
                sanPhamList = sanPhamChiTietRepo.findByGiaBanBetween(minPrice, maxPrice);
            } else if (minPrice != null) {
                sanPhamList = sanPhamChiTietRepo.findByGiaBanBetween(minPrice, Integer.MAX_VALUE);
            } else {
                sanPhamList = sanPhamChiTietRepo.findByGiaBanBetween(Integer.MIN_VALUE, maxPrice);
            }
        } else {
            sanPhamList = sanPhamChiTietRepo.findAll();
        }

        if (sort.equals("asc")) {
            sanPhamList = sanPhamChiTietRepo.findAllByOrderByGiaBanAsc();
        } else if (sort.equals("desc")) {
            sanPhamList = sanPhamChiTietRepo.findAllByOrderByGiaBanDesc();
        }

        model.addAttribute("listSanPham", sanPhamList);
        model.addAttribute("listThuongHieu", thuongHieuRepo.findAll());
        model.addAttribute("listHuongVi", huongViRepo.findAll());
        model.addAttribute("listLoaiHat", loaiHatRepo.findAll());
        model.addAttribute("listMucDoRang", mucDoRangRepo.findAll());
        model.addAttribute("listLoaiCaPhe", loaiCaPheRepo.findAll());

        model.addAttribute("listGioHang",gioHangChiTietRepo.findAll());
        model.addAttribute("listGioHang2",gioHangRepo.findAll());

        return "customer/san_pham/index";
    }
}