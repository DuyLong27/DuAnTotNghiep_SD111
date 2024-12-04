package com.example.demo.service;

import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.SanPhamChiTietRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SanPhamChiTietService {
    @Autowired
    private SanPhamChiTietRepo sanPhamChiTietRepository;

    public List<SanPhamChiTiet> getProductsByIds(List<Integer> productIds) {
        return sanPhamChiTietRepository.findAllById(productIds);
    }
}
