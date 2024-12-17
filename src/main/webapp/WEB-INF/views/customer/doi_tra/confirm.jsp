<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Xác Nhận Đổi Trả</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../header_user.jsp"/>
<div class="container my-4">
    <h2 class="text-center">Xác Nhận Đổi Trả</h2>
    <div class="card">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/doi-tra/xac-nhan" method="post" enctype="multipart/form-data">
                <input type="hidden" name="hoaDonId" value="${hoaDonId}">
                <input type="hidden" name="lyDo" value="${lyDo}">
                <input type="hidden" name="lyDoDetail" value="${lyDoDetail}">
                <input type="hidden" name="hinhThucHoan" value="${hinhThucHoan}">

                <c:forEach var="product" items="${selectedProducts}">
                    <input type="hidden" name="sanPhamChiTietIds" value="${product.id}">
                </c:forEach>

                <h6>Danh Sách Sản Phẩm Đổi Trả:</h6>
                <ul class="list-group">
                    <c:forEach var="product" items="${selectedProducts}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/uploads/${product.hinhAnh}"
                                     alt="Hình ảnh sản phẩm" class="me-3" style="width: 100px; height: auto;">
                                <span>${product.sanPham.ten}</span>
                            </div>
                            <div>
                                <label>Số lượng: </label>
                                <input type="number" name="soLuong_${product.id}" value="${soLuongMap[product.id]}"
                                       min="1" max="${soLuongMap[product.id]}" class="form-control" style="width: 80px;">
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <p>Hình Thức: ${hinhThucHoan}</p>
                <p>Lý Do Đổi Trả: ${lyDo}</p>
                <p>Lý Do Cụ Thể: ${lyDoDetail}</p>
                <div class="mb-3">
                    <label for="tongTienHoan" class="form-label">Tổng Tiền Phải Hoàn:</label>
                    <input type="text" id="tongTienHoan" name="tongTienHoan" class="form-control" value="${tongTienHoan}" readonly>
                </div>
                <div class="mb-3">
                    <label for="phuongThucChuyenTien" class="form-label">Phương Thức Chuyển Tiền:</label>
                    <select id="phuongThucChuyenTien" name="phuongThucChuyenTien" class="form-select" onchange="toggleBankFields()">
                        <option value="Tiền mặt">Tiền mặt</option>
                        <option value="Chuyển khoản">Chuyển khoản</option>
                    </select>
                </div>
                <div class="mb-3" id="bankDetails" style="display: none;">
                    <label for="tenNganHang" class="form-label">Tên Ngân Hàng:</label>
                    <input type="text" id="tenNganHang" name="tenNganHang" class="form-control" placeholder="Nhập tên ngân hàng">

                    <label for="soNganHang" class="form-label">Số Ngân Hàng:</label>
                    <input type="text" id="soNganHang" name="soNganHang" class="form-control" placeholder="Nhập số ngân hàng">
                </div>
                <div class="mb-3">
                    <label for="ghiChu" class="form-label">Mô Tả:</label>
                    <textarea id="ghiChu" name="moTa" class="form-control"></textarea>
                </div>
                <div class="mb-3">
                    <label for="uploadImage" class="form-label">Tải Ảnh Chứng Minh:</label>
                    <input type="file" id="uploadImage" name="uploadImage" class="form-control" accept="image/*" required>
                </div>
                <div class="mt-3">
                    <a href="/doi-tra/chi-tiet?id=${hoaDon.id}" class="btn btn-warning">Quay Lại</a>
                    <button type="submit" class="btn btn-success">Xác Nhận Đổi Trả</button>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="../footer_user.jsp"/>
<script>
    function toggleBankFields() {
        var phuongThucChuyenTien = document.getElementById("phuongThucChuyenTien").value;
        var bankFields = document.getElementById("bankDetails");
        if (phuongThucChuyenTien === "Chuyển khoản") {
            bankFields.style.display = "block";
        } else {
            bankFields.style.display = "none";
        }
    }
</script>
</body>
</html>
