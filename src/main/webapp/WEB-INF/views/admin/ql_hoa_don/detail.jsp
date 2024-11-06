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
        #alertMessage {
            position: fixed;
            right: -300px; /* Ẩn thông báo ra ngoài màn hình */
            top: 20px;
            width: 250px;
            transition: right 0.5s ease-in-out;
            z-index: 1050;
        }

        #alertMessage.show {
            right: 20px; /* Di chuyển vào bên trong màn hình khi hiện */
        }
    </style>
</head>
<jsp:include page="../layout.jsp" />
<body>
<div class="container mt-3">
    <div class="mt-3 mb-3">
        <a href="/hoa-don/hien-thi" class="btn btn-outline-success">Quay lại</a>
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
        <div class="status-item ${hoaDon.tinh_trang >= 11 ? 'active' : ''}">
            <i class="fas fa-undo-alt status-icon"></i>
            <p>Xác nhận đổi trả</p>
        </div>
        <div class="status-item ${hoaDon.tinh_trang >= 12 ? 'active' : ''}">
            <i class="fas fa-times-circle status-icon"></i>
            <p>Đã hủy</p>
        </div>
        <%--        <div class="status-item ${hoaDon.tinh_trang == 13 ? 'active' : ''}">--%>
        <%--            <i class="fas fa-exchange-alt status-icon"></i>--%>
        <%--            <p>Hoàn một phần</p>--%>
        <%--        </div>--%>
    </div>

    <div id="alertMessage" class="alert alert-warning" role="alert">
        Phải xác nhận thanh toán trước khi hoàn thành đơn hàng.
    </div>

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
    <div class="card mb-4 mt-3">
        <div class="card-header">Thông tin khách hàng</div>
        <div class="card-body">
            <div class="row mb-2">
                <div class="col-md-6">
                    <p><strong>Tên khách hàng:</strong> ${hoaDon.khachHang.tenKhachHang}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Số hóa đơn:</strong> ${hoaDon.soHoaDon}</p>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-6">
                    <p><strong>Số điện thoại:</strong> ${hoaDon.soDienThoai}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Ngày tạo:</strong> ${hoaDon.ngayTao}</p>
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
                    <p><strong>Ghi chú:</strong> ${hoaDon.ghiChu}</p>
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
            <c:if test="${hoaDon.tinh_trang == 2}">
                <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#confirmPaymentModal">
                    Xác nhận thanh toán
                </button>
            </c:if>
            <c:if test="${hoaDon.tinh_trang == 11}">
                <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#doiTraModal">
                    Xem Thông tin Đổi Trả
                </button>
            </c:if>
            <p class="text-end fw-bold">
                Tổng tiền: ${hoaDonChiTiets[0].hoaDon.tongTien} VND
            </p>
        </div>
    </div>
</div>

<!-- Modal Xác Nhận Thanh Toán -->
<div class="modal fade" id="confirmPaymentModal" tabindex="-1" aria-labelledby="confirmPaymentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmPaymentModalLabel">Xác Nhận Thanh Toán</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p><strong>Mã hóa đơn:</strong> <span id="invoiceCode">${hoaDon.soHoaDon}</span></p>
                <p><strong>Tổng tiền:</strong> <span id="totalAmount">${hoaDon.tongTien}</span> VNĐ</p>
                <p><strong>Phương thức thanh toán:</strong> <span id="paymentMethod">${hoaDon.phuong_thuc_thanh_toan}</span></p>
                <form action="/hoa-don/cap-nhat-tinh-trang" method="post">
                    <input type="hidden" name="id" value="${hoaDon.id}" />
                    <div class="mb-3">
                        <label for="ghiChu" class="form-label"><strong>Ghi chú:</strong></label>
                        <textarea name="ghiChu" id="ghiChu" class="form-control" rows="4" placeholder="Nhập ghi chú" style="resize: vertical;">${hoaDon.ghiChu}</textarea>
                    </div>
                    <div class="d-flex justify-content-between">
                        <button type="submit" name="tinhTrangMoi" value="3" class="btn btn-info me-2">Xác nhận thanh toán</button>
                        <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Hủy</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="doiTraModal" tabindex="-1" aria-labelledby="doiTraModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="doiTraModalLabel">Thông tin Đổi Trả</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <tr>
                        <th>ID Đổi Trả</th>
                        <td>${doiTra.id}</td>
                    </tr>
                    <tr>
                        <th>Lý Do Cụ Thể</th>
                        <td>${doiTra.lyDoCuThe}</td>
                    </tr>
                    <tr>
                        <th>Hình Thức Hoàn Trả</th>
                        <td>${doiTra.hinhThuc}</td>
                    </tr>
                    <tr>
                        <th>Số Tiền Hoàn Trả</th>
                        <td>${doiTra.tienHoan} VND</td>
                    </tr>
                    <tr>
                        <th>Phương Thức Thanh Toán</th>
                        <td>${doiTra.phuongThucChuyenTien}</td>
                    </tr>
                    <tr>
                        <th>Ngày yêu cầu</th>
                        <td>${doiTra.ngayYeuCau}</td>
                    </tr>
                    <tr>
                        <th>Hình Ảnh Sản Phẩm</th>
                        <td>
                            <img style="width: 90px" src="${pageContext.request.contextPath}/uploads/${doiTra.hinhAnh}">
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Đóng</button>
                <form action="/hoa-don/cap-nhat-tinh-trang" method="post">
                    <input type="hidden" name="id" value="${hoaDon.id}" />
                    <button type="submit" name="tinhTrangMoi" value="12" class="btn btn-primary" >Xác Nhận Đổi Trả</button>
                </form>
            </div>
        </div>
    </div>
</div>


</body>
<script>
    function confirmCompletion(tinhTrang) {
        const alertBox = document.getElementById('alertMessage');
        if (tinhTrang < 3) {
            alertBox.textContent = 'Phải xác nhận thanh toán trước khi hoàn thành đơn hàng.';
            alertBox.classList.add('show'); // Hiện thông báo
            setTimeout(() => {
                alertBox.classList.remove('show'); // Ẩn thông báo sau 3 giây
            }, 3000);
            return false;
        }
        return true;
    }
</script>
</html>