<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Trang Chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" crossorigin="anonymous">
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


    </style>
</head>
<body data-bs-spy="scroll" data-bs-target="#navbar" data-bs-offset="70">
<jsp:include page="../header_user.jsp" />
<div id="carouselExample" class="carousel slide mb-4" data-bs-ride="carousel" data-bs-interval="3900">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="${pageContext.request.contextPath}/lib/background_khachhang123.png" class="d-block w-100" alt="Banner 1">
        </div>
        <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/lib/background_khachhang1.png" class="d-block w-100" alt="Banner 2">
        </div>
        <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/lib/background_khachhang12.png" class="d-block w-100" alt="Banner 3">
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
                        <img src="${pageContext.request.contextPath}/uploads/${product.hinhAnh}" class="card-img-top" alt="${product.sanPham.ten}">
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
                            <a href="/danh-sach-san-pham-chi-tiet/view-sp/${product.id}" class="btn btn-outline-success">Xem chi tiết</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <h2 class="text-success mb-4" data-aos="fade-up" data-aos-delay="200">Chương trình khuyến mãi</h2>
        <div class="row" data-aos="fade-up" data-aos-delay="300">
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
</div>

<button id="back-to-top" title="Back to Top"><i class="fas fa-arrow-up"></i></button>

<jsp:include page="../footer_user.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init();

    window.onscroll = function() {
        if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
            document.getElementById("back-to-top").style.display = "block";
        } else {
            document.getElementById("back-to-top").style.display = "none";
        }
    };

    document.getElementById("back-to-top").addEventListener("click", function() {
        window.scrollTo({top: 0, behavior: 'smooth'});
    });
</script>
</body>
</html>
