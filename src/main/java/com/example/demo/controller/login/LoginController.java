package com.example.demo.controller.login;

import com.example.demo.entity.KhachHang;
import com.example.demo.entity.NhanVien;
import com.example.demo.repository.NhanVienRepo;
import com.example.demo.service.KhachHangService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("auth")
public class LoginController {
    @Autowired
    private NhanVienRepo nhanVienRepo;

    @Autowired
    private KhachHangService khachHangService;

    @GetMapping("login")
    public String login() {
        return "view/login";
    }

    @PostMapping("login")
    public String doLogin(String email, String matKhau, HttpSession session, HttpServletResponse response, Model model) {
        KhachHang khachHang = khachHangService.findByEmail(email);
        if (khachHang != null && matKhau.equals(khachHang.getMatKhau())) {
            session.setAttribute("khachHang", khachHang);
            session.setAttribute("role", khachHang.getRole());
            Cookie cookie = new Cookie("userSession", khachHang.getIdKhachHang().toString());
            cookie.setMaxAge(7 * 24 * 60 * 60);
            cookie.setPath("/");
            response.addCookie(cookie);
            if (khachHang.getRole() == 2) {
                return "redirect:/trang-chu";
            }
        }
        NhanVien nhanVien = nhanVienRepo.findByEmail(email);
        if (nhanVien != null && matKhau.equals(nhanVien.getMatKhau())) {
            session.setAttribute("khachHang", nhanVien);
            session.setAttribute("role", nhanVien.getRole());
            Cookie cookie = new Cookie("userSession", nhanVien.getId().toString());
            cookie.setMaxAge(7 * 24 * 60 * 60);
            cookie.setPath("/");
            response.addCookie(cookie);
            if (nhanVien.getRole() == 1 || nhanVien.getRole() == 0) {
                return "redirect:/doanh-thu/hien-thi";
            }
        }
        model.addAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
        return "view/login";
    }


    @GetMapping("logout")
    public String logout(HttpSession session, HttpServletResponse response) {
        session.invalidate();
        Cookie cookie = new Cookie("userSession", null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
        return "redirect:/auth/login";
    }

    @GetMapping("register")
    public String registerForm() {
        return "view/register";
    }

    @PostMapping("register")
    public String doRegister(String tenKhachHang, String email, String matKhau, String soDienThoai, String diaChi, Model model) {
        if (khachHangService.findByEmail(email) != null) {
            model.addAttribute("error", "Email đã tồn tại");
            return "view/register";
        }
        KhachHang khachHang = new KhachHang();
        khachHang.setTenKhachHang(tenKhachHang);
        khachHang.setEmail(email);
        khachHang.setMatKhau(matKhau);
        khachHang.setSoDienThoai(soDienThoai);
        khachHang.setDiaChi(diaChi);
        khachHang.setDiemTichLuy(0);
        khachHang.setRole(2);
        khachHangService.registerCustomer(khachHang);
        return "redirect:/auth/login";
    }
}
