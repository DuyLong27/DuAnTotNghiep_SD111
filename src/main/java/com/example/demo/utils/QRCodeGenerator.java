package com.example.demo.utils;

import com.example.demo.entity.SanPhamChiTiet;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.util.Map;

public class QRCodeGenerator {

    public static void generateQRCode(SanPhamChiTiet sanPhamChiTiet) throws IOException, WriterException {
        String qrCodePath = "C:\\Users\\longl\\Documents\\DuAnTotNghiep_SD111\\src\\main\\webapp\\qrcode\\";
        String qrCodeName = qrCodePath + sanPhamChiTiet.getMa() + sanPhamChiTiet.getId() + "-QRCODE.png";
        QRCodeWriter qrCodeWriter = new QRCodeWriter();

        // Tạo nội dung QR dưới dạng JSON
        String content = "{ \"sanPhamId\": \"" + sanPhamChiTiet.getId() + "\", " +
                "\"sanPhamTen\": \"" + sanPhamChiTiet.getSanPham().getTen() + "\", " +
                "\"giaBan\": \"" + sanPhamChiTiet.getGiaBan() + "\", " +
                "\"soLuong\": \"" + sanPhamChiTiet.getSoLuong() + "\" }";

        BitMatrix bitMatrix = qrCodeWriter.encode(content, BarcodeFormat.QR_CODE, 400, 400, Map.of(EncodeHintType.CHARACTER_SET, "UTF-8"));

        Path path = FileSystems.getDefault().getPath(qrCodeName);
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);
    }
}
