<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<jsp:include page="../header_user.jsp" />
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <h1 class="text-center mb-4">Thông tin đơn hàng</h1>
            <table class="table table-bordered table-striped">
                <thead class="table-light">
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Tổng tiền</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${selectedItems}">
                    <tr>
                        <td>${item.sanPhamChiTiet.sanPham.ten}</td>
                        <td>${item.giaBan} đ</td>
                        <td>${item.soLuong}</td>
                        <td>${item.soLuong * item.giaBan} đ</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <h3 class="text-center">Tổng tiền: <span id="totalPrice" class="text-danger">${tongTien} đ</span></h3>
        </div>
        <div class="col-md-4">
            <h2 class="text-center mb-4">Thông tin thanh toán</h2>
            <form action="/gio-hang/xac-nhan-hoa-don" method="post">
                <div class="mb-3">
                    <label for="phuongThucThanhToan" class="form-label">Phương thức thanh toán:</label>
                    <select class="form-select" id="phuongThucThanhToan" name="phuongThucThanhToan" required>
                        <option value="Tiền mặt">Tiền mặt</option>
                        <option value="Chuyển khoản">Chuyển khoản</option>
                        <option value="Thẻ tín dụng">Thẻ tín dụng</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Phương thức vận chuyển:</label>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="phuongThucVanChuyen" id="giaoHangNhanh" value="Giao Hàng Nhanh" required onchange="updateTotal()">
                        <label class="form-check-label" for="giaoHangNhanh">Giao Hàng Nhanh</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="phuongThucVanChuyen" id="giaoHangTieuChuan" value="Giao Hàng Tiêu Chuẩn" onchange="updateTotal()">
                        <label class="form-check-label" for="giaoHangTieuChuan">Giao Hàng Tiêu Chuẩn</label>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="diaChi" class="form-label">Địa chỉ cụ thể:</label>
                    <input type="text" class="form-control" id="diaChi" name="diaChi" required>
                </div>
                <div class="mb-3">
                    <label for="soDienThoai" class="form-label">Số điện thoại:</label>
                    <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai" pattern="[0-9]{10}" required>
                </div>
                <c:if test="${empty khachHang}">
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                        <small class="form-text text-muted">Nếu bạn không có tài khoản, vui lòng nhập email để nhận hóa đơn.</small>
                    </div>
                </c:if>
                <c:forEach var="item" items="${selectedItems}">
                    <input type="hidden" name="selectedItems" value="${item.sanPhamChiTiet.id}">
                </c:forEach>

                <button type="submit" class="btn btn-success w-100">Xác nhận đơn hàng</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="../footer_user.jsp" />
<script>
    // Hàm cập nhật tổng tiền
    function updateTotal() {
        // Lấy tổng tiền ban đầu
        let totalPrice = parseInt('${tongTien}');
        // Lấy giá trị phí vận chuyển
        let shippingFee = document.querySelector('input[name="phuongThucVanChuyen"]:checked') ? (document.querySelector('input[name="phuongThucVanChuyen"]:checked').value === "Giao Hàng Nhanh" ? 33000 : 20000) : 0;
        // Cập nhật tổng tiền
        let finalTotal = totalPrice + shippingFee;
        // Hiển thị tổng tiền mới
        document.getElementById('totalPrice').innerText = finalTotal + ' đ';
    }
</script>
</body>
</html>