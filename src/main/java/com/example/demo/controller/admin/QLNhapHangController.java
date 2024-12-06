package com.example.demo.controller.admin;

import com.example.demo.entity.NhaCungCap;
import com.example.demo.entity.NhanVien;
import com.example.demo.entity.NhapHang;
import com.example.demo.entity.NhapHangChiTiet;
import com.example.demo.entity.SanPham;
import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.NhaCungCapRepo;
import com.example.demo.repository.NhapHangChiTietRepo;
import com.example.demo.repository.NhapHangRepo;
import com.example.demo.repository.SanPhamChiTietRepo;
import com.example.demo.repository.SanPhamRepo;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;
import java.util.stream.Collectors;

@Controller
@RequestMapping("nhap-hang")
public class QLNhapHangController {

    @Autowired
    NhapHangRepo repo;

    @Autowired
    NhapHangChiTietRepo nhapHangChiTietRepo;

    @Autowired
    NhaCungCapRepo nhaCungCapRepo;

    @Autowired
    SanPhamRepo sanPhamRepo;

    @Autowired
    SanPhamChiTietRepo sanPhamChiTietRepo;

    public String generateMaPhieuNhap() {
        return "PN" + new Random().nextInt(90000);
    }

    @GetMapping("/dat-hang")
    public String showDatHangPage(@RequestParam(value = "page", defaultValue = "0") int page,
                                  @RequestParam(value = "size", defaultValue = "5") int size,
                                  Model model) {
        Pageable pageable = PageRequest.of(page, size);
        Page<SanPhamChiTiet> sanPhamChiTietPage = sanPhamChiTietRepo.findAll(pageable);

        model.addAttribute("listSanPhamChiTiet", sanPhamChiTietPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", sanPhamChiTietPage.getTotalPages());

        // Truyền thêm dữ liệu về nhà cung cấp (SanPham)
        model.addAttribute("danhSachSanPham", sanPhamRepo.findAll());

        return "admin/ql_nhap_hang/nhaphang";
    }


    @GetMapping("/hien-thi")
    public String index(@RequestParam(name = "page", defaultValue = "0") int pageNo,
                        @RequestParam(name = "size", defaultValue = "5") int pageSize,
                        @RequestParam(name = "nhaCungCapId", required = false) Integer nhaCungCapId,
                        @RequestParam(name = "tenNhacungcap", required = false) String tenNhacungcap,
                        @RequestParam(name = "ngayTao", required = false) String ngayTao,
                        Model model) {

        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<NhapHang> page;

        try {
            if (ngayTao != null && !ngayTao.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                Date date = sdf.parse(ngayTao);
                page = repo.findByNgayTaoEquals(date, pageable);
            }
            else if (tenNhacungcap != null && !tenNhacungcap.isEmpty()) {
                page = repo.findByNhanVien_TenNhanVienContainingIgnoreCase(tenNhacungcap, pageable);
            }
            else if (nhaCungCapId != null) {
                page = repo.findByNhaCungCapId(nhaCungCapId, pageable);
            }
            else {
                page = repo.findAll(pageable);
            }
        } catch (ParseException e) {
            model.addAttribute("error", "Ngày tạo không hợp lệ.");
            return "admin/ql_nhap_hang/index";
        }

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        List<Map<String, Object>> formattedList = page.getContent().stream().map(nhapHang -> {
            Map<String, Object> formattedNhapHang = new HashMap<>();

            formattedNhapHang.put("id", nhapHang.getId());
            formattedNhapHang.put("maPhieuNhap", nhapHang.getMaPhieuNhap());
            formattedNhapHang.put("nhaCungCap", nhapHang.getNhaCungCap());
            formattedNhapHang.put("nhanVien", nhapHang.getNhanVien());
            formattedNhapHang.put("tongGiaTri", nhapHang.getTongGiaTri());
            formattedNhapHang.put("ghiChu", nhapHang.getGhiChu());
            formattedNhapHang.put("tinhTrang", nhapHang.getTinhTrang());
            formattedNhapHang.put("ngayNhap", nhapHang.getNgayNhap() != null ? sdf.format(nhapHang.getNgayNhap()) : "");
            formattedNhapHang.put("ngayTao", nhapHang.getNgayTao() != null ? sdf.format(nhapHang.getNgayTao()) : "");
            return formattedNhapHang;
        }).collect(Collectors.toList());

        model.addAttribute("data", new PageImpl<>(formattedList, pageable, page.getTotalElements()));
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("nhaCungCapList", nhaCungCapRepo.findAll());
        model.addAttribute("nhaCungCapId", nhaCungCapId);

        return "admin/ql_nhap_hang/index";
    }




    @PostMapping("/add")
    public String addNhapHang(
            @RequestParam Map<String, String> formData,
            @RequestParam(value = "selectedItems", required = false) List<String> selectedItems,
            HttpSession session) {
        NhanVien nhanVien = (NhanVien) session.getAttribute("khachHang");

        if (nhanVien == null) {
            return "redirect:/login";
        }

        System.out.println("Tên nhân viên: " + nhanVien.getTenNhanVien());

        Map<NhaCungCap, List<String>> productsBySupplier = new HashMap<>();
        for (String productIdStr : selectedItems) {
            Integer productId = Integer.valueOf(productIdStr);
            SanPham sanPham = sanPhamRepo.findById(productId).orElse(null);
            if (sanPham != null) {
                NhaCungCap nhaCungCap = sanPham.getNhaCungCap();
                productsBySupplier.computeIfAbsent(nhaCungCap, k -> new ArrayList<>()).add(productIdStr);
            }
        }

        for (Map.Entry<NhaCungCap, List<String>> entry : productsBySupplier.entrySet()) {
            NhaCungCap nhaCungCap = entry.getKey();
            List<String> productIds = entry.getValue();
            NhapHang nhapHang = new NhapHang();
            nhapHang.setMaPhieuNhap(generateMaPhieuNhap());
            nhapHang.setNgayTao(new Date());
            nhapHang.setTinhTrang(0);
            nhapHang.setNhaCungCap(nhaCungCap);
            nhapHang.setNhanVien(nhanVien);

            String ghiChu = formData.get("ghiChu");
            nhapHang.setGhiChu(ghiChu);

            int tongGiaTri = 0;
            nhapHang = repo.save(nhapHang);

            for (String productIdStr : productIds) {
                Integer productId = Integer.valueOf(productIdStr);

                String giaNhapStr = formData.get("giaNhap_" + productId);
                String soLuongStr = formData.get("soLuong_" + productId);

                Integer giaNhap = (giaNhapStr != null && !giaNhapStr.isEmpty()) ? Integer.valueOf(giaNhapStr) : 0; // Nếu giá nhập là null hoặc rỗng, gán giá trị mặc định là 0
                Integer soLuong = (soLuongStr != null && !soLuongStr.isEmpty()) ? Integer.valueOf(soLuongStr) : 0; // Nếu số lượng là null hoặc rỗng, gán giá trị mặc định là 0

                SanPham sanPham = sanPhamRepo.findById(productId).orElse(null);
                if (sanPham != null) {
                    Integer giaNhapFromSpan = sanPham.getGiaBan();

                    Integer tongTien = giaNhapFromSpan * soLuong;

                    tongGiaTri += tongTien;

                    NhapHangChiTiet chiTiet = new NhapHangChiTiet();
                    chiTiet.setNhapHang(nhapHang);
                    chiTiet.setSanPham(sanPham);
                    chiTiet.setGiaNhap(giaNhapFromSpan);
                    chiTiet.setSoLuong(soLuong);
                    chiTiet.setTongTien(tongTien);
                    chiTiet.setNgaySanXuat(new Date());
                    chiTiet.setHanSuDung(new Date());

                    nhapHangChiTietRepo.save(chiTiet);
                }
            }
            nhapHang.setTongGiaTri(tongGiaTri);
            repo.save(nhapHang);
        }
        return "redirect:/nhap-hang/hien-thi";
    }


    @GetMapping("/chi-tiet/{id}")
    public String chiTiet(@PathVariable("id") Integer id, Model model) {
        Optional<NhapHang> nhapHang1 = repo.findById(id);
        if (nhapHang1.isPresent()) {
            NhapHang nhapHang = nhapHang1.get();
            List<NhapHangChiTiet> nhapHangChiTiets = nhapHangChiTietRepo.findByNhapHangId(id);

            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            String formattedNgayNhap = nhapHang.getNgayNhap() != null ? sdf.format(nhapHang.getNgayNhap()) : "";
            String formattedNgayTao = nhapHang.getNgayTao() != null ? sdf.format(nhapHang.getNgayTao()) : "";

            model.addAttribute("nhapHang", nhapHang);
            model.addAttribute("nhapHangChiTiets", nhapHangChiTiets);
            model.addAttribute("formattedNgayNhap", formattedNgayNhap);
            model.addAttribute("formattedNgayTao", formattedNgayTao);

            return "/admin/ql_nhap_hang/phieunhapchitiet";
        } else {
            model.addAttribute("error", "Phiếu nhập không tồn tại");
            return "/admin/ql_nhap_hang/index";
        }
    }



    @PostMapping("/da-nhan-hang/{id}")
    public String daNhanHang(@PathVariable("id") Integer nhapHangId, RedirectAttributes redirectAttributes) {

        Optional<NhapHang> optionalNhapHang = repo.findById(nhapHangId);
        if (!optionalNhapHang.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Phiếu nhập không tồn tại!");
            return "redirect:/nhap-hang/hien-thi";
        }

        NhapHang nhapHang = optionalNhapHang.get();

        List<NhapHangChiTiet> danhSachSanPham = nhapHangChiTietRepo.findByNhapHangId(nhapHangId);

        for (NhapHangChiTiet chiTiet : danhSachSanPham) {
            Optional<SanPhamChiTiet> optionalSanPhamChiTiet = sanPhamChiTietRepo.findById(chiTiet.getSanPham().getId());
            if (optionalSanPhamChiTiet.isPresent()) {
                SanPhamChiTiet sanPhamChiTiet = optionalSanPhamChiTiet.get();
                sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() + chiTiet.getSoLuong());
                sanPhamChiTietRepo.save(sanPhamChiTiet);
            }
        }
        nhapHang.setTinhTrang(1);
        nhapHang.setNgayNhap(new Date());
        repo.save(nhapHang);
        redirectAttributes.addFlashAttribute("successMessage", "Hàng đã vào cửa hàng!");

        return "redirect:/nhap-hang/chi-tiet/" + nhapHangId;
    }
}