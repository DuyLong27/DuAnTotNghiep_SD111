package com.example.demo.controller.employee;

import com.example.demo.entity.SanPham;
import com.example.demo.repository.BanHangRepo;
import com.example.demo.service.BanHangService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/ban-hang")
public class BanHangController {
    @Autowired
    private BanHangService banHangService;

    private List<SanPham> invoice = new ArrayList<>();
    @GetMapping("/hien-thi")
    public String hienThi(Model model) {
        List<SanPham> productList = banHangService.getAllSanPham();
        model.addAttribute("productList", productList);
        model.addAttribute("invoice", invoice);
        model.addAttribute("total", calculateTotal());
        return "/employee/ban_hang/index";
    }
    @PostMapping("/add-to-invoice")
    public String addToCart(@RequestParam("productId") Integer productId) {
        SanPham product = banHangService.getSanPhamById(productId);
        if (product != null) {
            invoice.add(product);
        }
        return "redirect:/ban-hang/hien-thi";
    }

    private int calculateTotal() {
        return invoice.stream().mapToInt(SanPham::getGiaBan).sum();
    }

}
