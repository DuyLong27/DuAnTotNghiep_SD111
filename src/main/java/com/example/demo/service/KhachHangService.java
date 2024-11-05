package com.example.demo.service;

import com.example.demo.entity.KhachHang;
import com.example.demo.repository.KhachHangRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
public class KhachHangService {
    @Autowired
    private KhachHangRepo khachHangRepo;
    public KhachHang findByEmail(String email) {
        return khachHangRepo.findByEmail(email);
    }

    public void registerCustomer(KhachHang khachHang) {
        khachHang.setNgayDangKy(LocalDate.now());
        khachHangRepo.save(khachHang);
    }
}
