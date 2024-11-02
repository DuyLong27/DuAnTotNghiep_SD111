<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hóa đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha384-dyB3z1Vv3Pq9xJHqGZEXr2O6bUJ1FglF8fx7IDzW3a0BIcGoZsI6T3ez3/1p7byC" crossorigin="anonymous">
    <style>
        .order-status {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .status-item {
            text-align: center;
            color: #6c757d;
            font-size: 14px;
            flex: 1;
        }
        .status-item.active {
            color: #28a745;
            font-weight: bold;
        }
        .status-icon {
            font-size: 24px;
            display: block;
            margin-bottom: 5px;
        }
        .card-header {
            background-color: #0B745E !important;
            color: white;
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<jsp:include page="../layout.jsp" />
<body>
<div class="container mt-3">
    <div class="mt-3 mb-3">
        <a href="/ban-hang" class="btn btn-outline-success">Quay lại</a>
    </div>



    <!-- Phần trạng thái đơn hàng -->
    <div class="order-status">
        <div class="status-item ${hoaDon.tinh_trang >= 0 ? 'active' : ''}">
            <i class="fas fa-clock status-icon"></i>
            <p>Chờ xác nhận</p>
        </div>
        <div class="status-item ${hoaDon.tinh_trang >= 1 ? 'active' : ''}">
            <i class="fas fa-box status-icon"></i>
            <p>Chờ giao</p>
        </div>
        <div class="status-item ${hoaDon.tinh_trang >= 2 ? 'active' : ''}">
            <i class="fas fa-truck status-icon"></i>
            <p>Đang giao</p>
        </div>
        <div class="status-item ${hoaDon.tinh_trang >= 3 ? 'active' : ''}">
            <i class="fas fa-check-double status-icon"></i>
            <p>Xác nhận thanh toán</p>
        </div>
        <div class="status-item ${hoaDon.tinh_trang >= 4 ? 'active' : ''}">
            <i class="fas fa-check-circle status-icon"></i>
            <p>Hoàn thành</p>
        </div>
    </div>

    <div id="alertMessage" class="alert alert-warning d-none" role="alert"></div>

    <form action="/hoa-don/cap-nhat-tinh-trang" method="post">
        <input type="hidden" name="id" value="${hoaDon.id}" />

        <c:choose>
            <c:when test="${hoaDon.tinh_trang == 0}">
                <button type="submit" name="tinhTrangMoi" value="1" class="btn btn-primary">Xác nhận</button>
            </c:when>

            <c:when test="${hoaDon.tinh_trang == 1}">
                <button type="submit" name="tinhTrangMoi" value="2" class="btn btn-warning">Giao hàng</button>
            </c:when>

            <c:when test="${hoaDon.tinh_trang == 2 || hoaDon.tinh_trang == 3}">
                <button type="submit" name="tinhTrangMoi" value="4" class="btn btn-success"
                        onclick="return confirmCompletion(${hoaDon.tinh_trang});">Hoàn thành</button>
            </c:when>
        </c:choose>
    </form>

    <!-- Thông tin khách hàng -->
    <div class="card mb-4">
        <div class="card-header">Thông tin khách hàng</div>
        <div class="card-body">
            <div class="row mb-2">
                <div class="col-md-6">
                    <p><strong>Tên khách hàng:</strong> ${hoaDon.khachHang.tenKhachHang}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Số hóa đơn:</strong> ${hoaDon.so_hoa_don}</p>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-6">
                    <p><strong>Số điện thoại:</strong> ${hoaDon.soDienThoai}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Ngày tạo:</strong> ${hoaDon.ngay_tao}</p>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-6">
                    <p><strong>Địa chỉ:</strong> ${hoaDon.diaChi}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Phương thức vận chuyển:</strong> ${hoaDon.phuongThucVanChuyen}</p>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-6">
                    <p><strong>Ghi chú:</strong> ${hoaDon.ghi_chu}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Phương thức thanh toán:</strong> ${hoaDon.phuong_thuc_thanh_toan}</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Thông tin tình trạng và sản phẩm -->
    <div class="card mb-4">
        <div class="card-header">Chi tiết sản phẩm</div>
        <div class="card-body">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Hình ảnh</th>
                    <th>Tên Sản Phẩm</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="tongTien" value="0" />
                <c:forEach items="${hoaDonChiTiets}" var="item">
                    <tr>
                        <td><img style="width: 90px" src="${pageContext.request.contextPath}/uploads/${item.sanPhamChiTiet.hinhAnh}"></td>
                        <td>${item.sanPhamChiTiet.sanPham.ten}</td>
                        <td>${item.sanPhamChiTiet.giaBan} VND</td>
                        <td>${item.so_luong}</td>
                    </tr>
                    <c:set var="tongTien" value="${tongTien + (item.so_luong * item.sanPhamChiTiet.giaBan)}" />
                </c:forEach>
                </tbody>
            </table>
            <form action="/hoa-don/cap-nhat-tinh-trang" method="post">
                <input type="hidden" name="id" value="${hoaDon.id}" />
                <c:if test="${hoaDon.tinh_trang == 2}">
                    <button type="submit" name="tinhTrangMoi" value="3" class="btn btn-info">Xác nhận thanh toán</button>
                </c:if>
            </form>
            <p class="text-end fw-bold">Tổng tiền: ${tongTien} VND</p>
        </div>
    </div>
</div>
</body>
<script>
    function confirmCompletion(tinhTrang) {
        const alertBox = document.getElementById('alertMessage');
        if (tinhTrang < 3) {
            alertBox.textContent = 'Phải xác nhận thanh toán trước khi hoàn thành đơn hàng.';
            alertBox.classList.remove('d-none');
            alertBox.classList.add('alert', 'alert-warning');
            return false;
        }
        alertBox.classList.add('d-none');
        return true;
    }
</script>
</html>
