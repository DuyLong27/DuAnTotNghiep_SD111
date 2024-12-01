<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Khuyến Mãi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KyZXEJ8J2HaxIEXs2d0sd2e9v8T0r6VQ8cxzLxX+UiwmI4zDzv9WUyBzFz01+Rnp" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            background-color: #f8f9fa;
        }

        .promo-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .promo-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .promo-header {
            background-color: #0B745E !important;
            color: #fff;
            border-radius: 5px 5px 0 0;
            padding: 10px;
        }

        .promo-body {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 0 0 5px 5px;
        }

        .promo-body ul {
            list-style: none;
            padding-left: 0;
        }

        .promo-body ul li {
            padding: 5px 0;
            font-size: 14px;
        }

        .promo-info {
            font-size: 14px;
            color: #666;
        }

        .promo-card-footer {
            text-align: center;
            padding: 10px;
            background-color: #e9ecef;
        }
    </style>
</head>
<body>
<jsp:include page="../header_user.jsp" />

<div class="container mt-5 mb-5">
    <h2 class="text-center text-success mb-4">Các Chương Trình Khuyến Mãi Của The Nature Coffee</h2>
    <div class="row row-cols-1 row-cols-md-3 g-4 mt-3">
        <c:set var="hasPromoDetails" value="false" />
        <c:forEach var="khuyenMai" items="${khuyenMais}">
            <c:if test="${not empty khuyenMai.khuyenMaiChiTietList}">
                <c:set var="hasPromoDetails" value="true" />
            </c:if>
        </c:forEach>
        <c:if test="${!hasPromoDetails}">
            <div class="col-12 text-center">
                <div class="alert alert-warning" role="alert">
                    Hiện chưa có chương trình khuyến mãi nào.
                </div>
            </div>
        </c:if>
        <c:forEach var="khuyenMai" items="${khuyenMais}">
            <c:if test="${not empty khuyenMai.khuyenMaiChiTietList}">
                <div class="col">
                    <div class="card promo-card shadow-sm">
                        <div class="promo-header card-header">
                            <h5 class="card-title">${khuyenMai.tenKhuyenMai}</h5>
                        </div>
                        <div class="promo-body card-body">
                            <h6 class="card-subtitle mb-2 text-muted">Áp dụng cho sản phẩm:</h6>
                            <ul>
                                <c:forEach var="chiTiet" items="${khuyenMai.khuyenMaiChiTietList}">
                                    <li>${chiTiet.sanPhamChiTiet.sanPham.ten}</li>
                                </c:forEach>
                            </ul>
                            <div class="promo-info">
                                <p><strong>Ngày bắt đầu:</strong> ${khuyenMai.ngayBatDau}</p>
                                <p><strong>Ngày kết thúc:</strong> ${khuyenMai.ngayKetThuc}</p>
                            </div>
                        </div>
                        <div class="promo-card-footer">
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>

<jsp:include page="../footer_user.jsp" />
</body>
</html>