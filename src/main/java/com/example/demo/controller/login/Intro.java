package com.example.demo.controller.login;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("Gioi-Thieu")
public class Intro {
    @GetMapping("main")
    public String gioithieu() {
        return "view/GioiThieu";
    }
}
