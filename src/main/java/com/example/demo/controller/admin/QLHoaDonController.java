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

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

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

    @Autowired
    KhachHangRepo khachHangRepo;

    @Autowired
    ThoiGianDonHangRepo thoiGianDonHangRepo;
    @GetMapping("/tinhTrang={tinhTrang}")
    public String hienThi(Model model,
                          @PathVariable(required = false) String tinhTrang,
                          @RequestParam(defaultValue = "0") int page,
                          @RequestParam(defaultValue = "10") int size,
                          @RequestParam(required = false) String phoneNumber,
                          @RequestParam(required = false) String startDate,
                          @RequestParam(required = false) String endDate,
                          @RequestParam(required = false) Integer kieuHoaDon) {

        Pageable pageable = PageRequest.of(page, size);
        Page<HoaDon> hoaDonPage;

        // Chuyển đổi các tham số thời gian từ chuỗi sang LocalDateTime
        LocalDateTime start = startDate != null && !startDate.isEmpty() ? LocalDateTime.parse(startDate + "T00:00:00") : null;
        LocalDateTime end = endDate != null && !endDate.isEmpty() ? LocalDateTime.parse(endDate + "T23:59:59") : null;

        // Chuyển đổi tình trạng từ String sang Integer (nếu có)
        Integer tinhTrangInt = null;
        try {
            if (tinhTrang != null && !"all".equals(tinhTrang)) {
                tinhTrangInt = Integer.valueOf(tinhTrang);
            }
        } catch (NumberFormatException e) {
            // Nếu không thể chuyển đổi, tình trạng sẽ để null
        }

        // Truy vấn với các điều kiện đã lọc
        hoaDonPage = hoaDonRepo.findByMultipleCriteria(
                tinhTrangInt,
                phoneNumber,
                kieuHoaDon,
                start,
                end,
                pageable
        );

        List<HoaDon> hoaDonList = hoaDonPage.getContent();

        // Định dạng thời gian hiển thị cho hóa đơn
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss, dd-MM-yyyy");
        for (HoaDon hoaDon : hoaDonList) {
            hoaDon.setThoiGianTaoFormatted(hoaDon.getThoiGianTao().format(formatter));
        }

        // Thêm các thuộc tính vào model để hiển thị trên view
        model.addAttribute("listHoaDon", hoaDonList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", hoaDonPage.getTotalPages());
        model.addAttribute("isFirst", hoaDonPage.isFirst());
        model.addAttribute("isLast", hoaDonPage.isLast());
        model.addAttribute("phoneNumber", phoneNumber);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("tinhTrang", tinhTrang);
        model.addAttribute("kieuHoaDon", kieuHoaDon);

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

            Optional<ThoiGianDonHang> thoiGianDonHangOpt = thoiGianDonHangRepo.findByHoaDonId(id);
            if (thoiGianDonHangOpt.isPresent()) {
                ThoiGianDonHang thoiGianDonHang = thoiGianDonHangOpt.get();

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss , dd/MM/yyyy");

                String formattedThoiGianTao = null;
                if (thoiGianDonHang.getThoiGianTao() != null) {
                    formattedThoiGianTao = thoiGianDonHang.getThoiGianTao().format(formatter);
                } else {
                    formattedThoiGianTao = "Chưa có thông tin";
                }

                String formattedThoiGianHoanTra = null;
                if (thoiGianDonHang.getHoanTra() != null) {
                    formattedThoiGianHoanTra = thoiGianDonHang.getHoanTra().format(formatter);
                } else {
                    formattedThoiGianHoanTra = "Chưa có thông tin";
                }

                model.addAttribute("thoiGianTao", formattedThoiGianTao);
                model.addAttribute("thoiGianHoanTra", formattedThoiGianHoanTra);
            }

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
        int diemHoan = 0;

        for (DoiTraChiTiet doiTraChiTiet : doiTraChiTietList) {
            SanPhamChiTiet sanPhamChiTiet = doiTraChiTiet.getSanPhamChiTiet();

            sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() + doiTraChiTiet.getSoLuong());
            sanPhamChiTietRepo.save(sanPhamChiTiet);

            HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietRepo.findByHoaDonAndSanPhamChiTiet(hoaDon, sanPhamChiTiet);
            if (hoaDonChiTiet != null) {
                tongTienHoan -= doiTraChiTiet.getSoLuong() * hoaDonChiTiet.getGia_san_pham();
            }

            diemHoan += (doiTraChiTiet.getSoLuong() * sanPhamChiTiet.getGiaBan()) / 10000;
        }


        hoaDon.setTongTien(tongTienHoan);
        hoaDon.setTinh_trang(13);
        hoaDonRepo.save(hoaDon);

        KhachHang khachHang = hoaDon.getKhachHang();
        if (khachHang.getDiemTichLuy() >= diemHoan) {
            khachHang.setDiemTichLuy(khachHang.getDiemTichLuy() - diemHoan);
            khachHangRepo.save(khachHang);
        } else {
            redirectAttributes.addFlashAttribute("error", "Khách hàng không có đủ điểm tích lũy để hoàn trả!");
            return "redirect:/hoa-don/detail/" + id;
        }

        List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepo.findByHoaDonId(id);
        for (HoaDonChiTiet hoaDonChiTiet : hoaDonChiTietList) {
            for (DoiTraChiTiet doiTraChiTiet : doiTraChiTietList) {
                if (hoaDonChiTiet.getSanPhamChiTiet().equals(doiTraChiTiet.getSanPhamChiTiet())) {
                    int newSoLuong = hoaDonChiTiet.getSo_luong() - doiTraChiTiet.getSoLuong();
                    hoaDonChiTiet.setSo_luong(newSoLuong);
                    hoaDonChiTietRepo.save(hoaDonChiTiet);

                    if (newSoLuong <= 0) {
                        hoaDonChiTietRepo.delete(hoaDonChiTiet);
                    }
                }
            }
        }

        ThoiGianDonHang thoiGianDonHang = thoiGianDonHangRepo.findByHoaDon_Id(id);
        thoiGianDonHang.setDaHoanTra(LocalDateTime.now());
        thoiGianDonHangRepo.save(thoiGianDonHang);

        redirectAttributes.addFlashAttribute("message", "Hoàn hàng thành công và điểm tích lũy đã được trừ!");
        return "redirect:/hoa-don/detail/" + id;
    }

    @PostMapping("/xac-nhan-hoa-don/{id}")
    public String xacNhanHoaDon(
            @PathVariable("id") Integer hoaDonId,
            Model model) {

        Optional<HoaDon> optionalHoaDon = hoaDonRepo.findById(hoaDonId);
        if (!optionalHoaDon.isPresent()) {
            model.addAttribute("errorMessage", "Hóa đơn không tồn tại.");
            return "redirect:/danh-sach-hoa-don";
        }

        HoaDon hoaDon = optionalHoaDon.get();
        hoaDon.setTinh_trang(1);

        ThoiGianDonHang thoiGianDonHang = thoiGianDonHangRepo.findByHoaDon_Id(hoaDonId);
        if (thoiGianDonHang == null) {
            model.addAttribute("errorMessage", "Không tìm thấy thời gian cho hóa đơn này.");
            return "redirect:/hoa-don/detail/" + hoaDonId; // Quay lại trang chi tiết hóa đơn nếu không có thời gian
        }

        thoiGianDonHang.setThoiGianXacNhan(LocalDateTime.now());
        thoiGianDonHangRepo.save(thoiGianDonHang);
        hoaDonRepo.save(hoaDon);

        model.addAttribute("successMessage", "Hóa đơn đã được xác nhận thành công.");
        return "redirect:/hoa-don/detail/" + hoaDon.getId();
    }

    @PostMapping("/ban-giao-van-chuyen/{id}")
    public String banGiaoVanChuyen(
            @PathVariable("id") Integer hoaDonId,
            Model model) {

        Optional<HoaDon> optionalHoaDon = hoaDonRepo.findById(hoaDonId);
        if (!optionalHoaDon.isPresent()) {
            model.addAttribute("errorMessage", "Hóa đơn không tồn tại.");
            return "redirect:/danh-sach-hoa-don";
        }

        HoaDon hoaDon = optionalHoaDon.get();

        hoaDon.setTinh_trang(2);

        ThoiGianDonHang thoiGianDonHang = thoiGianDonHangRepo.findByHoaDon_Id(hoaDonId);
        if (thoiGianDonHang == null) {
            model.addAttribute("errorMessage", "Không tìm thấy thời gian cho hóa đơn này.");
            return "redirect:/hoa-don/detail/" + hoaDonId;
        }

        thoiGianDonHang.setBanGiaoVanChuyen(LocalDateTime.now());

        thoiGianDonHangRepo.save(thoiGianDonHang);

        hoaDonRepo.save(hoaDon);

        model.addAttribute("successMessage", "Hóa đơn đã được bàn giao vận chuyển thành công.");

        return "redirect:/hoa-don/detail/" + hoaDon.getId();
    }



    @PostMapping("/hoan-thanh/{id}")
    public String hoanThanh(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {

        HoaDon hoaDon = hoaDonRepo.findById(id).orElse(null);
        if (hoaDon == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy hóa đơn!");
            return "redirect:/hoa-don/detail/" + id;
        }

        List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepo.findByHoaDonId(id);
        int tongTienSanPham = 0;
        for (HoaDonChiTiet hoaDonChiTiet : hoaDonChiTietList) {
            if (hoaDonChiTiet.getSanPhamChiTiet() != null) {
                tongTienSanPham += hoaDonChiTiet.getSanPhamChiTiet().getGiaBan() * hoaDonChiTiet.getSo_luong();
            }
        }

        hoaDon.setTinh_trang(4);

        int diem = tongTienSanPham / 10000;

        KhachHang khachHang = hoaDon.getKhachHang();
        if (khachHang != null) {
            khachHang = khachHangRepo.findById(khachHang.getIdKhachHang()).orElse(khachHang);

            int diemTichLuy = (khachHang.getDiemTichLuy() != null) ? khachHang.getDiemTichLuy() : 0;
            khachHang.setDiemTichLuy(diemTichLuy + diem);

            khachHangRepo.save(khachHang);
        }

        ThoiGianDonHang thoiGianDonHang = thoiGianDonHangRepo.findByHoaDon_Id(id);
        if (thoiGianDonHang != null) {
            thoiGianDonHang.setHoanThanh(LocalDateTime.now());
            thoiGianDonHangRepo.save(thoiGianDonHang);
        }

        hoaDonRepo.save(hoaDon);

        redirectAttributes.addFlashAttribute("message", "Hóa đơn đã hoàn thành!" +
                (khachHang != null ? " Khách hàng đã nhận được điểm tích lũy." : " Hóa đơn không có thông tin khách hàng."));

        return "redirect:/hoa-don/detail/" + id;
    }

    @PostMapping("/xac-nhan-hoan-tra/{id}")
    public String xacNhanHoanTra(
            @PathVariable("id") Integer hoaDonId,
            Model model) {

        Optional<HoaDon> optionalHoaDon = hoaDonRepo.findById(hoaDonId);
        if (!optionalHoaDon.isPresent()) {
            model.addAttribute("errorMessage", "Hóa đơn không tồn tại.");
            return "redirect:/danh-sach-hoa-don";
        }

        HoaDon hoaDon = optionalHoaDon.get();

        hoaDon.setTinh_trang(12);

        ThoiGianDonHang thoiGianDonHang = thoiGianDonHangRepo.findByHoaDon_Id(hoaDonId);
        if (thoiGianDonHang == null) {
            model.addAttribute("errorMessage", "Không tìm thấy thời gian cho hóa đơn này.");
            return "redirect:/hoa-don/detail/" + hoaDonId;
        }

        thoiGianDonHang.setXacNhanHoanTra(LocalDateTime.now());

        thoiGianDonHangRepo.save(thoiGianDonHang);
        hoaDonRepo.save(hoaDon);

        model.addAttribute("successMessage", "Hóa đơn đã được xác nhận hoàn trả thành công.");

        return "redirect:/hoa-don/detail/" + hoaDon.getId();
    }


}