<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <title>Xác nhận Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYzIY0LIzj+PZrXsSOJo9ORpB0d6BSZ/S30R7rpkhwn/tI3oU7j7Sk" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css">
</head>
<body>
<div class="container">
    <div class="modal show" tabindex="-1" style="display: block;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thông Tin Hóa Đơn</h5>
                </div>
                <div class="modal-body">
                    <p hidden><strong>ID:</strong> ${hoaDon.id}</p>
                    <p><strong>Số Hóa Đơn:</strong> ${hoaDon.so_hoa_don}</p>
                    <p><strong>Phương Thức Thanh Toán:</strong> ${hoaDon.phuong_thuc_thanh_toan}</p>
                    <p><strong>Ghi Chú:</strong>
                        <c:choose>
                            <c:when test="${empty hoaDon.ghi_chu}">
                                Không có ghi chú
                            </c:when>
                            <c:otherwise>
                                ${hoaDon.ghi_chu} <!-- Hiển thị ghi chú đã lưu -->
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Ngày Tạo:</strong> ${hoaDon.ngay_tao}</p>
                    <h6>Chi Tiết Sản Phẩm:</h6>
                    <ul>
                        <c:forEach items="${chiTietList}" var="chiTiet">
                            <li>${chiTiet.sanPhamChiTiet.sanPham.ten} - ${chiTiet.so_luong} x ${chiTiet.gia_san_pham} VNĐ</li>
                        </c:forEach>
                    </ul>
                    <p><strong>Tổng Tiền:</strong> ${hoaDon.tong_tien} VNĐ</p>
                </div>
                <div class="modal-footer">
                    <form action="${pageContext.request.contextPath}/ban-hang/${hoaDon.id}/confirm-order" method="post">
                        <button type="submit" class="btn btn-primary">Xác nhận Đơn hàng</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/ban-hang/${hoaDon.id}" method="get">
                        <button type="submit" class="btn btn-secondary">Quay lại chi tiết hóa đơn</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>