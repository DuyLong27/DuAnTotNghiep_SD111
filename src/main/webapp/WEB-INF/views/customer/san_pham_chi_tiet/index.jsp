<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
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

        .old-price {
            text-decoration: line-through;
            color: grey;
        }

        /* Display old price on a new line */
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

        /* Bold product names in related products */
        .related-products .product-price {
            font-weight: normal;
        }

        /* Normal font weight for prices */
        .description {
            margin-top: 60px;
        }
    </style>
</head>
<body>
<%--<jsp:include page="../../header_user.jsp" />--%>
<div class="container mt-5">
    <div class="row">
        <div class="col-lg-9"> <!-- Increased size to 75% -->
            <div class="row">
                <div class="col-md-6">
                    <img src="${sanPhamChiTiet.hinhAnh}" alt="Product Image" class="img-fluid">
                </div>
                <div class="col-md-6">
                    <input type="text" name="id" value="${sanPhamChiTiet.id}" hidden>
                    <h1 class="product-title">${sanPhamChiTiet.sanPham.ten}</h1>
                    <div class="price">
                        ${sanPhamChiTiet.giaBan} VNĐ
<%--                        <span class="old-price">$${sanPhamChiTiet.giaBan} VNĐ</span>--%>
                    </div>
                    <hr>
                    <div class="quantity">
                        Chọn số lượng:
                        <input type="number" id="quantity" value="1" min="1" class="form-control">
                    </div>
                    <div class="items">
                        <p>Còn ${sanPhamChiTiet.soLuong} sản phẩm trong kho</p>
                    </div>
                    <hr>
                    <div class="mt-3">
                        <button class="btn btn-dark btn-lg text-white">Thêm vào giỏ hàng</button>
                        <button class="btn btn-success btn-lg text-white">Mua ngay</button>
                    </div>
                </div>
            </div>
            <div class="description mt-10">
                <ul class="nav nav-tabs" id="productTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active text-black" id="description-tab" data-toggle="tab" href="#description"
                           role="tab" aria-controls="description" aria-selected="true">Thông tin sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-black" id="details-tab" data-toggle="tab" href="#details" role="tab"
                           aria-controls="details" aria-selected="false">Nhận xét</a>
                    </li>
                    <%--                    <li class="nav-item">--%>
                    <%--                        <a class="nav-link text-black" id="reviews-tab" data-toggle="tab" href="#reviews" role="tab"--%>
                    <%--                           aria-controls="reviews" aria-selected="false">Nhận xét</a>--%>
                    <%--                    </li>--%>
                </ul>
                <div class="tab-content" id="productTabContent">
                    <div class="tab-pane fade show active mt-3" id="description" role="tabpanel"
                         aria-labelledby="description-tab">
                        <p>Mô tả sản phẩm: ${sanPhamChiTiet.sanPham.moTa}</p>
                        <p>Trọng lượng: ${sanPhamChiTiet.canNang.ten}</p>
                        <p>Loại hạt: ${sanPhamChiTiet.loaiHat.ten}</p>
                        <p>Loại túi: ${sanPhamChiTiet.loaiTui.ten}</p>
                        <p>Mức độ rang: ${sanPhamChiTiet.mucDoRang.ten}</p>
                        <p>Hương vị: ${sanPhamChiTiet.huongVi.ten}</p>
                        <p>Thương hiệu: ${sanPhamChiTiet.thuongHieu.ten}</p>
                    </div>
                    <div class="tab-pane fade mt-5" id="details" role="tabpanel" aria-labelledby="details-tab">
                        <p>
                            ${sanPhamChiTiet.danhGia}
                        </p>
                    </div>
                    <%--                    <div class="tab-pane fade mt-5" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">--%>
                    <%--                        <p>${sanPhamChiTiet.danhGia}</p>--%>
                    <%--                    </div>--%>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="related-products">
                <h3 class="mb-3">Sản phẩm liên quan</h3>
                <div class="row mb-3">
                    <div class="col-4">
                        <img src="related-product-1.jpg" alt="Related Product 1" class="img-fluid">
                    </div>
                    <div class="col-8">
                        <p class="product-name">Trung Nguyên Legend Cà Phê Sữa Đá</p>
                        <p class="product-price">88,879 ₫</p>
                    </div>
                </div>
                <hr>
                <div class="row mb-3">
                    <div class="col-4">
                        <img src="related-product-2.jpg" alt="Related Product 2" class="img-fluid">
                    </div>
                    <div class="col-8">
                        <p class="product-name">Trung Nguyên Legend Special Edition</p>
                        <p class="product-price">115,999 ₫</p>
                    </div>
                </div>
                <hr>
                <div class="row mb-3">
                    <div class="col-4">
                        <img src="related-product-3.jpg" alt="Related Product 3" class="img-fluid">
                    </div>
                    <div class="col-8">
                        <p class="product-name">Trung Nguyên Legend Classic</p>
                        <p class="product-price">60,000 ₫</p>
                    </div>
                </div>
                <hr>
                <div class="row mb-3">
                    <div class="col-4">
                        <img src="related-product-4.jpg" alt="Related Product 4" class="img-fluid">
                    </div>
                    <div class="col-8">
                        <p class="product-name">Trung Nguyên Legend Special Edition</p>
                        <p class="product-price">63,299 ₫</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Related items section-->
        <section class="py-5 bg-light">
            <div class="container px-4 px-lg-5 mt-5">
                <h2 class="fw-bolder mb-4">Sản phẩm gợi ý</h2>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <c:forEach items="${listSanPham}" var="item">
                        <div class="col mb-5">
                            <div class="card h-100">
                                <!-- Product image-->
                                <img class="card-img-top" src="${item.hinhAnh}" alt="..."/>
                                <!-- Product details-->
                                <div class="card-body p-4">
                                    <div class="text-center">
                                        <!-- Product name-->
                                        <h5 class="fw-bolder">${item.sanPham.ten}</h5>
                                        <!-- Product price-->
                                            ${item.giaBan} VNĐ
                                    </div>
                                </div>
                                <!-- Product actions-->
                                <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                    <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Thêm vào giỏ hàng</a></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </div>
</div>
<%--<jsp:include page="../../header_user.jsp" />--%>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
