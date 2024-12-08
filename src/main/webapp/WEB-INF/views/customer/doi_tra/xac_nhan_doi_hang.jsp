<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin đổi hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .total-price {
            font-size: 1.2rem;
            font-weight: bold;
        }
    </style>
</head>
<body>
<jsp:include page="../header_user.jsp"/>

<div class="container my-4">
    <h1 class="text-center mb-4">Thông tin đổi hàng</h1>
    <form action="/doi-tra/xac-nhan-doi-hang" method="post" enctype="multipart/form-data" class="d-inline">

    <div class="card">
        <div class="card-body">
            <h4>Mã hóa đơn ID: ${hoaDon.soHoaDon}</h4>
            <p><strong>Lý do đổi hàng:</strong> ${lyDo}</p>
            <p><strong>Lý do chi tiết:</strong> ${lyDoDetail}</p>
            <p><strong>Mô tả:</strong> ${moTa}</p>

            <c:if test="${not empty uploadImage}">
                <p><strong>Ảnh chứng minh:</strong></p>
                <img src="${pageContext.request.contextPath}/uploads/${uploadImage}" alt="Ảnh chứng minh" class="product-img">
            </c:if>

            <h5 class="mt-4">Danh sách sản phẩm muốn đổi:</h5>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Hình ảnh</th>
                    <th>Số lượng</th>
                    <th>Đơn giá</th>
                    <th>Thành tiền</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="product" items="${selectedProducts}">
                    <input type="hidden" name="sanPhamChiTietIds[]" value="${product.id}">
                    <input type="hidden" name="soLuong_${product.id}" value="${soLuongMap[product.id]}">
                    <tr>
                        <td>${product.sanPham.ten}</td>
                        <td>
                            <img src="${pageContext.request.contextPath}/uploads/${product.hinhAnh}" class="product-img" alt="Ảnh sản phẩm">
                        </td>
                        <td>${soLuongMap[product.id]}</td>
                        <td>${giaSanPhamMap[product.id]} VND</td>
                        <td>${soLuongMap[product.id] * giaSanPhamMap[product.id]} VND</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <h5 class="mt-4">Danh sách sản phẩm đổi:</h5>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Hình ảnh</th>
                    <th>Số lượng</th>
                    <th>Đơn giá</th>
                    <th>Thành tiền</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="product" items="${sanPhamChiTietDoiList}">
                    <input type="hidden" name="sanPhamChiTietDoiIds[]" value="${product.id}">
                    <input type="hidden" name="soLuong_${product.id}" value="${soLuongMapDoi[product.id]}">
                    <tr>
                        <td>${product.sanPham.ten}</td>
                        <td>
                            <img src="${pageContext.request.contextPath}/uploads/${product.hinhAnh}" class="product-img" alt="Ảnh sản phẩm">
                        </td>
                        <td>${soLuongMapDoi[product.id]}</td>
                        <td>${giaSanPhamMapDoi[product.id]} VND</td>
                        <td>${soLuongMapDoi[product.id] * giaSanPhamMapDoi[product.id]} VND</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <h5 class="total-price mt-4">Tổng tiền đổi hàng: ${tongTienDoi} VND</h5>
            <h5 class="total-price mt-2">Tổng tiền hoàn trả: ${tongTienHoan} VND</h5>
            <h5 class="total-price mt-2">Tổng tiền cần bù: ${tongTienDoi - tongTienHoan} VND</h5>

            <div class="mt-4">
                <a href="/doi-tra/chi-tiet?id=${hoaDon.id}" class="btn btn-warning">Quay lại</a>
                    <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                    <input type="hidden" name="lyDo" value="${lyDo}">
                    <input type="hidden" name="lyDoDetail" value="${lyDoDetail}">
                    <input type="hidden" name="moTa" value="${moTa}">
                    <input type="hidden" name="sanPhamChiTietIds" value="${sanPhamChiTietIdsStr}">
                    <input type="hidden" name="sanPhamChiTietDoiIds" value="${sanPhamChiTietIdsStr}">
                    <div class="mb-3">
                        <label for="uploadImage" class="form-label">Ảnh chứng minh:</label>
                        <input type="file" class="form-control" id="uploadImage" name="uploadImage" required>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                        <div class="alert alert-danger">${errorTongtien}</div>
                    </c:if>


                    <button type="submit" class="btn btn-primary">Xác nhận đổi hàng</button>
            </div>
        </div>
    </div>
    </form>

</div>

<jsp:include page="../footer_user.jsp"/>
</body>
</html>
