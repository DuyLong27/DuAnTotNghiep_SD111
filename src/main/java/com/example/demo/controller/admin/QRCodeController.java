package com.example.demo.controller.admin;


import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.SanPhamChiTietRepo;
import com.example.demo.service.QRCodeService;
import com.example.demo.utils.QRCodeGenerator;
import com.google.zxing.WriterException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/qrcode")
public class QRCodeController {

    private final QRCodeService qrCodeService;

    @GetMapping("/index")
    public ResponseEntity<List<SanPhamChiTiet>> getSanPhamChiTiets() throws IOException, WriterException{
        List<SanPhamChiTiet> sanPhamChiTiets = qrCodeService.getSanPhamChiTiet();
        if (sanPhamChiTiets.size() != 0){
            for (SanPhamChiTiet sanPhamChiTiet : sanPhamChiTiets){
                QRCodeGenerator.generateQRCode(sanPhamChiTiet);
            }
        }
        return ResponseEntity.ok(qrCodeService.getSanPhamChiTiet());
    }

}
