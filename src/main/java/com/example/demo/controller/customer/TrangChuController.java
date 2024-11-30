package com.example.demo.controller.customer;

import com.example.demo.entity.KhuyenMai;
import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.HoaDonChiTietRepo;
import com.example.demo.repository.KhuyenMaiRepo;
import com.example.demo.repository.SanPhamChiTietRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("")
public class TrangChuController {
    @Autowired
    private HoaDonChiTietRepo hoaDonChiTietRepository;

    @Autowired
    private KhuyenMaiRepo khuyenMaiRepository;

    @Autowired
    private SanPhamChiTietRepo sanPhamChiTietRepository;


    @GetMapping("/trang-chu")
    public String homePage(Model model) {
        Pageable pageable = PageRequest.of(0, 4);
        List<Object[]> topSellingProducts = hoaDonChiTietRepository.findTopSellingProducts(pageable);

        List<SanPhamChiTiet> bestSellers = topSellingProducts.stream()
                .map(obj -> (SanPhamChiTiet) obj[0])
                .collect(Collectors.toList());

        List<SanPhamChiTiet> allProducts = sanPhamChiTietRepository.findAll();

        List<KhuyenMai> khuyenMais = khuyenMaiRepository.findAll();
        List<KhuyenMai> validKhuyenMais = khuyenMais.stream()
                .filter(khuyenMai -> khuyenMai.getKhuyenMaiChiTietList() != null && !khuyenMai.getKhuyenMaiChiTietList().isEmpty())
                .collect(Collectors.toList());

        model.addAttribute("bestSellers", bestSellers);
        model.addAttribute("validKhuyenMais", validKhuyenMais);
        model.addAttribute("allProducts", allProducts);

        return "customer/trang_chu/index";
    }


}
