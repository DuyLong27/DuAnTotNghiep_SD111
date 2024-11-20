<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Danh sách sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        /* Styles for the product image */
        .product-image {
            width: 100%;
            height: 250px;
            object-fit: cover; /* Prevents image distortion */
        }

        /* Sidebar styles */
        #sidebar {
            background-color: #f8f9fa; /* Sidebar background color */
            border-right: 1px solid #dee2e6; /* Sidebar right border */
            padding: 20px;
            height: 100%; /* Ensures full height */
        }

        /* Sidebar links */
        #sidebar .nav-link {
            color: #0B745E; /* Default link color */
            font-weight: 500; /* Bold text */
            padding: 10px 15px;
            border-radius: 5px; /* Rounded corners */
            transition: background-color 0.3s ease, color 0.3s ease; /* Transition for color and background */
        }

        /* Sidebar hover effect */
        #sidebar .nav-link:hover {
            background-color: #0B745E; /* Background color on hover */
            color: #ffffff; /* Text color on hover */
        }

        /* Submenu items */
        #sidebar .collapse .nav-item .nav-link {
            padding-left: 30px; /* Indentation for submenu items */
        }

        /* Submenu hover effect */
        #sidebar .collapse .nav-item .nav-link:hover {
            background-color: #e9ecef; /* Background color on hover for submenu */
            color: #0B745E; /* Text color on hover for submenu */
        }

        /* Collapse arrow icon */
        #sidebar .nav-item a[data-bs-toggle="collapse"]:after {
            content: '\f107'; /* Font Awesome caret down icon */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            float: right;
            transition: transform 0.3s ease; /* Smooth arrow rotation */
        }

        /* Rotate arrow when expanded */
        #sidebar .nav-item a[data-bs-toggle="collapse"][aria-expanded="true"]:after {
            transform: rotate(180deg);
        }

        /* Expanded collapse effect */
        #sidebar .collapse.show {
            border-left: 2px solid #0B745E;
            margin-left: 10px;
            transition: border-left 0.5s ease, margin-left 0.5s ease;
            opacity: 1;
        }

        /* Collapsed collapse effect */
        #sidebar .collapse {
            border-left: 2px solid transparent;
            transition: border-left 0.5s ease, margin-left 0.5s ease;
        }

        /* Active link in the sidebar */
        #sidebar .nav-item a.active {
            background-color: #0B745E;
            color: #ffffff;
        }

        /* Combobox (dropdown for sorting) styling */
        .form-select {
            width: 200px; /* Set width */
            padding: 5px;
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            background-color: #fff;
            transition: border-color 0.3s ease-in-out;
        }

        /* Hover effect for combobox */
        .form-select:hover {
            border-color: #0B745E;
        }

        /* Focus effect for combobox */
        .form-select:focus {
            border-color: #0B745E;
            box-shadow: 0 0 5px rgba(11, 116, 94, 0.5);
        }

        /* Combobox option style */
        .form-select option {
            padding: 5px;
            font-size: 14px;
        }

        /* Product card layout */
        .product-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            transition: box-shadow 0.3s ease;
            background-color: #fff;
        }

        /* Hover effect for product card */
        .product-card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Product card title */
        .product-card-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }

        /* Product card description */
        .product-card-description {
            font-size: 14px;
            color: #777;
            margin-bottom: 10px;
        }


        .product-card-price {
            font-size: 16px;
            font-weight: bold;
            color: #0B745E;
        }


        .product-card .btn {
            background-color: #0B745E;
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }


        .product-card .btn:hover {
            background-color: #084d3c;
            color: white;
        }

        .product-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }


        .product-grid-item {
            flex: 1 1 calc(33.333% - 20px);
            max-width: calc(33.333% - 20px);
        }

        /* Responsive for smaller screens */
        @media (max-width: 768px) {
            .product-grid-item {
                flex: 1 1 calc(50% - 20px);
                max-width: calc(50% - 20px);
            }
        }

        @media (max-width: 576px) {
            .product-grid-item {
                flex: 1 1 100%;
                max-width: 100%;
            }
        }


        .nav-link {
            color: #0B745E;
            transition: color 0.3s ease;
        }


        .nav-link:hover {
            color: #084d3c;
            text-decoration: none;
        }

        .card {
            overflow: hidden;
        }

        .product-image {
            transition: transform 0.3s ease;
        }

        .card:hover .product-image {
            transform: scale(1.1);
        }

        .product-quantity {
            display: none;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 10px;
            border-radius: 5px;
            z-index: 10;
        }

        .card:hover .product-quantity {
            display: block;
        }

        .product-quantity.top-50 {
            top: 35% !important;
        }

        .product-buy, .product-cart {
            display: none;
            background-color: rgba(11, 116, 94, 1);
            padding: 10px;
            border-radius: 5px;
            z-index: 10;
        }

        .card:hover .product-buy, .card:hover .product-cart {
            display: block;
        }


        .product-cart.top-50, .product-buy.top-50 {
            top: 50% !important;
        }

        .product-cart.start-50 {
            left: 56% !important;
        }

        .product-buy.start-50 {
            left: 43% !important;
        }

        .product-buy a i, .product-cart a i {
            transition: transform 0.3s ease, color 0.3s ease;
            color: white !important;
        }

        .product-buy a:hover i, .product-cart a:hover i {
            transform: scale(1.2);
        }

        .btn-custom {
            background-color: rgba(11, 116, 94, 1);
            border: none;
            width: 25px;
            height: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.3s, transform 0.3s;
        }

        .btn-custom i {
            color: white !important;
            font-size: 20px;
            transition: transform 0.3s;
        }

        .btn-custom:hover {
            transform: scale(1.1);
        }

        .modal.show {
            display: block;
            opacity: 1;
        }
        #soLuong::-webkit-outer-spin-button,
        #soLuong::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        #soLuong {
            -moz-appearance: textfield;
        }

        .discount-badge {
            position: absolute;
            top: 0;
            right: 0;
            background-color: red;
            color: white;
            padding: 5px 10px;
            font-size: 12px;
            border-bottom-left-radius: 8px;
            z-index: 1;
        }


    </style>
</head>
<body>
<jsp:include page="../header_user.jsp" />
<div class="container mt-3">
    <div class="d-flex justify-content-end align-items-center">
        <div class="d-flex justify-content-end align-items-center">
            <div class="float-end">
                <select class="form-select" onchange="location = this.value;">
                    <option value="#">Sắp Xếp</option>
                    <option value="/danh-sach-san-pham/hien-thi">Tất Cả</option>
                    <option value="/danh-sach-san-pham/hien-thi?sort=asc">Giá Thấp Nhất</option>
                    <option value="/danh-sach-san-pham/hien-thi?sort=desc">Giá Cao Nhất</option>
                </select>
            </div>
        </div>
    </div>
    <div class="row mt-3">
        <!-- Sidebar -->
        <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
            <div class="position-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="collapse" href="#collapsePhanGia">
                            Giá Tiền
                        </a>
                        <div class="collapse" id="collapsePhanGia">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="/danh-sach-san-pham/hien-thi">Tất cả</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="?minPrice=0&maxPrice=100000">Dưới 100,000 VNĐ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="?minPrice=100000&maxPrice=200000">100,000 - 200,000 VNĐ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="?minPrice=200000&maxPrice=500000">200,000 - 500,000 VNĐ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="?minPrice=500000&maxPrice=1000000">500,000 - 1,000,000 VNĐ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="?minPrice=1000000">Trên 1,000,000 VNĐ</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="collapse" href="#collapseThuongHieu" aria-expanded="false">
                            Thương Hiệu
                        </a>
                        <div class="collapse" id="collapseThuongHieu">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="/danh-sach-san-pham/hien-thi">Tất cả</a>
                                </li>
                                <li class="nav-item">
                                    <c:forEach items="${listThuongHieu}" var="item">
                                        <a class="nav-link" href="?thuongHieuId=${item.id}">${item.ten}</a>
                                    </c:forEach>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="collapse" href="#collapseLoaiCaPhe">
                            Loại Cà Phê
                        </a>
                        <div class="collapse" id="collapseLoaiCaPhe">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="/danh-sach-san-pham/hien-thi">Tất cả</a>
                                </li>
                                <li class="nav-item">
                                    <c:forEach items="${listLoaiCaPhe}" var="item">
                                        <a class="nav-link" href="?loaiCaPheId=${item.id}">${item.ten}</a>
                                    </c:forEach>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " data-bs-toggle="collapse" href="#collapseHuongVi">
                            Hương Vị
                        </a>
                        <div class="collapse" id="collapseHuongVi">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="/danh-sach-san-pham/hien-thi">Tất cả</a>
                                </li>
                                <li class="nav-item">
                                    <c:forEach items="${listHuongVi}" var="item">
                                        <a class="nav-link" href="?huongViId=${item.id}">${item.ten}</a>
                                    </c:forEach>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " data-bs-toggle="collapse" href="#collapseLoaiHat">
                            Loại Hạt
                        </a>
                        <div class="collapse" id="collapseLoaiHat">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="/danh-sach-san-pham/hien-thi">Tất cả</a>
                                </li>
                                <li class="nav-item">
                                    <c:forEach items="${listLoaiHat}" var="item">
                                        <a class="nav-link" href="?loaiHatId=${item.id}">${item.ten}</a>
                                    </c:forEach>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="collapse" href="#collapseMucDoRang">
                            Mức Độ Rang
                        </a>
                        <div class="collapse" id="collapseMucDoRang">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="/danh-sach-san-pham/hien-thi">Tất cả</a>
                                </li>
                                <li class="nav-item">
                                    <c:forEach items="${listMucDoRang}" var="item">
                                        <a class="nav-link" href="?mucDoRangId=${item.id}">${item.ten}</a>
                                    </c:forEach>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Content -->
        <div class="col-md-9 col-lg-10">
            <div class="row">
                <c:forEach items="${listSanPham}" var="item">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100 shadow-sm position-relative">
                            <c:if test="${item.giaGiamGia != null && item.giaGiamGia > 0}">
                            <span class="discount-badge">
                                ${item.khuyenMaiChiTietList[0].khuyenMai.giaTriKhuyenMai}%
                            </span>
                            </c:if>
                            <a href="/danh-sach-san-pham-chi-tiet/view-sp/${item.id}">
                                <img src="${pageContext.request.contextPath}/uploads/${item.hinhAnh}" class="card-img-top product-image" alt="${item.sanPham.ten}">
                            </a>
                            <div class="card-body text-center">
                                <h5 class="card-title">${item.sanPham.ten}</h5>
                                <p class="card-text">
                                    <c:choose>
                                        <c:when test="${item.giaGiamGia != null and item.giaGiamGia > 0}">
                                            <span style="color: red; text-decoration: line-through;">${item.giaBan} VNĐ</span>
                                            <br>
                                            <span style="color: green;">${item.giaGiamGia} VNĐ</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${item.giaBan} VNĐ
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <div class="product-detail-link rounded-bottom-3" style="background-color: #0B745E; border-radius: 5px;">
                                    <a class="nav-link text-light" href="/danh-sach-san-pham-chi-tiet/view-sp/${item.id}">
                                        <i class="fa-solid fa-link"></i> Chi Tiết Sản Phẩm
                                    </a>
                                </div>
                            </div>
                            <div class="product-buy position-absolute top-50 start-50 translate-middle">
                                <form action="/danh-sach-san-pham/mua-ngay" method="get">
                                    <input type="hidden" name="productId" value="${item.id}">
                                    <button type="submit" class="btn-custom"><i class="fa-solid fa-money-bill"></i></button>
                                </form>
                            </div>
                            <div class="product-cart position-absolute top-50 start-50 translate-middle">
                                <form action="/gio-hang/add" method="post">
                                    <input type="hidden" name="sanPhamId" value="${item.id}">
                                    <button type="submit" class="btn-custom"><i class="fa-solid fa-cart-shopping"></i></button>
                                </form>
                            </div>
                            <div class="product-quantity position-absolute top-50 start-50 translate-middle">
                                <span class="quantity-text">${item.soLuong} sản phẩm</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <!-- Modal hiển thị thông tin sản phẩm (hiển thị nếu sản phẩm được chọn) -->
                <c:if test="${not empty sanPhamChiTiet}">
                    <div class="modal fade show" id="productPopup" tabindex="-1" aria-labelledby="productPopupLabel" aria-modal="true" role="dialog" style="display: block;">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content shadow-lg border-0 rounded">
                                <div class="modal-header border-bottom-0 pb-0">
                                    <h5 class="modal-title fw-bold text-success" id="productPopupLabel">Mua Ngay</h5>
                                    <a href="/danh-sach-san-pham/hien-thi" class="btn-close" aria-label="Close"></a>
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
                                                        <span id="giaBan" style="text-decoration: line-through; color: red">${sanPhamChiTiet.giaBan}</span> VNĐ
                                                        <br>
                                                        <span id="giaGiamGia" style="color: green">${sanPhamChiTiet.giaGiamGia}</span> VNĐ
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span id="giaBan">${sanPhamChiTiet.giaBan}</span> VNĐ
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
                                                        <p id="tongTien" class="text-success fw-bold">${sanPhamChiTiet.giaGiamGia} VNĐ</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p id="tongTien" class="text-success fw-bold">${sanPhamChiTiet.giaBan} VNĐ</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="col-md-6 border-start">
                                            <h3 class="text-center mb-4 text-secondary">Thông tin thanh toán</h3>
                                            <form action="/danh-sach-san-pham/xac-nhan-hoa-don" method="post">
                                                <input type="hidden" name="sanPhamId" value="${sanPhamChiTiet.id}">
                                                <input type="hidden" name="soLuong" id="soLuongInput" value="1">
                                                <input type="hidden" name="tongTien" id="tongTienInput" value="${sanPhamChiTiet.giaBan}">
                                                <div class="mb-3">
                                                    <label for="phuongThucThanhToan" class="form-label fw-bold">Phương thức thanh toán:</label>
                                                    <select class="form-select" id="phuongThucThanhToan" name="phuongThucThanhToan" required>
                                                        <option value="Tiền mặt">Tiền mặt</option>
                                                        <option value="Chuyển khoản">Chuyển khoản</option>
                                                        <option value="Thẻ tín dụng">Thẻ tín dụng</option>
                                                    </select>
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
                                                    <input type="text" class="form-control" id="diaChi" name="diaChi" required>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="soDienThoai" class="form-label fw-bold">Số điện thoại:</label>
                                                    <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai" pattern="[0-9]{10}" required>
                                                </div>
                                                <button type="submit" class="btn btn-success w-100 py-2 mt-4">Xác nhận đơn hàng</button>
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
    </div>
</div>
<jsp:include page="../footer_user.jsp" />
<script>
    // Giá bán của sản phẩm
    const giaBan = ${sanPhamChiTiet.giaBan};
    // Giá giảm giá của sản phẩm (ví dụ)
    const giaGiamGia = ${sanPhamChiTiet.giaGiamGia};

    // Hàm cập nhật tổng tiền
    function updateTotal() {
        const soLuong = parseInt(document.getElementById("soLuong").value) || 1; // Giá trị mặc định là 1
        const selectedShipping = document.querySelector('input[name="phuongThucVanChuyen"]:checked');

        // Đặt chi phí vận chuyển mặc định là 0
        let shippingCost = 0;

        // Nếu có phương thức vận chuyển được chọn, tính toán giá trị chi phí vận chuyển
        if (selectedShipping) {
            if (selectedShipping.value === "Giao Hàng Nhanh") {
                shippingCost = 33000; // Chi phí cho giao hàng nhanh
            } else if (selectedShipping.value === "Giao Hàng Tiêu Chuẩn") {
                shippingCost = 20000; // Chi phí cho giao hàng tiêu chuẩn
            }
        }

        // Kiểm tra giá giảm giá (giaGiamGia) và sử dụng giá phù hợp
        const giaSuDung = (giaGiamGia && giaGiamGia > 0) ? giaGiamGia : giaBan;

        // Tính tổng tiền
        const tongTien = (giaSuDung * soLuong) + shippingCost;

        // Cập nhật nội dung tổng tiền trong modal
        document.getElementById("tongTien").innerText = tongTien.toLocaleString('vi-VN') + " VNĐ";
    }

    function changeQuantity(amount) {
        const soLuongInput = document.getElementById("soLuong");
        const soLuongHiddenInput = document.getElementById("soLuongInput"); // Thêm dòng này
        let currentQuantity = parseInt(soLuongInput.value);
        currentQuantity = isNaN(currentQuantity) ? 1 : currentQuantity;
        currentQuantity = Math.max(1, currentQuantity + amount); // Đảm bảo số lượng tối thiểu là 1
        soLuongInput.value = currentQuantity;

        // Cập nhật giá trị cho trường ẩn
        soLuongHiddenInput.value = currentQuantity; // Thêm dòng này

        updateTotal(); // Cập nhật lại tổng tiền
    }
</script>
</body>
</html>
