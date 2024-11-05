<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hóa đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
</head>
<jsp:include page="../layout.jsp" />
<body>
<div class="container mt-3">
    <p><strong>Tên khách hàng:</strong> ${hoaDon.idKhachHang.tenKhachHang}</p>
    <p><strong>Số hóa đơn:</strong> ${hoaDon.soHoaDon}</p>
    <p><strong>Số điện thoại:</strong> ${hoaDon.idKhachHang.soDienThoai}</p>
    <p><strong>Địa chỉ:</strong> ${hoaDon.diaChi}</p>
    <p><strong>Ghi chú:</strong> ${hoaDon.ghi_chu}</p>
    <p><strong>Phương thức vận chuyển:</strong> ${hoaDon.phuongThucVanChuyen}</p>
    <p><strong>Ngày tạo:</strong> ${hoaDon.ngayTao}</p>
    <p><strong>Phương thức thanh toán:</strong> ${hoaDon.phuong_thuc_thanh_toan}</p>
    <p><strong>Tình trạng:</strong> ${hoaDon.tinh_trang == 0 ? "Chờ xác nhận" : (hoaDon.tinh_trang == 1 ? "Chờ giao" : (hoaDon.tinh_trang == 2 ? "Hoàn thành" : (hoaDon.tinh_trang == 3 ? "Đã hủy" : "Hoàn một phần")))}</p>

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
        <c:set var="tongTien" value="0" />
        <c:forEach items="${hoaDonChiTiets}" var="item">
            <tr>
                <td>${item.sanPhamChiTiet.sanPham.ten}</td>
                <td>${item.sanPhamChiTiet.giaBan} VND</td>
                <td>${item.so_luong}</td>
            </tr>
            <c:set var="tongTien" value="${tongTien + (item.so_luong * item.sanPhamChiTiet.giaBan)}" />
        </c:forEach>
        </tbody>
    </table>

    <p><strong>Tổng tiền:</strong> ${tongTien} VND</p>
</div>
<div class="mt-3 text-center">
    <a href="/lich-su/hien-thi" class="btn btn-create">Quay lại</a>
</div>
</body>
</html>