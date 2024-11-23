<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hóa đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@12.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
</head>
<jsp:include page="navbar.jsp" />
<body class="">
<div>
    <div>
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
            <c:forEach items="${listHoaDon}" var="item" varStatus="status">
                <c:if test="${tinhTrang == 'all' || item.tinh_trang == 0 || item.tinh_trang == 1
                || item.tinh_trang == 2 || item.tinh_trang == 3 || item.tinh_trang == 4
                || item.tinh_trang == 11 || item.tinh_trang == 12 || item.tinh_trang == 13 || item.tinh_trang == 14}">
                    <tr>
                        <td>${item.id}</td>
                        <td>${item.khachHang.tenKhachHang}</td>
                        <td>${item.soHoaDon}</td>
                        <td>${item.tongTien} VNĐ</td>
                        <td>${item.phuong_thuc_thanh_toan}</td>
                        <td>${item.ghiChu}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty thoiGianTaoList[status.index]}">
                                    ${thoiGianTaoList[status.index]}
                                </c:when>
                                <c:otherwise>
                                    Không có thông tin
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.tinh_trang == 0}">
                                    Chờ xác nhận
                                </c:when>
                                <c:when test="${item.tinh_trang == 1 }">
                                    Chờ giao
                                </c:when>
                                <c:when test="${item.tinh_trang == 2 || item.tinh_trang == 3}">
                                    Đang giao
                                </c:when>
                                <c:when test="${item.tinh_trang == 4}">
                                    Hoàn thành
                                </c:when>
                                <c:when test="${item.tinh_trang == 11}">
                                    Chờ xác nhận đổi trả
                                </c:when>
                                <c:when test="${item.tinh_trang == 12}">
                                    Chờ đổi trả
                                </c:when>
                                <c:when test="${item.tinh_trang == 13}">
                                    Đã đổi trả
                                </c:when>
                                <c:when test="${item.tinh_trang == 14}">
                                    Đã hủy
                                </c:when>
                                <c:otherwise>
                                    Không xác định
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="detail/${item.id}" class="btn btn-outline-custom">
                                <i class="fa-solid fa-circle-info"></i>
                            </a>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">

                <li class="page-item ${isFirst ? 'disabled' : ''}">
                    <a class="page-link" href="?page=0&size=10&tinhTrang=${param.tinhTrang}">First</a>
                </li>

                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage - 1}&size=10&tinhTrang=${param.tinhTrang}">Previous</a>
                </li>

                <li class="page-item disabled">
                <span class="page-link">
                    Page ${currentPage + 1} of ${totalPages}
                </span>
                </li>

                <li class="page-item ${isLast ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage + 1}&size=10&tinhTrang=${param.tinhTrang}">Next</a>
                </li>

                <li class="page-item ${isLast ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${totalPages - 1}&size=10&tinhTrang=${param.tinhTrang}">Last</a>
                </li>
            </ul>
        </nav>
    </div>
</div>
</body>
</html>