<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Danh Sách Hóa Đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYzIY0LIzj+PZrXsSOJo9ORpB0d6BSZ/S30R7rpkhwn/tI3oU7j7Sk" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css">
    <style>
        table {
            width: 100%;
            margin-top: 20px;
        }
        table th, table td {
            text-align: center;
            padding: 10px;
        }
        .card {
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        .card-body {
            padding: 20px;
        }
        .btn-outline-primary {
            border-radius: 50%;
            padding: 8px 12px;
        }
    </style>
    <title>Bán Hàng</title>
</head>
<body>
<jsp:include page="../layout.jsp" />
<div class="container mt-3">
    <h2>Trang Bán Hàng</h2>
    <br>
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" data-bs-toggle="tab" href="#taomoi">Tạo Mới</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" href="#danhsachhoadon">Danh Sách Hóa Đơn</a>
        </li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content">
        <div id="taomoi" class="container tab-pane active"><br>
            <div class="mt-1">
                <div class="row">
                    <div class="col-md-6 filter-section">
                        <div class="d-flex align-items-center mb-3">
                            <form action="/ban-hang/addHoaDon" method="post" class="me-2">
                                <button class="btn btn-create">Tạo hóa đơn mới</button>
                            </form>
                            <div class="form-group me-2">
                                <label for="hoaDonSelect" class="visually-hidden">Chọn Hóa Đơn:</label>
                                <select id="hoaDonSelect" class="form-select" onchange="location = this.value;">
                                    <option value="">-- Chọn Hóa Đơn --</option>
                                    <c:forEach items="${hoaDonList}" var="hoaDon">
                                        <c:if test="${hoaDon.tinh_trang == 0}">
                                            <option value="${pageContext.request.contextPath}/ban-hang/${hoaDon.id}"
                                                    <c:if test="${hoaDon.id == selectedHoaDonId}">selected</c:if>>
                                                    ${hoaDon.soHoaDon}
                                            </option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <c:if test="${not empty selectedHoaDonId}">
                                <form action="/ban-hang/${selectedHoaDonId}/delete" method="post" class="me-2">
                                    <button class="btn btn-secondary-outline" onclick="return confirm('Bạn có chắc chắn muốn xóa hóa đơn này?');">Xóa</button>
                                </form>
                            </c:if>
                        </div>

                        <c:if test="${not empty selectedHoaDonId}">
                            <h3 class="text-primary">Hóa Đơn ID: ${selectedHoaDonId}</h3>
                            <table class="table table-striped table-bordered">
                                <thead class="table-dark">
                                <tr>
                                    <th>STT</th>
                                    <th>Tên Sản Phẩm</th>
                                    <th>Giá Bán</th>
                                    <th>Số Lượng</th>
                                    <th>Thao Tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:set var="tongTien" value="0" /> <!-- Khởi tạo tổng tiền -->
                                <c:forEach items="${hoaDonChiTiets}" var="item" varStatus="i">
                                    <tr>
                                        <td>${i.index + 1}</td>
                                        <td>${item.sanPhamChiTiet.sanPham.ten}</td>
                                        <td>${item.sanPhamChiTiet.giaBan}</td>
                                        <td>${item.so_luong}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/ban-hang/${selectedHoaDonId}/remove-product/${item.sanPhamChiTiet.id}" method="post" style="display:inline-block;">
                                                <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <!-- Tính tổng tiền dựa trên giá bán của SanPhamChiTiet -->
                                    <c:set var="tongTien" value="${tongTien + (item.so_luong * item.sanPhamChiTiet.giaBan)}" />
                                </c:forEach>

                                </tbody>
                            </table>

                            <h5>Tổng tiền: ${tongTien}</h5> <!-- Hiển thị tổng tiền -->

                            <form id="paymentMethodForm" action="${pageContext.request.contextPath}/ban-hang/${selectedHoaDonId}/update-all-payment-method" method="post" class="mb-3">
                                <div class="form-group">
                                    <label for="phuongThucThanhToan">Chọn phương thức thanh toán:</label>
                                    <select id="phuongThucThanhToan" name="phuongThucThanhToan" class="form-select" onchange="this.form.submit();">
                                        <option value="Tiền mặt" <c:if test="${phuongThucThanhToan == 'Tiền mặt'}">selected</c:if>>Tiền mặt</option>
                                        <option value="Chuyển khoản" <c:if test="${phuongThucThanhToan == 'Chuyển khoản'}">selected</c:if>>Chuyển khoản</option>
                                        <option value="Thẻ tín dụng" <c:if test="${phuongThucThanhToan == 'Thẻ tín dụng'}">selected</c:if>>Thẻ tín dụng</option>
                                        <!-- Thêm các phương thức thanh toán khác nếu cần -->
                                    </select>
                                </div>
                            </form>

                            <div class="mb-3" id="cashPaymentSection" style="display: none;">
                                <label for="soTienKhachDua" class="form-label">Số tiền khách đưa:</label>
                                <input type="number" id="soTienKhachDua" class="form-control" oninput="calculateChange()" />
                            </div>
                            <h4 class="text-danger" id="soTienPhaiBu" style="display: none;">Số tiền phải bù lại: 0 VNĐ</h4>
                        </c:if>
                        <c:if test="${not empty selectedHoaDonId}">
                            <h4 class="mt-4">Ghi chú</h4>
                            <form id="noteForm" action="${pageContext.request.contextPath}/ban-hang/${selectedHoaDonId}/confirm" method="post">
                                <div class="form-group">
                                    <textarea name="ghiChu" class="form-control" rows="3">${hoaDon.ghiChu}</textarea>
                                </div>
                                <button type="submit" class="btn btn-create mt-2">Xác nhận hóa đơn</button>
                            </form>
                        </c:if>
                    </div>
                    <div class="col-md-6">
                        <c:if test="${not empty selectedHoaDonId}">
                            <div class="row">
                                <c:forEach items="${sanPhams}" var="sanPham">
                                    <div class="col-md-4 mb-3">
                                        <div class="card" style="border-radius: 20px">
                                            <div class="card-body text-center">
                                                <img style="width: 90px" height="70px" src="${pageContext.request.contextPath}/uploads/${sanPham.hinhAnh}">
                                                <h5 class="card-title">${sanPham.sanPham.ten}</h5>
                                                <p class="card-text">Giá: ${sanPham.giaBan} VNĐ</p>
                                                <p class="card-text">Số Lượng: ${sanPham.soLuong}</p>
                                                <form action="${pageContext.request.contextPath}/ban-hang/${selectedHoaDonId}/add-product" method="post">
                                                    <input type="hidden" name="sanPhamId" value="${sanPham.id}" />
                                                    <button type="submit" class="btn btn-outline-custom">
                                                        <i class="bi bi-plus"></i> <!-- Icon dấu cộng -->
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <div id="danhsachhoadon" class="container tab-pane fade"><br>
            <h2 class="text-primary">Danh Sách Hóa Đơn</h2>
            <br>
            <ul class="nav nav-tabs d-flex justify-content-center mt-3" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" href="#" id="TatCa" data-bs-toggle="tab" data-bs-target="#tatca" role="tab" aria-controls="tatca" aria-selected="true">Tất cả</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" href="?tinhTrang=0" id="ChoXacNhan" data-bs-toggle="tab" data-bs-target="#choxacnhan" role="tab" aria-controls="choxacnhan" aria-selected="false">Chờ xác nhận</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" href="?tinhTrang=1" id="ChoGiao" data-bs-toggle="tab" data-bs-target="#chogiao" role="tab" aria-controls="chogiao" aria-selected="false">Chờ giao</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" href="?tinhTrang=2" id="HoanThanh" data-bs-toggle="tab" data-bs-target="#hoanthanh" role="tab" aria-controls="hoanthanh" aria-selected="false">Hoàn thành</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" href="?tinhTrang=3" id="DaHuy" data-bs-toggle="tab" data-bs-target="#dahuy" role="tab" aria-controls="dahuy" aria-selected="false">Đã hủy</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" href="?tinhTrang=4" id="HoanMotPhan" data-bs-toggle="tab" data-bs-target="#hoanmotphan" role="tab" aria-controls="hoanmotphan" aria-selected="false">Hoàn một phần</a>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="tatca" role="tabpanel" aria-labelledby="TatCa">
                    <table class="table table-striped table-hover table-bordered text-center">
                        <thead>
                        <tr>
                            <th>ID hóa đơn</th>
                            <th>Tên khách hàng</th>
                            <th>Số hóa đơn</th>
                            <th>Tổng tiền</th>
                            <th>Phương thức thanh toán</th>
                            <th>Ghi chú</th>
                            <th>Ngày tạo</th>
                            <th>Tình trạng</th>
                            <th>Hàng động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${hoaDonList}" var="item">
                            <tr>
                                <td>${item.id}</td>
                                <td>${item.khachHang.tenKhachHang}</td>
                                <td>${item.soHoaDon}</td>
                                <td>${item.tong_tien}</td>
                                <td>${item.phuong_thuc_thanh_toan}</td>
                                <td>${item.ghi_chu}</td>
                                <td>${item.ngayTao}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.tinh_trang == 0}">
                                            Chờ xác nhận
                                        </c:when>
                                        <c:when test="${item.tinh_trang == 1 || item.tinh_trang == 2 || item.tinh_trang == 3}">
                                            Chờ giao
                                        </c:when>
                                        <c:when test="${item.tinh_trang == 4}">
                                            Hoàn thành
                                        </c:when>
                                        <c:when test="${item.tinh_trang == 5}">
                                            Đã hủy
                                        </c:when>
                                        <c:when test="${item.tinh_trang == 6}">
                                            Hoàn một phần
                                        </c:when>
                                        <c:otherwise>
                                            Không xác định
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="/hoa-don/detail/${item.id}" class="btn btn-outline-custom" >
                                        <i class="fa-solid fa-circle-info"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane fade" id="choxacnhan" role="tabpanel" aria-labelledby="ChoXacNhan">
                    <table class="table table-striped table-hover table-bordered text-center">
                        <thead>
                        <tr>
                            <th>ID hóa đơn</th>
                            <th>Tên khách hàng</th>
                            <th>Số hóa đơn</th>
                            <th>Tổng tiền</th>
                            <th>Phương thức thanh toán</th>
                            <th>Ghi chú</th>
                            <th>Ngày tạo</th>
                            <th>Tình trạng</th>
                            <th>Hàng động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${hoaDonList}" var="item">
                            <c:if test="${item.tinh_trang == 0}">
                                <tr>
                                    <td>${item.id}</td>
                                    <td>${item.khachHang.tenKhachHang}</td>
                                    <td>${item.soHoaDon}</td>
                                    <td>${item.tong_tien}</td>
                                    <td>${item.phuong_thuc_thanh_toan}</td>
                                    <td>${item.ghi_chu}</td>
                                    <td>${item.ngayTao}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.tinh_trang == 0}">
                                                Chờ xác nhận
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 1 || item.tinh_trang == 2 || item.tinh_trang == 3}">
                                                Chờ giao
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 4}">
                                                Hoàn thành
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 5}">
                                                Đã hủy
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 6}">
                                                Hoàn một phần
                                            </c:when>
                                            <c:otherwise>
                                                Không xác định
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="/hoa-don/detail/${item.id}" class="btn btn-outline-custom" >
                                            <i class="fa-solid fa-circle-info"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane fade" id="chogiao" role="tabpanel" aria-labelledby="ChoGiao">
                    <table class="table table-striped table-hover table-bordered text-center">
                        <thead>
                        <tr>
                            <th>ID hóa đơn</th>
                            <th>Tên khách hàng</th>
                            <th>Số hóa đơn</th>
                            <th>Tổng tiền</th>
                            <th>Phương thức thanh toán</th>
                            <th>Ghi chú</th>
                            <th>Ngày tạo</th>
                            <th>Tình trạng</th>
                            <th>Hàng động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${hoaDonList}" var="item">
                            <c:if test="${item.tinh_trang == 1 || item.tinh_trang == 2 || item.tinh_trang == 3}">
                                <tr>
                                    <td>${item.id}</td>
                                    <td>${item.khachHang.tenKhachHang}</td>
                                    <td>${item.soHoaDon}</td>
                                    <td>${item.tong_tien}</td>
                                    <td>${item.phuong_thuc_thanh_toan}</td>
                                    <td>${item.ghi_chu}</td>
                                    <td>${item.ngayTao}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.tinh_trang == 0}">
                                                Chờ xác nhận
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 1 || item.tinh_trang == 2 || item.tinh_trang == 3}">
                                                Chờ giao
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 4}">
                                                Hoàn thành
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 5}">
                                                Đã hủy
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 6}">
                                                Hoàn một phần
                                            </c:when>
                                            <c:otherwise>
                                                Không xác định
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="/hoa-don/detail/${item.id}" class="btn btn-outline-custom" >
                                            <i class="fa-solid fa-circle-info"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table></div>
                <div class="tab-pane fade" id="hoanthanh" role="tabpanel" aria-labelledby="HoanThanh">
                    <table class="table table-striped table-hover table-bordered text-center">
                        <thead>
                        <tr>
                            <th>ID hóa đơn</th>
                            <th>Tên khách hàng</th>
                            <th>Số hóa đơn</th>
                            <th>Tổng tiền</th>
                            <th>Phương thức thanh toán</th>
                            <th>Ghi chú</th>
                            <th>Ngày tạo</th>
                            <th>Tình trạng</th>
                            <th>Hàng động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${hoaDonList}" var="item">
                            <c:if test="${item.tinh_trang == 4}">
                                <tr>
                                    <td>${item.id}</td>
                                    <td>${item.khachHang.tenKhachHang}</td>
                                    <td>${item.soHoaDon}</td>
                                    <td>${item.tong_tien}</td>
                                    <td>${item.phuong_thuc_thanh_toan}</td>
                                    <td>${item.ghi_chu}</td>
                                    <td>${item.ngayTao}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.tinh_trang == 0}">
                                                Chờ xác nhận
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 1 || item.tinh_trang == 2 || item.tinh_trang == 3}">
                                                Chờ giao
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 4}">
                                                Hoàn thành
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 5}">
                                                Đã hủy
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 6}">
                                                Hoàn một phần
                                            </c:when>
                                            <c:otherwise>
                                                Không xác định
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="/hoa-don/detail/${item.id}" class="btn btn-outline-custom" >
                                            <i class="fa-solid fa-circle-info"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table></div>
                <div class="tab-pane fade" id="dahuy" role="tabpanel" aria-labelledby="DaHuy">
                    <table class="table table-striped table-hover table-bordered text-center">
                        <thead>
                        <tr>
                            <th>ID hóa đơn</th>
                            <th>Tên khách hàng</th>
                            <th>Số hóa đơn</th>
                            <th>Tổng tiền</th>
                            <th>Phương thức thanh toán</th>
                            <th>Ghi chú</th>
                            <th>Ngày tạo</th>
                            <th>Tình trạng</th>
                            <th>Hàng động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${hoaDonList}" var="item">
                            <c:if test="${item.tinh_trang == 5}">
                                <tr>
                                    <td>${item.id}</td>
                                    <td>${item.khachHang.tenKhachHang}</td>
                                    <td>${item.soHoaDon}</td>
                                    <td>${item.tong_tien}</td>
                                    <td>${item.phuong_thuc_thanh_toan}</td>
                                    <td>${item.ghi_chu}</td>
                                    <td>${item.ngayTao}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.tinh_trang == 0}">
                                                Chờ xác nhận
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 1 || item.tinh_trang == 2 || item.tinh_trang == 3}">
                                                Chờ giao
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 4}">
                                                Hoàn thành
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 5}">
                                                Đã hủy
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 6}">
                                                Hoàn một phần
                                            </c:when>
                                            <c:otherwise>
                                                Không xác định
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="/hoa-don/detail/${item.id}" class="btn btn-outline-custom" >
                                            <i class="fa-solid fa-circle-info"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table></div>
                <div class="tab-pane fade" id="hoanmotphan" role="tabpanel" aria-labelledby="HoanMotPhan">
                    <table class="table table-striped table-hover table-bordered text-center">
                        <thead>
                        <tr>
                            <th>ID hóa đơn</th>
                            <th>Tên khách hàng</th>
                            <th>Số hóa đơn</th>
                            <th>Tổng tiền</th>
                            <th>Phương thức thanh toán</th>
                            <th>Ghi chú</th>
                            <th>Ngày tạo</th>
                            <th>Tình trạng</th>
                            <th>Hàng động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${hoaDonList}" var="item">
                            <c:if test="${item.tinh_trang == 6}">
                                <tr>
                                    <td>${item.id}</td>
                                    <td>${item.khachHang.tenKhachHang}</td>
                                    <td>${item.soHoaDon}</td>
                                    <td>${item.tong_tien}</td>
                                    <td>${item.phuong_thuc_thanh_toan}</td>
                                    <td>${item.ngayTao}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.tinh_trang == 0}">
                                                Chờ xác nhận
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 1 || item.tinh_trang == 2 || item.tinh_trang == 3}">
                                                Chờ giao
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 4}">
                                                Hoàn thành
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 5}">
                                                Đã hủy
                                            </c:when>
                                            <c:when test="${item.tinh_trang == 6}">
                                                Hoàn một phần
                                            </c:when>
                                            <c:otherwise>
                                                Không xác định
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="/hoa-don/detail/${item.id}" class="btn btn-outline-custom" >
                                            <i class="fa-solid fa-circle-info"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Kiểm tra và hiển thị phần thanh toán ban đầu
        toggleCashPaymentSection();

        // Bắt sự kiện khi thay đổi phương thức thanh toán
        document.getElementById("phuongThucThanhToan").addEventListener("change", toggleCashPaymentSection);
    });

    function toggleCashPaymentSection() {
        var paymentMethod = document.getElementById("phuongThucThanhToan").value;
        var cashPaymentSection = document.getElementById("cashPaymentSection");
        var changeSection = document.getElementById("soTienPhaiBu");

        if (paymentMethod === "Tiền mặt") {
            cashPaymentSection.style.display = "block";
            changeSection.style.display = "block";
        } else {
            cashPaymentSection.style.display = "none";
            changeSection.style.display = "none";
        }
    }

    function calculateChange() {
        var tongTien = ${tongTien};
        var soTienKhachDua = document.getElementById("soTienKhachDua").value || 0;
        var soTienPhaiBu = soTienKhachDua - tongTien;

        document.getElementById("soTienPhaiBu").innerText = "Số tiền phải bù lại: " + Math.max(0, soTienPhaiBu) + " VNĐ";
    }
</script>
</body>
</html>
