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
            flex-direction: column;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
        }

        .status-group {
            display: flex;
            justify-content: center;
            gap: 1rem;
            flex-wrap: wrap;
            border-bottom: 1px solid #ddd;
            padding-bottom: 0.5rem;
            width: 100%;
            text-align: center;
        }

        .return-group {
            border-top: 1px solid #ddd;
            padding-top: 0.5rem;
        }

        .status-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            padding: 0.5rem;
            color: #666;
            transition: all 0.3s ease;
            border-radius: 8px;
            width: 120px;
        }

        .status-item.active {
            font-weight: bold;
        }

        .status-icon {
            font-size: 1.5rem;
            margin-bottom: 0.25rem;
            transition: transform 0.3s ease;
            color: #666;
        }

        .status-item.active .status-icon {
            transform: scale(1.2);
        }

        .status-item:not(.return-item):not(.cancel-item).active {
            color: #0B745E;
        }
        .status-item:not(.return-item):not(.cancel-item).active .status-icon {
            color: #0B745E;
        }

        .return-item.active {
            color: #FFB800;
        }
        .return-item.active .status-icon {
            color: #FFB800;
        }

        .cancel-item.active {
            color: #FF4B4B;
        }
        .cancel-item.active .status-icon {
            color: #FF4B4B;
        }
        .card-header {
            background-color: #0B745E !important;
            color: white;
            font-weight: bold;
            text-align: center;
        }
        #alertMessage {
            position: fixed;
            right: -300px;
            top: 20px;
            width: 250px;
            transition: right 0.5s ease-in-out;
            z-index: 1050;
        }

        #alertMessage.show {
            right: 20px;
        }
    </style>
</head>
<jsp:include page="../layout.jsp" />
<body>
<div class="container mt-3">
    <div class="mt-3 mb-3">
        <a href="/hoa-don/tinhTrang=all" class="btn btn-outline-success">Quay lại</a>
    </div>

    <div class="order-status">
        <div class="status-group">
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

        <div class="status-group return-group">
            <c:if test="${hoaDon.tinh_trang >= 11}">
                <div class="status-item return-item ${hoaDon.tinh_trang >= 11 ? 'active' : ''}">
                    <i class="fas fa-clock status-icon"></i>
                    <p>Chờ xác nhận đổi trả</p>
                </div>
                <div class="status-item return-item ${hoaDon.tinh_trang >= 12 ? 'active' : ''}">
                    <i class="fas fa-undo-alt status-icon"></i>
                    <p>Đã xác nhận đổi trả</p>
                </div>
                <div class="status-item return-item ${hoaDon.tinh_trang >= 13 ? 'active' : ''}">
                    <i class="fas fa-exchange-alt status-icon"></i>
                    <p>Đổi trả thành công</p>
                </div>
            </c:if>
            <c:if test="${hoaDon.tinh_trang == 14}">
                <div class="status-item cancel-item ${hoaDon.tinh_trang == 14 ? 'active' : ''}">
                    <i class="fas fa-times-circle status-icon"></i>
                    <p>Đã hủy</p>
                </div>
            </c:if>
        </div>
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
                <c:set var="phiVanChuyen" value="0" />
                <c:set var="tongGiaSanPham" value="0" />
                <c:forEach items="${hoaDonChiTiets}" var="item">
                    <tr>
                        <td><img style="width: 90px" src="${pageContext.request.contextPath}/uploads/${item.sanPhamChiTiet.hinhAnh}"></td>
                        <td>${item.sanPhamChiTiet.sanPham.ten}</td>
                        <td>${item.sanPhamChiTiet.giaBan} VND</td>
                        <td>${item.so_luong}</td>
                    </tr>
                    <c:set var="tongGiaSanPham" value="${tongGiaSanPham + (item.so_luong * item.sanPhamChiTiet.giaBan)}" />
                    <c:set var="phiVanChuyen" value="${hoaDon.tongTien - tongGiaSanPham}" />
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
            <c:if test="${hoaDon.tinh_trang == 12}">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#doiTraChiTietModal">
                    Xem chi tiết đổi trả
                </button>
            </c:if>
            <p class="text-end" style="color: #0B745E">
                Phí vận chuyển: ${phiVanChuyen}
            </p>
            <p class="text-end fw-bold">
                Tổng tiền: ${hoaDonChiTiets[0].hoaDon.tongTien} VND
            </p>
        </div>
    </div>
</div>

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
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="doiTraModalLabel">Thông tin Đổi Trả</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Hình Thức Hoàn Trả:</strong></p>
                        <p class="col-sm-8"><span>${doiTra.hinhThuc}</span></p>
                    </div>
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Số Tiền Hoàn Trả:</strong></p>
                        <p class="col-sm-8"><span>${doiTra.tienHoan} VND</span></p>
                    </div>
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Phương Thức Thanh Toán:</strong></p>
                        <p class="col-sm-8"><span>${doiTra.phuongThucChuyenTien}</span></p>
                    </div>
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Ngày Yêu Cầu:</strong></p>
                        <p class="col-sm-8"><span>${doiTra.ngayYeuCau}</span></p>
                    </div>
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Lý Do Cụ Thể:</strong></p>
                        <p class="col-sm-8"><span>${doiTra.lyDoCuThe}</span></p>
                    </div>
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Hình Ảnh Sản Phẩm:</strong></p>
                        <p class="col-sm-8">
                            <img style="width: 90px;" src="${pageContext.request.contextPath}/uploads/${doiTra.hinhAnh}">
                        </p>
                    </div>

                    <h5 class="mt-4">Sản phẩm muốn đổi trả</h5>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th>Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Giá sản phẩm</th>
                                <th>Số lượng</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="doiTraChiTiet" items="${doiTraChiTiets}">
                                <tr>
                                    <td class="text-center">
                                        <img style="width: 90px; height: auto;" src="${pageContext.request.contextPath}/uploads/${doiTraChiTiet.sanPhamChiTiet.hinhAnh}" alt="Hình ảnh sản phẩm">
                                    </td>
                                    <td>${doiTraChiTiet.sanPhamChiTiet.sanPham.ten}</td>
                                    <td class="text-center">${doiTraChiTiet.giaSanPham} VNĐ</td>
                                    <td class="text-center">${doiTraChiTiet.soLuong}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Đóng</button>
                <form action="/hoa-don/cap-nhat-tinh-trang" method="post">
                    <input type="hidden" name="id" value="${hoaDon.id}" />
                    <button type="submit" name="tinhTrangMoi" value="12" class="btn btn-primary">Xác Nhận Đổi Trả</button>
                </form>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="doiTraChiTietModal" tabindex="-1" aria-labelledby="doiTraChiTietModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="doiTraChiTietModalLabel">Thông tin Đổi Trả</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body overflow-auto" style="max-height: 70vh;">
                <div class="container">
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Số Tiền Hoàn Trả:</strong></p>
                        <p class="col-sm-8"><span>${doiTra.tienHoan} VND</span></p>
                    </div>
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Phương Thức Thanh Toán:</strong></p>
                        <p class="col-sm-8"><span>${doiTra.phuongThucChuyenTien}</span></p>
                    </div>
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Hình Ảnh Sản Phẩm:</strong></p>
                        <p class="col-sm-8">
                            <img style="width: 90px;" src="${pageContext.request.contextPath}/uploads/${doiTra.hinhAnh}">
                        </p>
                    </div>

                    <h5 class="mt-4">Sản phẩm muốn đổi trả</h5>
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>Hình ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Giá sản phẩm</th>
                            <th>Số lượng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="doiTraChiTiet" items="${doiTraChiTiets}">
                            <tr>
                                <td class="text-center">
                                    <img style="width: 90px; height: auto;" src="${pageContext.request.contextPath}/uploads/${doiTraChiTiet.sanPhamChiTiet.hinhAnh}" alt="Hình ảnh sản phẩm">
                                </td>
                                <td>${doiTraChiTiet.sanPhamChiTiet.sanPham.ten}</td>
                                <td class="text-center">${doiTraChiTiet.giaSanPham} VNĐ</td>
                                <td class="text-center">${doiTraChiTiet.soLuong}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Đóng</button>
                <form action="/hoa-don/hoan-hang/${hoaDon.id}" method="post">
                    <button type="submit" class="btn btn-success">Đổi trả</button>
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
            alertBox.classList.add('show');
            setTimeout(() => {
                alertBox.classList.remove('show');
            }, 3000);
            return false;
        }
        return true;
    }
</script>
</html>
