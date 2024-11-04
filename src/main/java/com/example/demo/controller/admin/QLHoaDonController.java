package com.example.demo.controller.admin;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    @GetMapping("/hien-thi")
    public String hienThi(Model model,
                          @RequestParam(required = false) Integer tinhTrang
    ){
        List<HoaDon> hoaDonList;
        if (tinhTrang != null){
            hoaDonList = hoaDonRepo.findByTinhTrang(tinhTrang);
        }else {
            hoaDonList = hoaDonRepo.findAll();
        }
        model.addAttribute("listHoaDon", hoaDonList);
        model.addAttribute("list",hoaDonRepo.findAll());
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

            // Lấy DoiTra theo id_hoa_don
            DoiTra doiTra = doiTraRepo.findFirstByHoaDon_Id(id); // Giả sử chỉ có một DoiTra cho mỗi HoaDon
            model.addAttribute("doiTra", doiTra);

            return "/admin/ql_hoa_don/detail";
        } else {
            model.addAttribute("error", "Hóa đơn không tồn tại");
            return "/admin/ql_hoa_don/index"; // Hoặc trang lỗi phù hợp
        }
    }


    @PostMapping("/cap-nhat-tinh-trang")
    public String capNhatTinhTrang(@RequestParam("id") Integer id,
                                   @RequestParam("tinhTrangMoi") Integer tinhTrangMoi,
                                   @RequestParam(value = "ghiChu", required = false) String ghiChu, // Đặt required = false
                                   RedirectAttributes redirectAttributes) {
        HoaDon hoaDon = hoaDonRepo.findById(id).orElse(null);
        if (hoaDon != null) {
            hoaDon.setTinh_trang(tinhTrangMoi);

            // Kiểm tra ghi chú và chỉ cập nhật nếu không rỗng
            if (ghiChu != null && !ghiChu.trim().isEmpty()) {
                hoaDon.setGhi_chu(ghiChu);
            }

            hoaDonRepo.save(hoaDon);
            List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepo.findByHoaDonId(id);
            for (HoaDonChiTiet hoaDonChiTiet : hoaDonChiTietList) {
                SanPhamChiTiet sanPhamChiTiet = hoaDonChiTiet.getSanPhamChiTiet();
                sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() + hoaDonChiTiet.getSo_luong());
                sanPhamChiTietRepo.save(sanPhamChiTiet); // Cập nhật số lượng sản phẩm trong cơ sở dữ liệu
            }
            redirectAttributes.addFlashAttribute("message", "Cập nhật trạng thái thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy hóa đơn!");
        }
        return "redirect:/hoa-don/detail/" + id;
    }
}
