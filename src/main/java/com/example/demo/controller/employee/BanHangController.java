package com.example.demo.controller.employee;

import com.example.demo.entity.SanPham;
import com.example.demo.repository.BanHangRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/ban-hang")
public class BanHangController {
    @Autowired
    BanHangRepo banHangRepo;

    @GetMapping("/hien-thi")
    public String hienThi(Model model) {
        List<SanPham> productList = banHangRepo.findAll();
        model.addAttribute("productList", productList);
        return "employee/ban_hang/index"; // Your JSP file path
    }
}
