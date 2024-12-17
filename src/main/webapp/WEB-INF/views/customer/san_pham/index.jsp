<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .product-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
        }

        #sidebar {
            background-color: #f8f9fa;
            border-right: 1px solid #dee2e6;
            padding: 20px;
            height: 100%;
        }

        #sidebar .nav-link {
            color: #0B745E;
            font-weight: 500;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        #sidebar .nav-link:hover {
            background-color: #0B745E;
            color: #ffffff;
        }

        #sidebar .collapse .nav-item .nav-link {
            padding-left: 30px;
        }

        #sidebar .collapse .nav-item .nav-link:hover {
            background-color: #e9ecef;
            color: #0B745E;
        }

        #sidebar .nav-item a[data-bs-toggle="collapse"]:after {
            content: '\f107';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            float: right;
            transition: transform 0.3s ease;
        }

        #sidebar .nav-item a[data-bs-toggle="collapse"][aria-expanded="true"]:after {
            transform: rotate(180deg);
        }

        #sidebar .collapse.show {
            border-left: 2px solid #0B745E;
            margin-left: 10px;
            transition: border-left 0.5s ease, margin-left 0.5s ease;
            opacity: 1;
        }

        #sidebar .collapse {
            border-left: 2px solid transparent;
            transition: border-left 0.5s ease, margin-left 0.5s ease;
        }

        #sidebar .nav-item a.active {
            background-color: #0B745E;
            color: #ffffff;
        }

        .form-select {
            width: 200px;
            padding: 5px;
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            background-color: #fff;
            transition: border-color 0.3s ease-in-out;
        }

        .form-select:hover {
            border-color: #0B745E;
        }

        .form-select:focus {
            border-color: #0B745E;
            box-shadow: 0 0 5px rgba(11, 116, 94, 0.5);
        }

        .form-select option {
            padding: 5px;
            font-size: 14px;
        }

        .product-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            transition: box-shadow 0.3s ease;
            background-color: #fff;
        }

        .product-card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .product-card-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }

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

        .card-body {
            min-height: 150px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
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

    </style>
</head>
<body>
<jsp:include page="../header_user.jsp" />
<div class="container mt-3">
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
                    <c:if test="${item.tinhTrang == 1}">
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
                                                <span style="color: red; text-decoration: line-through;"><fmt:formatNumber value="${item.giaBan}" type="number" pattern="#,###" /> VNĐ</span>
                                                <br>
                                                <span style="color: green;"><fmt:formatNumber value="${item.giaGiamGia}" type="number" pattern="#,###"/> VNĐ</span>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${item.giaBan}" type="number" pattern="#,###" /> VNĐ
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <div class="product-detail-link rounded-bottom-3" style="background-color: #0B745E; border-radius: 5px;">
                                        <a class="nav-link text-light" href="/danh-sach-san-pham-chi-tiet/view-sp/${item.id}">
                                            <i class="fa-solid fa-link"></i> Chi Tiết Sản Phẩm
                                        </a>
                                    </div>
                                </div>
                                <c:if test="${item.soLuong > 0}">
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
                                </c:if>
                                <c:if test="${item.soLuong <= 0}">
                                    <div class="product-quantity position-absolute top-50 start-50 translate-middle">
                                        <span class="quantity-text text-danger">Đã hết hàng!</span>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
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
                                                <input type="number" class="form-control mx-2 text-center" id="soLuong" name="soLuong" min="1" max="${soLuongTon}" value="1" required onchange="handleQuantityChange()" onkeyup="handleQuantityChange()" style="width: 80px;">
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
                                            <form id="orderForm" action="/danh-sach-san-pham/xac-nhan-hoa-don" method="post">
                                                <input type="hidden" name="sanPhamId" value="${sanPhamChiTiet.id}">
                                                <input type="hidden" name="soLuong" id="soLuongInput" value="1">
                                                <input type="hidden" name="tongTien" id="tongTienInput" value="${sanPhamChiTiet.giaBan}">

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
    </div>
</div>
<jsp:include page="../footer_user.jsp" />
</body>
<script>
    const giaBan = ${sanPhamChiTiet.giaBan != null ? sanPhamChiTiet.giaBan : 0};
    const giaGiamGia = ${sanPhamChiTiet.giaGiamGia != null ? sanPhamChiTiet.giaGiamGia : 0};
    const soLuongTon = ${soLuongTon};
    const diemTichLuy = ${khachHang != null ? khachHang.diemTichLuy : 0};
    const discountRate = Math.min(Math.floor(diemTichLuy / 1000) * 5, 30);
    function calculateDiscountAmount(price, rate) {
        return price * (rate / 100);
    }
    function handleQuantityChange() {
        const soLuongInput = document.getElementById("soLuong");
        const soLuongHiddenInput = document.getElementById("soLuongInput");
        let soLuong = parseInt(soLuongInput.value) || 1;
        if (soLuong < 1) {
            soLuong = 1;
            alert("Số lượng không thể nhỏ hơn 1.");
        } else if (soLuong > soLuongTon) {
            soLuong = soLuongTon;
            alert("Số lượng vượt quá tồn kho. Vui lòng chọn lại.");
        }
        soLuongInput.value = soLuong;
        soLuongHiddenInput.value = soLuong;
        updateTotal();
    }
    function updateTotal() {
        const soLuongInput = document.getElementById("soLuong");
        const soLuong = parseInt(soLuongInput.value) || 1;
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
    function changeQuantity(amount) {
        const soLuongInput = document.getElementById("soLuong");
        let soLuong = parseInt(soLuongInput.value) || 1;
        soLuong = Math.max(1, Math.min(soLuong + amount, soLuongTon));

        soLuongInput.value = soLuong;
        handleQuantityChange();
    }
    function displayImage() {
        const paymentMethod = document.getElementById("phuongThucThanhToan").value;
        const imageContainer = document.getElementById("imageContainer");
        imageContainer.style.display = paymentMethod === "Chuyển khoản" ? "block" : "none";
    }
    document.getElementById("soLuong").addEventListener("change", handleQuantityChange);
    document.getElementById("soLuong").addEventListener("keyup", handleQuantityChange);
    document.querySelectorAll('input[name="phuongThucVanChuyen"]').forEach((input) => {
        input.addEventListener("change", updateTotal);
    });
    updateTotal();
</script>
</html>
