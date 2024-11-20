<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <title>Xác nhận Đơn hàng</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css">
    <style>
        body {
            background: linear-gradient(to right, #0B745E, #4CAF50); /* Chuyển từ màu xanh sang vàng */
            font-family: 'Arial', sans-serif;
        }
        .modal-content {
            border-radius: 15px;
            box-shadow: 0px 6px 16px rgba(0, 0, 0, 0.15);
            background: #ffffff;
            transition: transform 0.3s ease;
        }
        .modal-header {
            background: linear-gradient(135deg, #0B745E, #532B0E);
            color: #fff;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            padding: 20px;
        }
        .modal-header h5 {
            font-weight: bold;
        }
        .modal-body {
            padding: 40px;
        }
        .modal-footer {
            padding: 20px;
            border-top: none;
            justify-content: space-between;
        }
        .modal-content:hover {
            transform: scale(1.02);
        }
        .product-list {
            margin-top: 20px;
        }
        .product-list li {
            margin-bottom: 12px;
        }
        .product-list li span {
            font-weight: 600;
            color: #333;
        }
        .total-price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #28a745;
        }
        .btn {
            padding: 12px 20px;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 8px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .btn-primary {
            background: linear-gradient(135deg, #0B745E, #532B0E);
            border-color: #532B0E;
        }
        .btn-primary:hover {
            background-color: #4CAF50;
            transform: translateY(-2px);
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
        }
        .container {
            margin-top: 30px;
        }

    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
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
                            <c:when test="${empty hoaDon.ghiChu}">
                                Không có ghi chú
                            </c:when>
                            <c:otherwise>
                                ${hoaDon.ghiChu}
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Ngày Tạo:</strong> ${hoaDon.ngayTao}</p>

                    <p><strong>Tên Khách Hàng:</strong>
                        <c:choose>
                            <c:when test="${empty hoaDon.khachHang}">
                                Khách lẻ
                            </c:when>
                            <c:otherwise>
                                ${hoaDon.khachHang.tenKhachHang}
                            </c:otherwise>
                        </c:choose>
                    </p>


                    <h6>Chi Tiết Sản Phẩm:</h6>
                    <ul class="list-group product-list">
                        <c:forEach items="${chiTietList}" var="chiTiet">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                    ${chiTiet.sanPhamChiTiet.sanPham.ten}
                                <span>${chiTiet.so_luong} x ${chiTiet.gia_san_pham} VNĐ</span>
                            </li>
                        </c:forEach>
                    </ul>
                    <p class="total-price mt-2"><strong>Tổng Tiền:</strong> ${hoaDon.tongTien} VNĐ</p>
                </div>
                <div class="modal-footer">
                    <!-- Form để xác nhận đơn hàng và lưu dữ liệu -->
                    <form action="${pageContext.request.contextPath}/ban-hang/${hoaDon.id}/confirm-order" method="post">
                        <input type="hidden" name="ghiChu" value="${hoaDon.ghiChu}">
                        <input type="hidden" name="soDienThoai" value="${soDienThoai}">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle"></i> Xác nhận Đơn hàng
                        </button>
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
