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
        #imageModal {
            z-index: 1051 !important;
        }

        #doiTraModal {
            z-index: 1050; !important;
        }

        #doiTraChiTietModal{
            z-index: 1050; !important;
        }

        #confirmationModalRejectReturn{
            z-index:1052; !important;
        }

        #confirmationModalPending2{
            z-index: 1053; !important;
        }
        #confirmationModalReturn{
            z-index: 1053; !important;
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
            <div class="status-item ${hoaDon.tinh_trang >= 0 && hoaDon.tinh_trang != 14 ? 'active' : ''}">
                <i class="fas fa-clock status-icon"></i>
                <p>Chờ xác nhận</p>
            </div>

            <div class="status-item ${hoaDon.tinh_trang >= 1 && hoaDon.tinh_trang != 14 ? 'active' : ''}">
                <i class="fas fa-box status-icon"></i>
                <p>Chờ giao</p>
            </div>

            <div class="status-item ${hoaDon.tinh_trang >= 2 && hoaDon.tinh_trang != 14? 'active' : ''}">
                <i class="fas fa-truck status-icon"></i>
                <p>Đang giao</p>
            </div>

            <div class="status-item ${hoaDon.tinh_trang >= 3 && hoaDon.tinh_trang != 14 ? 'active' : ''}">
                <i class="fas fa-check-double status-icon"></i>
                <p>Xác nhận thanh toán</p>
            </div>

            <div class="status-item ${hoaDon.tinh_trang >= 4 && hoaDon.tinh_trang != 14 ? 'active' : ''}">
                <i class="fas fa-check-circle status-icon"></i>
                <p>Hoàn thành</p>
            </div>
        </div>

        <div class="status-group return-group">
            <c:if test="${hoaDon.tinh_trang >= 11 && hoaDon.tinh_trang < 14}">
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

    <c:if test="${hoaDon.tinh_trang == 0}">
        <div class="d-flex gap-2">
            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#cancelModal">
                Không xác nhận
            </button>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModal">
                Xác nhận
            </button>
        </div>
    </c:if>
    <c:if test="${hoaDon.tinh_trang == 1}">
    <div class="d-flex gap-2">
        <button type="button" class="btn btn-secondary-outline" data-bs-toggle="modal" data-bs-target="#confirmationModal1">
            Quay về chờ xác nhận
        </button>
        <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#deliveryModal">
            Giao hàng
        </button>
    </div>
    </c:if>
    <div class="modal fade" id="confirmationModal1" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmationModalLabel">Xác nhận thay đổi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn quay về trạng thái "Chờ xác nhận" không?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary-ouline" data-bs-dismiss="modal">Hủy</button>
                    <form action="/hoa-don/cap-nhat-tinh-trang" method="post" id="confirmationForm">
                        <input type="hidden" name="id" value="${hoaDon.id}" />
                        <button type="submit" name="tinhTrangMoi" value="0" class="btn btn-success">Xác nhận</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <c:if test="${hoaDon.tinh_trang == 2 || hoaDon.tinh_trang == 3}">
    <div class="d-flex gap-2">
        <c:if test="${hoaDon.tinh_trang == 2}">
            <button type="button" class="btn btn-secondary-outline" data-bs-toggle="modal" data-bs-target="#confirmationModalDelivery1">
                Quay về chờ giao
            </button>
        </c:if>
        <c:if test="${hoaDon.tinh_trang == 3}">
            <button type="button" class="btn btn-secondary-outline" data-bs-toggle="modal" data-bs-target="#confirmationModalPayment1">
                Quay về thanh toán
            </button>
        </c:if>
        <button type="button" class="btn btn-success" data-bs-target="#completeModal" onclick="return confirmCompletion(${hoaDon.tinh_trang});">
            Hoàn thành
        </button>
    </div>
    </c:if>

    <div class="modal fade" id="confirmationModalDelivery1" tabindex="-1" aria-labelledby="confirmationModalDeliveryLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmationModalDeliveryLabel">Xác nhận thay đổi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn quay về trạng thái "Chờ giao" không?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Hủy</button>
                    <form action="/hoa-don/cap-nhat-tinh-trang" method="post" id="confirmationFormDelivery">
                        <input type="hidden" name="id" value="${hoaDon.id}" />
                        <button type="submit" name="tinhTrangMoi" value="1" class="btn btn-success">Xác nhận</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="confirmationModalPayment1" tabindex="-1" aria-labelledby="confirmationModalPaymentLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmationModalPaymentLabel">Xác nhận thay đổi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn quay về trạng thái "Chờ Thanh toán" không?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary-ouline" data-bs-dismiss="modal">Hủy</button>
                    <form action="/hoa-don/cap-nhat-tinh-trang" method="post" id="confirmationFormPayment">
                        <input type="hidden" name="id" value="${hoaDon.id}" />
                        <button type="submit" name="tinhTrangMoi" value="2" class="btn btn-success">Xác nhận</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="card mb-4 mt-3">
        <div class="card-header">Thông tin khách hàng</div>
        <div class="card-body">
            <div class="row mb-2">
                <div class="col-md-6">
                    <p><strong>Tên khách hàng:</strong>
                        <c:choose>
                            <c:when test="${empty hoaDon.khachHang.tenKhachHang}">
                                Khách Lẻ
                            </c:when>
                            <c:otherwise>
                                ${hoaDon.khachHang.tenKhachHang}
                            </c:otherwise>
                        </c:choose>
                    </p>

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
                    <p><strong>Ngày tạo:</strong> ${hoaDon.thoiGianTaoFormatted}</p>
                </div>
            </div>
            <div class="row mb-2">
                <c:if test="${hoaDon.diaChi != null}">
                    <div class="col-md-6">
                        <p><strong>Địa chỉ:</strong> ${hoaDon.diaChi}</p>
                    </div>
                </c:if>
                <c:if test="${hoaDon.phuongThucVanChuyen != null}">
                    <div class="col-md-6">
                        <p><strong>Phương thức vận chuyển:</strong> ${hoaDon.phuongThucVanChuyen}</p>
                    </div>
                </c:if>
            </div>
            <div class="row mb-2">
                <div class="col-md-6">
                    <p><strong>Ghi chú:</strong> ${hoaDon.ghiChu}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Phương thức thanh toán:</strong> ${hoaDon.phuong_thuc_thanh_toan}</p>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-6">

                </div>
                <div class="col-md-6">
                    <p><strong>Loại hóa đơn:</strong> ${hoaDon.kieuHoaDon ==1 ? "Online":"Tại quầy"}</p>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-6">

                </div>
                <div class="col-md-6">
                    <p><strong>Trạng thái hóa đơn:</strong>
                        <c:choose>
                            <c:when test="${hoaDon.tinh_trang == 0}">
                                Chờ xác nhận
                            </c:when>
                            <c:when test="${hoaDon.tinh_trang == 1 }">
                                Chờ giao
                            </c:when>
                            <c:when test="${hoaDon.tinh_trang == 2 || item.tinh_trang == 3}">
                                Đang giao
                            </c:when>
                            <c:when test="${hoaDon.tinh_trang == 4}">
                                Hoàn thành
                            </c:when>
                            <c:when test="${hoaDon.tinh_trang == 11}">
                                Chờ xác nhận đổi trả
                            </c:when>
                            <c:when test="${hoaDon.tinh_trang == 12}">
                                Chờ đổi trả
                            </c:when>
                            <c:when test="${hoaDon.tinh_trang == 13}">
                                Đã đổi trả
                            </c:when>
                            <c:when test="${hoaDon.tinh_trang == 14}">
                                Đã hủy
                            </c:when>
                            <c:otherwise>
                                Không xác định
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>
                <c:if test="${hoaDon.tinh_trang >=11 && hoaDon.tinh_trang <14 && doiTra.loaiDichVu == null}">
                <div class="row mb-2">
                    <div class="col-md-6">

                    </div>
                    <div class="col-md-6">
                            <p><strong>Hình thức hoàn trả:</strong> ${doiTra.hinhThuc}</p>
                    </div>
                </div>
                </c:if>
            <c:if test="${hoaDon.tinh_trang >=11 && hoaDon.tinh_trang <14 && doiTra.loaiDichVu != null}">
                <div class="row mb-2">
                    <div class="col-md-6">

                    </div>
                    <div class="col-md-6">
                        <p><strong>Loại dịch vụ:</strong> ${doiTra.loaiDichVu == 1 ? "Đổi hàng" : "Trả hàng"}</p>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <div class="card mb-4">
        <c:if test="${not empty hoaDonChiTiets}">
            <div class="card-header">Danh sách sản phẩm</div>
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
                            <td>
                                <c:choose>
                                    <c:when test="${item.gia_san_pham != item.sanPhamChiTiet.giaBan}">
                                <span style="text-decoration: line-through; color: gray;">
                                    ${item.sanPhamChiTiet.giaBan} VNĐ
                                </span>
                                        <br>
                                        <span style="color: green;">
                                    ${item.gia_san_pham} VNĐ
                                </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>${item.gia_san_pham} VNĐ</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${item.so_luong}</td>
                        </tr>
                        <c:set var="tongGiaSanPham" value="${tongGiaSanPham + (item.so_luong * item.gia_san_pham)}" />
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
            </div>
        </c:if>
        <c:if test="${hoaDon.tinh_trang == 13}">
            <div class="card mb-4">
                <div class="card-header">Sản phẩm đổi trả</div>
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
                        <c:forEach var="doiTraChiTiet" items="${doiTraChiTiets}">
                            <tr>
                                <td><img style="width: 90px" src="${pageContext.request.contextPath}/uploads/${doiTraChiTiet.sanPhamChiTiet.hinhAnh}"></td>
                                <td>${doiTraChiTiet.sanPhamChiTiet.sanPham.ten}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${doiTraChiTiet.giaSanPham == doiTraChiTiet.sanPhamChiTiet.giaBan}">
                                            ${doiTraChiTiet.giaSanPham} VNĐ
                                        </c:when>
                                        <c:otherwise>
                                            <span style="text-decoration: line-through; color: gray;">
                                                    ${doiTraChiTiet.sanPhamChiTiet.giaBan} VNĐ
                                            </span>
                                            <br>
                                            <span style="color: green;">
                                                    ${doiTraChiTiet.giaSanPham} VNĐ
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${doiTraChiTiet.soLuong}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
        <c:if test="${hoaDon.phuongThucVanChuyen != null}">
            <p class="text-end" style="color: #0B745E">
                Phí vận chuyển: ${hoaDon.phuongThucVanChuyen == "Giao Hàng Nhanh" ? "33.000":'20.000'} VNĐ
            </p>
        </c:if>
        <c:if test="${hoaDon.tongTien != 33000 && hoaDon.tongTien != 20000}">
            <p class="text-end">
                Tổng Tiền: <strong>${hoaDon.tongTien} đ</strong></p>
        </c:if>
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
                        <button type="button" class="btn btn-info me-2" data-bs-toggle="modal" data-bs-target="#confirmationModalPayment2">
                            Xác nhận thanh toán
                        </button>
                        <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Hủy</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="confirmationModalPayment2" tabindex="-1" aria-labelledby="confirmationModalPaymentLabel1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmationModalPaymentLabel1">Xác nhận hành động</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Xác nhận đã thanh toán đơn hàng <br>
                Hãy kiểm tra kỹ giao dịch thanh toán trước khi xác nhận
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Hủy</button>
                <form action="/hoa-don/cap-nhat-tinh-trang" method="post" id="confirmationFormPayment2">
                    <input type="hidden" name="id" value="${hoaDon.id}" />
                    <button type="submit" name="tinhTrangMoi" value="3" class="btn btn-info">Xác nhận thanh toán</button>
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
                        <p class="col-sm-4"><strong>Loại dịch vụ:</strong></p>
                        <p class="col-sm-8"><span>${doiTra.loaiDichVu == 1 ? "Đổi hàng" : "Trả hàng"}</span></p>
                    </div>
                    <c:if test="${doiTra.loaiDichVu == 0}">
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Số Tiền Hoàn Trả:</strong></p>
                        <p class="col-sm-8"><span>${doiTra.tienHoan} VND</span></p>
                    </div>
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Phương Thức Thanh Toán:</strong></p>
                        <p class="col-sm-8"><span>${doiTra.phuongThucChuyenTien}</span></p>
                    </div>
                    </c:if>
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Ngày Yêu Cầu:</strong></p>
                        <p class="col-sm-8"><span>${thoiGianHoanTra}</span></p>
                    </div>
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Lý Do Cụ Thể:</strong></p>
                        <p class="col-sm-8"><span>${doiTra.lyDoCuThe}</span></p>
                    </div>
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Hình Ảnh Sản Phẩm:</strong></p>
                        <p class="col-sm-8">
                            <img style="width: 90px;" src="${pageContext.request.contextPath}/uploads/${doiTra.hinhAnh}">
                            <button class="btn btn-info ms-3" data-bs-toggle="modal" data-bs-target="#imageModal">Xem Hình Ảnh</button>
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
                    <c:if test="${not empty doiSanPhams}">
                        <h5 class="mt-4">Sản phẩm muốn đổi lấy</h5>
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
                                <c:forEach var="doiSanPhams" items="${doiSanPhams}">
                                    <tr>
                                        <td class="text-center">
                                            <img style="width: 90px; height: auto;" src="${pageContext.request.contextPath}/uploads/${doiSanPhams.sanPhamChiTiet.hinhAnh}" alt="Hình ảnh sản phẩm">
                                        </td>
                                        <td>${doiSanPhams.sanPhamChiTiet.sanPham.ten}</td>
                                        <td class="text-center">${doiSanPhams.giaSanPham} VNĐ</td>
                                        <td class="text-center">${doiSanPhams.soLuong}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Đóng</button>
                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmationModalRejectReturn">
                    Không Xác Nhận Đổi Trả
                </button>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmationModalReturn">
                    Xác Nhận Đổi Trả
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="confirmationModalRejectReturn" tabindex="-1" aria-labelledby="confirmationModalRejectReturnLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmationModalRejectReturnLabel">Xác nhận hành động</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn không xác nhận yêu cầu đổi trả này không?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Hủy</button>
                <form action="/hoa-don/khong-xac-nhan-doi-tra/${hoaDon.id}" method="post" id="confirmationFormRejectReturn">
                    <button type="submit" class="btn btn-danger">Xác nhận</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="confirmationModalReturn" tabindex="-1" aria-labelledby="confirmationModalReturnLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmationModalReturnLabel">Xác nhận hành động</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Xác nhận yêu cầu đổi trả <br>
                Hãy kiểm tra kỹ hình ảnh sản phẩm trước khi xác nhận
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Hủy</button>
                <form action="/hoa-don/xac-nhan-hoan-tra/${hoaDon.id}" method="post" id="confirmationFormReturn">
                    <button type="submit" class="btn btn-primary">Xác nhận</button>
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
                    <c:if test="${doiTra.loaiDichVu == 0}">
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Số Tiền Hoàn Trả:</strong></p>
                        <p class="col-sm-8"><span>${doiTra.tienHoan} VND</span></p>
                    </div>
                        <c:if test="${doiTra.phuongThucChuyenTien == 'Tiền mặt'}">
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Phương Thức Thanh Toán:</strong></p>
                        <p class="col-sm-8"><span>${doiTra.phuongThucChuyenTien}</span></p>
                    </div>
                        </c:if>
                        <c:if test="${doiTra.phuongThucChuyenTien == 'Chuyển khoản'}">
                            <div class="row mb-2">
                                <p class="col-sm-4"><strong>Phương Thức Thanh Toán:</strong></p>
                                <p class="col-sm-8"><span>${doiTra.phuongThucChuyenTien}</span></p>
                            </div>
                            <div class="row mb-2">
                                <p class="col-sm-4"><strong>Tên Ngân Hàng:</strong></p>
                                <p class="col-sm-8"><span>${doiTra.tenNganHang}</span></p>
                            </div>
                            <div class="row mb-2">
                                <p class="col-sm-4"><strong>Số tài khoản:</strong></p>
                                <p class="col-sm-8"><span>${doiTra.soNganHang}</span></p>
                            </div>
                        </c:if>
                    </c:if>
                    <div class="row mb-2">
                        <p class="col-sm-4"><strong>Hình Ảnh Sản Phẩm:</strong></p>
                        <p class="col-sm-8">
                            <img style="width: 90px;" src="${pageContext.request.contextPath}/uploads/${doiTra.hinhAnh}">
                            <button class="btn btn-info ms-3" data-bs-toggle="modal" data-bs-target="#imageModal">Xem Hình Ảnh</button>
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
                    <c:if test="${not empty doiSanPhams}">
                        <h5 class="mt-4">Sản phẩm muốn đổi lấy</h5>
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
                                <c:forEach var="doiSanPhams" items="${doiSanPhams}">
                                    <tr>
                                        <td class="text-center">
                                            <img style="width: 90px; height: auto;" src="${pageContext.request.contextPath}/uploads/${doiSanPhams.sanPhamChiTiet.hinhAnh}" alt="Hình ảnh sản phẩm">
                                        </td>
                                        <td>${doiSanPhams.sanPhamChiTiet.sanPham.ten}</td>
                                        <td class="text-center">${doiSanPhams.giaSanPham} VNĐ</td>
                                        <td class="text-center">${doiSanPhams.soLuong}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Đóng</button>
                <button type="button" class="btn btn-secondary-outline" data-bs-toggle="modal" data-bs-target="#confirmationModalPending2">
                    Quay về chờ xác nhận
                </button>
                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#confirmationModalReturnItem">
                    Đổi trả
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="confirmationModalPending2" tabindex="-1" aria-labelledby="confirmationModalPendingLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmationModalPendingLabel">Xác nhận thay đổi trạng thái</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn quay về trạng thái "Chờ xác nhận" không?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Hủy</button>
                <form action="/hoa-don/cap-nhat-tinh-trang" method="post" id="confirmationFormPending">
                    <input type="hidden" name="id" value="${hoaDon.id}" />
                    <button type="submit" name="tinhTrangMoi" value="11" class="btn btn-success">Xác nhận</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="confirmationModalReturnItem" tabindex="-1" aria-labelledby="confirmationModalReturnItemLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmationModalReturnItemLabel">Xác nhận hành động</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Hoàn thành đổi trả cho đơn hàng <br>
                Hãy kiểm tra kỹ giao dịch thanh toán
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Hủy</button>
                <form action="/hoa-don/hoan-hang/${hoaDon.id}" method="post" id="confirmationFormReturnItem">
                    <button type="submit" class="btn btn-success">Xác nhận</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="imageModalLabel">Hình ảnh Sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <img style="width: 100%; height: auto;" src="${pageContext.request.contextPath}/uploads/${doiTra.hinhAnh}" alt="Hình ảnh sản phẩm">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmModalLabel">Xác nhận</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Xác nhận đơn hàng và chuẩn bị hàng
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Hủy</button>
                <form action="/hoa-don/xac-nhan-hoa-don/${hoaDon.id}" method="post">
                    <button type="submit" class="btn btn-primary">Xác nhận</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="cancelModal" tabindex="-1" role="dialog" aria-labelledby="cancelModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="cancelModalLabel">Không xác nhận</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn hủy xác nhận đơn hàng này?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Hủy</button>
                <form action="/hoa-don/khong-xac-nhan/${hoaDon.id}" method="post">
                    <button type="submit" class="btn btn-danger">Không xác nhận</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deliveryModal" tabindex="-1" role="dialog" aria-labelledby="deliveryModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deliveryModalLabel">Giao hàng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bàn giao đơn hàng cho đơn vị vận chuyển
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Hủy</button>
                <form action="/hoa-don/ban-giao-van-chuyen/${hoaDon.id}" method="post">
                    <button type="submit" class="btn btn-warning">Giao hàng</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="completeModal" tabindex="-1" role="dialog" aria-labelledby="completeModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="completeModalLabel">Hoàn thành</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Hoàn thành đơn hàng <br>
                Hãy kiểm tra thanh toán trước khi hoàn thành
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Hủy</button>
                <form action="/hoa-don/hoan-thanh/${hoaDon.id}" method="post">
                    <button type="submit" class="btn btn-success">Hoàn thành</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
<script>
    function confirmCompletion(tinhTrang) {
        const alertBox = document.getElementById('alertMessage');
        const modalElement = document.getElementById('completeModal');
        const modal = new bootstrap.Modal(modalElement);

        if (tinhTrang < 3) {
            alertBox.textContent = 'Phải xác nhận thanh toán trước khi hoàn thành đơn hàng.';
            alertBox.classList.add('show');
            alertBox.style.display = 'block';

            setTimeout(() => {
                alertBox.classList.remove('show');
                alertBox.style.display = 'none';
            }, 3000);

            return;
        }

        modal.show();
    }
</script>
</html>
