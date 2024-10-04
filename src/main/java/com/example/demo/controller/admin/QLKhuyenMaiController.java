package com.example.demo.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/khuyen-mai")
public class QLKhuyenMaiController {

    @GetMapping("/hien-thi")
    public String hienThi(Model model){
//        model.addAttribute("listKhuyenMai",khuyenMaiRepository.findAll());
        return "admin/ql_khuyen_mai/khuyen-mai";
    }

    @GetMapping("/chi-tiet")
    public String trangDetail(@RequestParam("id")Integer id, Model model){
//        model.addAttribute("khuyenMaiDetail",khuyenMaiRepository.findById(id).get());
        return "admin/ql_khuyen_mai/chi-tiet";
    }

    @GetMapping ("/sua/{id}")
    public String trangSua(@PathVariable("id") Integer id, Model model){
//        model.addAttribute("khuyenMaiDetail",khuyenMaiRepository.findById(id).get());
        return "admin/ql_khuyen_mai/sua";
    }

    @GetMapping("/them")
    public String trangAdd(){
        return "admin/ql_khuyen_mai/them";
    }
}
