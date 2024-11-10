package com.example.demo.controller.admin;

import com.example.demo.entity.DoiTra;
import com.example.demo.entity.HoaDon;
import com.example.demo.entity.HoaDonChiTiet;
import com.example.demo.entity.NhaCungCap;
import com.example.demo.entity.NhapHang;
import com.example.demo.entity.NhapHangChiTiet;
import com.example.demo.entity.SanPham;
import com.example.demo.entity.SanPhamChiTiet;
import com.example.demo.repository.NhaCungCapRepo;
import com.example.demo.repository.NhapHangChiTietRepo;
import com.example.demo.repository.NhapHangRepo;
import com.example.demo.repository.SanPhamChiTietRepo;
import com.example.demo.repository.SanPhamRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

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

        // Lấy danh sách sản phẩm chi tiết phân trang
        Page<SanPhamChiTiet> sanPhamChiTietPage = sanPhamChiTietRepo.findAll(pageable);

        // Lấy các thông tin cần thiết để truyền vào model
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
                        @RequestParam(name = "sanPhamId", required = false) Integer sanPhamId,
                        @RequestParam(name = "tenNhanVien", required = false) String tenNhanVien,
                        @RequestParam(name = "ngayTao", required = false) String ngayTao,
                        Model model) {

        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<NhapHangChiTiet> page;

        try {
            // Tìm kiếm theo ngày tạo nếu có
            if (ngayTao != null && !ngayTao.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date date = sdf.parse(ngayTao);
                page = nhapHangChiTietRepo.findByNhapHang_NgayTaoEquals(date, pageable);
            }
            // Tìm kiếm theo tên nhân viên nếu có
            else if (tenNhanVien != null && !tenNhanVien.isEmpty()) {
                page = nhapHangChiTietRepo.findByNhapHang_NhanVien_TenNhanVienContainingIgnoreCase(tenNhanVien, pageable);
            }
            // Tìm kiếm theo sanPhamId nếu có
            else if (sanPhamId != null) {
                page = nhapHangChiTietRepo.findBySanPhamId(sanPhamId, pageable);
            }
            // Nếu không có tham số nào, tìm tất cả
            else {
                page = nhapHangChiTietRepo.findAll(pageable);
            }
        } catch (ParseException e) {
            model.addAttribute("error", "Ngày tạo không hợp lệ.");
            return "admin/ql_nhap_hang/index";
        }

        List<SanPham> sanPhamList = sanPhamRepo.findAll();

        model.addAttribute("data", page);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("sanPhamList", sanPhamList);
        model.addAttribute("sanPhamId", sanPhamId);

        return "admin/ql_nhap_hang/index";
    }



    @PostMapping("/add")
    public String addNhapHang(@RequestParam Map<String, String> formData, @RequestParam(value = "selectedItems", required = false) List<String> selectedItems) {
        // Debug: Kiểm tra formData và selectedItems
        formData.forEach((key, value) -> System.out.println(key + ": " + value));
        if (selectedItems != null) {
            selectedItems.forEach(itemId -> System.out.println("Selected Product ID: " + itemId));
        }

        // Tạo đối tượng NhapHang
        NhapHang nhapHang = new NhapHang();
        nhapHang.setMaPhieuNhap(generateMaPhieuNhap());
        nhapHang.setNgayNhap(new Date());
        nhapHang.setNgayTao(new Date());
        nhapHang.setTinhTrang(0); // Tình trạng mặc định

        // Lấy giá trị ghi chú từ form
        String ghiChu = formData.get("ghiChu");
        nhapHang.setGhiChu(ghiChu);  // Lưu ghi chú vào đối tượng nhapHang (nếu có)

        // Khởi tạo tổng giá trị
        int tongGiaTri = 0;

        // Khởi tạo nhà cung cấp từ sản phẩm đầu tiên (giả sử sản phẩm có cùng nhà cung cấp)
        NhaCungCap nhaCungCap = null;

        // Lưu phiếu nhập hàng
        nhapHang = repo.save(nhapHang);

        // Xử lý các chi tiết nhập hàng
        if (selectedItems != null) {
            for (String productIdStr : selectedItems) {
                Integer productId = Integer.valueOf(productIdStr);

                // Lấy giá nhập và số lượng từ form
                Integer giaNhap = Integer.valueOf(formData.get("giaNhap_" + productId));
                Integer soLuong = Integer.valueOf(formData.get("soLuong_" + productId));

                // Lấy sản phẩm và nhà cung cấp
                SanPham sanPham = sanPhamRepo.findById(productId).orElse(null);
                if (sanPham != null) {
                    if (nhaCungCap == null) {
                        nhaCungCap = sanPham.getNhaCungCap(); // Gán nhà cung cấp từ sản phẩm đầu tiên
                    }

                    // Tính tổng tiền cho từng sản phẩm
                    Integer tongTien = giaNhap * soLuong;

                    // Cộng tổng tiền vào tổng giá trị của phiếu nhập
                    tongGiaTri += tongTien;

                    // Lưu chi tiết nhập hàng
                    NhapHangChiTiet chiTiet = new NhapHangChiTiet();
                    chiTiet.setNhapHang(nhapHang);
                    chiTiet.setSanPham(sanPham);
                    chiTiet.setGiaNhap(giaNhap);
                    chiTiet.setSoLuong(soLuong);
                    chiTiet.setTongTien(tongTien);
                    chiTiet.setNgaySanXuat(new Date()); // Cập nhật ngày sản xuất nếu có
                    chiTiet.setHanSuDung(new Date()); // Cập nhật hạn sử dụng nếu có

                    nhapHangChiTietRepo.save(chiTiet); // Lưu chi tiết nhập hàng vào cơ sở dữ liệu
                }
            }
        }

        // Sau khi tính tổng giá trị, cập nhật vào phiếu nhập và nhà cung cấp
        nhapHang.setTongGiaTri(tongGiaTri); // Lưu tổng giá trị
        nhapHang.setNhaCungCap(nhaCungCap); // Lưu nhà cung cấp (nếu có)

        // Lưu lại phiếu nhập với tổng giá trị và nhà cung cấp
        repo.save(nhapHang);

        // Sau khi lưu tất cả các chi tiết, điều hướng đến trang hiển thị danh sách phiếu nhập
        return "redirect:/nhap-hang/hien-thi";
    }



    @GetMapping("/chi-tiet/{id}")
    public String chiTiet(@PathVariable("id") Integer id, Model model) {
        Optional<NhapHang> nhapHang1 = repo.findById(id);
        if (nhapHang1.isPresent()) {
            NhapHang nhapHang = nhapHang1.get();
            List<NhapHangChiTiet> nhapHangChiTiets = nhapHangChiTietRepo.findByNhapHangId(id);
            model.addAttribute("nhapHang", nhapHang);
            model.addAttribute("nhapHangChiTiets", nhapHangChiTiets);

            return "/admin/ql_nhap_hang/phieunhapchitiet";
        } else {
            model.addAttribute("error", "Phiếu nhập không tồn tại");
            return "/admin/ql_nhap_hang/index"; // Hoặc trang lỗi phù hợp
        }
    }
}
