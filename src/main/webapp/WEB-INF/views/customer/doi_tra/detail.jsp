<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Hóa Đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .info-box {
            flex: 1;
            padding: 10px;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
<jsp:include page="../header_user.jsp"/>
<div class="container mb-3">
    <h2 class="text-center my-4">Chi Tiết Hóa Đơn</h2>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center">${errorMessage}</div>
    </c:if>

    <c:if test="${not empty hoaDon}">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Mã Hóa Đơn: ${hoaDon.so_hoa_don}</h5>
                <p>Ngày Tạo: ${hoaDon.ngay_tao}</p>

                <div class="info-row">
                    <div class="info-box">
                        <h6>Thông Tin Khách Hàng:</h6>
                        <p>Tên Khách Hàng: ${tenKhachHang}</p>
                        <p>Số Điện Thoại: ${hoaDon.soDienThoai}</p>
                        <p>Địa Chỉ: ${hoaDon.diaChi}</p>
                    </div>
                    <div class="info-box">
                        <h6>Thông Tin Đơn Hàng:</h6>
                        <p>Phương Thức Thanh Toán: <strong>${hoaDon.phuong_thuc_thanh_toan}</strong></p>
                        <p>Phương Thức Vận Chuyển: <strong>${hoaDon.phuongThucVanChuyen}</strong></p>
                        <p>Tiền Vận Chuyển: <strong>${tienVanChuyen} đ</strong></p>
                        <p>Tổng Tiền: <strong>${hoaDon.tong_tien} đ</strong></p>
                        <p>
                            Tình Trạng:
                            <c:choose>
                                <c:when test="${hoaDon.tinh_trang == 0}">
                                    <span class="order-status status-unpaid">Chưa Thanh Toán</span>
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 11}">
                                    <span class="order-status status-return-pending">Chờ Xác Nhận Đổi Trả</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="order-status status-paid">Đã Thanh Toán</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>

                <h6>Danh Sách Sản Phẩm:</h6>
                <ul class="list-group">
                    <c:forEach var="chiTiet" items="${hoaDon.hoaDonChiTietList}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                ${chiTiet.sanPhamChiTiet.sanPham.ten}
                            <span>Số Lượng: ${chiTiet.so_luong}</span>
                        </li>
                    </c:forEach>
                </ul>

                <!-- Nút Quay Lại và Đổi Trả -->
                <div class="mt-3">
                    <a href="/doi-tra" class="btn btn-warning">Quay Lại</a>
                    <a href="#" class="btn btn-success" onclick="showDoiTraPopup()">Đổi Trả</a>
                </div>
            </div>
        </div>
    </c:if>
</div>

<!-- Pop-up Đổi Trả -->
<div id="doiTraPopup" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5);">
    <div style="width: 400px; margin: 10% auto; background-color: white; padding: 20px; border-radius: 10px;">
        <h5>Lý Do Đổi Trả</h5>
        <form action="/doi-tra/ly-do-doi-tra" method="post">
            <div class="form-group mb-3">
                <label>Lý Do:</label><br>
                <input type="radio" name="lyDo" value="Sản phẩm lỗi" required onclick="toggleTextarea(false)"> Sản phẩm lỗi<br>
                <input type="radio" name="lyDo" value="Không đúng mô tả" onclick="toggleTextarea(false)"> Không đúng mô tả<br>
                <input type="radio" name="lyDo" value="Giao hàng trễ" onclick="toggleTextarea(false)"> Giao hàng trễ<br>
                <input type="radio" name="lyDo" value="Khác" onclick="toggleTextarea(true)"> Khác<br>
            </div>
            <div class="form-group mb-3" id="textareaContainer" style="display: none;">
                <label for="otherLyDo">Vui lòng nhập lý do:</label>
                <textarea class="form-control" name="otherLyDo" id="otherLyDo"></textarea>
            </div>
            <input type="hidden" name="hoaDonId" value="${hoaDon.id}" />
            <button type="submit" class="btn btn-primary">Gửi Yêu Cầu</button>
            <button type="button" class="btn btn-secondary" onclick="closeDoiTraPopup()">Hủy</button>
        </form>
    </div>
</div>

<jsp:include page="../footer_user.jsp"/>
<script>
    function showDoiTraPopup() {
        document.getElementById("doiTraPopup").style.display = "block";
    }

    function closeDoiTraPopup() {
        document.getElementById("doiTraPopup").style.display = "none";
    }

    function toggleTextarea(show) {
        document.getElementById("textareaContainer").style.display = show ? "block" : "none";
    }
</script>

</body>
</html>
