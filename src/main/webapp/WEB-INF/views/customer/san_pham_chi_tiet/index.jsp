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
        <%--   Modal    --%>
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

        /* Giảm khoảng cách giữa các nút */
        .row {
            margin-top: 20px; /* Nếu cần thêm khoảng cách với các phần tử khác */
        }

        /* Nếu bạn muốn khoảng cách tùy chỉnh giữa các nút */
        .d-flex {
            gap: 15px; /* Điều chỉnh giá trị này tùy ý để có khoảng cách phù hợp */
        }

        /* Căn chỉnh chữ trong nút */
        .btn {
            white-space: nowrap; /* Đảm bảo chữ không bị xuống dòng */
        }
    </style>
</head>
<body>
<jsp:include page="../header_user.jsp"/>
<div class="container mt-5">
    <div class="row">
        <div class="col-lg-9"> <!-- Increased size to 75% -->
            <div class="row">
                <div class="col-md-6">
                    <img src="${pageContext.request.contextPath}/uploads/${sanPhamChiTiet.hinhAnh}"
                         class="card-img-top product-image">
                </div>
                <div class="col-md-6">
                    <input type="text" name="id" value="${sanPhamChiTiet.id}" hidden>
                    <h1 class="product-title">${sanPhamChiTiet.sanPham.ten}</h1>
                    <div class="price">
                        ${sanPhamChiTiet.giaBan} VNĐ
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
                    <div class="row mt-3">
                        <div class="col-12 d-flex justify-content-between gap-3">
                            <form action="/gio-hang/add" method="post" class="w-50">
                                <input type="hidden" name="sanPhamId" value="${item.id}">
                                <button type="submit" class="btn btn-dark btn-lg w-100 text-center">Thêm vào giỏ hàng
                                </button>
                            </form>

                            <form action="/danh-sach-san-pham-chi-tiet/mua-ngay" method="get" class="w-50">
                                <input type="hidden" name="productId" value="${item.id}">
                                <button type="submit" class="btn btn-success btn-lg w-100 text-center">Mua ngay</button>
                            </form>
                        </div>
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
                <h3 class="mb-3">Sản phẩm bán chạy</h3>
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

<!-- Modal hiển thị thông tin sản phẩm (hiển thị nếu sản phẩm được chọn) -->
<c:if test="${not empty sanPhamChiTiet}">
    <div class="modal fade show" id="productPopup" tabindex="-1" aria-labelledby="productPopupLabel" aria-modal="true"
         role="dialog" style="display: block;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content shadow-lg border-0 rounded">
                <div class="modal-header border-bottom-0 pb-0">
                    <h5 class="modal-title fw-bold text-success" id="productPopupLabel">Mua Ngay Tức Thì Nào
                        HeHeBoizz!</h5>
                    <a href="/danh-sach-san-pham-chi-tiet/hien-thi" class="btn-close" aria-label="Close"></a>
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
                            <p class="text-danger fw-bold">Giá: <span id="giaBan">${sanPhamChiTiet.giaBan}</span> VNĐ
                            </p>
                            <p class="text-muted">Mô tả: ${sanPhamChiTiet.sanPham.moTa}</p>
                            <div class="mb-3 d-flex align-items-center justify-content-center">
                                <button type="button" class="btn btn-outline-secondary rounded-circle px-2"
                                        onclick="changeQuantity(-1)">-
                                </button>
                                <input type="number" class="form-control mx-2 text-center" id="soLuong" name="soLuong"
                                       min="1" value="1" required onchange="updateTotal()" style="width: 80px;">
                                <button type="button" class="btn btn-outline-secondary rounded-circle px-2"
                                        onclick="changeQuantity(1)">+
                                </button>
                            </div>
                            <div>
                                <label class="form-label fw-bold">Tổng tiền:</label>
                                <p id="tongTien" class="text-success fw-bold">${sanPhamChiTiet.giaBan} VNĐ</p>
                            </div>
                        </div>
                        <div class="col-md-6 border-start">
                            <h3 class="text-center mb-4 text-secondary">Thông tin thanh toán</h3>
                            <form action="/danh-sach-san-pham/xac-nhan-hoa-don" method="post">
                                <input type="hidden" name="sanPhamId" value="${sanPhamChiTiet.id}">
                                <input type="hidden" name="soLuong" id="soLuongInput" value="1">
                                <input type="hidden" name="tongTien" id="tongTienInput"
                                       value="${sanPhamChiTiet.giaBan}">
                                <div class="mb-3">
                                    <label for="phuongThucThanhToan" class="form-label fw-bold">Phương thức thanh
                                        toán:</label>
                                    <select class="form-select" id="phuongThucThanhToan" name="phuongThucThanhToan"
                                            required>
                                        <option value="Tiền mặt">Tiền mặt</option>
                                        <option value="Chuyển khoản">Chuyển khoản</option>
                                        <option value="Thẻ tín dụng">Thẻ tín dụng</option>
                                    </select>
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
                                <button type="submit" class="btn btn-success w-100 py-2 mt-4">Xác nhận đơn hàng</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>

<script>
    let currentPage = 0; // Trang bắt đầu

    function loadRelatedProducts(page) {
        // Sử dụng AJAX để tải các sản phẩm mới mỗi khi đổi trang
        $.ajax({
            url: '/danh-sach-san-pham-chi-tiet',
            type: 'GET',
            data: {
                page: page, // Gửi thông tin trang hiện tại
                size: 4 // Mỗi lần tải 5 sản phẩm
            },
            success: function (response) {
                // Thay thế nội dung sản phẩm
                const newProducts = $(response).find('.related-products').html();
                $('.related-products').html(newProducts);
            },
            error: function () {
                console.error('Error loading related products');
            }
        });
    }

    document.querySelector('.btn-dark').addEventListener('click', function () {
        // Lấy thông tin sản phẩm từ trang
        let productId = document.querySelector('input[name="id"]').value;
        let productName = document.querySelector('.product-title').innerText;
        let price = document.querySelector('.price').innerText;
        let quantity = document.getElementById('quantity').value;

        // Tạo đối tượng sản phẩm
        let product = {
            id: productId,
            name: productName,
            price: price,
            quantity: quantity
        };

        // Lấy giỏ hàng từ localStorage (nếu có)
        let cart = localStorage.getItem('cart') ? JSON.parse(localStorage.getItem('cart')) : [];

        // Kiểm tra nếu sản phẩm đã có trong giỏ hàng
        let existingProduct = cart.find(item => item.id === productId);

        if (existingProduct) {
            // Nếu sản phẩm đã có trong giỏ hàng, tăng số lượng
            existingProduct.quantity = parseInt(existingProduct.quantity) + parseInt(quantity);
        } else {
            // Nếu sản phẩm chưa có, thêm sản phẩm mới vào giỏ hàng
            cart.push(product);
        }

        // Lưu giỏ hàng lại vào localStorage
        localStorage.setItem('cart', JSON.stringify(cart));

        // Thông báo cho người dùng
        alert('Sản phẩm đã được thêm vào giỏ hàng');
    });

    function displayCart() {
        let cart = localStorage.getItem('cart') ? JSON.parse(localStorage.getItem('cart')) : [];

        let cartTable = document.querySelector('tbody');
        cartTable.innerHTML = ''; // Xóa nội dung cũ

        cart.forEach((item, index) => {
            let row = `
            <tr>
                <td>${index + 1}</td>
                <td>${item.name}</td>
                <td>${item.price}</td>
                <td>${item.quantity}</td>
                <td><button class="btn btn-danger btn-sm" onclick="removeFromCart(${item.id})">Xóa</button></td>
            </tr>
        `;
            cartTable.innerHTML += row;
        });
    }

    // Gọi hàm displayCart khi trang tải
    window.onload = displayCart;

    function removeFromCart(productId) {
        let cart = JSON.parse(localStorage.getItem('cart'));

        // Loại bỏ sản phẩm khỏi giỏ hàng
        cart = cart.filter(item => item.id != productId);

        // Lưu lại giỏ hàng mới vào localStorage
        localStorage.setItem('cart', JSON.stringify(cart));

        // Cập nhật lại hiển thị giỏ hàng
        displayCart();
    }

    // Giá bán của sản phẩm
    const giaBan = ${sanPhamChiTiet.giaBan};

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

        // Tính tổng tiền
        const tongTien = (giaBan * soLuong) + shippingCost;

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
<jsp:include page="../footer_user.jsp"/>
</body>
</html>
