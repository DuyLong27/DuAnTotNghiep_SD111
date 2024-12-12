<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Đơn nhập hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .cart-container {
            margin-top: 50px;
        }

        .table-hover tbody tr:hover {
            background-color: #e9ecef;
        }

        .cart-header {
            font-weight: bold;
            text-transform: uppercase;
            padding: 15px 0;
            border-bottom: 2px solid #dee2e6;
            color: #495057;
        }

        .cart-card {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            transition: box-shadow 0.3s ease;
        }

        .cart-card:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .cart-item img {
            width: 80px;
            height: auto;
            border-radius: 5px;
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
            transition: background-color 0.3s, border-color 0.3s;
        }

        .btn-danger:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }

        .total-row {
            font-weight: bold;
            font-size: 1.2em;
        }

        /* Tăng kích thước checkbox */
        input[type="checkbox"] {
            width: 30px;
            height: 30px;
            cursor: pointer;
        }

        /* Thêm khoảng cách cho các nút */
        .btn-secondary {
            margin: 0 5px;
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

<div class="container cart-container mb-3">
    <div class="cart-card">
        <h2 class="cart-header">Phiếu Nhập Hàng</h2>
        <form action="${pageContext.request.contextPath}/nhap-hang/add" method="post">
            <table class="table table-hover table-bordered text-center align-middle">
                <thead class="table-light">
                <tr>
                    <th>Chọn</th>
                    <th>Sản Phẩm</th>
                    <th>Giá Nhập</th>
                    <th>Nhà Cung Cấp</th>
                    <th>Số Lượng</th>
                    <th>Tổng Tiền</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${listSanPhamChiTiet}">
                    <tr data-id="${item.id}">
                        <td>
                            <input type="checkbox" name="selectedItems" value="${item.id}"/>
                        </td>
                        <td class="cart-item">
                            <img src="${pageContext.request.contextPath}/uploads/${item.hinhAnh}"
                                 alt="${item.sanPham.ten}">
                            <div class="product-name">${item.sanPham.ten}</div>
                        </td>
                        <td>
                            <span class="giaNhapSpan" data-giaban="${item.sanPham.giaBan}">
                <fmt:formatNumber value="${item.sanPham.giaBan}" pattern="#,###" /> đ
                            </span>
                        </td>
                        <td>${item.sanPham.nhaCungCap.tenNCC}</td> <!-- Hiển thị nhà cung cấp -->
                        <td>
                            <input type="number" name="soLuong_${item.id}" value="0" class="form-control soLuongInput"
                                   style="width: 60px; text-align: center;" min="0" required/>
                        </td>
                        <td>
                        <span class="tongTien_${item.id}">
                            ${tongTienMap[item.id] != null ? tongTienMap[item.id] : 0} đ
                        </span>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <!-- Phân trang -->
            <div class="d-flex justify-content-center mt-4">
                <c:if test="${currentPage > 0}">
                    <a href="${pageContext.request.contextPath}/nhap-hang/dat-hang?page=${currentPage - 1}&size=${size}"
                       class="btn btn-outline-primary">Previous</a>
                </c:if>
                <c:forEach begin="0" end="${totalPages - 1}" var="i">
                    <a href="${pageContext.request.contextPath}/nhap-hang/dat-hang?page=${i}&size=${size}"
                       class="btn btn-outline-primary mx-1">${i + 1}</a>
                </c:forEach>
                <c:if test="${currentPage < totalPages - 1}">
                    <a href="${pageContext.request.contextPath}/nhap-hang/dat-hang?page=${currentPage + 1}&size=${size}"
                       class="btn btn-outline-primary">Next</a>
                </c:if>
            </div>


            <div class="form-group mt-4">
                <label for="ghiChu">Ghi Chú:</label>
                <textarea name="ghiChu" id="ghiChu" class="form-control" rows="4"></textarea>
            </div>

            <!-- Tổng giá trị -->
            <div class="d-flex justify-content-between align-items-center mt-4">
                <h4>Tổng Giá Trị: <span id="totalValue" style="display:none;">0 đ</span></h4>
                <button type="submit" class="btn btn-success btn-lg" id="checkoutBtn" disabled>Gửi phiếu nhập</button>
            </div>
        </form>
    </div>
</div>


<script>
    function saveCartToLocalStorage() {
        let cartItems = [];

        document.querySelectorAll('tr').forEach(function (row) {
            const giaNhapSpan = row.querySelector('.giaNhapSpan');
            const soLuongInput = row.querySelector('.soLuongInput');
            const checkbox = row.querySelector('input[type="checkbox"]');

            if (!giaNhapSpan || !soLuongInput || !checkbox) {
                return;
            }

            const item = {
                id: checkbox.value,
                giaNhap: parseFloat(giaNhapSpan.getAttribute('data-giaban')) || 0,
                soLuong: parseInt(soLuongInput.value) || 0,
                checked: checkbox.checked
            };

            cartItems.push(item);
        });

        localStorage.setItem('cartItems', JSON.stringify(cartItems));
    }

    function loadCartFromLocalStorage() {
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];

        document.querySelectorAll('tr').forEach(function (row) {
            const checkbox = row.querySelector('input[type="checkbox"]');
            const giaNhapSpan = row.querySelector('.giaNhapSpan');
            const soLuongInput = row.querySelector('.soLuongInput');

            if (!checkbox || !giaNhapSpan || !soLuongInput) {
                return;
            }

            const item = cartItems.find(item => item.id === checkbox.value);

            if (item) {
                giaNhapSpan.setAttribute('data-giaban', item.giaNhap);
                soLuongInput.value = item.soLuong;
                checkbox.checked = item.checked;
            }
        });
    }

    function updateTotal() {
        let totalValue = 0;
        let isAnyCheckboxChecked = false;

        // Thêm formatter để định dạng tiền tệ
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND',
            minimumFractionDigits: 0
        });

        document.querySelectorAll('tr').forEach(function (row) {
            const giaNhapSpan = row.querySelector('.giaNhapSpan');
            const soLuongInput = row.querySelector('.soLuongInput');
            const checkbox = row.querySelector('input[type="checkbox"]');

            if (!giaNhapSpan || !soLuongInput || !checkbox) {
                return;
            }

            const tongTienElement = row.querySelector('.tongTien_' + checkbox.value);

            if (!tongTienElement) {
                return;
            }

            const giaNhap = parseFloat(giaNhapSpan.getAttribute('data-giaban')) || 0;
            const soLuong = parseInt(soLuongInput.value) || 0;
            const tongTien = giaNhap * soLuong;

            // Định dạng số tiền cho từng hàng
            tongTienElement.textContent = formatter.format(tongTien);

            if (checkbox.checked) {
                totalValue += tongTien;
                isAnyCheckboxChecked = true;
            }
        });

        const totalValueElement = document.getElementById('totalValue');
        if (totalValueElement) {
            // Định dạng tổng giá trị
            totalValueElement.textContent = formatter.format(totalValue);
            totalValueElement.style.display = isAnyCheckboxChecked ? 'inline' : 'none';
        }

        const checkoutBtn = document.getElementById('checkoutBtn');
        if (checkoutBtn) {
            checkoutBtn.disabled = !isAnyCheckboxChecked || totalValue === 0;
        }
    }

    document.querySelectorAll('.giaNhapInput, .soLuongInput, input[type="checkbox"]').forEach(function (input) {
        input.addEventListener('input', function () {
            updateTotal();
            saveCartToLocalStorage();
        });
        input.addEventListener('change', function () {
            updateTotal();
            saveCartToLocalStorage();
        });
    });

    window.onload = function () {
        loadCartFromLocalStorage();
        updateTotal();
    };
</script>


</body>
</html>