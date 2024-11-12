package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

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
}
