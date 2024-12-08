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
<div class="container my-5">
    <div class="row g-4">
        <!-- Phần thông tin đơn hàng -->
        <div class="col-lg-8">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white text-center">
                    <h2>Thông Tin Đơn Hàng</h2>
                </div>
                <div class="card-body">
                    <table class="table table-bordered table-striped text-center align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>Tên Sản Phẩm</th>
                            <th>Giá</th>
                            <th>Số Lượng</th>
                            <th>Tổng Tiền</th>
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
                    <h4 class="text-center mt-3">
                        Tổng Tiền Sản Phẩm: <span class="text-danger">${tongTienCuThe} đ</span>
                    </h4>
                    <h4 class="text-center">
                        Số Tiền Cần Trả: <span id="totalPrice" class="text-danger">${tongTienSauGiam} đ</span>
                    </h4>
                </div>
            </div>

            <!-- Phần thông tin khách hàng -->
            <div class="customer-info bg-light p-3 mt-4 rounded shadow-sm">
                <c:choose>
                    <c:when test="${not empty khachHang}">
                        <h5 class="text-center text-success mb-3">Thông Tin Khách Hàng</h5>
                        <ul class="list-group">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <strong>Rank (Hạng Bậc):</strong>
                                <span id="rank" class="text-primary">${rank}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <strong>Số Điểm Tích Lũy:</strong>
                                <span id="diemTichLuy" class="text-primary">${diemTichLuy}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <strong>Giá Trị Giảm Giá:</strong>
                                <span id="giamGia" class="text-primary">${phanTramGiam}%</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <strong>Số Tiền Được Giảm:</strong>
                                <span id="giamTien" class="text-primary">${giamGia} đ</span>
                            </li>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <div class="text-warning text-center fw-bold mt-3">
                            Hãy tạo tài khoản để chuẩn bị cho món quà dài hạn nào!
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Phần thông tin thanh toán -->
        <div class="col-lg-4">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white text-center">
                    <h2>Thông Tin Thanh Toán</h2>
                </div>
                <div class="card-body">
                    <form action="/gio-hang/xac-nhan-hoa-don" method="post">
                        <div class="mb-3">
                            <label for="phuongThucThanhToan" class="form-label fw-bold">Phương Thức Thanh Toán:</label>
                            <select class="form-select" id="phuongThucThanhToan" name="phuongThucThanhToan" required onchange="displayImage()">
                                <option value="Tiền mặt">Tiền mặt</option>
                                <option value="Chuyển khoản">Chuyển khoản</option>
                            </select>
                        </div>
                        <div id="imageContainer" class="text-center" style="display: none;">
                            <img id="myImage" src="../../../../images/QRLong.png" alt="Image of transfer method" class="img-thumbnail" style="max-width: 200px;">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Phương Thức Vận Chuyển:</label>
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
                            <label for="diaChi" class="form-label">Địa Chỉ Cụ Thể:</label>
                            <input type="text" class="form-control" id="diaChi" name="diaChi" required>
                        </div>
                        <div class="mb-3">
                            <label for="soDienThoai" class="form-label">Số Điện Thoại:</label>
                            <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai" pattern="[0-9]{10}" required>
                        </div>
                        <c:if test="${empty khachHang}">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email:</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                                <small class="form-text text-muted">Nếu bạn không có tài khoản, vui lòng nhập email để nhận hóa đơn.</small>
                            </div>
                        </c:if>
                        <c:forEach var="item" items="${selectedItems}">
                            <input type="hidden" name="selectedItems" value="${item.sanPhamChiTiet.id}">
                        </c:forEach>
                        <button type="submit" class="btn btn-success w-100 mt-3">Xác Nhận Đơn Hàng</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../footer_user.jsp" />
<script>
    function updateTotal() {
        let basePrice = parseInt('${tongTien}');
        let discount = parseInt('${giamGia}');
        let shippingFee = document.querySelector('input[name="phuongThucVanChuyen"]:checked')
            ? (document.querySelector('input[name="phuongThucVanChuyen"]:checked').value === "Giao Hàng Nhanh" ? 33000 : 20000)
            : 0;
        let totalPrice = basePrice + shippingFee;
        let totalPriceAfterDiscount = (basePrice - discount) + shippingFee;
        document.getElementById('totalPrice').innerText = totalPriceAfterDiscount + ' đ';
        document.getElementById('giamTien').innerText = discount + ' đ';
        document.querySelector('h3.text-center span.text-danger').innerText = totalPrice + ' đ';
    }


    function displayImage() {
        var paymentMethod = document.getElementById("phuongThucThanhToan").value;
        var imageContainer = document.getElementById("imageContainer");

        // Nếu chọn "Chuyển khoản", hiển thị hình ảnh
        if (paymentMethod === "Chuyển khoản") {
            imageContainer.style.display = "block";
        } else {
            imageContainer.style.display = "none";
        }
    }
</script>

</body>
</html>