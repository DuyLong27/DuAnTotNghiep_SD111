<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                            <input type="checkbox" name="selectedItems" value="${item.id}" />
                        </td>
                        <td class="cart-item">
                            <img src="${pageContext.request.contextPath}/uploads/${item.hinhAnh}" alt="${item.sanPham.ten}">
                            <div class="product-name">${item.sanPham.ten}</div>
                        </td>
                        <td>
                            <input type="number" name="giaNhap_${item.id}" value="0" class="form-control giaNhapInput" style="width: 100px; text-align: center;" min="0" required/>
                        </td>
                        <td>${item.sanPham.nhaCungCap.tenNCC}</td> <!-- Hiển thị nhà cung cấp -->
                        <td>
                            <input type="number" name="soLuong_${item.id}" value="0" class="form-control soLuongInput" style="width: 60px; text-align: center;" min="0" required/>
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
    // Lưu giỏ hàng vào localStorage
    function saveCartToLocalStorage() {
        let cartItems = [];

        document.querySelectorAll('tr').forEach(function(row) {
            const giaNhapInput = row.querySelector('.giaNhapInput');
            const soLuongInput = row.querySelector('.soLuongInput');
            const checkbox = row.querySelector('input[type="checkbox"]');

            // Nếu không tìm thấy các phần tử cần thiết, bỏ qua dòng này
            if (!giaNhapInput || !soLuongInput || !checkbox) {
                return;
            }

            const item = {
                id: checkbox.value,
                giaNhap: parseFloat(giaNhapInput.value) || 0,
                soLuong: parseInt(soLuongInput.value) || 0,
                checked: checkbox.checked
            };

            cartItems.push(item);
        });

        // Lưu giỏ hàng vào localStorage dưới dạng JSON
        localStorage.setItem('cartItems', JSON.stringify(cartItems));
    }

    // Khôi phục giỏ hàng từ localStorage
    function loadCartFromLocalStorage() {
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];

        document.querySelectorAll('tr').forEach(function(row) {
            const checkbox = row.querySelector('input[type="checkbox"]');
            const giaNhapInput = row.querySelector('.giaNhapInput');
            const soLuongInput = row.querySelector('.soLuongInput');

            if (!checkbox || !giaNhapInput || !soLuongInput) {
                return;
            }

            // Tìm phần tử trong giỏ hàng đã lưu
            const item = cartItems.find(item => item.id === checkbox.value);

            if (item) {
                // Cập nhật giá trị từ giỏ hàng đã lưu
                giaNhapInput.value = item.giaNhap;
                soLuongInput.value = item.soLuong;
                checkbox.checked = item.checked;
            }
        });
    }

    // Cập nhật tổng tiền
    function updateTotal() {
        let totalValue = 0;
        let isAnyCheckboxChecked = false; // Kiểm tra có checkbox nào được chọn

        // Lặp qua từng sản phẩm để tính tổng tiền
        document.querySelectorAll('tr').forEach(function(row) {
            const giaNhapInput = row.querySelector('.giaNhapInput');
            const soLuongInput = row.querySelector('.soLuongInput');
            const checkbox = row.querySelector('input[type="checkbox"]');

            // Nếu không tìm thấy các phần tử cần thiết, bỏ qua dòng này
            if (!giaNhapInput || !soLuongInput || !checkbox) {
                return;
            }

            const tongTienElement = row.querySelector('.tongTien_' + checkbox.value);

            // Nếu không tìm thấy phần tử hiển thị tổng tiền, bỏ qua dòng này
            if (!tongTienElement) {
                return;
            }

            const giaNhap = parseFloat(giaNhapInput.value) || 0;
            const soLuong = parseInt(soLuongInput.value) || 0;
            const tongTien = giaNhap * soLuong;

            tongTienElement.textContent = tongTien + ' đ';

            // Cập nhật tổng giá trị của giỏ hàng nếu sản phẩm được chọn
            if (checkbox.checked) {
                totalValue += tongTien;
                isAnyCheckboxChecked = true; // Đánh dấu rằng có ít nhất 1 checkbox được chọn
            }
        });

        // Hiển thị tổng giá trị của giỏ hàng chỉ khi có checkbox được chọn
        const totalValueElement = document.getElementById('totalValue');
        if (totalValueElement) {
            totalValueElement.textContent = totalValue + ' đ';
            totalValueElement.style.display = isAnyCheckboxChecked ? 'inline' : 'none'; // Ẩn/hiện tổng giá trị
        }

        // Kích hoạt nút "Gửi phiếu nhập" nếu có ít nhất 1 sản phẩm được chọn và tổng giá trị > 0
        const checkoutBtn = document.getElementById('checkoutBtn');
        const selectedItems = document.querySelectorAll('input[name="selectedItems"]:checked').length;
        if (checkoutBtn) {
            checkoutBtn.disabled = selectedItems === 0 || totalValue === 0;
        }
    }

    // Lắng nghe sự kiện khi người dùng thay đổi giá trị
    document.querySelectorAll('.giaNhapInput, .soLuongInput, input[type="checkbox"]').forEach(function(input) {
        input.addEventListener('input', function() {
            updateTotal();
            saveCartToLocalStorage(); // Lưu lại giỏ hàng sau mỗi thay đổi
        });
        input.addEventListener('change', function() {
            updateTotal();
            saveCartToLocalStorage(); // Lưu lại giỏ hàng sau mỗi thay đổi
        });
    });

    // Chạy khi trang được tải để khôi phục giỏ hàng từ localStorage
    window.onload = function() {
        loadCartFromLocalStorage();
        updateTotal();
    };

</script>


</body>
</html>