package com.example.demo.service;

import com.example.demo.entity.HoaDonChiTiet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender javaMailSender;

    public void sendOtpEmail(String toEmail, String otp) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject("Mã OTP xác thực");
        message.setText("Mã OTP của bạn là: " + otp);

        try {
            javaMailSender.send(message);
            System.out.println("Đã gửi OTP đến email: " + toEmail);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Lỗi khi gửi email: " + e.getMessage());
        }
    }

    public void sendHoaDonMuaNgayEmail(String toEmail, String soHoaDon, String phuongThucThanhToan,
                                String phuongThucVanChuyen, String diaChi, String soDienThoai,
                                int soLuong, String tenSanPham, int giaSanPham, int tongTien) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject("Thông tin hóa đơn của bạn - " + soHoaDon);

        StringBuilder content = new StringBuilder();
        content.append("Cảm ơn bạn đã mua sắm tại The Nature Coffee.\n\n")
                .append("Chi tiết hóa đơn của bạn:\n")
                .append("Mã hóa đơn: ").append(soHoaDon).append("\n")
                .append("Sản phẩm: ").append(tenSanPham).append("\n")
                .append("Số lượng: ").append(soLuong).append("\n")
                .append("Giá sản phẩm: ").append(giaSanPham).append(" VNĐ\n")
                .append("Phương thức vận chuyển: ").append(phuongThucVanChuyen).append("\n")
                .append("Tổng tiền: ").append(tongTien).append(" VNĐ\n\n")
                .append("Thông tin giao hàng:\n")
                .append("Địa chỉ: ").append(diaChi).append("\n")
                .append("Số điện thoại: ").append(soDienThoai).append("\n\n")
                .append("Hãy truy cập mục Tra Cứu Đơn Hàng tại website của The Nature Coffee để theo dõi đơn hàng một cách tốt nhất\n")
                .append("Chúng tôi rất mong được phục vụ bạn lần sau!");

        message.setText(content.toString());

        try {
            javaMailSender.send(message);
            System.out.println("Đã gửi thông tin hóa đơn đến email: " + toEmail);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Lỗi khi gửi email: " + e.getMessage());
        }
    }

    public void sendHoaDonMuaNhieuSanPhamEmail(String toEmail, String soHoaDon, String phuongThucThanhToan,
                                               String phuongThucVanChuyen, String diaChi, String soDienThoai,
                                               List<HoaDonChiTiet> hoaDonChiTietList, int tongTien) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject("Thông tin hóa đơn của bạn - " + soHoaDon);

        StringBuilder content = new StringBuilder();
        content.append("Cảm ơn bạn đã mua sắm tại The Nature Coffee.\n\n")
                .append("Chi tiết hóa đơn của bạn:\n")
                .append("Mã hóa đơn: ").append(soHoaDon).append("\n");

        // Lặp qua danh sách HoaDonChiTiet để hiển thị từng sản phẩm
        for (HoaDonChiTiet hoaDonChiTiet : hoaDonChiTietList) {
            // Truy cập tên sản phẩm từ đối tượng SanPham trong SanPhamChiTiet
            String tenSanPham = hoaDonChiTiet.getSanPhamChiTiet().getSanPham().getTen();

            content.append("Sản phẩm: ").append(tenSanPham).append("\n")
                    .append("Số lượng: ").append(hoaDonChiTiet.getSo_luong()).append("\n")
                    .append("Giá sản phẩm: ").append(hoaDonChiTiet.getGia_san_pham()).append(" VNĐ\n")
                    .append("Tổng tiền cho sản phẩm: ").append(hoaDonChiTiet.getSo_luong() * hoaDonChiTiet.getGia_san_pham()).append(" VNĐ\n\n");
        }

        content.append("Phương thức thanh toán: ").append(phuongThucThanhToan).append("\n")
                .append("Phương thức vận chuyển: ").append(phuongThucVanChuyen).append("\n")
                .append("Tổng tiền: ").append(tongTien).append(" VNĐ\n\n")
                .append("Thông tin giao hàng:\n")
                .append("Địa chỉ: ").append(diaChi).append("\n")
                .append("Số điện thoại: ").append(soDienThoai).append("\n\n")
                .append("Hãy truy cập mục Tra Cứu Đơn Hàng tại website của The Nature Coffee để theo dõi đơn hàng một cách tốt nhất.\n")
                .append("Chúng tôi rất mong được phục vụ bạn lần sau!");

        message.setText(content.toString());

        try {
            javaMailSender.send(message);
            System.out.println("Đã gửi thông tin hóa đơn đến email: " + toEmail);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Lỗi khi gửi email: " + e.getMessage());
        }
    }


}
