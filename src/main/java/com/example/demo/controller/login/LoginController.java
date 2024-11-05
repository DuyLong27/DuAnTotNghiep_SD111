package com.example.demo.controller.login;

import com.example.demo.entity.KhachHang;
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
            Cookie cookie = new Cookie("userSession", khachHang.getIdKhachHang().toString());
            cookie.setMaxAge(7 * 24 * 60 * 60);
            cookie.setPath("/");
            response.addCookie(cookie);

            return "redirect:/danh-sach-san-pham/hien-thi";
        } else {
            model.addAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            return "view/login";
        }
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
        // Kiểm tra email đã tồn tại chưa
        if (khachHangService.findByEmail(email) != null) {
            model.addAttribute("error", "Email đã tồn tại");
            return "view/register";
        }

        // Tạo đối tượng KhachHang mới
        KhachHang khachHang = new KhachHang();
        khachHang.setTenKhachHang(tenKhachHang);
        khachHang.setEmail(email);
        khachHang.setMatKhau(matKhau);
        khachHang.setSoDienThoai(soDienThoai);
        khachHang.setDiaChi(diaChi);

        khachHangService.registerCustomer(khachHang);
        return "redirect:/auth/login";
    }
}

