<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css">
    <style>
        body {
            background: linear-gradient(to right, #4CAF50, #0B745E);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .modal-content {
            border-radius: 12px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
            background: #ffffff;
            transition: transform 0.3s ease;
            width: 80%;
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
        }

        .modal-header {
            background: linear-gradient(to right, #005b46, #532B0E);
            color: #fff;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
            padding: 20px;
            font-weight: bold;
            text-align: center;
        }

        .modal-body {
            padding: 40px;
            color: #333;
        }

        .modal-footer {
            padding: 20px;
            border-top: none;
            justify-content: space-between;
        }

        .modal-content:hover {
            transform: scale(1.02);
        }

        .product-list li {
            margin-bottom: 15px;
        }

        .product-list li span {
            font-weight: 600;
            color: #333;
        }

        .total-price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #28a745;
            background-color: #eaf9e6;
            border-radius: 8px;
            padding: 10px;
            margin-top: 20px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }

        .discount {
            font-size: 1.25rem;
            font-weight: 600;
            color: #0d6efd;
            background-color: #e3f2fd;
            border-radius: 8px;
            padding: 10px;
            margin-top: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }

        .discount span {
            font-weight: 700;
            color: #155a8a;
        }

        .btn {
            padding: 12px 20px;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 8px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #005b46, #532B0E);
            border-color: #0056b3;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            transform: translateY(-3px);
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-3px);
        }

        .container {
            margin-top: 50px;
        }

        .container, .modal-body {
            padding-left: 15px;
            padding-right: 15px;
        }

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
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận Đơn hàng</h5>
                </div>
                <div class="modal-body">
                    <p hidden><strong>ID:</strong> ${hoaDon.id}</p>
                    <p><strong>Số Hóa Đơn:</strong> ${hoaDon.soHoaDon}</p>
                    <p><strong>Phương Thức Thanh Toán:</strong> ${hoaDon.phuong_thuc_thanh_toan}</p>
                    <p><strong>Ghi Chú:</strong>
                        <c:choose>
                            <c:when test="${empty hoaDon.ghiChu}">Không có ghi chú</c:when>
                            <c:otherwise>${hoaDon.ghiChu}</c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Ngày Tạo:</strong> ${formattedThoiGianTao}</p>
                    <p><strong>Tên Khách Hàng:</strong>
                        <c:choose>
                            <c:when test="${empty hoaDon.khachHang}">Khách lẻ</c:when>
                            <c:otherwise>${hoaDon.khachHang.tenKhachHang}</c:otherwise>
                        </c:choose>
                    </p>
                    <h6>Chi Tiết Sản Phẩm:</h6>
                    <ul class="list-group product-list">
                        <c:forEach items="${chiTietList}" var="chiTiet">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                    ${chiTiet.sanPhamChiTiet.sanPham.ten}
                                <span>${chiTiet.so_luong} x <fmt:formatNumber value="${chiTiet.gia_san_pham}" type="number" pattern="#,###" /> VNĐ</span>
                            </li>
                        </c:forEach>
                    </ul>
                    <p class="total-price">
                        <strong>Tổng Tiền:</strong> <span><fmt:formatNumber value="${hoaDon.tongTien}" type="number" pattern="#,###" /> VNĐ</span>
                    </p>
                    <h5 class="discount">
                        <strong>Giảm giá:</strong> <span id="discountedPrice"><fmt:formatNumber value="${discountAmount}" type="number" pattern="#,###" /> VNĐ</span>
                    </h5>
                </div>
                <div class="modal-footer">
<<<<<<< HEAD
                    <form action="${pageContext.request.contextPath}/ban-hang/${hoaDon.id}/confirm-order" method="post">
=======
                    <!-- Form để xác nhận đơn hàng và lưu dữ liệu -->
                    <form id="orderForm" action="${pageContext.request.contextPath}/ban-hang/${hoaDon.id}/confirm-order" method="post">
>>>>>>> e30b2ebdf761dd7a8d1055c0560f34e45acf52d2
                        <input type="hidden" name="ghiChu" value="${hoaDon.ghiChu}">
                        <input type="hidden" name="soDienThoai" value="${soDienThoai}">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModal">
                            <i class="bi bi-check-circle"></i> Xác nhận Đơn hàng
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
                    <form action="${pageContext.request.contextPath}/ban-hang/${hoaDon.id}" method="get">
                        <button type="submit" class="btn btn-secondary">
                            <i class="bi bi-arrow-left-circle"></i> Quay lại chi tiết hóa đơn
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
