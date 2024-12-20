<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt1" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hóa đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous">
</head>
<jsp:include page="../layout.jsp"/>
<body>
<div class="container mt-3">
    <div class="row">
        <div class="col-md-6">
            <p><strong>Tên khách hàng:</strong> ${empty hoaDon.khachHang.tenKhachHang ? "Khách vãng lai" : hoaDon.khachHang.tenKhachHang}</p>
            <p><strong>Số hóa đơn:</strong> ${hoaDon.soHoaDon}</p>
            <p><strong>Số điện thoại:</strong> ${empty hoaDon.khachHang.soDienThoai ? "Không" : hoaDon.khachHang.soDienThoai}</p>
            <p><strong>Địa chỉ:</strong> ${empty hoaDon.diaChi ? "Mua tại quầy" : hoaDon.diaChi}</p>
        </div>
        <div class="col-md-6">
            <p><strong>Ghi chú:</strong> ${empty hoaDon.ghiChu ? "Không" : hoaDon.ghiChu}</p>
            <p><strong>Phương thức vận chuyển:</strong> ${empty hoaDon.phuongThucVanChuyen ? "Không" : hoaDon.phuongThucVanChuyen}</p>
            <p><strong>Ngày tạo:</strong> <fmt1:formatDate value="${hoaDon.ngayTao}" pattern="dd/MM/yyyy" /></p>
            <p><strong>Phương thức thanh toán:</strong> ${hoaDon.phuong_thuc_thanh_toan}</p>
            <p><strong>Tình trạng:</strong> ${hoaDon.tinh_trang == 4 ? "Hoàn Thành" : (hoaDon.tinh_trang == 13 ? "Hoàn Thành" : "Đã Hủy")}</p>
        </div>
    </div>

    <h6>Chi tiết sản phẩm:</h6>
    <table class="table">
        <thead>
        <tr>
            <th>Tên Sản Phẩm</th>
            <th>Giá</th>
            <th>Số lượng</th>
        </tr>
        </thead>
        <tbody>
        <c:set var="tongTien" value="0"/>
        <c:forEach items="${hoaDonChiTiets}" var="item">
            <tr>
                <td>${item.sanPhamChiTiet.sanPham.ten}</td>
                <td><fmt:formatNumber value="${item.sanPhamChiTiet.giaBan}" type="number" pattern="#,###" /> VNĐ</td>
                <td>${item.so_luong}</td>
            </tr>
            <c:set var="tongTien" value="${tongTien + (item.so_luong * item.sanPhamChiTiet.giaBan)}"/>
        </c:forEach>
        </tbody>
    </table>

    <p><strong>Tổng tiền:</strong> <fmt:formatNumber value="${tongTien}" type="number" pattern="#,###" /> VNĐ</p>
</div>
<div class="mt-3 text-center">
    <a href="/lich-su/hien-thi" class="btn btn-create">Quay lại</a>
</div>
</body>
</html>