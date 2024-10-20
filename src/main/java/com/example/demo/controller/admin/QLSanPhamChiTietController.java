package com.example.demo.controller.admin;

import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Calendar;

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
                        @RequestParam(name = "tinhTrang", required = false) String tinhTrang, // Thêm tham số tình trạng
                        Model model) {
        Pageable pageable = PageRequest.of(pageNo, pageSize);

        // Kiểm tra nếu có tình trạng thì lọc theo tình trạng
        Page<SanPhamChiTiet> sanPhamChiTietPage;
        if (tinhTrang != null && !tinhTrang.isEmpty()) {
            Integer status = Integer.parseInt(tinhTrang); // Chuyển đổi sang Integer
            sanPhamChiTietPage = sanPhamChiTietRepo.findByTinhTrang(status, pageable); // Gọi phương thức lọc
        } else {
            sanPhamChiTietPage = sanPhamChiTietRepo.findAll(pageable);
        }

        model.addAttribute("sanPhamChiTietList", sanPhamChiTietPage.getContent());
        model.addAttribute("currentPage", sanPhamChiTietPage.getNumber());
        model.addAttribute("totalPages", sanPhamChiTietPage.getTotalPages());
        model.addAttribute("data", sanPhamChiTietPage);

        // Thêm danh sách cho các khóa phụ
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
                String relativeFolder = "src/main/webapp/uploads/";
                Path folderPath = Paths.get(relativeFolder).toAbsolutePath();
                if (!Files.exists(folderPath)) {
                    Files.createDirectories(folderPath);
                }
                String originalFilename = imageFile.getOriginalFilename();
                String fileName = System.currentTimeMillis() + "_" + originalFilename;
                Path filePath = folderPath.resolve(fileName);
                Files.write(filePath, imageFile.getBytes());
                sanPhamChiTiet.setHinhAnh(fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

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

        if (!imageFile.isEmpty()) {
            if (existingProduct != null && existingProduct.getHinhAnh() != null) {
                String relativeFolder = "src/main/webapp/uploads/";
                Path oldImagePath = Paths.get(relativeFolder).resolve(existingProduct.getHinhAnh());
                try {
                    Files.deleteIfExists(oldImagePath);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
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
                sanPhamChiTiet.setHinhAnh(fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            sanPhamChiTiet.setHinhAnh(existingProduct.getHinhAnh());
        }

        sanPhamChiTietRepo.save(sanPhamChiTiet);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công!");
        return "redirect:/spct/index";
    }
}
