<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Trang Chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <style>
        .banner img {
            width: 100%;
            height: auto;
            max-height: 400px;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }


        .section h2 {
            font-weight: bold;
            border-bottom: 3px solid #0B745E;
            display: inline-block;
            padding-bottom: 5px;
            margin-bottom: 20px;
        }


        .card {
            border: 1px solid #eaeaea;
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }

        .card-img-top {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .card-body {
            height: 155px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            overflow: hidden;
        }

        .card-title {
            font-size: 1rem;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .card-text {
            color: #0B745E;
            font-size: 0.9rem;
            margin-bottom: 10px;
        }

        .btn {
            font-size: 0.85rem;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0B745E;
            color: white;
        }

        .custom-card {
            border: 1px solid #dcdcdc;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .custom-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .card-header {
            background-color: #0B745E;
            border-bottom: none;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: bold;
        }

        .product-list {
            list-style-type: none;
            padding-left: 0;
        }

        .product-list li {
            font-size: 1rem;
            color: #555;
        }

        .card-body {
            padding: 1.25rem;
        }

        .card-subtitle {
            font-size: 1.1rem;
            margin-bottom: 10px;
        }

        .card-body p {
            font-size: 1rem;
            color: #333;
            margin-bottom: 10px;
        }

        @media (max-width: 768px) {
            .custom-card {
                margin-bottom: 20px;
            }
        }

        .card-footer {
            background-color: #f8f9fa;
            border-top: 1px solid #ddd;
            text-align: center;
            padding: 1rem;
        }

        .card-footer .btn {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
        }

        .card-footer .btn:hover {
            background-color: #0B745E;
            color: white;
            border-color: #0B745E;
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

        #back-to-top {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #0B745E;
            color: white;
            border: none;
            border-radius: 50%;
            padding: 15px;
            cursor: pointer;
            display: none;
        }

        #back-to-top:hover {
            background-color: #06533b;
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
<body data-bs-spy="scroll" data-bs-target="#navbar" data-bs-offset="70">
<jsp:include page="../header_user.jsp"/>
<div id="carouselExample" class="carousel slide mb-4" data-bs-ride="carousel" data-bs-interval="3900">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="${pageContext.request.contextPath}/lib/background_khachhang123.png" class="d-block w-100"
                 alt="Banner 1">
        </div>
        <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/lib/background_khachhang1.png" class="d-block w-100"
                 alt="Banner 2">
        </div>
        <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/lib/background_khachhang12.png" class="d-block w-100"
                 alt="Banner 3">
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>
<div class="container">
    <div class="section">
        <h2 class="text-success mb-3" data-aos="fade-up">Sản phẩm bán chạy</h2>
        <div class="row" data-aos="fade-up" data-aos-delay="100">
            <c:forEach var="product" items="${bestSellers}">
                <div class="col-md-3 mb-4">
                    <div class="card">
                        <c:if test="${product.giaGiamGia != null && product.giaGiamGia > 0}">
                                <span class="discount-badge">
                                    ${product.khuyenMaiChiTietList[0].khuyenMai.giaTriKhuyenMai}%
                                </span>
                        </c:if>
                        <img src="${pageContext.request.contextPath}/uploads/${product.hinhAnh}" class="card-img-top"
                             alt="${product.sanPham.ten}">
                        <div class="card-body text-center">
                            <h5 class="card-title">${product.sanPham.ten}</h5>
                            <p class="card-text text-success">
                                <c:choose>
                                    <c:when test="${product.giaGiamGia != null && product.giaGiamGia > 0}">
                                        <span style="color: red; text-decoration: line-through;">${product.giaBan} VNĐ</span>
                                        <br>
                                        <span style="color: green;">${product.giaGiamGia} VNĐ</span>
                                    </c:when>
                                    <c:otherwise>
                                        ${product.giaBan} VNĐ
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <a href="/danh-sach-san-pham-chi-tiet/view-sp/${product.id}"
                               class="btn btn-outline-success">Xem chi tiết</a>
                            <div class="product-buy position-absolute top-50 start-50 translate-middle">
                                <form action="/trang-chu/mua-ngay" method="get">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <button type="submit" class="btn-custom"><i class="fa-solid fa-money-bill"></i>
                                    </button>
                                </form>
                            </div>
                            <div class="product-cart position-absolute top-50 start-50 translate-middle">
                                <form action="/trang-chu/add" method="post">
                                    <input type="hidden" name="sanPhamId" value="${product.id}">
                                    <button type="submit" class="btn-custom"><i class="fa-solid fa-cart-shopping"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <h2 class="text-success mb-3" data-aos="fade-up">Sản phẩm đang khuyến mãi</h2>
        <div class="row" data-aos="fade-up" data-aos-delay="100">
            <c:set var="hasPromotion" value="false"/>
            <c:forEach var="product" items="${allProducts}">
                <c:if test="${product.giaGiamGia != null && product.giaGiamGia > 0}">
                    <c:set var="hasPromotion" value="true"/>
                    <div class="col-md-3 mb-4">
                        <div class="card">
                    <span class="discount-badge">
                        ${product.khuyenMaiChiTietList[0].khuyenMai.giaTriKhuyenMai}%
                    </span>
                            <img src="${pageContext.request.contextPath}/uploads/${product.hinhAnh}"
                                 class="card-img-top" alt="${product.sanPham.ten}">
                            <div class="card-body">
                                <h5 class="card-title">${product.sanPham.ten}</h5>
                                <p class="card-text text-success">
                                    <c:choose>
                                        <c:when test="${product.giaGiamGia != null && product.giaGiamGia > 0}">
                                            <span style="color: red; text-decoration: line-through;">${product.giaBan} VNĐ</span>
                                            <br>
                                            <span style="color: green;">${product.giaGiamGia} VNĐ</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${product.giaBan} VNĐ
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <a href="/danh-sach-san-pham-chi-tiet/view-sp/${product.id}"
                                   class="btn btn-outline-success">Xem chi tiết</a>
                                <div class="product-buy position-absolute top-50 start-50 translate-middle">
                                    <form action="/trang-chu/mua-ngay" method="get">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        <button type="submit" class="btn-custom"><i class="fa-solid fa-money-bill"></i>
                                        </button>
                                    </form>
                                </div>
                                <div class="product-cart position-absolute top-50 start-50 translate-middle">
                                    <form action="/trang-chu/add" method="post">
                                        <input type="hidden" name="sanPhamId" value="${product.id}">
                                        <button type="submit" class="btn-custom"><i
                                                class="fa-solid fa-cart-shopping"></i></button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
            <c:if test="${!hasPromotion}">
                <p class="text-center text-danger">Chưa có sản phẩm nào đang trong chương trình khuyến mãi</p>
            </c:if>
        </div>
        <h2 class="text-success mb-4" data-aos="fade-up" data-aos-delay="200">Chương trình khuyến mãi</h2>
        <div class="row" data-aos="fade-up" data-aos-delay="300">
            <c:if test="${empty validKhuyenMais}">
                <p class="text-center text-danger">Hiện chưa có chương trình khuyến mãi nào</p>
            </c:if>
            <c:forEach var="khuyenMai" items="${validKhuyenMais}">
                <div class="col-md-4 mb-4">
                    <div class="card custom-card">
                        <div class="card-header bg-success text-white">
                            <h5 class="card-title">${khuyenMai.tenKhuyenMai}</h5>
                        </div>
                        <div class="card-body">
                            <h6 class="card-subtitle mb-3 text-muted">Áp dụng cho sản phẩm:</h6>
                            <ul class="product-list">
                                <c:forEach var="chiTiet" items="${khuyenMai.khuyenMaiChiTietList}">
                                    <li>${chiTiet.sanPhamChiTiet.sanPham.ten}</li>
                                </c:forEach>
                            </ul>
                            <p><strong>Ngày bắt đầu:</strong> ${khuyenMai.ngayBatDau}</p>
                            <p><strong>Ngày kết thúc:</strong> ${khuyenMai.ngayKetThuc}</p>
                        </div>
                        <div class="card-footer text-center">
                            <a href="/khuyen-mai" class="btn btn-success btn-sm">Truy cập khuyến mãi</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <!-- Modal hiển thị thông tin sản phẩm (hiển thị nếu sản phẩm được chọn) -->
    <c:if test="${not empty sanPhamChiTiet}">
        <div class="modal fade show" id="productPopup" tabindex="-1" aria-labelledby="productPopupLabel"
             aria-modal="true" role="dialog" style="display: block;">
            <div class="modal-dialog modal-lg">
                <div class="modal-content shadow-lg border-0 rounded">
                    <div class="modal-header border-bottom-0 pb-0">
                        <h5 class="modal-title fw-bold text-success" id="productPopupLabel">Mua Ngay</h5>
                        <a href="/trang-chu" class="btn-close" aria-label="Close"></a>
                    </div>
                    <div class="modal-body">
                        <div class="row g-4">
                            <div class="col-md-6 d-flex flex-column align-items-center text-center">
                                <a href="/danh-sach-san-pham-chi-tiet/view-sp/${sanPhamChiTiet.id}">
                                    <img src="${pageContext.request.contextPath}/uploads/${sanPhamChiTiet.hinhAnh}"
                                         class="card-img-top product-image rounded mb-3 shadow-sm"
                                         alt="${sanPhamChiTiet.sanPham.ten}">
                                </a>
                                <h5 class="fw-bold mb-2">${sanPhamChiTiet.sanPham.ten}</h5>
                                <p class="fw-bold">Giá:
                                    <c:choose>
                                        <c:when test="${sanPhamChiTiet.giaGiamGia != null and sanPhamChiTiet.giaGiamGia > 0}">
                                            <span id="giaBan"
                                                  style="text-decoration: line-through; color: red">${sanPhamChiTiet.giaBan}</span> VNĐ
                                            <br>
                                            <span id="giaGiamGia"
                                                  style="color: green">${sanPhamChiTiet.giaGiamGia}</span> VNĐ
                                        </c:when>
                                        <c:otherwise>
                                            <span id="giaBan">${sanPhamChiTiet.giaBan}</span> VNĐ
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <p class="text-muted">Mô tả: ${sanPhamChiTiet.sanPham.moTa}</p>
                                <div class="mb-3 d-flex align-items-center justify-content-center">
                                    <button type="button" class="btn btn-outline-secondary rounded-circle px-2"
                                            onclick="changeQuantity(-1)">-
                                    </button>
                                    <input type="number" class="form-control mx-2 text-center" id="soLuong"
                                           name="soLuong" min="1" value="1" required onchange="updateTotal()"
                                           style="width: 80px;">
                                    <button type="button" class="btn btn-outline-secondary rounded-circle px-2"
                                            onclick="changeQuantity(1)">+
                                    </button>
                                </div>
                                <div>
                                    <label class="form-label fw-bold">Tổng tiền:</label>
                                    <c:choose>
                                        <c:when test="${sanPhamChiTiet.giaGiamGia != null and sanPhamChiTiet.giaGiamGia > 0}">
                                            <p id="tongTien" class="text-success fw-bold">${sanPhamChiTiet.giaGiamGia}
                                                VNĐ</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p id="tongTien" class="text-success fw-bold">${sanPhamChiTiet.giaBan}
                                                VNĐ</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <c:if test="${khachHang != null}">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <label class="form-label fw-bold">Số tiền giảm giá:</label>
                                            <p id="discountAmount" class="text-success fw-bold">${discountAmount}
                                                VNĐ</p>
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
                                <form action="/trang-chu/xac-nhan-hoa-don" method="post">
                                    <input type="hidden" name="sanPhamId" value="${sanPhamChiTiet.id}">
                                    <input type="hidden" name="soLuong" id="soLuongInput" value="1">
                                    <input type="hidden" name="tongTien" id="tongTienInput"
                                           value="${sanPhamChiTiet.giaBan}">
                                    <c:choose>
                                        <c:when test="${empty khachHang}">
                                            <div class="mb-3">
                                                <label for="email" class="form-label fw-bold">Email:</label>
                                                <input type="email" class="form-control" id="email" name="email"
                                                       placeholder="Nhập email của bạn" required>
                                            </div>
                                        </c:when>
                                    </c:choose>


                                    <div class="mb-3">
                                        <label for="phuongThucThanhToan" class="form-label fw-bold">Phương thức thanh
                                            toán:</label>
                                        <select class="form-select" id="phuongThucThanhToan" name="phuongThucThanhToan"
                                                required onchange="displayImage()">
                                            <option value="Tiền mặt">Tiền mặt</option>
                                            <option value="Chuyển khoản">Chuyển khoản</option>
                                        </select>
                                    </div>
                                    <div id="imageContainer" style="display: none; text-align: center;">
                                        <img id="myImage" src="../../../../images/QRLong.png"
                                             alt="Image of transfer method" width="200"
                                             style="border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
                                    </div>


                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Phương thức vận chuyển:</label>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="phuongThucVanChuyen"
                                                   id="giaoHangNhanh" value="Giao Hàng Nhanh" required
                                                   onchange="updateTotal()">
                                            <label class="form-check-label" for="giaoHangNhanh">Giao Hàng Nhanh</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="phuongThucVanChuyen"
                                                   id="giaoHangTieuChuan" value="Giao Hàng Tiêu Chuẩn"
                                                   onchange="updateTotal()">
                                            <label class="form-check-label" for="giaoHangTieuChuan">Giao Hàng Tiêu
                                                Chuẩn</label>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="diaChi" class="form-label fw-bold">Địa chỉ cụ thể:</label>
                                        <input type="text" class="form-control" id="diaChi" name="diaChi" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="soDienThoai" class="form-label fw-bold">Số điện thoại:</label>
                                        <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai"
                                               pattern="[0-9]{10}" required>
                                    </div>
                                    <button type="submit" class="btn btn-success w-100 py-2 mt-4">Xác nhận đơn hàng
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>

<button id="back-to-top" title="Back to Top"><i class="fas fa-arrow-up"></i></button>

<jsp:include page="../footer_user.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init();

    window.onscroll = function () {
        if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
            document.getElementById("back-to-top").style.display = "block";
        } else {
            document.getElementById("back-to-top").style.display = "none";
        }
    };

    document.getElementById("back-to-top").addEventListener("click", function () {
        window.scrollTo({top: 0, behavior: 'smooth'});
    });

    const giaBan = ${sanPhamChiTiet.giaBan != null ? sanPhamChiTiet.giaBan : 0};
    const giaGiamGia = ${sanPhamChiTiet.giaGiamGia != null ? sanPhamChiTiet.giaGiamGia : 0};
    const diemTichLuy = ${khachHang != null ? khachHang.diemTichLuy : 0};
    const discountRate = Math.min(Math.floor(diemTichLuy / 1000) * 5, 30); // % giảm giá tối đa 30%

    function calculateDiscountAmount(price, rate) {
        return price * (rate / 100); // Số tiền giảm giá
    }

    function updateTotal() {
        const soLuong = parseInt(document.getElementById("soLuong").value) || 1; // Số lượng sản phẩm
        const selectedShipping = document.querySelector('input[name="phuongThucVanChuyen"]:checked');

        let shippingCost = 0; // Phí vận chuyển mặc định
        if (selectedShipping) {
            shippingCost = selectedShipping.value === "Giao Hàng Nhanh" ? 33000 : 20000;
        }

        // Giá sử dụng (ưu tiên giá giảm nếu có)
        const giaSuDung = giaGiamGia > 0 ? giaGiamGia : giaBan;

        // Tính tổng tiền sản phẩm
        const tongTienSanPham = giaSuDung * soLuong;

        // Kiểm tra có đăng nhập hay không
        let tongTien;
        if (diemTichLuy > 0) {
            // Tính giảm giá nếu khách hàng có điểm tích lũy
            const discountAmount = calculateDiscountAmount(tongTienSanPham, discountRate);
            document.getElementById("discountAmount").innerText = discountAmount.toLocaleString('vi-VN') + " VNĐ"; // Hiển thị tiền giảm giá
            tongTien = tongTienSanPham - discountAmount + shippingCost;
        } else {
            // Nếu không đăng nhập, không áp dụng giảm giá
            tongTien = tongTienSanPham + shippingCost;
        }

        // Hiển thị tổng tiền trên giao diện
        document.getElementById("tongTien").innerText = tongTien.toLocaleString('vi-VN') + " VNĐ";
        document.getElementById("tongTienInput").value = tongTien; // Nếu cần gửi giá trị này qua form
    }


    // Khi thay đổi số lượng sản phẩm
    document.getElementById("soLuong").addEventListener("change", updateTotal);

    // Khi thay đổi phương thức vận chuyển
    document.querySelectorAll('input[name="phuongThucVanChuyen"]').forEach((input) => {
        input.addEventListener("change", updateTotal);
    });

    // Khi nhấn nút tăng/giảm số lượng
    function changeQuantity(amount) {
        const soLuongInput = document.getElementById("soLuong");
        let currentQuantity = parseInt(soLuongInput.value);
        currentQuantity = isNaN(currentQuantity) ? 1 : currentQuantity;
        currentQuantity = Math.max(1, currentQuantity + amount); // Đảm bảo số lượng tối thiểu là 1
        soLuongInput.value = currentQuantity;

        updateTotal(); // Cập nhật lại tổng tiền
    }

    // Khởi tạo giá trị ban đầu
    updateTotal();

    function changeQuantity(amount) {
        const soLuongInput = document.getElementById("soLuong");
        const soLuongHiddenInput = document.getElementById("soLuongInput"); // Trường ẩn

        let currentQuantity = parseInt(soLuongInput.value);
        currentQuantity = isNaN(currentQuantity) ? 1 : currentQuantity;
        currentQuantity = Math.max(1, currentQuantity + amount); // Đảm bảo số lượng tối thiểu là 1
        soLuongInput.value = currentQuantity;

        // Cập nhật giá trị cho trường ẩn
        soLuongHiddenInput.value = currentQuantity;

        updateTotal(); // Cập nhật lại tổng tiền
    }


    function displayImage() {
        var paymentMethod = document.getElementById("phuongThucThanhToan").value;
        var imageContainer = document.getElementById("imageContainer");

        // Nếu chọn "Chuyển khoản", hiển thị hình ảnh
        if (paymentMethod === "Chuyển khoản") {
            imageContainer.style.display = "block";
        } else {
            imageContainer.style.display = "none";
        }
    }

</script>
</body>
</html>
