package com.example.demo.controller.customers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/khach-hang")
public class ThongTinKhachHangController {
    @GetMapping("")
    public String hienThi(){
        return "customer/thong_tin/view";
    }
    @GetMapping("/thong-tin")
    public String thongTin(){
        return "customer/thong_tin/infor";
    }
    @GetMapping("/doi-mat-khau")
    public String doiMatKhau(){
        return "customer/thong_tin/change_password";
    }

    @GetMapping("/ma-giam-gia")
    public String maGiamGia(){
        return "customer/thong_tin/coupon";
    }

    @GetMapping("/diem-thuong")
    public String diemThuong(){
        return "customer/thong_tin/reward_point";
    }

    @GetMapping("/tat-ca-don-hang")
    public String tatCaDonHang(){
        return "customer/thong_tin/order_all";
    }
}
