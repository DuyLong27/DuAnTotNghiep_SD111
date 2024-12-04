package com.example.demo.controller.customer;

import com.example.demo.entity.*;
import com.example.demo.repository.*;
import com.example.demo.service.SanPhamChiTietService;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("doi-tra")
public class DoiTraController {
    @Autowired
    private DoiSanPhamRepo doiSanPhamRepo;
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

    @Autowired
    private ThoiGianDonHangRepo thoiGianDonHangRepo;

    @GetMapping("")
    public String danhSachHoaDon(Model model, HttpSession session) {
        KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
        if (khachHang != null) {
            List<HoaDon> hoaDonList = hoaDonRepo.findByKhachHang(khachHang);

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm , dd-MM-yyyy");

            for (HoaDon hoaDon : hoaDonList) {
                hoaDon.setHoaDonChiTietList(hoaDonChiTietRepo.findByHoaDon(hoaDon));
            }

            hoaDonList.sort(Comparator.comparing(
                    HoaDon::getThoiGianTao, Comparator.reverseOrder()
            ));

            model.addAttribute("hoaDonList", hoaDonList);

            Map<Integer, String> formattedThoiGianTaoMap = new HashMap<>();
            for (HoaDon hoaDon : hoaDonList) {
                LocalDateTime thoiGianTao = hoaDon.getThoiGianTao();
                if (thoiGianTao != null) {
                    formattedThoiGianTaoMap.put(hoaDon.getId(), thoiGianTao.format(formatter));
                }
            }
            model.addAttribute("thoiGianTaoMap", formattedThoiGianTaoMap);
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

            ThoiGianDonHang thoiGianDonHang = thoiGianDonHangRepo.findByHoaDon_Id(id);
            if (thoiGianDonHang != null) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm , dd-MM-yyyy");

                model.addAttribute("thoiGianTao", thoiGianDonHang.getThoiGianTao() != null ? thoiGianDonHang.getThoiGianTao().format(formatter) : "Chưa có thời gian tạo");
                model.addAttribute("thoiGianXacNhan", thoiGianDonHang.getThoiGianXacNhan() != null ? thoiGianDonHang.getThoiGianXacNhan().format(formatter) : "Chưa có thời gian xác nhận");
                model.addAttribute("banGiaoVanChuyen", thoiGianDonHang.getBanGiaoVanChuyen() != null ? thoiGianDonHang.getBanGiaoVanChuyen().format(formatter) : "Chưa có thời gian bàn giao vận chuyển");
                model.addAttribute("hoanThanh", thoiGianDonHang.getHoanThanh() != null ? thoiGianDonHang.getHoanThanh().format(formatter) : "Chưa có thời gian hoàn thành");
                model.addAttribute("hoanTra", thoiGianDonHang.getHoanTra() != null ? thoiGianDonHang.getHoanTra().format(formatter) : "Chưa có thời gian hoàn trả");
                model.addAttribute("xacNhanHoanTra", thoiGianDonHang.getXacNhanHoanTra() != null ? thoiGianDonHang.getXacNhanHoanTra().format(formatter) : "Chưa có thời gian xác nhận hoàn trả");
                model.addAttribute("daHoanTra", thoiGianDonHang.getDaHoanTra() != null ? thoiGianDonHang.getDaHoanTra().format(formatter) : "Chưa có thời gian đã hoàn trả");
                model.addAttribute("daHuy", thoiGianDonHang.getDaHuy() != null ? thoiGianDonHang.getDaHuy().format(formatter) : "Chưa có thời gian đã hủy");
                model.addAttribute("khongDoiTra", thoiGianDonHang.getKhongHoanTra() != null ? thoiGianDonHang.getKhongHoanTra().format(formatter) : "Chưa có thời gian không xác nhận");

                if (thoiGianDonHang.getBanGiaoVanChuyen() != null) {
                    LocalDateTime banGiaoVanChuyen = thoiGianDonHang.getBanGiaoVanChuyen();
                    int soNgayThem = "Giao Hàng Nhanh".equals(hoaDon.getPhuongThucVanChuyen()) ? 2 : 3;
                    LocalDateTime thoiGianDuKien = banGiaoVanChuyen.plusDays(soNgayThem);

                    DateTimeFormatter duKienFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                    model.addAttribute("thoiGianDuKien", thoiGianDuKien.format(duKienFormatter));
                } else {
                    model.addAttribute("thoiGianDuKien", "Chưa có thời gian xác nhận");
                }
            } else {
                model.addAttribute("thoiGianTao", "Không có thông tin thời gian.");
                model.addAttribute("thoiGianDuKien", "Không có thời gian dự kiến");
            }

            int tienVanChuyen = "Giao Hàng Nhanh".equals(hoaDon.getPhuongThucVanChuyen()) ? 33000 : 20000;
            model.addAttribute("tienVanChuyen", tienVanChuyen);

            List<DoiTraChiTiet> doiTraChiTietList = doiTraChiTietRepo.findByDoiTra_HoaDon_Id(id);
            model.addAttribute("doiTraChiTiets", doiTraChiTietList);
            DoiTra doiTra = doiTraRepo.findFirstByHoaDon_Id(id);
            model.addAttribute("doiTra", doiTra);
        } else {
            model.addAttribute("errorMessage", "Không tìm thấy hóa đơn.");
        }

        return "customer/doi_tra/detail";
    }


    @PostMapping("/luu-ly-do-doi-tra")
    public String luuLyDoDoi(@RequestParam("hoaDonId") Integer hoaDonId,
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
                                @RequestParam("uploadImage") MultipartFile uploadImage,
                                @RequestParam(value = "tenNganHang", required = false) String tenNganHang,
                                @RequestParam(value = "soNganHang", required = false) String soNganHang) {
        HoaDon hoaDon = hoaDonRepo.findById(hoaDonId).orElse(null);
        if (hoaDon != null) {
            String fileName = null;
            if (!uploadImage.isEmpty()) {
                try {
                    String relativeFolder = "src/main/webapp/uploads/";
                    Path folderPath = Paths.get(relativeFolder).toAbsolutePath();
                    if (!Files.exists(folderPath)) {
                        Files.createDirectories(folderPath);
                    }
                    fileName = System.currentTimeMillis() + "_" + uploadImage.getOriginalFilename();
                    Path filePath = folderPath.resolve(fileName);
                    Files.write(filePath, uploadImage.getBytes());
                } catch (IOException e) {
                    e.printStackTrace();
                    return "customer/doi_tra/error";
                }
            }
            DoiTra doiTra = new DoiTra();
            doiTra.setHoaDon(hoaDon);
            doiTra.setLyDoCuThe(lyDoDetail);
            doiTra.setHinhThuc(hinhThucHoan);
            doiTra.setTienHoan(tongTienHoan);
            doiTra.setPhuongThucChuyenTien(phuongThucChuyenTien);
            doiTra.setMoTa(moTa);
            doiTra.setHinhAnh(fileName);
            doiTra.setNgayYeuCau(new Date());
            doiTra.setLoaiDichVu(0);
            doiTra.setTinhTrang(11);
            if ("Chuyển khoản".equals(phuongThucChuyenTien)) {
                doiTra.setTenNganHang(tenNganHang);
                doiTra.setSoNganHang(soNganHang);
            }
            doiTraRepo.save(doiTra);
            List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepo.findByHoaDon(hoaDon);
            for (Integer sanPhamChiTietId : sanPhamChiTietIds) {
                SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamChiTietId).orElse(null);
                if (sanPhamChiTiet != null) {
                    Integer soLuongHoan = Integer.valueOf(requestParams.get("soLuong_" + sanPhamChiTietId));
                    HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietList.stream()
                            .filter(chiTiet -> chiTiet.getSanPhamChiTiet().getId().equals(sanPhamChiTietId))
                            .findFirst().orElse(null);
                    if (hoaDonChiTiet != null) {
                        DoiTraChiTiet doiTraChiTiet = new DoiTraChiTiet();
                        doiTraChiTiet.setDoiTra(doiTra);
                        doiTraChiTiet.setSanPhamChiTiet(sanPhamChiTiet);
                        doiTraChiTiet.setGiaSanPham(hoaDonChiTiet.getGia_san_pham());
                        doiTraChiTiet.setSoLuong(soLuongHoan);
                        doiTraChiTietRepo.save(doiTraChiTiet);
                    }
                }
            }
            ThoiGianDonHang thoiGianDonHang = thoiGianDonHangRepo.findByHoaDon(hoaDon);
            thoiGianDonHang.setHoanTra(LocalDateTime.now());
            thoiGianDonHangRepo.save(thoiGianDonHang);
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

            hoaDon.setTinh_trang(14);
            hoaDonRepo.save(hoaDon);

            ThoiGianDonHang thoiGianDonHang = thoiGianDonHangRepo.findByHoaDon_Id(id);
            thoiGianDonHang.setDaHuy(LocalDateTime.now());
            thoiGianDonHangRepo.save(thoiGianDonHang);

            model.addAttribute("message", "Đơn hàng đã được hủy thành công và sản phẩm đã được hoàn lại.");
            return "redirect:/doi-tra/chi-tiet?id=" + id;
        }

        model.addAttribute("errorMessage", "Không tìm thấy hóa đơn.");
        return "customer/doi_tra/error";
    }


    @PostMapping("/luu-thong-tin-doi-hang")
    public String luuThongTinDoiHang(@RequestParam("hoaDonId") Integer hoaDonId,
                                     @RequestParam("lyDo") String lyDo,
                                     @RequestParam("lyDoDetail") String lyDoDetail,
                                     @RequestParam("sanPhamChiTietIds") List<Integer> sanPhamChiTietIds,
                                     @RequestParam Map<String, String> requestParams,
                                     Model model) {

        HoaDon hoaDon = hoaDonRepo.findById(hoaDonId).orElse(null);

        List<SanPhamChiTiet> sanPhamChiTiets = sanPhamChiTietRepo.findAll();
        model.addAttribute("sanPhamChiTiets", sanPhamChiTiets);


        if (hoaDon != null) {
            List<SanPhamChiTiet> selectedProducts = new ArrayList<>();
            Map<Integer, Integer> soLuongMap = new HashMap<>();
            Map<Integer, Integer> giaSanPhamMap = new HashMap<>();

            // Lấy danh sách sản phẩm chi tiết từ hóa đơn
            List<HoaDonChiTiet> hoaDonChiTietList = hoaDonChiTietRepo.findByHoaDon(hoaDon);

            // Map để lưu số lượng đã mua cho từng sản phẩm chi tiết
            Map<Integer, Integer> soLuongDaMuaMap = new HashMap<>();
            Map<Integer, Integer> giaBanSanPhamDaMuaMap = new HashMap<>();
            for (HoaDonChiTiet chiTiet : hoaDonChiTietList) {
                soLuongDaMuaMap.put(chiTiet.getSanPhamChiTiet().getId(), chiTiet.getSo_luong());
                giaBanSanPhamDaMuaMap.put(chiTiet.getSanPhamChiTiet().getId(), chiTiet.getGia_san_pham());
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

            return "customer/doi_tra/doi_hang";
        }

        model.addAttribute("errorMessage", "Không tìm thấy hóa đơn.");
        return "customer/doi_tra/detail";
    }

    @PostMapping("/xac-nhan-doi-hang")
    @Transactional
    public String xacNhanDoiHang(
            @RequestParam("hoaDonId") Integer hoaDonId,
            @RequestParam("lyDo") String lyDo,
            @RequestParam("lyDoDetail") String lyDoDetail,
            @RequestParam("sanPhamChiTietIds") String sanPhamChiTietIdsStr,
            @RequestParam Map<String, String> requestParams,
            @RequestParam("moTa") String moTa,
            @RequestParam("uploadImage") MultipartFile uploadImage,
            Model model) {

        // Kiểm tra và lấy hóa đơn
        HoaDon hoaDon = hoaDonRepo.findById(hoaDonId).orElse(null);
        if (hoaDon == null) {
            model.addAttribute("error", "Hóa đơn không tồn tại.");
            return "customer/doi_tra/error";
        }

        // Chuyển đổi chuỗi ID sản phẩm thành danh sách
        List<Integer> sanPhamChiTietIds;
        try {
            sanPhamChiTietIds = Arrays.stream(sanPhamChiTietIdsStr.split(","))
                    .map(Integer::valueOf)
                    .collect(Collectors.toList());
        } catch (NumberFormatException e) {
            model.addAttribute("error", "Dữ liệu sản phẩm không hợp lệ.");
            return "customer/doi_tra/error";
        }

        // Xử lý file ảnh chứng minh
        String fileName = null;
        if (!uploadImage.isEmpty()) {
            try {
                String relativeFolder = "src/main/webapp/uploads/";
                Path folderPath = Paths.get(relativeFolder).toAbsolutePath();
                if (!Files.exists(folderPath)) {
                    Files.createDirectories(folderPath);
                }
                fileName = System.currentTimeMillis() + "_" + uploadImage.getOriginalFilename();
                Path filePath = folderPath.resolve(fileName);
                Files.write(filePath, uploadImage.getBytes());
            } catch (IOException e) {
                e.printStackTrace();
                model.addAttribute("error", "Không thể lưu ảnh.");
                return "customer/doi_tra/error";
            }
        }

        // Tạo đối tượng DoiTra
        DoiTra doiTra = new DoiTra();
        doiTra.setHoaDon(hoaDon);
        doiTra.setLyDoCuThe(lyDoDetail);
        doiTra.setMoTa(moTa);
        doiTra.setHinhAnh(fileName);
        doiTra.setNgayYeuCau(new Date());
        doiTra.setLoaiDichVu(1);
        doiTra.setTinhTrang(11); // Đổi hàng chờ xử lý
        doiTraRepo.save(doiTra);

        // Lưu thông tin đổi sản phẩm
        for (Integer sanPhamChiTietId : sanPhamChiTietIds) {
            SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepo.findById(sanPhamChiTietId).orElse(null);
            if (sanPhamChiTiet != null) {
                String soLuongStr = requestParams.get("soLuong_" + sanPhamChiTietId);
                Integer soLuong = soLuongStr != null ? Integer.valueOf(soLuongStr) : 1;  // Mặc định số lượng là 1

                // Kiểm tra số lượng hợp lệ
                if (soLuong > 0 && soLuong <= sanPhamChiTiet.getSoLuong()) {
                    DoiSanPham doiSanPham = new DoiSanPham();
                    doiSanPham.setDoiTra(doiTra);
                    doiSanPham.setSanPhamChiTiet(sanPhamChiTiet);
                    doiSanPham.setGiaSanPham(sanPhamChiTiet.getGiaBan());
                    doiSanPham.setSoLuong(soLuong);

                    // Cập nhật số lượng tồn kho của sản phẩm
                    sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() - soLuong);
                    sanPhamChiTietRepo.save(sanPhamChiTiet);

                    doiSanPhamRepo.save(doiSanPham);
                } else {
                    model.addAttribute("error", "Số lượng yêu cầu vượt quá số lượng tồn kho cho sản phẩm ID: " + sanPhamChiTietId);
                    return "customer/doi_tra/error";
                }
            }
        }

        // Cập nhật trạng thái hóa đơn
        hoaDon.setTinh_trang(11); // Trạng thái "Đổi hàng chờ xử lý"
        hoaDonRepo.save(hoaDon);

        return "redirect:/doi-tra";
    }



}