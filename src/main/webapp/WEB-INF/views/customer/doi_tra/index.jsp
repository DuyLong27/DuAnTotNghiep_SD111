<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đổi Trả</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Custom styling for the cards */
        .order-card {
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            transition: box-shadow 0.3s ease;
            position: relative;
            padding-right: 20px;
        }
        .order-card:hover {
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }
        .card-body {
            padding: 20px;
        }
        .order-header {
            font-weight: bold;
            font-size: 1.25em;
            color: #333;
            margin-bottom: 10px;
        }
        .order-status {
            font-size: 0.9em;
            padding: 5px 10px;
            border-radius: 20px;
            display: inline-block;
            margin-top: 5px;
        }
        .status-unpaid {
            background-color: #ffefef;
            color: #e74c3c;
        }
        .status-paid {
            background-color: #e7f9e7;
            color: #27ae60;
        }
        .product-list {
            margin-top: 10px;
            padding-left: 20px;
        }
        .product-item {
            display: flex;
            justify-content: space-between;
            padding: 5px 0;
            border-bottom: 1px solid #ddd;
        }
        /* Position button at top-right corner */
        .action-button {
            position: absolute;
            top: 10px;
            right: 10px;
        }
        /* Tình trạng Chờ xác nhận */
        .status-pending {
            background-color: #b3e5fc; /* Màu xanh dương nhạt */
            color: #0277bd; /* Màu xanh dương đậm */
        }

        /* Tình trạng Chờ giao */
        .status-awaiting-delivery {
            background-color: #ffecb3; /* Màu vàng nhạt */
            color: #f57c00; /* Màu cam đậm */
        }

        /* Tình trạng Đang giao */
        .status-delivering {
            background-color: #a5d6a7; /* Màu xanh lá cây sáng */
            color: #388e3c; /* Màu xanh lá đậm */
        }

        /* Tình trạng Hoàn thành */
        .status-completed {
            background-color: #c8e6c9; /* Màu xanh lá cây nhạt */
            color: #2e7d32; /* Màu xanh lá đậm */
        }

        /* Tình trạng Chờ xác nhận đổi trả */
        .status-return-pending {
            background-color: #e1bee7; /* Màu tím nhạt */
            color: #7b1fa2; /* Màu tím đậm */
        }

        /* Tình trạng Chờ đổi trả */
        .status-returning {
            background-color: #ffcc80; /* Màu cam sáng */
            color: #d32f2f; /* Màu đỏ */
        }

        /* Tình trạng Đã đổi trả */
        .status-returned {
            background-color: #c5e1a5; /* Màu xanh lá cây nhạt */
            color: #558b2f; /* Màu xanh lá cây đậm */
        }

        /* Tình trạng Đã hủy */
        .status-cancelled {
            background-color: #ffcdd2; /* Màu đỏ nhạt */
            color: #d32f2f; /* Màu đỏ đậm */
        }

        /* Tình trạng Không xác định */
        .status-unknown {
            background-color: #e0e0e0; /* Màu xám nhạt */
            color: #616161; /* Màu xám đậm */
        }


    </style>
</head>
<body>
<jsp:include page="../header_user.jsp"/>
<div class="container">
    <h2 class="text-center my-4">Lịch Sử Mua Hàng</h2>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center">${errorMessage}</div>
    </c:if>

    <div class="row">
        <c:forEach var="hoaDon" items="${hoaDonList}">
            <div class="col-12">
                <div class="card order-card">
                    <div class="action-button">
                        <a href="/doi-tra/chi-tiet?id=${hoaDon.id}" class="btn btn-outline-primary btn-sm">Xem Chi Tiết</a>
                    </div>
                    <div class="card-body">
                        <div class="order-header">Mã Hóa Đơn: ${hoaDon.soHoaDon}</div>
                        <p>Ngày Tạo: ${hoaDon.ngayTao}</p>
                        <p>Tổng Tiền: <strong>${hoaDon.tongTien} đ</strong></p>
                        <p>
                            Tình Trạng:
                            <c:choose>
                                <c:when test="${hoaDon.tinh_trang == 0}">
                                    <span class="order-status status-pending">Chờ xác nhận</span>
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 1}">
                                    <span class="order-status status-awaiting-delivery">Chờ giao</span>
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 2 || hoaDon.tinh_trang == 3}">
                                    <span class="order-status status-delivering">Đang giao</span>
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 4}">
                                    <span class="order-status status-completed">Hoàn thành</span>
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 11}">
                                    <span class="order-status status-return-pending">Chờ xác nhận đổi trả</span>
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 12}">
                                    <span class="order-status status-returning">Chờ đổi trả</span>
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 13}">
                                    <span class="order-status status-returned">Đã đổi trả</span>
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 14}">
                                    <span class="order-status status-cancelled">Đã hủy</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="order-status status-unknown">Không xác định</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <h6>Chi Tiết Sản Phẩm:</h6>
                        <div class="product-list">
                            <c:forEach var="chiTiet" items="${hoaDon.hoaDonChiTietList}">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <img src="${pageContext.request.contextPath}/uploads/${chiTiet.sanPhamChiTiet.hinhAnh}"
                                             alt="Hình ảnh sản phẩm" class="me-3" style="width: 100px; height: auto;">
                                        <div>
                                            <span>${chiTiet.sanPhamChiTiet.sanPham.ten}</span>
                                        </div>
                                    </div>
                                    <span>Số Lượng: ${chiTiet.so_luong}</span>
                                </li>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<jsp:include page="../footer_user.jsp"/>
</body>
</html>
