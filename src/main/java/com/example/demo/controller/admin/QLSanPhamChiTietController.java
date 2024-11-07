package com.example.demo.controller.admin;

import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.*;
import com.example.demo.utils.QRCodeGenerator;
import com.google.zxing.WriterException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.data.domain.Pageable;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.util.Calendar;
import java.util.List;

@Controller
@RequestMapping("spct")
public class QLSanPhamChiTietController {
    @Autowired
    SanPhamChiTietRepo sanPhamChiTietRepo;

    @Autowired
    SanPhamRepo sanPhamRepo;
    @Autowired
    CanNangRepo canNangRepo;

    @Autowired
    ThuongHieuRepo thuongHieuRepo;

    @Autowired
    LoaiHatRepo loaiHatRepo;

    @Autowired
    LoaiCaPheRepo loaiCaPheRepo;

    @Autowired
    LoaiTuiRepo loaiTuiRepo;

    @Autowired
    HuongViRepo huongViRepo;

    @Autowired
    MucDoRangRepo mucDoRangRepo;

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "0") int pageNo,
                        @RequestParam(name = "size", defaultValue = "5") int pageSize,
                        @RequestParam(name = "tinhTrang", required = false) String tinhTrang,
                        Model model) throws IOException, WriterException {
        Pageable pageable = PageRequest.of(pageNo, pageSize);

        Page<SanPhamChiTiet> sanPhamChiTietPage;
        if (tinhTrang != null && !tinhTrang.isEmpty()) {
            Integer status = Integer.parseInt(tinhTrang);
            sanPhamChiTietPage = sanPhamChiTietRepo.findByTinhTrang(status, pageable);
        } else {
            sanPhamChiTietPage = sanPhamChiTietRepo.findAll(pageable);
        }


        model.addAttribute("sanPhamChiTietList", sanPhamChiTietPage.getContent());
        model.addAttribute("currentPage", sanPhamChiTietPage.getNumber());
        model.addAttribute("totalPages", sanPhamChiTietPage.getTotalPages());
        model.addAttribute("data", sanPhamChiTietPage);

        model.addAttribute("sanPhamList", sanPhamRepo.findAll());
        model.addAttribute("loaiCaPheList", loaiCaPheRepo.findAll());
        model.addAttribute("canNangList", canNangRepo.findAll());
        model.addAttribute("loaiHatList", loaiHatRepo.findAll());
        model.addAttribute("loaiTuiList", loaiTuiRepo.findAll());
        model.addAttribute("mucDoRangList", mucDoRangRepo.findAll());
        model.addAttribute("huongViList", huongViRepo.findAll());
        model.addAttribute("thuongHieuList", thuongHieuRepo.findAll());

        return "admin/ql_san_pham_chi_tiet/index";
    }




    @PostMapping("/add")
    public String addSanPhamChiTiet(@ModelAttribute SanPhamChiTiet sanPhamChiTiet,
                                    @RequestParam("imageFile") MultipartFile imageFile,
                                    RedirectAttributes redirectAttributes) {
        // Tính toán ngày hết hạn là 3 tháng sau
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, 3);
        sanPhamChiTiet.setNgayHetHan(calendar.getTime());

        // Xử lý upload file ảnh
        if (!imageFile.isEmpty()) {
            try {
                // Lấy đường dẫn tương đối đến thư mục images
                String relativeFolder = "src/main/webapp/uploads/";

                // Sử dụng Paths.get() để lấy đường dẫn tuyệt đối của thư mục images
                Path folderPath = Paths.get(relativeFolder).toAbsolutePath();

                // Kiểm tra và tạo thư mục nếu chưa tồn tại
                if (!Files.exists(folderPath)) {
                    Files.createDirectories(folderPath);
                }

                // Thêm thời gian hiện tại để tránh trùng tên file
                String originalFilename = imageFile.getOriginalFilename();
                String fileName = System.currentTimeMillis() + "_" + originalFilename;

                // Đường dẫn đầy đủ của file ảnh
                Path filePath = folderPath.resolve(fileName);

                // Ghi file ảnh lên đường dẫn
                Files.write(filePath, imageFile.getBytes());

                // Lưu tên file vào database
                sanPhamChiTiet.setHinhAnh(fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // Lưu sản phẩm chi tiết vào database
        sanPhamChiTietRepo.save(sanPhamChiTiet);
        redirectAttributes.addFlashAttribute("message", "Thêm thành công!");
        return "redirect:/spct/index";
    }


//    @GetMapping("/delete/{id}")
//    public String deleteSanPhamChiTiet(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
//        // Xóa sản phẩm chi tiết theo ID
//        sanPhamChiTietRepo.deleteById(id);
//        redirectAttributes.addFlashAttribute("message", "Xóa thành công!");
//        return "redirect:/spct/index";
//    }

    @PostMapping("/update")
    public String updateSanPhamChiTiet(@ModelAttribute SanPhamChiTiet sanPhamChiTiet,
                                       @RequestParam("imageFile") MultipartFile imageFile,
                                       RedirectAttributes redirectAttributes) {
        // Lấy sản phẩm hiện tại từ database để có thông tin hình ảnh cũ
        SanPhamChiTiet existingProduct = sanPhamChiTietRepo.findById(sanPhamChiTiet.getId()).orElse(null);

        // Tính toán ngày hết hạn là 3 tháng sau
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, 3);
        sanPhamChiTiet.setNgayHetHan(calendar.getTime());

        // Xử lý upload file ảnh nếu có
        if (!imageFile.isEmpty()) {
            // Xóa hình ảnh cũ
            if (existingProduct != null && existingProduct.getHinhAnh() != null) {
                String relativeFolder = "src/main/webapp/uploads/";
                Path oldImagePath = Paths.get(relativeFolder).resolve(existingProduct.getHinhAnh());
                try {
                    Files.deleteIfExists(oldImagePath); // Xóa file cũ
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            // Lưu hình ảnh mới
            try {
                String relativeFolder = "src/main/webapp/uploads/";
                Path folderPath = Paths.get(relativeFolder).toAbsolutePath();
                if (!Files.exists(folderPath)) {
                    Files.createDirectories(folderPath);
                }

                String originalFilename = imageFile.getOriginalFilename();
                String fileName = System.currentTimeMillis() + "_" + originalFilename;
                Path filePath = folderPath.resolve(fileName);
                Files.write(filePath, imageFile.getBytes());

                // Lưu tên file vào database
                sanPhamChiTiet.setHinhAnh(fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            // Nếu không có hình ảnh mới, giữ nguyên hình ảnh cũ
            sanPhamChiTiet.setHinhAnh(existingProduct.getHinhAnh());
        }

        // Lưu sản phẩm chi tiết vào database
        sanPhamChiTietRepo.save(sanPhamChiTiet);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công!");
        return "redirect:/spct/index";
    }

}
