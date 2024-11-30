package com.example.demo.controller.customer;


import com.example.demo.entity.KhuyenMai;
import com.example.demo.repository.KhuyenMaiRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class KhuyenMaiController {

    @Autowired
    private KhuyenMaiRepo khuyenMaiRepository;

    @GetMapping("/khuyen-mai")
    public String getKhuyenMaiPage(Model model) {
        List<KhuyenMai> khuyenMais = khuyenMaiRepository.findAll();
        model.addAttribute("khuyenMais", khuyenMais);
        return "customer/khuyen_mai/index";
    }
}

