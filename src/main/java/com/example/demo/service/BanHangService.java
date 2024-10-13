package com.example.demo.service;

import com.example.demo.entity.SanPham;
import com.example.demo.repository.SanPhamRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BanHangService {
    @Autowired
    private SanPhamRepo sanPhamRepo;

    public List<SanPham> getAllSanPham(){
        return sanPhamRepo.findAll();
    }
    public SanPham getSanPhamById(Integer id){
        return sanPhamRepo.findById(id).orElse(null);
    }
}
