package com.example.demo.controller.admin;

import com.example.demo.repository.KhachHangRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/khach-hang")
public class QLKhachHangController {

    @Autowired
    private KhachHangRepo repo;

    @GetMapping("/hien-thi")
    public String hienThiDanhSach(Model model){
        model.addAttribute("lists", repo.findAll());
        return "admin/ql_khach_hang/QuanLyKhachHang";
    }
}