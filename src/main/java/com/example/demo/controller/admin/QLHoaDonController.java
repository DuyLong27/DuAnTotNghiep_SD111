package com.example.demo.controller.admin;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/hoa-don")
public class QLHoaDonController {

    @Autowired
    HoaDonRepo hoaDonRepo;

    @Autowired
    private HoaDonChiTietRepo hoaDonChiTietRepo;

    @Autowired
    DoiTraRepo doiTraRepo;

    @Autowired
    SanPhamChiTietRepo sanPhamChiTietRepo;
    @Autowired
    DoiTraChiTietRepo doiTraChiTietRepo;
    @GetMapping("/tinhTrang={tinhTrang}")
    public String hienThi(Model model,
                          @PathVariable(required = false) String tinhTrang,
                          @RequestParam(defaultValue = "0") int page,
                          @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<HoaDon> hoaDonPage;

        if ("all".equals(tinhTrang)) {
            hoaDonPage = hoaDonRepo.findAll(pageable);
        } else {
            Integer tinhTrangInt = null;
            try {
                tinhTrangInt = Integer.valueOf(tinhTrang);
            } catch (NumberFormatException e) {
            }

            if (tinhTrangInt != null && tinhTrangInt == 2) {
                hoaDonPage = hoaDonRepo.findByTinhTrangIn(Arrays.asList(2, 3), pageable);
            } else if (tinhTrangInt != null) {
                hoaDonPage = hoaDonRepo.findByTinhTrang(tinhTrangInt, pageable);
            } else {
                hoaDonPage = hoaDonRepo.findAll(pageable);
            }
        }

        model.addAttribute("listHoaDon", hoaDonPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", hoaDonPage.getTotalPages());
        model.addAttribute("isFirst", hoaDonPage.isFirst());
        model.addAttribute("isLast", hoaDonPage.isLast());

        return "/admin/ql_hoa_don/index";
    }



    @GetMapping("/detail/{id}")
    public String chiTiet(@PathVariable("id") Integer id, Model model) {
        Optional<HoaDon> optionalHoaDon = hoaDonRepo.findById(id);
        if (optionalHoaDon.isPresent()) {
            HoaDon hoaDon = optionalHoaDon.get();
            List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepo.findByHoaDonId(id);
            model.addAttribute("hoaDon", hoaDon);
            model.addAttribute("hoaDonChiTiets", hoaDonChiTietList);

            DoiTra doiTra = doiTraRepo.findFirstByHoaDon_Id(id);
            model.addAttribute("doiTra", doiTra);

            List<DoiTraChiTiet> doiTraChiTietList = doiTraChiTietRepo.findByDoiTra_HoaDon_Id(id);
            model.addAttribute("doiTraChiTiets", doiTraChiTietList);

            return "/admin/ql_hoa_don/detail";
        } else {
            model.addAttribute("error", "Hóa đơn không tồn tại");
            return "/admin/ql_hoa_don/index";
        }
    }


    @PostMapping("/cap-nhat-tinh-trang")
    public String capNhatTinhTrang(@RequestParam("id") Integer id,
                                   @RequestParam("tinhTrangMoi") Integer tinhTrangMoi,
                                   @RequestParam(value = "ghiChu", required = false) String ghiChu,
                                   RedirectAttributes redirectAttributes) {
        HoaDon hoaDon = hoaDonRepo.findById(id).orElse(null);
        if (hoaDon != null) {
            hoaDon.setTinh_trang(tinhTrangMoi);

            if (ghiChu != null && !ghiChu.trim().isEmpty()) {
                hoaDon.setGhiChu(ghiChu);
            }

            hoaDonRepo.save(hoaDon);
            redirectAttributes.addFlashAttribute("message", "Cập nhật trạng thái thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy hóa đơn!");
        }
        return "redirect:/hoa-don/detail/" + id;
    }


    @PostMapping("/hoan-hang/{id}")
    public String hoanHang(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        HoaDon hoaDon = hoaDonRepo.findById(id).orElse(null);
        if (hoaDon == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy hóa đơn!");
            return "redirect:/hoa-don/detail/" + id;
        }

        List<DoiTraChiTiet> doiTraChiTietList = doiTraChiTietRepo.findByDoiTra_HoaDon_Id(id);

        if (doiTraChiTietList.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Không có sản phẩm cần hoàn trong hóa đơn!");
            return "redirect:/hoa-don/detail/" + id;
        }

        int tongTienHoan = hoaDon.getTongTien();

        for (DoiTraChiTiet doiTraChiTiet : doiTraChiTietList) {
            SanPhamChiTiet sanPhamChiTiet = doiTraChiTiet.getSanPhamChiTiet();

            sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() + doiTraChiTiet.getSoLuong());
            sanPhamChiTietRepo.save(sanPhamChiTiet);

            tongTienHoan -= doiTraChiTiet.getSoLuong() * sanPhamChiTiet.getGiaBan();
        }

        hoaDon.setTongTien(tongTienHoan);
        hoaDon.setTinh_trang(13);
        hoaDonRepo.save(hoaDon);

        List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepo.findByHoaDonId(id);
        for (HoaDonChiTiet hoaDonChiTiet : hoaDonChiTietList) {
            for (DoiTraChiTiet doiTraChiTiet : doiTraChiTietList) {
                if (hoaDonChiTiet.getSanPhamChiTiet().equals(doiTraChiTiet.getSanPhamChiTiet())) {

                    hoaDonChiTiet.setSo_luong(hoaDonChiTiet.getSo_luong() - doiTraChiTiet.getSoLuong());
                    hoaDonChiTietRepo.save(hoaDonChiTiet);
                }
            }
        }

        doiTraChiTietRepo.deleteAll(doiTraChiTietList);

        redirectAttributes.addFlashAttribute("message", "Hoàn hàng thành công!");
        return "redirect:/hoa-don/detail/" + id;
    }

}