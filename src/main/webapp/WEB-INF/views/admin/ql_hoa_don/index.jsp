<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hóa đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@12.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
</head>
<jsp:include page="../layout.jsp" />
<body class="">
<h2 class="d-flex justify-content-center mt-3">Quản lý hóa đơn</h2>
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
        <a class="nav-link" href="?tinhTrang=11" id="XacNhanDoiTra" data-bs-toggle="tab" data-bs-target="#xacnhandoitra" role="tab" aria-controls="xacnhandoitra" aria-selected="false">Chờ xác nhận đổi trả</a>
    </li>
    <li class="nav-item" role="presentation">
        <a class="nav-link" href="?tinhTrang=12" id="DaHuy" data-bs-toggle="tab" data-bs-target="#dahuy" role="tab" aria-controls="dahuy" aria-selected="false">Đã hủy</a>
    </li>
<%--    <li class="nav-item" role="presentation">--%>
<%--        <a class="nav-link" href="?tinhTrang=13" id="HoanMotPhan" data-bs-toggle="tab" data-bs-target="#hoanmotphan" role="tab" aria-controls="hoanmotphan" aria-selected="false">Hoàn một phần</a>--%>
<%--    </li>--%>
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
            <c:forEach items="${list}" var="item">
                <tr>
                    <td>${item.id}</td>
                    <td>${item.khachHang.tenKhachHang}</td>
                    <td>${item.so_hoa_don}</td>
                    <td>${item.tong_tien}</td>
                    <td>${item.phuong_thuc_thanh_toan}</td>
                    <td>${item.ghi_chu}</td>
                    <td>${item.ngay_tao}</td>
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
                            <c:when test="${item.tinh_trang == 12}">
                                Đã hủy
                            </c:when>
                            <c:when test="${item.tinh_trang == 13}">
                                Hoàn một phần
                            </c:when>
                            <c:when test="${item.tinh_trang == 11}">
                                Chờ xác nhận đổi trả
                            </c:when>
                            <c:otherwise>
                                Không xác định
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="detail/${item.id}" class="btn btn-outline-custom" >
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
            <c:forEach items="${listHoaDon}" var="item">
                <c:if test="${item.tinh_trang == 0}">
                    <tr>
                        <td>${item.id}</td>
                        <td>${item.khachHang.tenKhachHang}</td>
                        <td>${item.so_hoa_don}</td>
                        <td>${item.tong_tien}</td>
                        <td>${item.phuong_thuc_thanh_toan}</td>
                        <td>${item.ghi_chu}</td>
                        <td>${item.ngay_tao}</td>
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
                                <c:when test="${item.tinh_trang == 12}">
                                    Đã hủy
                                </c:when>
                                <c:when test="${item.tinh_trang == 13}">
                                    Hoàn một phần
                                </c:when>
                                <c:when test="${item.tinh_trang == 11}">
                                    Chờ xác nhận đổi trả
                                </c:when>
                                <c:otherwise>
                                    Không xác định
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="detail/${item.id}" class="btn btn-outline-custom" >
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
            <c:forEach items="${listHoaDon}" var="item">
                <c:if test="${item.tinh_trang == 1 || item.tinh_trang == 2 || item.tinh_trang == 3}">
                    <tr>
                        <td>${item.id}</td>
                        <td>${item.khachHang.tenKhachHang}</td>
                        <td>${item.so_hoa_don}</td>
                        <td>${item.tong_tien}</td>
                        <td>${item.phuong_thuc_thanh_toan}</td>
                        <td>${item.ghi_chu}</td>
                        <td>${item.ngay_tao}</td>
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
                                <c:when test="${item.tinh_trang == 12}">
                                    Đã hủy
                                </c:when>
                                <c:when test="${item.tinh_trang == 13}">
                                    Hoàn một phần
                                </c:when>
                                <c:when test="${item.tinh_trang == 11}">
                                    Chờ xác nhận đổi trả
                                </c:when>
                                <c:otherwise>
                                    Không xác định
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="detail/${item.id}" class="btn btn-outline-custom" >
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
            <c:forEach items="${listHoaDon}" var="item">
                <c:if test="${item.tinh_trang == 4}">
                    <tr>
                        <td>${item.id}</td>
                        <td>${item.khachHang.tenKhachHang}</td>
                        <td>${item.so_hoa_don}</td>
                        <td>${item.tong_tien}</td>
                        <td>${item.phuong_thuc_thanh_toan}</td>
                        <td>${item.ghi_chu}</td>
                        <td>${item.ngay_tao}</td>
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
                                <c:when test="${item.tinh_trang == 12}">
                                    Đã hủy
                                </c:when>
                                <c:when test="${item.tinh_trang == 13}">
                                    Hoàn một phần
                                </c:when>
                                <c:when test="${item.tinh_trang == 11}">
                                    Chờ xác nhận đổi trả
                                </c:when>
                                <c:otherwise>
                                    Không xác định
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="detail/${item.id}" class="btn btn-outline-custom" >
                                <i class="fa-solid fa-circle-info"></i>
                            </a>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table></div>
    <div class="tab-pane fade" id="xacnhandoitra" role="tabpanel" aria-labelledby="XacNhanDoiTra">
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
            <c:forEach items="${listHoaDon}" var="item">
                <c:if test="${item.tinh_trang == 11}">
                    <tr>
                        <td>${item.id}</td>
                        <td>${item.khachHang.tenKhachHang}</td>
                        <td>${item.so_hoa_don}</td>
                        <td>${item.tong_tien}</td>
                        <td>${item.phuong_thuc_thanh_toan}</td>
                        <td>${item.ghi_chu}</td>
                        <td>${item.ngay_tao}</td>
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
                                <c:when test="${item.tinh_trang == 12}">
                                    Đã hủy
                                </c:when>
                                <c:when test="${item.tinh_trang == 13}">
                                    Hoàn một phần
                                </c:when>
                                <c:when test="${item.tinh_trang == 11}">
                                    Chờ xác nhận đổi trả
                                </c:when>
                                <c:otherwise>
                                    Không xác định
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="detail/${item.id}" class="btn btn-outline-custom" >
                                <i class="fa-solid fa-circle-info"></i>
                            </a>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </div>
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
            <c:forEach items="${listHoaDon}" var="item">
                <c:if test="${item.tinh_trang == 12}">
                    <tr>
                        <td>${item.id}</td>
                        <td>${item.khachHang.tenKhachHang}</td>
                        <td>${item.so_hoa_don}</td>
                        <td>${item.tong_tien}</td>
                        <td>${item.phuong_thuc_thanh_toan}</td>
                        <td>${item.ghi_chu}</td>
                        <td>${item.ngay_tao}</td>
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
                                <c:when test="${item.tinh_trang == 12}">
                                    Đã hủy
                                </c:when>
                                <c:when test="${item.tinh_trang == 13}">
                                    Hoàn một phần
                                </c:when>
                                <c:when test="${item.tinh_trang == 11}">
                                    Chờ xác nhận đổi trả
                                </c:when>
                                <c:otherwise>
                                    Không xác định
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="detail/${item.id}" class="btn btn-outline-custom" >
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
            <c:forEach items="${listHoaDon}" var="item">
                <c:if test="${item.tinh_trang == 13}">
                    <tr>
                        <td>${item.id}</td>
                        <td>${item.khachHang.tenKhachHang}</td>
                        <td>${item.so_hoa_don}</td>
                        <td>${item.tong_tien}</td>
                        <td>${item.phuong_thuc_thanh_toan}</td>
                        <td>${item.ghi_chu}</td>
                        <td>${item.ngay_tao}</td>
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
                                <c:when test="${item.tinh_trang == 12}">
                                    Đã hủy
                                </c:when>
                                <c:when test="${item.tinh_trang == 13}">
                                    Hoàn một phần
                                </c:when>
                                <c:when test="${item.tinh_trang == 11}">
                                    Chờ xác nhận đổi trả
                                </c:when>
                                <c:otherwise>
                                    Không xác định
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="detail/${item.id}" class="btn btn-outline-custom" >
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
</body>
</html>