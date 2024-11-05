package com.example.demo.controller.customer;

import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
@RequestMapping("/danh-sach-san-pham-chi-tiet")
public class DanhSachSPCTController {
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

    // Helper method to add common attributes to the model
    private void addCommonAttributes(Model model) {
        model.addAttribute("loaiCaPheList", loaiCaPheRepo.findAll());
        model.addAttribute("sanPhamList", sanPhamRepo.findAll());
        model.addAttribute("canNangList", canNangRepo.findAll());
        model.addAttribute("loaiHatList", loaiHatRepo.findAll());
        model.addAttribute("loaiTuiList", loaiTuiRepo.findAll());
        model.addAttribute("mucDoRangList", mucDoRangRepo.findAll());
        model.addAttribute("huongViList", huongViRepo.findAll());
        model.addAttribute("thuongHieuList", thuongHieuRepo.findAll());
    }

    @GetMapping("/hien-thi")
    public String index(@RequestParam(name = "page", defaultValue = "0") int pageNo,
                        @RequestParam(name = "size", defaultValue = "5") int pageSize,
                        Model model) {

        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<SanPhamChiTiet> page = sanPhamChiTietRepo.findAll(pageable);

        // Add pagination data
        model.addAttribute("data", page);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());

        // Add common attributes
        addCommonAttributes(model);

        return "customer/san_pham_chi_tiet/index";
    }

    @GetMapping("/view-sp/{id}")
    public String viewProduct(@PathVariable("id") Integer id, Model model) {
        // Lấy sản phẩm chi tiết
        Optional<SanPhamChiTiet> optionalSanPhamChiTiet = sanPhamChiTietRepo.findById(id);

        if (optionalSanPhamChiTiet.isPresent()) {
            model.addAttribute("sanPhamChiTiet", optionalSanPhamChiTiet.get());
        } else {
            model.addAttribute("sanPhamChiTiet", null); // Trường hợp không tìm thấy sản phẩm
        }

        // Lấy danh sách sản phẩm liên quan
        Pageable pageable = PageRequest.of(0, 5); // Giới hạn số lượng sản phẩm liên quan
        Page<SanPhamChiTiet> relatedProductsPage = sanPhamChiTietRepo.findAll(pageable);

        // Thêm sản phẩm liên quan vào model
        model.addAttribute("data", relatedProductsPage);

        return "customer/san_pham_chi_tiet/index";
    }

    public String showProductList(@RequestParam(name = "page", defaultValue = "0") int pageNo,
                                  @RequestParam(name = "size", defaultValue = "5") int pageSize,
                                  Model model) {

        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<SanPhamChiTiet> page = sanPhamChiTietRepo.findAll(pageable);

        model.addAttribute("data", page); // Dữ liệu sản phẩm phân trang
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());

        return "customer/san_pham_chi_tiet/index"; // Trả về JSP
    }
}
