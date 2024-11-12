package com.example.demo.controller.customer;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.KhachHang;
import com.example.demo.repository.HoaDonRepo;
import com.example.demo.repository.KhachHangRepo;
import com.example.demo.service.EmailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Controller
@RequestMapping("/khach-hang")
public class ThongTinKhachHangController {
    @Autowired
    private EmailService emailService;

    @Autowired
    KhachHangRepo khachHangRepo;

    @Autowired
    private HoaDonRepo hoaDonRepo;

    @GetMapping("")
    public String hienThi(HttpSession session, Model model) {
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        if (khachHang != null) {
            List<HoaDon> hoaDonList = hoaDonRepo.findByKhachHangId(khachHang.getIdKhachHang());
            int tongHoaDon = hoaDonList.size();
            int choXacNhan = 0;
            int choGiaoHang = 0;
            int dangGiao = 0;
            int xacNhanThanhToan = 0;
            int hoanThanh = 0;
            for (HoaDon hoaDon : hoaDonList) {
                switch (hoaDon.getTinh_trang()) {
                    case 0 -> choXacNhan++;
                    case 1 -> choGiaoHang++;
                    case 2 -> dangGiao++;
                    case 3 -> xacNhanThanhToan++;
                    case 4 -> hoanThanh++;
                }
            }
            Map<String, Integer> stats = new HashMap<>();
            stats.put("tongHoaDon", tongHoaDon);
            stats.put("choXacNhan", choXacNhan);
            stats.put("choGiaoHang", choGiaoHang);
            stats.put("dangGiao", dangGiao);
            stats.put("xacNhanThanhToan", xacNhanThanhToan);
            stats.put("hoanThanh", hoanThanh);
            model.addAttribute("orderStats", stats);
            model.addAttribute("khachHang", khachHang);
            return "customer/thong_tin/view";
        } else {
            return "redirect:/auth/login";
        }
    }

    @GetMapping("/thong-tin")
    public String thongTin(HttpSession session, Model model) {
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        if (khachHang != null) {
            model.addAttribute("khachHang", khachHang);
            return "customer/thong_tin/infor";
        } else {
            return "redirect:/auth/login";
        }
    }

    @PostMapping("/cap-nhat-thong-tin")
    public String capNhatThongTin(HttpSession session,
                                  @RequestParam("tenKhachHang") String tenKhachHang,
                                  @RequestParam("email") String email,
                                  @RequestParam("soDienThoai") String soDienThoai,
                                  @RequestParam("diaChi") String diaChi,
                                  Model model) {
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        if (khachHang != null) {
            khachHang.setTenKhachHang(tenKhachHang);
            khachHang.setEmail(email);
            khachHang.setSoDienThoai(soDienThoai);
            khachHang.setDiaChi(diaChi);
            khachHangRepo.save(khachHang);
            session.setAttribute("khachHang", khachHang);
            model.addAttribute("khachHang", khachHang);
            model.addAttribute("message", "Cập nhật thông tin thành công!");
            return "customer/thong_tin/infor";
        } else {
            return "redirect:/auth/login";
        }
    }

    @PostMapping("/doi-mat-khau")
    public String doiMatKhau(HttpSession session,
                             @RequestParam("currentPassword") String currentPassword,
                             @RequestParam("newPassword") String newPassword,
                             @RequestParam("confirmPassword") String confirmPassword,
                             Model model) {
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        if (khachHang != null) {
            // Kiểm tra mật khẩu hiện tại
            if (!khachHang.getMatKhau().equals(currentPassword)) {
                model.addAttribute("errorMessage", "Mật khẩu hiện tại không chính xác!");
                return "customer/thong_tin/change_password";
            }

            // Kiểm tra mật khẩu mới và xác nhận mật khẩu
            if (!newPassword.equals(confirmPassword)) {
                model.addAttribute("errorMessage", "Mật khẩu mới và xác nhận mật khẩu không trùng khớp!");
                return "customer/thong_tin/change_password";
            }

            // Cập nhật mật khẩu
            khachHang.setMatKhau(newPassword);
            khachHangRepo.save(khachHang);

            model.addAttribute("successMessage", "Đổi mật khẩu thành công!");
            return "customer/thong_tin/change_password";
        } else {
            return "redirect:/auth/login";
        }
    }

    @GetMapping("/doi-mat-khau")
    public String doiMatKhauForm() {
        return "customer/thong_tin/change_password";
    }

    @PostMapping("/gui-ma-xac-minh")
    @ResponseBody
    public Map<String, Object> guiMaXacMinh(@RequestParam String email, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        KhachHang khachHang = khachHangRepo.findByEmail(email);

        if (khachHang == null) {
            response.put("success", false);
            response.put("message", "Email không tồn tại trong hệ thống!");
            return response;
        }

        String otp = generateOTP();
        session.setAttribute("otp", otp);
        session.setAttribute("email", email);

        // Gửi OTP qua email
        emailService.sendOtpEmail(email, otp);

        response.put("success", true);
        response.put("message", "Mã OTP đã được gửi! Hãy kiểm tra email của bạn.");
        return response;
    }


    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    @PostMapping("/xac-nhan-otp")
    @ResponseBody
    public Map<String, Object> xacNhanOTP(@RequestParam String otp, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        String sessionOtp = (String) session.getAttribute("otp");

        if (sessionOtp == null || !sessionOtp.equals(otp)) {
            response.put("success", false);
            response.put("message", "Mã OTP không chính xác!");
            return response;
        }

        // OTP chính xác, thực hiện các thao tác tiếp theo
        response.put("success", true);
        response.put("message", "Xác nhận OTP thành công!");
        return response;
    }

    @PostMapping("/cap-nhat-mat-khau")
    @ResponseBody
    public Map<String, Object> capNhatMatKhau(@RequestParam String newPassword, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        // Lấy thông tin email từ session
        String email = (String) session.getAttribute("email");
        if (email == null) {
            response.put("success", false);
            response.put("message", "Không tìm thấy thông tin người dùng trong session!");
            return response;
        }

        // Lấy khách hàng từ database
        KhachHang khachHang = khachHangRepo.findByEmail(email);
        if (khachHang == null) {
            response.put("success", false);
            response.put("message", "Không tìm thấy tài khoản!");
            return response;
        }

        // Cập nhật mật khẩu mới
        khachHang.setMatKhau(newPassword); // Giả sử bạn đã mã hóa mật khẩu trước khi lưu
        khachHangRepo.save(khachHang); // Lưu thay đổi vào cơ sở dữ liệu

        response.put("success", true);
        response.put("message", "Mật khẩu đã được cập nhật thành công!");
        return response;
    }
}
