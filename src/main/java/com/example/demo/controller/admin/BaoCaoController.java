package com.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/bao-cao")
public class BaoCaoController {

    @GetMapping("/hien-thi")
    public String hienThiDanhSach(Model model) {

        return "admin/bao_cao/BaoCaoDoanhThu";
    }
}
