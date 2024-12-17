<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
    .custom-modal {
        background-color: #ffffff;
        border-radius: 10px;
        border: 2px solid #0b745e;
    }


    .custom-modal .modal-header {
        background-color: #0b745e;
        color: #ffffff;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
    }

    .custom-modal .btn-success {
        background-color: #0b745e;
        border-color: #0b745e;
        transition: background-color 0.3s ease;
    }

    .custom-modal .btn-success:hover {
        background-color: #085f3b;
    }

    .custom-modal .btn-outline-danger {
        border-color: #e74c3c;
        color: #e74c3c;
        transition: border-color 0.3s, color 0.3s;
    }

    .custom-modal .btn-outline-danger:hover {
        background-color: #e74c3c;
        color: #ffffff;
        border-color: #e74c3c;
    }

    .custom-modal .modal-body {
        font-size: 1.1rem;
        padding: 20px;
        color: #555;
    }
</style>
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
                                <td><fmt:formatNumber value="${item.giaBan}" type="number" pattern="#,###" /> đ</td>
                                <td>${item.soLuong}</td>
                                <td><fmt:formatNumber value="${item.soLuong * item.giaBan}" type="number" pattern="#,###" /> đ</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <h4 class="text-center mt-3">
                        Tổng Tiền Sản Phẩm: <span class="text-danger"><fmt:formatNumber value="${tongTienCuThe}" type="number" pattern="#,###" /> đ</span>
                    </h4>
                    <h4 class="text-center">
                        Số Tiền Cần Trả: <span id="totalPrice" class="text-danger"><fmt:formatNumber value="${tongTienSauGiam}" type="number" pattern="#,###" /> đ</span>
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
                    <form id="orderForm" action="/gio-hang/xac-nhan-hoa-don" method="post">
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
                            <input type="text" class="form-control" id="diaChi" name="diaChi" value="${khachHang != null ? khachHang.diaChi : ''}" required>
                        </div>
                        <div class="mb-3">
                            <label for="soDienThoai" class="form-label">Số Điện Thoại:</label>
                            <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai" pattern="[0-9]{10}" value="${khachHang != null ? khachHang.soDienThoai : ''}" required>
                        </div>
                        <c:if test="${empty khachHang}">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email:</label>
                                <input type="email" class="form-control" id="email" name="email" value="${khachHang != null ? khachHang.email : ''}">
                                <small class="form-text text-muted">Nếu bạn không có tài khoản, vui lòng nhập email để nhận hóa đơn.</small>
                            </div>
                        </c:if>
                        <c:forEach var="item" items="${selectedItems}">
                            <input type="hidden" name="selectedItems" value="${item.sanPhamChiTiet.id}">
                        </c:forEach>
                        <button type="button" class="btn btn-success w-100 mt-3" data-bs-toggle="modal" data-bs-target="#confirmModal">
                            Xác Nhận Đơn Hàng
                        </button>
                        <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true" data-bs-backdrop="false">
                            <div class="modal-dialog">
                                <div class="modal-content custom-modal">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="confirmModalLabel">Xác Nhận Đơn Hàng</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        Bạn có chắc chắn các thông tin đúng và hoàn tất xác nhận đơn hàng?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Hủy</button>
                                        <button type="submit" class="btn btn-success" form="orderForm">Xác Nhận</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../footer_user.jsp" />
<script>
    function formatCurrency(value) {
        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value).replace("₫", "đ");
    }

    function updateTotal() {
        let basePrice = parseInt('${tongTien}');
        let discount = parseInt('${giamGia}');
        let shippingFee = document.querySelector('input[name="phuongThucVanChuyen"]:checked')
            ? (document.querySelector('input[name="phuongThucVanChuyen"]:checked').value === "Giao Hàng Nhanh" ? 33000 : 20000)
            : 0;

        let totalPrice = basePrice + shippingFee;
        let totalPriceAfterDiscount = (basePrice - discount) + shippingFee;

        document.getElementById('totalPrice').innerText = formatCurrency(totalPriceAfterDiscount);
        document.getElementById('giamTien').innerText = formatCurrency(discount);
        document.querySelector('h3.text-center span.text-danger').innerText = formatCurrency(totalPrice);
    }

    function displayImage() {
        var paymentMethod = document.getElementById("phuongThucThanhToan").value;
        var imageContainer = document.getElementById("imageContainer");
        if (paymentMethod === "Chuyển khoản") {
            imageContainer.style.display = "block";
        } else {
            imageContainer.style.display = "none";
        }
    }
</script>

</body>
</html>