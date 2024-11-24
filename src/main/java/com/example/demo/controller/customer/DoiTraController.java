package com.example.demo.controller.customer;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
            List<DoiTraChiTiet> doiTraChiTietList = doiTraChiTietRepo.findByDoiTra_HoaDon_Id(id);
            model.addAttribute("doiTraChiTiets", doiTraChiTietList);
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
                    // Sử dụng giaSanPham của HoaDonChiTiet thay vì giaBan của SanPhamChiTiet
                    HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietList.stream()
                            .filter(ct -> ct.getSanPhamChiTiet().getId().equals(id))
                            .findFirst().orElse(null);
                    if (hoaDonChiTiet != null) {
                        tongTienHoan += hoaDonChiTiet.getGia_san_pham() * soLuongHoan;
                    }
                }
            }

            // Xác định hình thức hoàn trả
            boolean isHoanToan = true; // Ban đầu giả định là hoàn toàn phần
            boolean coHoanMotPhan = false; // Biến kiểm tra có hoàn một phần hay không

            for (HoaDonChiTiet chiTiet : hoaDonChiTietList) {
                Integer sanPhamChiTietId = chiTiet.getSanPhamChiTiet().getId();
                Integer soLuongDaMua = chiTiet.getSo_luong();
                Integer soLuongHoan = soLuongMap.get(sanPhamChiTietId);

                if (soLuongHoan != null && soLuongHoan > 0) {
                    if (soLuongHoan < soLuongDaMua) {
                        // Có ít nhất một sản phẩm chỉ hoàn một phần số lượng
                        coHoanMotPhan = true;
                    }
                } else {
                    // Có sản phẩm không được hoàn trả, không phải hoàn toàn phần
                    isHoanToan = false;
                }
            }

            String hinhThucHoan;
            if (coHoanMotPhan || !isHoanToan) {
                hinhThucHoan = "Hoàn một phần";
            } else {
                hinhThucHoan = "Hoàn toàn phần";
            }

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
                                @RequestParam Map<String, String> requestParams,
                                @RequestParam("phuongThucChuyenTien") String phuongThucChuyenTien,
                                @RequestParam("moTa") String moTa,
                                @RequestParam("uploadImage") MultipartFile uploadImage) {

        HoaDon hoaDon = hoaDonRepo.findById(hoaDonId).orElse(null);
        if (hoaDon != null) {
            // Xử lý upload ảnh chứng minh lỗi hàng hóa
            String fileName = null;
            if (!uploadImage.isEmpty()) {
                try {
                    // Đường dẫn tương đối đến thư mục images
                    String relativeFolder = "src/main/webapp/uploads/";

                    // Tạo thư mục nếu chưa tồn tại
                    Path folderPath = Paths.get(relativeFolder).toAbsolutePath();
                    if (!Files.exists(folderPath)) {
                        Files.createDirectories(folderPath);
                    }

                    // Tạo tên file duy nhất với timestamp
                    fileName = System.currentTimeMillis() + "_" + uploadImage.getOriginalFilename();
                    Path filePath = folderPath.resolve(fileName);

                    // Lưu file vào thư mục
                    Files.write(filePath, uploadImage.getBytes());
                } catch (IOException e) {
                    e.printStackTrace();
                    return "customer/doi_tra/error";
                }
            }

            // Tạo đối tượng DoiTra
            DoiTra doiTra = new DoiTra();
            doiTra.setHoaDon(hoaDon);
            doiTra.setLyDoCuThe(lyDoDetail);
            doiTra.setHinhThuc(hinhThucHoan);
            doiTra.setTienHoan(tongTienHoan);
            doiTra.setPhuongThucChuyenTien(phuongThucChuyenTien);
            doiTra.setMoTa(moTa);
            doiTra.setHinhAnh(fileName); // Lưu tên file ảnh vào database
            doiTra.setNgayYeuCau(new Date());
            doiTra.setTinhTrang(11);
            doiTraRepo.save(doiTra);

            // Lấy danh sách HoaDonChiTiet để sử dụng giaSanPham
            List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepo.findByHoaDon(hoaDon);

            // Lưu từng chi tiết đổi trả
            for (Integer sanPhamChiTietId : sanPhamChiTietIds) {
                SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamChiTietId).orElse(null);
                if (sanPhamChiTiet != null) {
                    Integer soLuongHoan = Integer.valueOf(requestParams.get("soLuong_" + sanPhamChiTietId));

                    // Tìm HoaDonChiTiet tương ứng với sanPhamChiTietId
                    HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietList.stream()
                            .filter(chiTiet -> chiTiet.getSanPhamChiTiet().getId().equals(sanPhamChiTietId))
                            .findFirst().orElse(null);

                    if (hoaDonChiTiet != null) {
                        // Tạo đối tượng DoiTraChiTiet với giaSanPham từ HoaDonChiTiet
                        DoiTraChiTiet doiTraChiTiet = new DoiTraChiTiet();
                        doiTraChiTiet.setDoiTra(doiTra);
                        doiTraChiTiet.setSanPhamChiTiet(sanPhamChiTiet);
                        doiTraChiTiet.setGiaSanPham(hoaDonChiTiet.getGia_san_pham()); // Sử dụng giaSanPham từ HoaDonChiTiet
                        doiTraChiTiet.setSoLuong(soLuongHoan);
                        doiTraChiTietRepo.save(doiTraChiTiet);
                    }
                }
            }

            hoaDon.setTinh_trang(11);
            hoaDonRepo.save(hoaDon);

            return "redirect:/doi-tra";
        }

        return "customer/doi_tra/error";
    }

    @PostMapping("/huy-don/{id}")
    public String huyDon(@PathVariable("id") Integer id, Model model) {
        HoaDon hoaDon = hoaDonRepo.findById(id).orElse(null);
        if (hoaDon != null) {
            List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepo.findByHoaDon(hoaDon);

            for (HoaDonChiTiet hoaDonChiTiet : hoaDonChiTietList) {
                SanPhamChiTiet sanPhamChiTiet = hoaDonChiTiet.getSanPhamChiTiet();
                int soLuongHoan = hoaDonChiTiet.getSo_luong();

                sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() + soLuongHoan);
                sanPhamChiTietRepo.save(sanPhamChiTiet);
            }

            hoaDon.setTinh_trang(14);  // Cập nhật trạng thái đơn hàng
            hoaDonRepo.save(hoaDon);

            model.addAttribute("message", "Đơn hàng đã được hủy thành công và sản phẩm đã được hoàn lại.");
            return "redirect:/doi-tra/chi-tiet?id=" + id;
        }

        model.addAttribute("errorMessage", "Không tìm thấy hóa đơn.");
        return "customer/doi_tra/error";
    }

}