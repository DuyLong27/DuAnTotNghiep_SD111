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
        <div class="col-md-8 mt-3 mb-3">
            <h1 class="text-center mb-4">Thông tin đơn hàng</h1>
            <table class="table table-striped text-center">
                <thead class="table-light">
                <tr>
                    <th></th>
                    <th>Tên sản phẩm</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Tổng tiền</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${selectedItems}">
                    <tr>
                        <td><img style="width: 90px" src="${pageContext.request.contextPath}/uploads/${item.sanPhamChiTiet.hinhAnh}"></td>
                        <td>${item.sanPhamChiTiet.sanPham.ten}</td>
                        <td>${item.giaBan} VNĐ</td>
                        <td>${item.soLuong}</td>
                        <td>${item.soLuong * item.giaBan} VNĐ</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <h3 class="d-flex justify-content-end">Tổng tiền: <span class="text-danger">${tongTien} VNĐ</span></h3>
        </div>
        <div class="col-md-4 mt-3 mb-3">
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
                        <input class="form-check-input" type="radio" name="phuongThucVanChuyen" id="giaoHangNhanh" value="Giao Hàng Nhanh" required>
                        <label class="form-check-label" for="giaoHangNhanh">Giao Hàng Nhanh</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="phuongThucVanChuyen" id="giaoHangTieuChuan" value="Giao Hàng Tiêu Chuẩn">
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

                <!-- Đoạn mã bạn cần -->
                <c:forEach var="item" items="${selectedItems}">
                    <input type="hidden" name="selectedItems" value="${item.sanPhamChiTiet.id}">
                </c:forEach>

                <button type="submit" class="btn btn-success w-100">Xác nhận đơn hàng</button>
            </form>

        </div>
    </div>
</div>
<jsp:include page="../footer_user.jsp" />
</body>
</html>