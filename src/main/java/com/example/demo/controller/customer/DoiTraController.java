package com.example.demo.controller.customer;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;

@Controller
@RequestMapping("doi-tra")
public class DoiTraController {
    @Autowired
    private DoiTraChiTietRepo doiTraChiTietRepo;
    @Autowired
    private DoiTraRepo doiTraRepo;
    @Autowired
    private KhachHangRepo khachHangRepo;

    @Autowired
    private SanPhamChiTietRepo sanPhamChiTietRepo;

    @Autowired
    private HoaDonChiTietRepo hoaDonChiTietRepo;

    @Autowired
    private HoaDonRepo hoaDonRepo;

    @GetMapping("")
    public String danhSachHoaDon(Model model, HttpSession session) {
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        if (khachHang != null) {
            List<HoaDon> hoaDonList = hoaDonRepo.findByKhachHang(khachHang);
            for (HoaDon hoaDon : hoaDonList) {
                hoaDon.setHoaDonChiTietList(hoaDonChiTietRepo.findByHoaDon(hoaDon));
            }
            model.addAttribute("hoaDonList", hoaDonList);
        } else {
            model.addAttribute("errorMessage", "Bạn cần đăng nhập để xem danh sách hóa đơn.");
        }
        return "customer/doi_tra/index";
    }

    @GetMapping("/chi-tiet")
    public String chiTietHoaDon(@RequestParam("id") Integer id, Model model) {
        HoaDon hoaDon = hoaDonRepo.findById(id).orElse(null);
        if (hoaDon != null) {
            hoaDon.setHoaDonChiTietList(hoaDonChiTietRepo.findByHoaDon(hoaDon));
            model.addAttribute("hoaDon", hoaDon);
            KhachHang khachHang = hoaDon.getKhachHang();
            model.addAttribute("tenKhachHang", khachHang.getTenKhachHang());
            model.addAttribute("sdtKhachHang", khachHang.getSoDienThoai());
            model.addAttribute("diaChiKhachHang", khachHang.getDiaChi());
            int tienVanChuyen = "Giao Hàng Nhanh".equals(hoaDon.getPhuongThucVanChuyen()) ? 33000 : 20000;
            model.addAttribute("tienVanChuyen", tienVanChuyen);
        } else {
            model.addAttribute("errorMessage", "Không tìm thấy hóa đơn.");
        }

        return "customer/doi_tra/detail";
    }

    @PostMapping("/luu-ly-do-doi-tra")
    public String luuLyDoDoiTra(@RequestParam("hoaDonId") Integer hoaDonId,
                                @RequestParam("lyDo") String lyDo,
                                Model model) {
        HoaDon hoaDon = hoaDonRepo.findById(hoaDonId).orElse(null);
        if (hoaDon != null) {
            hoaDon.setHoaDonChiTietList(hoaDonChiTietRepo.findByHoaDon(hoaDon));
            model.addAttribute("hoaDon", hoaDon);
            model.addAttribute("lyDo", lyDo);
            model.addAttribute("lyDoDetail", lyDo);
            return "customer/doi_tra/select";
        }
        model.addAttribute("errorMessage", "Không tìm thấy hóa đơn.");
        return "customer/doi_tra/detail";
    }

    @PostMapping("/luu-thong-tin")
    public String luuThongTin(@RequestParam("hoaDonId") Integer hoaDonId,
                              @RequestParam("lyDo") String lyDo,
                              @RequestParam("lyDoDetail") String lyDoDetail,
                              @RequestParam("sanPhamChiTietIds") List<Integer> sanPhamChiTietIds,
                              @RequestParam Map<String, String> requestParams,
                              Model model) {

        HoaDon hoaDon = hoaDonRepo.findById(hoaDonId).orElse(null);
        if (hoaDon != null) {
            List<SanPhamChiTiet> selectedProducts = new ArrayList<>();
            Map<Integer, Integer> soLuongMap = new HashMap<>();

            // Lấy danh sách sản phẩm chi tiết từ hóa đơn
            List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepo.findByHoaDon(hoaDon);

            // Map để lưu số lượng đã mua cho từng sản phẩm chi tiết
            Map<Integer, Integer> soLuongDaMuaMap = new HashMap<>();
            for (HoaDonChiTiet chiTiet : hoaDonChiTietList) {
                soLuongDaMuaMap.put(chiTiet.getSanPhamChiTiet().getId(), chiTiet.getSo_luong());
            }

            int tongTienHoan = 0; // Biến lưu tổng tiền hoàn
            for (Integer id : sanPhamChiTietIds) {
                Integer soLuongHoan = Integer.valueOf(requestParams.get("soLuong_" + id));
                SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(id).orElse(null);
                if (sanPhamChiTiet != null) {
                    selectedProducts.add(sanPhamChiTiet);
                    soLuongMap.put(id, soLuongHoan);
                    // Tính tiền hoàn
                    tongTienHoan += sanPhamChiTiet.getGiaBan() * soLuongHoan; // Giả sử bạn có thuộc tính giá trong SanPhamChiTiet
                }
            }

            // Xác định hình thức hoàn trả
            String hinhThucHoan;
            int totalSoLuongHoan = 0;
            for (Integer id : sanPhamChiTietIds) {
                totalSoLuongHoan += soLuongMap.get(id); // Tổng số lượng hoàn
            }

            // Kiểm tra xem có hoàn tất số lượng sản phẩm hay không
            boolean isHoanToan = true;
            for (Integer id : sanPhamChiTietIds) {
                if (soLuongDaMuaMap.get(id) != null && soLuongMap.get(id) != null) {
                    if (soLuongMap.get(id) < soLuongDaMuaMap.get(id)) {
                        isHoanToan = false;
                        break;
                    }
                }
            }
            hinhThucHoan = isHoanToan ? "Hoàn toàn phần" : "Hoàn một phần";
            model.addAttribute("hinhThucHoan", hinhThucHoan); // Thêm vào model
            model.addAttribute("tongTienHoan", tongTienHoan); // Thêm tổng tiền hoàn vào model
            model.addAttribute("hoaDon", hoaDon);
            model.addAttribute("hoaDonId", hoaDonId);
            model.addAttribute("lyDo", lyDo);
            model.addAttribute("lyDoDetail", lyDoDetail);
            model.addAttribute("sanPhamChiTietIds", sanPhamChiTietIds);
            model.addAttribute("selectedProducts", selectedProducts);
            model.addAttribute("soLuongMap", soLuongMap);

            return "customer/doi_tra/confirm";
        }

        model.addAttribute("errorMessage", "Không tìm thấy hóa đơn.");
        return "customer/doi_tra/detail";
    }

    @PostMapping("/xac-nhan")
    public String xacNhanDoiTra(@RequestParam("hoaDonId") Integer hoaDonId,
                                @RequestParam("lyDo") String lyDo,
                                @RequestParam("lyDoDetail") String lyDoDetail,
                                @RequestParam("tongTienHoan") int tongTienHoan,
                                @RequestParam("hinhThucHoan") String hinhThucHoan,
                                @RequestParam("sanPhamChiTietIds") List<Integer> sanPhamChiTietIds,
                                @RequestParam("phuongThucChuyenTien") String phuongThucChuyenTien,
                                @RequestParam("moTa") String moTa,
                                @RequestParam("uploadImage") MultipartFile uploadImage) {

        HoaDon hoaDon = hoaDonRepo.findById(hoaDonId).orElse(null);
        if (hoaDon != null) {
            DoiTra doiTra = new DoiTra();
            doiTra.setHoaDon(hoaDon);
            doiTra.setLyDoCuThe(lyDoDetail);
            doiTra.setHinhThuc(hinhThucHoan);
            doiTra.setTienHoan(tongTienHoan);
            doiTra.setPhuongThucChuyenTien(phuongThucChuyenTien);
            doiTra.setMoTa(moTa);
            doiTra.setHinhAnh(uploadImage.getOriginalFilename());
            doiTra.setNgayYeuCau(new Date());
            doiTra.setTinhTrang(11);
            doiTraRepo.save(doiTra);
            hoaDon.setTinh_trang(11);
            hoaDonRepo.save(hoaDon);
            for (Integer sanPhamChiTietId : sanPhamChiTietIds) {
                DoiTraChiTiet doiTraChiTiet = new DoiTraChiTiet();
                doiTraChiTiet.setDoiTra(doiTra);
                SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamChiTietId).orElse(null);
                if (sanPhamChiTiet != null) {
                    doiTraChiTiet.setSanPhamChiTiet(sanPhamChiTiet);
                    doiTraChiTiet.setGiaSanPham(sanPhamChiTiet.getGiaBan()); // Lấy giá sản phẩm
                    doiTraChiTiet.setSoLuong(1); // Giả sử số lượng là 1
                    doiTraChiTietRepo.save(doiTraChiTiet);
                }
            }

            // Chuyển hướng đến trang xác nhận thành công
            return "redirect:/doi-tra";
        }

        // Thông báo lỗi nếu không tìm thấy hóa đơn
        return "customer/doi_tra/error"; // Trang lỗi
    }






}