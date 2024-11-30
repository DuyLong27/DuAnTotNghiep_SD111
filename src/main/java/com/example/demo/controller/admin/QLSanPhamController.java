package com.example.demo.controller.admin;

import com.example.demo.entity.DanhMuc;
import com.example.demo.entity.NhaCungCap;
import com.example.demo.entity.SanPham;
import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.DanhMucRepo;
import com.example.demo.repository.NhaCungCapRepo;
import com.example.demo.repository.SanPhamChiTietRepo;
import com.example.demo.repository.SanPhamRepo;
import com.example.demo.utils.QRCodeGenerator;
import com.google.zxing.WriterException;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("san-pham")
public class QLSanPhamController {

    @Autowired
    private NhaCungCapRepo nhaCungCapRepo;

    @Autowired
    private DanhMucRepo danhMucRepo;

    @Autowired
    private SanPhamRepo sanPhamRepo;


    @Autowired
    private SanPhamChiTietRepo sanPhamChiTietRepo;
    @PostMapping("/add")
    public String addProduct(Model model, @Valid @ModelAttribute("data") SanPham sanPham,
                             BindingResult validate, RedirectAttributes redirectAttributes) {
        if (validate.hasErrors()) {
            List<DanhMuc> danhMucList = danhMucRepo.findAll();
            List<NhaCungCap> nhaCungCapList = nhaCungCapRepo.findAll();
            model.addAttribute("data",sanPham);
            model.addAttribute("danhMucList",danhMucList);
            model.addAttribute("nhaCungCapList",nhaCungCapList);
            return "admin/ql_san_pham/index";
        }
        sanPhamRepo.save(sanPham);
        redirectAttributes.addFlashAttribute("message", "Thêm thành công!");
        return "redirect:/san-pham/index";
    }

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "0") int pageNo,
                        @RequestParam(name = "size", defaultValue = "5") int pageSize,
                        @RequestParam(name = "tinhTrang", required = false) Integer tinhTrang,
                        @RequestParam(name = "danhMucId", required = false) Integer danhMucId,
                        @RequestParam(name = "nhaCungCapTen", required = false) String nhaCungCapTen,
                        Model model) throws IOException, WriterException {
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<SanPham> page;

        // Xử lý đầu vào tìm kiếm tên nhà cung cấp
        if (nhaCungCapTen != null) {
            // Loại bỏ dấu cách ở đầu và cuối, và thay thế nhiều dấu cách liên tiếp
            nhaCungCapTen = nhaCungCapTen.trim().replaceAll("\\s+", " ");
        }

        // Tìm kiếm theo tên nhà cung cấp
        if (nhaCungCapTen != null && !nhaCungCapTen.isEmpty()) {
            page = sanPhamRepo.findByNhaCungCap_TenNCCContainingIgnoreCase(nhaCungCapTen, pageable);
        } else if (tinhTrang != null && danhMucId != null) {
            page = sanPhamRepo.findByTinhTrangAndDanhMucId(tinhTrang, danhMucId, pageable);
        } else if (tinhTrang != null) {
            page = sanPhamRepo.findByTinhTrang(tinhTrang, pageable);
        } else if (danhMucId != null) {
            page = sanPhamRepo.findByDanhMucId(danhMucId, pageable);
        } else {
            page = sanPhamRepo.findAll(pageable);
        }


        List<DanhMuc> danhMucList = danhMucRepo.findAll();
        List<NhaCungCap> nhaCungCapList = nhaCungCapRepo.findAll();
        model.addAttribute("data", page);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("danhMucList", danhMucList);
        model.addAttribute("nhaCungCapList", nhaCungCapList);
        model.addAttribute("tinhTrang", tinhTrang);
        model.addAttribute("danhMucId", danhMucId); // Để giữ trạng thái chọn
        model.addAttribute("nhaCungCapTen", nhaCungCapTen); // Để giữ trạng thái tìm kiếm
        return "admin/ql_san_pham/index";
    }





//    @GetMapping("delete/{id}")
//    @Transactional
//    public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
//        // Xóa tất cả các bản ghi con trong bảng san_pham_chi_tiet trước
//        sanPhamChiTietRepo.deleteBySanPhamId(id);
//
//        // Sau đó xóa sản phẩm
//        if (sanPhamRepo.existsById(id)) {
//            sanPhamRepo.deleteById(id);
//            redirectAttributes.addFlashAttribute("message", "Xóa thành công!");
//        } else {
//            redirectAttributes.addFlashAttribute("message", "Sản phẩm không tồn tại!");
//        }
//        return "redirect:/san-pham/index";
//    }






    @GetMapping("edit/{id}")
    public String editProduct(@PathVariable("id") Integer id, Model model) {
        SanPham sanPham = sanPhamRepo.findById(id).orElse(null);
        List<DanhMuc> danhMucList = danhMucRepo.findAll();
        List<NhaCungCap> nhaCungCapList = nhaCungCapRepo.findAll();
        model.addAttribute("data", sanPham);
        model.addAttribute("danhMucList", danhMucList);
        model.addAttribute("nhaCungCapList", nhaCungCapList);
        return "admin/ql_san_pham/edit"; // Tạo một trang mới hoặc trả về index với modal
    }

    @PostMapping("/update")
    public String updateProduct(@Valid @ModelAttribute("data") SanPham sanPham, BindingResult validate,
                                Model model, RedirectAttributes redirectAttributes) {
        if (validate.hasErrors()) {
            List<DanhMuc> danhMucList = danhMucRepo.findAll();
            List<NhaCungCap> nhaCungCapList = nhaCungCapRepo.findAll();
            model.addAttribute("data", sanPham);
            model.addAttribute("danhMucList", danhMucList);
            model.addAttribute("nhaCungCapList", nhaCungCapList);
            return "admin/ql_san_pham/index";
        }
        List<SanPhamChiTiet> sanPhamChiTietList = sanPhamChiTietRepo.findBySanPhamId(sanPham.getId());
        for (SanPhamChiTiet sanPhamChiTiet : sanPhamChiTietList) {
            sanPhamChiTiet.setTinhTrang(sanPham.getTinhTrang());
        }
        sanPhamChiTietRepo.saveAll(sanPhamChiTietList);
        sanPhamRepo.save(sanPham);

        redirectAttributes.addFlashAttribute("message", "Sửa thành công!");
        return "redirect:/san-pham/index";
    }

}
