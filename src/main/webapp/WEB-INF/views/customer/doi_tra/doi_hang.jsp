<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Nhận Đổi Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<style>
    .modal-content {
        border-radius: 10px;
    }
    .d-none {
        display: none !important;
    }
    .info-box {
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .info-box h5 {
        color: #007bff;
        font-size: 1.2rem;
    }

    .info-box p {
        font-size: 1rem;
        color: #333;
    }

    .info-box span {
        font-weight: bold;
    }

    .select-wrapper {
        border-radius: 10px;
        border: 1px solid #007bff;
        padding: 10px;
        background-color: #f1f1f1;
        margin-bottom: 20px;
    }

    .select-wrapper select {
        background-color: transparent;
        border: none;
        font-size: 1.1rem;
        width: 100%;
    }

    .card-wrapper {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 15px;
        justify-content: center;
    }

    .card-item {
        display: flex;
        flex-direction: column;
        height: 100%;
    }

    .card {
        border: 1px solid #ddd;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: column;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        background-color: white;
        min-height: 300px;
        height: 100%;
    }

    .card-body {
        padding: 15px;
        display: flex;
        flex-direction: column;
        flex-grow: 1;
        justify-content: space-between;
        text-align: center;
        min-height: 250px;
    }

    .card-title {
        font-size: 1.1rem;
        color: #007bff;
        margin-bottom: 10px;
        font-weight: bold;
    }

    .card-text {
        font-size: 1rem;
        margin-bottom: 15px;
        color: #333;
    }

    .card-price {
        font-weight: bold;
        color: #28a745;
    }

    .card-quantity {
        font-size: 0.9rem;
        color: #6c757d;
    }

    .card-img {
        max-height: 180px;
        object-fit: cover;
        margin-bottom: 15px;
        border-radius: 8px;
        width: 100%;
    }

    .card-btn {
        padding: 5px 10px;
        font-size: 1rem;
        text-transform: uppercase;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 50%;
        transition: background-color 0.3s;
        align-self: center;
        margin-top: auto;
    }

    .card-btn:hover {
        background-color: #0056b3;
    }

    .card-btn i {
        font-size: 1.2rem;
    }

    /* Hiệu ứng hover cho thông tin khuyến mãi */
    .khuyen-mai-info {
        position: relative;
        padding: 10px;
        border: 1px solid #e5e5e5;
        border-radius: 5px;
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }

    .khuyen-mai-info:hover {
        background-color: #f0faff; /* Tông màu nhẹ nhàng */
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Shadow mềm */
        cursor: pointer;
    }

    /* Dropdown container */
    .product-info-dropdown {
        display: none; /* Ẩn mặc định */
        position: absolute;
        top: calc(100% + 10px); /* Hiển thị ngay dưới cell */
        left: 0;
        width: 250px;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        padding: 15px;
        z-index: 1000;
        opacity: 0;
        transform: translateY(-10px); /* Hiệu ứng ẩn */
        transition: opacity 0.3s ease, transform 0.3s ease;
    }

    /* Hiển thị dropdown khi hover hoặc khi có lớp active */
    .khuyen-mai-info:hover .product-info-dropdown,
    .khuyen-mai-info.active .product-info-dropdown {
        display: block;
        opacity: 1;
        transform: translateY(0);
    }

    /* Dropdown tiêu đề */
    .dropdown-title {
        margin-bottom: 10px;
        font-size: 16px;
        font-weight: 600;
        color: #333;
        border-bottom: 1px solid #e5e5e5;
        padding-bottom: 5px;
    }

    /* Danh sách sản phẩm */
    .dropdown-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    /* Sản phẩm item */
    .dropdown-item {
        padding: 8px 10px;
        font-size: 14px;
        color: #555;
        transition: background-color 0.3s ease, color 0.3s ease;
        border-radius: 3px;
    }

    .dropdown-item:hover {
        background-color: #f9f9f9;
        color: #007bff;
    }

    /* Nút X đẹp hơn */
    .delete-link {
        margin-left: 10px;
        color: red;
        cursor: pointer;
        font-size: 16px;
    }

    .delete-link:hover {
        color: #dc3545;
    }


    .delete-link {
        margin-left: 10px;
        font-weight: bold;
        font-size: 16px;
        text-decoration: none;
        padding: 2px 6px;
        border-radius: 50%;
        transition: background-color 0.3s ease, color 0.3s ease;
    }

    .delete-link:hover {
        background-color: #dc3545;
        color: white !important;
    }


    .delete-link:focus {
        outline: none;
    }

    /* Ẩn mũi tên của input */
    input[type="number"]::-webkit-outer-spin-button,
    input[type="number"]::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }

    /* Ẩn mũi tên trong Firefox */
    input[type="number"] {
        -moz-appearance: textfield;
    }

    #doi-hang .card-wrapper {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
    }
    #doi-hang .card-body {
        padding: 15px;
    }

</style>
    <body>
<jsp:include page="../header_user.jsp"/>
<div class="container my-4">
    <h2 class="text-center mb-4">Xác Nhận Đổi Hàng</h2>

    <div class="card-1">
        <div class="card-body-1">
            <form action="${pageContext.request.contextPath}/doi-tra/hien-thi-thong-tin-doi-hang" method="post" enctype="multipart/form-data">
                <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                <input type="hidden" name="lyDo" value="${lyDo}">
                <input type="hidden" name="lyDoDetail" value="${lyDoDetail}">
                <h6>Các Sản Phẩm Bạn Cần Đổi:</h6>
                <ul class="list-group mb-3">
                    <c:forEach var="product" items="${selectedProducts}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/uploads/${product.hinhAnh}" alt="Hình ảnh sản phẩm" class="me-3" style="width: 80px; height: 80px; object-fit: cover;">
                                <span>${product.sanPham.ten}</span>
                            </div>
                            <div>
                                <span><fmt:formatNumber value="${giaSanPhamMap[product.id]}" type="number" pattern="#,###" /> VNĐ</span>
                            </div>
                            <div>
                                <label>Số lượng:</label>
                                <input type="number" name="soLuong_${product.id}" value="${soLuongMap[product.id]}"
                                       min="1" max="${soLuongMap[product.id]}" class="form-control"
                                       style="width: 80px;" required>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <div class="mb-3">
                    <label for="ghiChu" class="form-label">Mô Tả:</label>
                    <textarea id="ghiChu" name="moTa" class="form-control"></textarea>
                </div>

                <div class="mb-3">
                    <label for="uploadImage" class="form-label">Tải Ảnh Chứng Minh:</label>
                    <input type="file" id="uploadImage" name="uploadImage" class="form-control" accept="image/*" required>
                </div>
                <h6 class="mt-4">Chọn Sản Phẩm Đổi</h6>
                <div class="modal-body">
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <div class="card-wrapper">
                                <c:forEach items="${sanPhamChiTiets}" var="sp">
                                    <c:if test="${sp != null && sp.id != null && sp.tinhTrang == 1}">
                                        <div class="card-item" data-product-id="${sp.id}">
                                            <div class="card">
                                                <div class="card-body text-center">
                                                    <c:if test="${sp.hinhAnh != null}">
                                                        <img src="${pageContext.request.contextPath}/uploads/${sp.hinhAnh}" class="card-img"/>
                                                    </c:if>
                                                    <h5 class="card-title">${sp.sanPham.ten}</h5>
                                                    <p class="card-text">Giá: <fmt:formatNumber value="${sp.giaBan}" type="number" pattern="#,###" /> VND</p>
                                                    <p class="card-text">Số lượng tồn: ${sp.soLuong}</p>
                                                    <div id="quantity-input-${sp.id}" class="mt-3">
                                                        <label for="soLuong_${sp.id}">Nhập số lượng:</label>
                                                        <input type="number" name="soLuongDoi_${sp.id}" id="soLuongDoi_${sp.id}"
                                                               min="1" max="${sp.soLuong}" class="form-control"
                                                               placeholder="Nhập số lượng muốn đổi">
                                                    </div>
                                                    <button type="button" class="btn btn-primary toggle-btn" data-selected="false"
                                                            onclick="toggleProduct(this, ${sp.id})">Chọn</button>
                                                    <input type="hidden" id="sanPhamChiTietDoiIds" name="sanPhamChiTietDoiIds" value="">
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <p>Lý Do Đổi Trả: ${lyDo}</p>
                <p>Lý Do Cụ Thể: ${lyDoDetail}</p>
                <div class="mt-3">
                    <a href="/doi-tra/chi-tiet?id=${hoaDon.id}" class="btn btn-warning">Quay Lại</a>
                    <form id="doiTraForm" method="POST" action="/doi-tra/luu-thong-tin-doi-hang" enctype="multipart/form-data">
                        <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                        <input type="hidden" name="lyDo" value="${lyDo}">
                        <input type="hidden" name="lyDoDetail" value="${lyDoDetail}">
                        <input type="hidden" name="moTa" value="${moTa}">
                        <c:forEach var="product" items="${selectedProducts}">
                            <input type="hidden" name="sanPhamChiTietIds" value="${product.id}">
                        </c:forEach>
                    </form>
                    ${errorTongtien}
                    ${error}
                    <input type="hidden" name="soLuongSanPham" id="soLuongSanPham" value="1">
                        <button type="submit" class="btn btn-primary">Xác nhận đổi hàng</button>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="../footer_user.jsp"/>

<script>
    function toggleProduct(button, productId) {
        const isSelected = button.getAttribute('data-selected') === 'true';
        const hiddenInput = document.querySelector('input#sanPhamChiTietDoiIds');
        const quantityInput = document.querySelector(`#quantity-input-${productId}`);
        let selectedIds = hiddenInput.value ? hiddenInput.value.split(',') : [];
        if (isSelected) {
            button.setAttribute('data-selected', 'false');
            button.textContent = 'Chọn';
            selectedIds = selectedIds.filter(id => id !== productId.toString());
            if (quantityInput) {
                quantityInput.classList.add('d-none');
            }
        } else {
            button.setAttribute('data-selected', 'true');
            button.textContent = 'Bỏ chọn';
            if (!selectedIds.includes(productId.toString())) {
                selectedIds.push(productId);
            }

            if (quantityInput) {
                quantityInput.classList.remove('d-none');
            }
        }

        hiddenInput.value = selectedIds.join(',');
    }

    function submitForm() {
        const form = document.querySelector('#doiTraForm');
        const sanPhamChiTietIds = document.querySelector('#sanPhamChiTietDoiIds').value;

        if (!sanPhamChiTietIds) {
            alert('Vui lòng chọn ít nhất 1 sản phẩm!');
            return false;
        }

        form.submit();
    }

    document.querySelector('button[type="submit"]').addEventListener('click', submitForm);
</script>

</body>
</html>
