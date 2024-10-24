package com.example.demo.controller.admin;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.HoaDonChiTiet;
import com.example.demo.repository.HoaDonChiTietRepo;
import com.example.demo.repository.HoaDonRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/hoa-don")
public class QLHoaDonController {

    @Autowired
    HoaDonRepo hoaDonRepo;

    @Autowired
    private HoaDonChiTietRepo hoaDonChiTietRepository;
    @GetMapping("/hien-thi")
    public String hienThi(Model model,
                          @RequestParam(required = false) Integer tinhTrang
    ){
        List<HoaDon> hoaDonList;
        if (tinhTrang != null){
            hoaDonList = hoaDonRepo.findByTinhTrang(tinhTrang);
        }else {
            hoaDonList = hoaDonRepo.findAll();
        }
        model.addAttribute("listHoaDon", hoaDonList);
        model.addAttribute("list",hoaDonRepo.findAll());
        return "/admin/ql_hoa_don/index";
    }

    @GetMapping("/detail/{id}")
    public String chiTiet(@PathVariable("id") Integer id, Model model) {
        List<HoaDonChiTiet> hoaDonChiTiets = hoaDonChiTietRepository.findByHoaDonId(id);
        model.addAttribute("hoaDon",hoaDonRepo.findById(id).get());
        model.addAttribute("hoaDonChiTiets", hoaDonChiTiets);
        return "/admin/ql_hoa_don/detail";
    }
}
