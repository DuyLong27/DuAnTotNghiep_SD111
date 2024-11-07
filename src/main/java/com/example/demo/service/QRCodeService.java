package com.example.demo.service;

import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.SanPhamChiTietRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QRCodeService {
    @Autowired
    private SanPhamChiTietRepo sanPhamChiTietRepo;

    public List<SanPhamChiTiet> getSanPhamChiTiet(){
        return sanPhamChiTietRepo.findAll();
    }
}
