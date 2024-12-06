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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
                        @RequestParam(name = "nhaCungCapId", required = false) Integer nhaCungCapId,
                        @RequestParam(name = "tenNhacungcap", required = false) String tenNhacungcap,
                        @RequestParam(name = "ngayTao", required = false) String ngayTao,
                        Model model) {

        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<NhapHang> page;

        try {
            // Tìm kiếm theo ngày tạo nếu có
            if (ngayTao != null && !ngayTao.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                Date date = sdf.parse(ngayTao);
                page = repo.findByNgayTaoEquals(date, pageable);
            }
            // Tìm kiếm theo tên nhân viên nếu có
            else if (tenNhacungcap != null && !tenNhacungcap.isEmpty()) {
                page = repo.findByNhanVien_TenNhanVienContainingIgnoreCase(tenNhacungcap, pageable);
            }
            // Tìm kiếm theo sanPhamId nếu có
            else if (nhaCungCapId != null) {
                page = repo.findByNhaCungCapId(nhaCungCapId, pageable);
            }
            // Nếu không có tham số nào, tìm tất cả
            else {
                page = repo.findAll(pageable);
            }
        } catch (ParseException e) {
            model.addAttribute("error", "Ngày tạo không hợp lệ.");
            return "admin/ql_nhap_hang/index";
        }

        // Định dạng ngày nhập và ngày tạo trực tiếp trong controller
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

        // Tạo danh sách mới chứa các đối tượng với ngày đã định dạng
        List<Map<String, Object>> formattedList = page.getContent().stream().map(nhapHang -> {
            Map<String, Object> formattedNhapHang = new HashMap<>();

            // Chỉ định các thuộc tính của nhapHang vào map
            formattedNhapHang.put("id", nhapHang.getId());
            formattedNhapHang.put("maPhieuNhap", nhapHang.getMaPhieuNhap());
            formattedNhapHang.put("nhaCungCap", nhapHang.getNhaCungCap());
            formattedNhapHang.put("nhanVien", nhapHang.getNhanVien());
            formattedNhapHang.put("tongGiaTri", nhapHang.getTongGiaTri());
            formattedNhapHang.put("ghiChu", nhapHang.getGhiChu());
            formattedNhapHang.put("tinhTrang", nhapHang.getTinhTrang());

            // Định dạng ngày nhập và ngày tạo
            formattedNhapHang.put("ngayNhap", nhapHang.getNgayNhap() != null ? sdf.format(nhapHang.getNgayNhap()) : "");
            formattedNhapHang.put("ngayTao", nhapHang.getNgayTao() != null ? sdf.format(nhapHang.getNgayTao()) : "");

            return formattedNhapHang;
        }).collect(Collectors.toList());

        // Thêm danh sách đã định dạng vào model dưới dạng Page
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
            HttpSession session
    ) {
        // Lấy thông tin nhân viên từ session
        NhanVien nhanVien = (NhanVien) session.getAttribute("khachHang");

        if (nhanVien == null) {
            // Trường hợp không tìm thấy nhân viên trong session, chuyển hướng về trang đăng nhập
            return "redirect:/login";
        }

        // Debug: kiểm tra thông tin nhân viên
        System.out.println("Tên nhân viên: " + nhanVien.getTenNhanVien());

        // Nhóm sản phẩm theo nhà cung cấp
        Map<NhaCungCap, List<String>> productsBySupplier = new HashMap<>();
        for (String productIdStr : selectedItems) {
            Integer productId = Integer.valueOf(productIdStr);
            SanPham sanPham = sanPhamRepo.findById(productId).orElse(null);
            if (sanPham != null) {
                NhaCungCap nhaCungCap = sanPham.getNhaCungCap();
                productsBySupplier.computeIfAbsent(nhaCungCap, k -> new ArrayList<>()).add(productIdStr);
            }
        }

        // Xử lý từng nhóm sản phẩm theo nhà cung cấp
        for (Map.Entry<NhaCungCap, List<String>> entry : productsBySupplier.entrySet()) {
            NhaCungCap nhaCungCap = entry.getKey();
            List<String> productIds = entry.getValue();

            // Tạo đối tượng NhapHang cho từng nhóm sản phẩm
            NhapHang nhapHang = new NhapHang();
            nhapHang.setMaPhieuNhap(generateMaPhieuNhap());
            nhapHang.setNgayTao(new Date());
            nhapHang.setTinhTrang(0); // Tình trạng mặc định
            nhapHang.setNhaCungCap(nhaCungCap); // Gán nhà cung cấp cho phiếu nhập
            nhapHang.setNhanVien(nhanVien); // Gán nhân viên thực hiện nhập hàng

            // Lấy giá trị ghi chú từ form
            String ghiChu = formData.get("ghiChu");
            nhapHang.setGhiChu(ghiChu); // Lưu ghi chú vào đối tượng nhapHang (nếu có)

            // Khởi tạo tổng giá trị
            int tongGiaTri = 0;

            // Lưu phiếu nhập hàng
            nhapHang = repo.save(nhapHang);

            // Xử lý các chi tiết nhập hàng cho nhóm sản phẩm
            for (String productIdStr : productIds) {
                Integer productId = Integer.valueOf(productIdStr);

                // Lấy giá nhập và số lượng từ form
                String giaNhapStr = formData.get("giaNhap_" + productId); // Lấy giá nhập từ formData
                String soLuongStr = formData.get("soLuong_" + productId); // Lấy số lượng từ formData

                // Kiểm tra giá nhập và số lượng có hợp lệ hay không
                Integer giaNhap = (giaNhapStr != null && !giaNhapStr.isEmpty()) ? Integer.valueOf(giaNhapStr) : 0; // Nếu giá nhập là null hoặc rỗng, gán giá trị mặc định là 0
                Integer soLuong = (soLuongStr != null && !soLuongStr.isEmpty()) ? Integer.valueOf(soLuongStr) : 0; // Nếu số lượng là null hoặc rỗng, gán giá trị mặc định là 0

                // Lấy sản phẩm và nhà cung cấp
                SanPham sanPham = sanPhamRepo.findById(productId).orElse(null);
                if (sanPham != null) {
                    // Lấy giá nhập từ thẻ span (data-giaban)
                    Integer giaNhapFromSpan = sanPham.getGiaBan(); // Sử dụng giá bán từ sanPham

                    // Tính tổng tiền cho từng sản phẩm
                    Integer tongTien = giaNhapFromSpan * soLuong;

                    // Cộng tổng tiền vào tổng giá trị của phiếu nhập
                    tongGiaTri += tongTien;

                    // Lưu chi tiết nhập hàng
                    NhapHangChiTiet chiTiet = new NhapHangChiTiet();
                    chiTiet.setNhapHang(nhapHang);
                    chiTiet.setSanPham(sanPham);
                    chiTiet.setGiaNhap(giaNhapFromSpan); // Sử dụng giaNhapFromSpan đã lấy từ sản phẩm
                    chiTiet.setSoLuong(soLuong);
                    chiTiet.setTongTien(tongTien);
                    chiTiet.setNgaySanXuat(new Date()); // Cập nhật ngày sản xuất nếu có
                    chiTiet.setHanSuDung(new Date()); // Cập nhật hạn sử dụng nếu có

                    nhapHangChiTietRepo.save(chiTiet); // Lưu chi tiết nhập hàng vào cơ sở dữ liệu
                }
            }

            // Sau khi tính tổng giá trị, cập nhật vào phiếu nhập
            nhapHang.setTongGiaTri(tongGiaTri); // Lưu tổng giá trị

            // Lưu lại phiếu nhập với tổng giá trị và nhà cung cấp
            repo.save(nhapHang);
        }

        // Sau khi lưu tất cả các phiếu nhập, điều hướng đến trang hiển thị danh sách phiếu nhập
        return "redirect:/nhap-hang/hien-thi";
    }


    @GetMapping("/chi-tiet/{id}")
    public String chiTiet(@PathVariable("id") Integer id, Model model) {
        Optional<NhapHang> nhapHang1 = repo.findById(id);
        if (nhapHang1.isPresent()) {
            NhapHang nhapHang = nhapHang1.get();
            List<NhapHangChiTiet> nhapHangChiTiets = nhapHangChiTietRepo.findByNhapHangId(id);

            // Định dạng ngày nhập và ngày tạo
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

            // Định dạng ngày nhập và ngày tạo trước khi thêm vào model
            String formattedNgayNhap = nhapHang.getNgayNhap() != null ? sdf.format(nhapHang.getNgayNhap()) : "";
            String formattedNgayTao = nhapHang.getNgayTao() != null ? sdf.format(nhapHang.getNgayTao()) : "";

            // Thêm dữ liệu vào model
            model.addAttribute("nhapHang", nhapHang);
            model.addAttribute("nhapHangChiTiets", nhapHangChiTiets);
            model.addAttribute("formattedNgayNhap", formattedNgayNhap);
            model.addAttribute("formattedNgayTao", formattedNgayTao);

            return "/admin/ql_nhap_hang/phieunhapchitiet";
        } else {
            model.addAttribute("error", "Phiếu nhập không tồn tại");
            return "/admin/ql_nhap_hang/index"; // Hoặc trang lỗi phù hợp
        }
    }



    @PostMapping("/da-nhan-hang/{id}")
    public String daNhanHang(
            @PathVariable("id") Integer nhapHangId,
            RedirectAttributes redirectAttributes) {

        Optional<NhapHang> optionalNhapHang = repo.findById(nhapHangId);
        if (!optionalNhapHang.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Phiếu nhập không tồn tại!");
            return "redirect:/nhap-hang/hien-thi";
        }

        NhapHang nhapHang = optionalNhapHang.get();

        // Truy vấn danh sách các chi tiết nhập hàng cho phiếu nhập này
        List<NhapHangChiTiet> danhSachSanPham = nhapHangChiTietRepo.findByNhapHangId(nhapHangId);

        // Duyệt qua danh sách chi tiết nhập hàng để cập nhật số lượng tồn kho
        for (NhapHangChiTiet chiTiet : danhSachSanPham) {
            Optional<SanPhamChiTiet> optionalSanPhamChiTiet = sanPhamChiTietRepo.findById(chiTiet.getSanPham().getId());
            if (optionalSanPhamChiTiet.isPresent()) {
                SanPhamChiTiet sanPhamChiTiet = optionalSanPhamChiTiet.get();
                // Cập nhật số lượng tồn kho của sản phẩm
                sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() + chiTiet.getSoLuong());
                sanPhamChiTietRepo.save(sanPhamChiTiet); // Lưu lại sản phẩm đã cập nhật
            }
        }

        // Cập nhật trạng thái phiếu nhập và ngày nhập
        nhapHang.setTinhTrang(1);  // Đánh dấu phiếu nhập đã nhận hàng
        nhapHang.setNgayNhap(new Date());
        repo.save(nhapHang);

        // Thêm thông báo thành công
        redirectAttributes.addFlashAttribute("successMessage", "Hàng đã vào cửa hàng!");

        // Quay lại trang chi tiết phiếu nhập
        return "redirect:/nhap-hang/chi-tiet/" + nhapHangId;
    }

}
