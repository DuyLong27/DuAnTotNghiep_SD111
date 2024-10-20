package com.example.demo.controller.admin;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("thuoc-tinh")
public class QLThuocTinhController {
    @Autowired
    ThuongHieuRepo thuongHieuRepo;
    @Autowired
    MucDoRangRepo mucDoRangRepo;
    @Autowired
    LoaiCaPheRepo loaiCaPheRepo;
    @Autowired
    LoaiHatRepo loaiHatRepo;
    @Autowired
    LoaiTuiRepo loaiTuiRepo;
    @Autowired
    CanNangRepo canNangRepo;
    @Autowired
    HuongViRepo huongViRepo;

    @Autowired
    DanhMucRepo danhMucRepo;

    @GetMapping
    public String displayAttributes(
            @RequestParam(required = false) String entity,
            @RequestParam(name = "page", defaultValue = "0") int pageNo,
            @RequestParam(name = "size", defaultValue = "5") int pageSize,
            Model model) {
        if (entity == null || entity.isEmpty()) {
            entity = "canNang"; // Đặt mặc định là "Cân Nặng"
        }

        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<?> page;

        switch (entity) {
            case "canNang":
                page = canNangRepo.findAll(pageable);
                break;
            case "huongVi":
                page = huongViRepo.findAll(pageable);
                break;
            case "loaiCaPhe":
                page = loaiCaPheRepo.findAll(pageable);
                break;
            case "loaiHat":
                page = loaiHatRepo.findAll(pageable);
                break;
            case "loaiTui":
                page = loaiTuiRepo.findAll(pageable);
                break;
            case "mucDoRang":
                page = mucDoRangRepo.findAll(pageable);
                break;
            case "thuongHieu":
                page = thuongHieuRepo.findAll(pageable);
                break;
            case "danhMuc":
                page = danhMucRepo.findAll(pageable);
                break;
            default:
                throw new IllegalArgumentException("Invalid entity type");
        }

        model.addAttribute("items", page.getContent());
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("entity", entity);
        return "admin/ql_thuoc_tinh/index";
    }

    // Thêm RedirectAttributes vào các phương thức
    @PostMapping("/add")
    public String addAttribute(@RequestParam String entity, @RequestParam String propertyName, RedirectAttributes redirectAttributes) {
        // Thêm thuộc tính mới vào database
        switch (entity) {
            case "canNang":
                CanNang canNang = new CanNang();
                canNang.setTen(propertyName);
                canNangRepo.save(canNang);
                break;
            case "huongVi":
                HuongVi huongVi = new HuongVi();
                huongVi.setTen(propertyName);
                huongViRepo.save(huongVi);
                break;
            case "loaiCaPhe":
                LoaiCaPhe loaiCaPhe = new LoaiCaPhe();
                loaiCaPhe.setTen(propertyName);
                loaiCaPheRepo.save(loaiCaPhe);
                break;
            case "loaiHat":
                LoaiHat loaiHat = new LoaiHat();
                loaiHat.setTen(propertyName);
                loaiHatRepo.save(loaiHat);
                break;
            case "loaiTui":
                LoaiTui loaiTui = new LoaiTui();
                loaiTui.setTen(propertyName);
                loaiTuiRepo.save(loaiTui);
                break;
            case "mucDoRang":
                MucDoRang mucDoRang = new MucDoRang();
                mucDoRang.setTen(propertyName);
                mucDoRangRepo.save(mucDoRang);
                break;
            case "thuongHieu":
                ThuongHieu thuongHieu = new ThuongHieu();
                thuongHieu.setTen(propertyName);
                thuongHieuRepo.save(thuongHieu);
                break;
            case "danhMuc":
                DanhMuc danhMuc = new DanhMuc();
                danhMuc.setTen(propertyName);
                danhMucRepo.save(danhMuc);
                break;
        }

        // Thêm thông báo thành công vào flash attributes
        redirectAttributes.addFlashAttribute("message", "Thêm thuộc tính thành công!");

        // Sau khi thêm, chuyển hướng lại về phương thức hiển thị với entity đã chọn
        return "redirect:/thuoc-tinh?entity=" + entity;
    }

//    @PostMapping("/delete")
//    public String deleteAttribute(@RequestParam String entity, @RequestParam Integer id, RedirectAttributes redirectAttributes) {
//        switch (entity) {
//            case "canNang":
//                canNangRepo.deleteById(id);
//                break;
//            case "huongVi":
//                huongViRepo.deleteById(id);
//                break;
//            case "loaiCaPhe":
//                loaiCaPheRepo.deleteById(id);
//                break;
//            case "loaiHat":
//                loaiHatRepo.deleteById(id);
//                break;
//            case "loaiTui":
//                loaiTuiRepo.deleteById(id);
//                break;
//            case "mucDoRang":
//                mucDoRangRepo.deleteById(id);
//                break;
//            case "thuongHieu":
//                thuongHieuRepo.deleteById(id);
//                break;
//            case "danhMuc":
//                danhMucRepo.deleteById(id);
//                break;
//        }
//
//        // Thêm thông báo thành công vào flash attributes
//        redirectAttributes.addFlashAttribute("message", "Xóa thuộc tính thành công!");
//
//        // Sau khi xóa, chuyển hướng lại về phương thức hiển thị với entity đã chọn
//        return "redirect:/thuoc-tinh?entity=" + entity;
//    }

    @PostMapping("/update")
    public String updateAttribute(@RequestParam String entity, @RequestParam Integer id, @RequestParam String propertyName, RedirectAttributes redirectAttributes) {
        // Sửa thuộc tính trong database
        switch (entity) {
            case "canNang":
                CanNang canNang = canNangRepo.findById(id).orElse(null);
                if (canNang != null) {
                    canNang.setTen(propertyName);
                    canNangRepo.save(canNang);
                }
                break;
            case "huongVi":
                HuongVi huongVi = huongViRepo.findById(id).orElse(null);
                if (huongVi != null) {
                    huongVi.setTen(propertyName);
                    huongViRepo.save(huongVi);
                }
                break;
            case "loaiCaPhe":
                LoaiCaPhe loaiCaPhe = loaiCaPheRepo.findById(id).orElse(null);
                if (loaiCaPhe != null) {
                    loaiCaPhe.setTen(propertyName);
                    loaiCaPheRepo.save(loaiCaPhe);
                }
                break;
            case "loaiHat":
                LoaiHat loaiHat = loaiHatRepo.findById(id).orElse(null);
                if (loaiHat != null) {
                    loaiHat.setTen(propertyName);
                    loaiHatRepo.save(loaiHat);
                }
                break;
            case "loaiTui":
                LoaiTui loaiTui = loaiTuiRepo.findById(id).orElse(null);
                if (loaiTui != null) {
                    loaiTui.setTen(propertyName);
                    loaiTuiRepo.save(loaiTui);
                }
                break;
            case "mucDoRang":
                MucDoRang mucDoRang = mucDoRangRepo.findById(id).orElse(null);
                if (mucDoRang != null) {
                    mucDoRang.setTen(propertyName);
                    mucDoRangRepo.save(mucDoRang);
                }
                break;
            case "thuongHieu":
                ThuongHieu thuongHieu = thuongHieuRepo.findById(id).orElse(null);
                if (thuongHieu != null) {
                    thuongHieu.setTen(propertyName);
                    thuongHieuRepo.save(thuongHieu);
                }
                break;
            case "danhMuc":
                DanhMuc danhMuc = danhMucRepo.findById(id).orElse(null);
                if (danhMuc != null) {
                    danhMuc.setTen(propertyName);
                    danhMucRepo.save(danhMuc);
                }
                break;
        }
        // Thêm thông báo thành công vào flash attributes
        redirectAttributes.addFlashAttribute("message", "Sửa thuộc tính thành công!");

        // Sau khi sửa, chuyển hướng lại về phương thức hiển thị với entity đã chọn
        return "redirect:/thuoc-tinh?entity=" + entity;
    }
}
