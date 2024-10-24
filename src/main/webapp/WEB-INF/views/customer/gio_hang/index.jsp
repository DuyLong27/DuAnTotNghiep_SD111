<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Giỏ hàng của bạn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
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
    </style>
</head>
<body>
<jsp:include page="../header_user.jsp"/>
<div class="container cart-container mb-3">
    <div class="cart-card">
        <h2 class="cart-header">Giỏ hàng của bạn</h2>
        <c:if test="${empty listGioHang}">
            <div class="alert alert-warning" role="alert">
                Bạn chưa có sản phẩm nào trong giỏ hàng cả, hãy đi mua đi!
            </div>
        </c:if>
        <c:if test="${not empty listGioHang}">
            <form action="${pageContext.request.contextPath}/gio-hang/checkout" method="post">
                <table class="table table-hover table-bordered text-center align-middle">
                    <thead class="table-light">
                    <tr>
                        <th>Chọn</th>
                        <th>Tên Sản Phẩm</th>
                        <th>Giá Bán</th>
                        <th>Số Lượng</th>
                        <th>Tổng Tiền</th>
                        <th>Thao Tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <form action="${pageContext.request.contextPath}/gio-hang/checkout" method="post">
                        <c:forEach var="item" items="${listGioHang}">
                        <tr>
                            <td>
                                <input type="checkbox" name="selectedItems" value="${item.sanPhamChiTiet.id}"/>
                            </td>
                            <td class="cart-item">
                                <img src="${pageContext.request.contextPath}/uploads/${item.sanPhamChiTiet.hinhAnh}"
                                     alt="${item.sanPhamChiTiet.sanPham.ten}"
                                     style="cursor: pointer;"
                                     data-bs-toggle="popover"
                                     title="${item.sanPhamChiTiet.sanPham.ten}"
                                     data-bs-content='
                             <strong>Thông tin chi tiết:</strong><br>
                             <ul class="list-unstyled mb-0">
                                 <li><strong>Loại cà phê:</strong> ${item.sanPhamChiTiet.loaiCaPhe.ten}</li>
                                 <li><strong>Cân nặng:</strong> ${item.sanPhamChiTiet.canNang.ten}</li>
                                 <li><strong>Loại túi:</strong> ${item.sanPhamChiTiet.loaiTui.ten}</li>
                                 <li><strong>Độ rang:</strong> ${item.sanPhamChiTiet.mucDoRang.ten}</li>
                                 <li><strong>Hương vị:</strong> ${item.sanPhamChiTiet.huongVi.ten}</li>
                                 <li><strong>Thương hiệu:</strong> ${item.sanPhamChiTiet.thuongHieu.ten}</li>
                             </ul>'>
                                <div class="product-name">
                                        ${item.sanPhamChiTiet.sanPham.ten}
                                </div>
                            </td>
                            <td>${item.sanPhamChiTiet.giaBan} đ</td>
                    </form>
                    <td>
                        <form action="${pageContext.request.contextPath}/gio-hang/updateQuantity" method="post"
                              style="display: inline-block;">
                            <input type="hidden" name="sanPhamId" value="${item.sanPhamChiTiet.id}"/>
                            <input type="hidden" name="action" value="increase"/>
                            <button type="submit" class="btn btn-secondary">
                                <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                                     xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                                     viewBox="0 0 24 24">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                          stroke-width="2" d="m5 15 7-7 7 7"/>
                                </svg>
                            </button>
                        </form>
                        <form action="${pageContext.request.contextPath}/gio-hang/checkout" method="post">
                                ${item.soLuong}
                        </form>
                        <form action="${pageContext.request.contextPath}/gio-hang/updateQuantity" method="post"
                              style="display: inline-block;">
                            <input type="hidden" name="sanPhamId" value="${item.sanPhamChiTiet.id}"/>
                            <input type="hidden" name="action" value="decrease"/>
                            <button type="submit" class="btn btn-secondary">
                                <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                                     xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                                     viewBox="0 0 24 24">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                          stroke-width="2" d="m19 9-7 7-7-7"/>
                                </svg>
                            </button>
                        </form>
                    </td>
                    <td>${item.sanPhamChiTiet.giaBan * item.soLuong}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/gio-hang/remove" method="post">
                            <input type="hidden" name="sanPhamId" value="${item.sanPhamChiTiet.id}"/>
                            <button type="submit" class="btn btn-danger"
                                    onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">
                                <i class="bi bi-trash"></i> Xóa
                            </button>
                        </form>
                    </td>
                    </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <h4>Tạm tính: <span id="totalValue">0 đ</span></h4>
                    <button type="submit" class="btn btn-success btn-lg" id="checkoutBtn" disabled>Xác nhận giỏ hàng
                    </button>
                </div>
            </form>
        </c:if>
    </div>
</div>
<jsp:include page="../footer_user.jsp"/>
</body>
<script>
    // Khởi tạo popover cho các phần tử
    document.addEventListener('DOMContentLoaded', function () {
        const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
        const popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
            return new bootstrap.Popover(popoverTriggerEl, {
                html: true, // Cho phép HTML trong popover
                trigger: 'manual' // Thay đổi cách kích hoạt popover
            });
        });

        // Thêm sự kiện mouseenter và mouseleave cho các sản phẩm
        popoverTriggerList.forEach((element, index) => {
            element.addEventListener('mouseenter', function () {
                popoverList[index].show(); // Hiện popover
            });
            element.addEventListener('mouseleave', function () {
                popoverList[index].hide(); // Ẩn popover
            });
        });
    });

    function updateTotalInvoice() {
        const checkboxes = document.querySelectorAll('input[name="selectedItems"]:checked');
        const selectedIds = Array.from(checkboxes).map(checkbox => checkbox.value);

        // Gửi yêu cầu đến server để tính toán tổng giá trị hóa đơn
        fetch('/gio-hang/calculateTotal', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                selectedIds: selectedIds
            })
        })
            .then(response => response.text())
            .then(totalValue => {
                document.getElementById('totalValue').textContent = totalValue + ' đ'; // Cập nhật hiển thị
            })
            .catch(error => console.error('Error:', error));
    }

    // Gọi hàm khi checkbox được thay đổi
    document.querySelectorAll('input[name="selectedItems"]').forEach((checkbox) => {
        checkbox.addEventListener('change', updateTotalInvoice);
    });

    function toggleCheckoutButton() {
        // Lấy tất cả các checkbox
        const checkboxes = document.querySelectorAll('input[name="selectedItems"]');
        // Kiểm tra xem có checkbox nào được chọn hay không
        const anyChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);
        // Lấy nút "Xác nhận giỏ hàng"
        const checkoutBtn = document.getElementById('checkoutBtn');
        // Nếu có ít nhất một checkbox được chọn, kích hoạt nút
        checkoutBtn.disabled = !anyChecked;
    }

    // Gọi hàm kiểm tra khi checkbox thay đổi
    document.querySelectorAll('input[name="selectedItems"]').forEach((checkbox) => {
        checkbox.addEventListener('change', toggleCheckoutButton);
    });

    // Gọi hàm kiểm tra ban đầu để đảm bảo trạng thái nút đúng
    toggleCheckoutButton();
</script>
</html>