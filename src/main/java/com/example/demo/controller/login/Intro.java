package com.example.demo.controller.login;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("")
public class Intro {
    @GetMapping("/gioi-thieu")
    public String gioithieu() {
        return "customer/gioi_thieu/GioiThieu";
    }

    @GetMapping("/lien-he")
    public String lienHe(){
        return "customer/lien_he/index";
    }
}
