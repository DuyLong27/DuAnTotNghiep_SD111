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
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
<%--<jsp:include page="../header_user.jsp" />--%>
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
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="related-products">
                <h3 class="mb-3">Sản phẩm liên quan</h3>
                <c:if test="${empty data.content}">
                    <tr>
                        <td colspan="10">Không tìm thấy đối tượng nào.</td>
                    </tr>
                </c:if>
                <c:if test="${not empty data.content}">
                    <c:forEach items="${data.content}" var="spct">
                        <div class="row mb-3">
                            <div class="col-4">
                                <!-- Sửa 'item' thành 'spct' -->
                                <img src="${pageContext.request.contextPath}/uploads/${spct.hinhAnh}"
                                     alt="${spct.sanPham.ten}"
                                     class="img-fluid">
                            </div>
                            <div class="col-8">
                                <p class="product-name">${spct.sanPham.ten}</p>
                                <p class="product-price">${spct.giaBan} VNĐ</p>
                            </div>
                        </div>
                        <hr>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script>
    let currentPage = 0; // Trang bắt đầu

    function loadRelatedProducts(page) {
        // Sử dụng AJAX để tải các sản phẩm mới mỗi khi đổi trang
        $.ajax({
            url: '/danh-sach-san-pham-chi-tiet',
            type: 'GET',
            data: {
                page: page, // Gửi thông tin trang hiện tại
                size: 5 // Mỗi lần tải 5 sản phẩm
            },
            success: function(response) {
                // Thay thế nội dung sản phẩm
                const newProducts = $(response).find('.related-products').html();
                $('.related-products').html(newProducts);
            },
            error: function() {
                console.error('Error loading related products');
            }
        });
    }

    // Hàm thay đổi sản phẩm mỗi 20 giây
    function changeProductsPeriodically() {
        setInterval(function() {
            currentPage = (currentPage + 1) % 10; // Giới hạn trang là 10 (hoặc số bạn muốn)
            loadRelatedProducts(currentPage); // Tải sản phẩm từ trang tiếp theo
        }, 20000); // Thay đổi mỗi 20 giây
    }

    // Bắt đầu thay đổi sản phẩm
    $(document).ready(function() {
        changeProductsPeriodically(); // Bắt đầu
    });
</script>
<%--<jsp:include page="../header_user.jsp" />--%>
</body>
</html>
