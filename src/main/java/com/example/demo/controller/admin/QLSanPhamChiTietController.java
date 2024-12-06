package com.example.demo.controller.admin;

import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.*;
import com.example.demo.utils.QRCodeGenerator;
import com.google.zxing.WriterException;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.data.domain.Pageable;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.util.Calendar;
import java.util.Date;
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
    public String addSanPhamChiTiet(@Valid @ModelAttribute SanPhamChiTiet sanPhamChiTiet,
                                    BindingResult bindingResult,
                                    @RequestParam("imageFile") MultipartFile imageFile,
                                    RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "admin/ql_san_pham_chi_tiet/add";
        }
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, 12);
        sanPhamChiTiet.setNgayHetHan(calendar.getTime());
        sanPhamChiTiet.setNgayTao(new Date());
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
                redirectAttributes.addFlashAttribute("message", "Lỗi tải ảnh lên!");
                return "redirect:/spct/index";
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
    public String updateSanPhamChiTiet(@Valid @ModelAttribute SanPhamChiTiet sanPhamChiTiet,
                                       BindingResult bindingResult,
                                       @RequestParam("imageFile") MultipartFile imageFile,
                                       RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "admin/ql_san_pham_chi_tiet/update";
        }
        SanPhamChiTiet existingProduct = sanPhamChiTietRepo.findById(sanPhamChiTiet.getId()).orElse(null);
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, 12);
        sanPhamChiTiet.setNgayHetHan(calendar.getTime());
        sanPhamChiTiet.setNgayTao(new Date());
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



    @PostMapping("/kiem-tra")
    @ResponseBody
    public ResponseEntity<Void> kiemTraSanPhamChiTiet() {
        List<SanPhamChiTiet> sanPhamChiTietList = sanPhamChiTietRepo.findAll();
        Date currentDate = new Date();
        for (SanPhamChiTiet sanPhamChiTiet : sanPhamChiTietList) {
            if (sanPhamChiTiet.getNgayHetHan() != null && currentDate.after(sanPhamChiTiet.getNgayHetHan())) {
                sanPhamChiTiet.setTinhTrang(0);
            }
            sanPhamChiTietRepo.save(sanPhamChiTiet);
        }
        return ResponseEntity.ok().build();
    }



}
