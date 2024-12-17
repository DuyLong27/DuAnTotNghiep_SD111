<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Product Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <style>

        .product-title {
            font-size: 24px;
            font-weight: bold;
            margin-top: 20px;
        }

        .price {
            font-size: 20px;
            color: red;
            margin-top: 10px;
        }

        .quantity {
            margin-top: 10px;
            display: flex;
            align-items: center;
        }

        .quantity input {
            text-align: center;
            width: 64px;
            border-radius: 0;
            margin: 0 10px;
        }

        .related-products {
            margin-top: 40px;
        }

        .related-products img {
            width: 100%;
        }

        .related-products .product-name {
            font-weight: bold;
        }

        .related-products .product-price {
            font-weight: normal;
        }

        .description {
            margin-top: 60px;
        }

        .row {
            margin-top: 20px;
        }

        .d-flex {
            gap: 15px;
        }

        .btn {
            white-space: nowrap;
        }

        .related-products a {
            text-decoration: none;
        }
        .alert {
            font-size: 16px;
            font-weight: 500;
            line-height: 1.5;
            border-left: 4px solid #28a745;
            padding: 15px 20px;
            background-color: #d4edda;
            color: #155724;
        }

        .alert i {
            color: #28a745;
        }


        .alert .btn-close {
            background-color: transparent;
            opacity: 0.8;
        }

        #autoCloseAlert {
            animation: fadeOut 3s forwards;
        }

        @keyframes fadeOut {
            0% {
                opacity: 1;
            }
            80% {
                opacity: 1;
            }
            100% {
                opacity: 0;
                display: none;
            }
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
        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type="number"] {
            -moz-appearance: textfield;
        }
    </style>
</head>
<body>
<jsp:include page="../header_user.jsp"/>
<div class="container mt-5">
    <div class="container mt-3 position-relative">
        <c:if test="${not empty message}">
            <div id="autoCloseAlert" class="alert alert-success alert-dismissible fade show shadow-lg rounded"
                 role="alert"
                 style="max-width: 500px; margin: 0 auto; position: fixed; top: 20px; left: 50%; transform: translateX(-50%); z-index: 1050;">
                <i class="fa-solid fa-check-circle me-2"></i>
                <span>${message}</span>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
    </div>
    <div class="row">
        <div class="col-lg-9">
            <div class="row">
                <div class="col-md-6">
                    <img src="${pageContext.request.contextPath}/uploads/${sanPhamChiTiet.hinhAnh}"
                         class="card-img-top product-image">
                </div>
                <div class="col-md-6">
                    <input type="text" name="id" value="${sanPhamChiTiet.id}" hidden>
                    <h1 class="product-title" style="font-size: 35px;">${sanPhamChiTiet.sanPham.ten}</h1>
                    <div class="price">
                        <c:choose>
                            <c:when test="${sanPhamChiTiet.giaGiamGia != null and sanPhamChiTiet.giaGiamGia > 0}">
                    <span style="color: red; text-decoration: line-through; font-size: 20px;">
                        <fmt:formatNumber value="${sanPhamChiTiet.giaBan}" type="number" pattern="#,###" /> VNĐ
                    </span>
                                <br>
                                <span style="color: green; font-size: 30px;">
                        <fmt:formatNumber value="${sanPhamChiTiet.giaGiamGia}" type="number" pattern="#,###" /> VNĐ
                    </span>
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${sanPhamChiTiet.giaBan}" type="number" pattern="#,###" /> VNĐ
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <hr>
                    <div class="items">
                        <c:if test="${sanPhamChiTiet.soLuong > 0}">
                            <p class="text-success">Còn ${sanPhamChiTiet.soLuong} sản phẩm trong kho</p>
                            <hr>
                            <div class="row mt-3">
                                <div class="col-12">
                                    <div class="col-12 d-flex justify-content-between align-items-center gap-3">
                                        <form action="/danh-sach-san-pham-chi-tiet/add" method="post" class="w-100">
                                            <input type="hidden" name="sanPhamId" value="${sanPhamChiTiet.id}">
                                            <div class="form-group">
                                                <label for="soLuong">Số lượng</label>
                                                <input type="number" id="soLuong" name="soLuong" class="form-control" min="1" max="${sanPhamChiTiet.soLuong}" value="1">
                                            </div>
                                            <button type="submit" class="product-cart btn btn-dark btn-lg w-100 text-center mt-3">Thêm vào giỏ hàng</button>
                                        </form>
                                    </div>
                                    <form action="/danh-sach-san-pham-chi-tiet/mua-ngay" method="get" class="w-100">
                                        <input type="hidden" name="productId" value="${sanPhamChiTiet.id}">
                                        <button type="button" class="product-buy btn btn-success btn-lg w-100 text-center mt-3"
                                                data-bs-toggle="modal" data-bs-target="#productModal">
                                            Mua ngay
                                        </button>
                                    </form>
                                </div>
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger">${errorMessage}</div>
                                </c:if>
                            </div>
                        </c:if>
                        <c:if test="${sanPhamChiTiet.soLuong <= 0}">
                            <p class="text-danger">Hãy đợi cửa hàng cập nhật thêm nhé, mong khách hàng thông cảm!</p>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="description mt-10">
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link active" data-bs-toggle="pill" href="#home" style="color: black">Thông tin sản
                            phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="pill" href="#menu1" style="color: black">Nhận xét</a>
                    </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane container active" id="home">
                        <h3 class="mt-2">Thông tin sản phẩm</h3>
                        <p>Mô tả sản phẩm: ${sanPhamChiTiet.sanPham.moTa}</p>
                        <p>Trọng lượng: ${sanPhamChiTiet.canNang.ten}</p>
                        <p>Loại hạt: ${sanPhamChiTiet.loaiHat.ten}</p>
                        <p>Loại túi: ${sanPhamChiTiet.loaiTui.ten}</p>
                        <p>Mức độ rang: ${sanPhamChiTiet.mucDoRang.ten}</p>
                        <p>Hương vị: ${sanPhamChiTiet.huongVi.ten}</p>
                        <p>Thương hiệu: ${sanPhamChiTiet.thuongHieu.ten}</p>
                    </div>
                    <div class="tab-pane container fade" id="menu1">
                        <p class="mt-3">
                            ${sanPhamChiTiet.danhGia}
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="related-products">
                <h3 class="mb-3">Sản phẩm bán chạy</h3>
                <c:forEach items="${bestSellingProducts}" var="spct">
                    <div class="row mb-3">
                        <div class="col-4">
                            <a href="/danh-sach-san-pham-chi-tiet/view-sp/${spct.id}">
                                <img src="${pageContext.request.contextPath}/uploads/${spct.hinhAnh}"
                                     class="img-fluid product-image" alt="${spct.sanPham.ten}">
                            </a>
                        </div>
                        <div class="col-8">
                            <a href="/danh-sach-san-pham-chi-tiet/view-sp/${spct.id}">
                                <p class="product-name" style="color: black">${spct.sanPham.ten}</p>
                                <c:choose>
                                    <c:when test="${spct.giaGiamGia != null and spct.giaGiamGia > 0}">
                                        <p class="product-price"
                                           style="color: red; text-decoration: line-through;"><fmt:formatNumber value="${spct.giaBan}" type="number" pattern="#,###" /> VNĐ</p>
                                        <p class="product-price" style="color: green;"><fmt:formatNumber value="${spct.giaGiamGia}" type="number" pattern="#,###" /> VNĐ</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="product-price" style="color: green;"><fmt:formatNumber value="${spct.giaBan}" type="number" pattern="#,###" /> VNĐ</p>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </div>
                    </div>
                    <hr>
                </c:forEach>
            </div>
        </div>
        <!-- Modal hiển thị thông tin sản phẩm (hiển thị nếu sản phẩm được chọn) -->
        <c:if test="${not empty sanPhamChiTiet}">
            <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content shadow-lg border-0 rounded">
                        <div class="modal-header border-bottom-0 pb-0">
                            <h5 class="modal-title fw-bold text-success" id="productPopupLabel">Mua Ngay</h5>
                            <a href="/danh-sach-san-pham-chi-tiet/view-sp/${sanPhamChiTiet.id}" class="btn-close"
                               aria-label="Close"></a>
                        </div>
                        <div class="modal-body">
                            <div class="row g-4">
                                <div class="col-md-6 d-flex flex-column align-items-center text-center">
                                    <a href="/danh-sach-san-pham-chi-tiet/view-sp/${sanPhamChiTiet.id}">
                                        <img src="${pageContext.request.contextPath}/uploads/${sanPhamChiTiet.hinhAnh}" class="card-img-top product-image rounded mb-3 shadow-sm" alt="${sanPhamChiTiet.sanPham.ten}">
                                    </a>
                                    <h5 class="fw-bold mb-2">${sanPhamChiTiet.sanPham.ten}</h5>
                                    <p class="fw-bold">Giá:
                                        <c:choose>
                                            <c:when test="${sanPhamChiTiet.giaGiamGia != null and sanPhamChiTiet.giaGiamGia > 0}">
                                                <span id="giaBan" style="text-decoration: line-through; color: red"><fmt:formatNumber value="${sanPhamChiTiet.giaBan}" type="number" pattern="#,###" /></span> VNĐ
                                                <br>
                                                <span id="giaGiamGia" style="color: green"><fmt:formatNumber value="${sanPhamChiTiet.giaGiamGia}" type="number" pattern="#,###" /></span> VNĐ
                                            </c:when>
                                            <c:otherwise>
                                                <span id="giaBan"><fmt:formatNumber value="${sanPhamChiTiet.giaBan}" type="number" pattern="#,###" /></span> VNĐ
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <p class="text-muted">Mô tả: ${sanPhamChiTiet.sanPham.moTa}</p>
                                    <div class="mb-3 d-flex align-items-center justify-content-center">
                                        <button type="button" class="btn btn-outline-secondary rounded-circle px-2" onclick="changeQuantity(-1)">-</button>
                                        <input type="number" class="form-control mx-2 text-center" id="soLuong" name="soLuong" min="1" value="1" required onchange="updateTotal()" style="width: 80px;">
                                        <button type="button" class="btn btn-outline-secondary rounded-circle px-2" onclick="changeQuantity(1)">+</button>
                                    </div>
                                    <div>
                                        <label class="form-label fw-bold">Tổng tiền:</label>
                                        <c:choose>
                                            <c:when test="${sanPhamChiTiet.giaGiamGia != null and sanPhamChiTiet.giaGiamGia > 0}">
                                                <p id="tongTien" class="text-success fw-bold"><fmt:formatNumber value="${sanPhamChiTiet.giaGiamGia}" type="number" pattern="#,###" />VNĐ</p>
                                            </c:when>
                                            <c:otherwise>
                                                <p id="tongTien" class="text-success fw-bold"><fmt:formatNumber value="${sanPhamChiTiet.giaBan}" type="number" pattern="#,###" /> VNĐ</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <c:if test="${khachHang != null}">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <label class="form-label fw-bold">Số tiền giảm giá:</label>
                                                <p id="discountAmount" class="text-success fw-bold">${discountAmount} VNĐ</p>
                                            </div>
                                            <div>
                                                <label class="form-label fw-bold">Phần trăm giảm:</label>
                                                <p id="discountRate" class="text-warning fw-bold">${discountRate}%</p>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="col-md-6 border-start">
                                    <h3 class="text-center mb-4 text-secondary">Thông tin thanh toán</h3>
                                    <form id="orderForm" action="/danh-sach-san-pham-chi-tiet/xac-nhan-hoa-don" method="post">
                                        <input type="hidden" name="sanPhamId" value="${sanPhamChiTiet.id}">
                                        <input type="hidden" name="soLuong" id="soLuongInput" value="1">
                                        <input type="hidden" name="tongTien" id="tongTienInput" value="<fmt:formatNumber value="${sanPhamChiTiet.giaBan}" type="number" pattern="#,###" />">
                                        <div class="mb-3">
                                            <label for="phuongThucThanhToan" class="form-label fw-bold">Phương thức thanh toán:</label>
                                            <select class="form-select" id="phuongThucThanhToan" name="phuongThucThanhToan" required onchange="displayImage()">
                                                <option value="Tiền mặt">Tiền mặt</option>
                                                <option value="Chuyển khoản">Chuyển khoản</option>
                                            </select>
                                        </div>
                                        <div id="imageContainer" style="display: none; text-align: center;">
                                            <img id="myImage" src="../../../../images/QRLong.png" alt="Image of transfer method" width="200" style="border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Phương thức vận chuyển:</label>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="phuongThucVanChuyen" id="giaoHangNhanh" value="Giao Hàng Nhanh" required onchange="updateTotal()">
                                                <label class="form-check-label" for="giaoHangNhanh">Giao Hàng Nhanh</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="phuongThucVanChuyen" id="giaoHangTieuChuan" value="Giao Hàng Tiêu Chuẩn" onchange="updateTotal()">
                                                <label class="form-check-label" for="giaoHangTieuChuan">Giao Hàng Tiêu Chuẩn</label>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="diaChi" class="form-label fw-bold">Địa chỉ cụ thể:</label>
                                            <input type="text" class="form-control" id="diaChi" name="diaChi" value="${khachHang != null ? khachHang.diaChi : ''}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="soDienThoai" class="form-label fw-bold">Số điện thoại:</label>
                                            <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai" value="${khachHang != null ? khachHang.soDienThoai : ''}" pattern="[0-9]{10}" required>
                                        </div>
                                        <c:choose>
                                            <c:when test="${empty khachHang}">
                                                <div class="mb-3">
                                                    <label for="email" class="form-label fw-bold">Email:</label>
                                                    <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email của bạn để nhận thông tin hóa đơn">
                                                </div>
                                            </c:when>
                                        </c:choose>
                                        <button type="button" class="btn btn-success w-100 py-2 mt-4" data-bs-toggle="modal" data-bs-target="#confirmModal">
                                            Xác nhận đơn hàng
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
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                        <button type="submit" class="btn btn-primary">Xác nhận</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</div>

<script>
    const giaBan = ${sanPhamChiTiet.giaBan != null ? sanPhamChiTiet.giaBan : 0};
    const giaGiamGia = ${sanPhamChiTiet.giaGiamGia != null ? sanPhamChiTiet.giaGiamGia : 0};
    const diemTichLuy = ${khachHang != null ? khachHang.diemTichLuy : 0};
    const discountRate = Math.min(Math.floor(diemTichLuy / 1000) * 5, 30);

    function calculateDiscountAmount(price, rate) {
        return price * (rate / 100);
    }

    function updateTotal() {
        const soLuong = parseInt(document.getElementById("soLuong").value) || 1;
        const selectedShipping = document.querySelector('input[name="phuongThucVanChuyen"]:checked');

        let shippingCost = 0;
        if (selectedShipping) {
            shippingCost = selectedShipping.value === "Giao Hàng Nhanh" ? 33000 : 20000;
        }

        const giaSuDung = giaGiamGia > 0 ? giaGiamGia : giaBan;

        const tongTienSanPham = giaSuDung * soLuong;

        let tongTien;
        if (diemTichLuy > 0) {
            const discountAmount = calculateDiscountAmount(tongTienSanPham, discountRate);
            document.getElementById("discountAmount").innerText = discountAmount.toLocaleString('vi-VN') + " VNĐ";
            tongTien = tongTienSanPham - discountAmount + shippingCost;
        } else {
            tongTien = tongTienSanPham + shippingCost;
        }

        document.getElementById("tongTien").innerText = tongTien.toLocaleString('vi-VN') + " VNĐ";
        document.getElementById("tongTienInput").value = tongTien;
    }


    document.getElementById("soLuong").addEventListener("change", updateTotal);

    document.querySelectorAll('input[name="phuongThucVanChuyen"]').forEach((input) => {
        input.addEventListener("change", updateTotal);
    });

    function changeQuantity(amount) {
        const soLuongInput = document.getElementById("soLuong");
        let currentQuantity = parseInt(soLuongInput.value);
        currentQuantity = isNaN(currentQuantity) ? 1 : currentQuantity;
        currentQuantity = Math.max(1, currentQuantity + amount);
        soLuongInput.value = currentQuantity;

        updateTotal();
    }
    updateTotal();

    function changeQuantity(amount) {
        const soLuongInput = document.getElementById("soLuong");
        const soLuongHiddenInput = document.getElementById("soLuongInput");

        let currentQuantity = parseInt(soLuongInput.value);
        currentQuantity = isNaN(currentQuantity) ? 1 : currentQuantity;
        currentQuantity = Math.max(1, currentQuantity + amount);
        soLuongInput.value = currentQuantity;

        soLuongHiddenInput.value = currentQuantity;

        updateTotal();
    }


    function displayImage() {
        var paymentMethod = document.getElementById("phuongThucThanhToan").value;
        var imageContainer = document.getElementById("imageContainer");
        if (paymentMethod === "Chuyển khoản") {
            imageContainer.style.display = "block";
        } else {
            imageContainer.style.display = "none";
        }
    }
</script>
<jsp:include page="../footer_user.jsp"/>
</body>
</html>
