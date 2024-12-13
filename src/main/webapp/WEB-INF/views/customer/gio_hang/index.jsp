<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Giỏ hàng của bạn</title>
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

        th div.text-center {
            display: flex;
            justify-content: center; /* Căn giữa theo chiều ngang */
            align-items: center;    /* Căn giữa theo chiều dọc */
            height: 100%;           /* Đảm bảo chiều cao bằng với chiều cao của ô */
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
                        <th>
                            <div class="text-center">
                                <input type="checkbox" id="selectAll" style="width: 30px; height: 30px; cursor: pointer;"/>
                            </div>
                        </th>
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
                            <td>
                                <c:choose>
                                    <c:when test="${item.sanPhamChiTiet.giaGiamGia != null and item.sanPhamChiTiet.giaGiamGia > 0}">
                                        <span style="text-decoration: line-through; color: gray;">
                                            <fmt:formatNumber value="${item.sanPhamChiTiet.giaBan}" type="number" pattern="#,###" /> VNĐ
                                        </span>
                                        <br>
                                        <span style="color: green; font-weight: bold;">
                                        <fmt:formatNumber value="${item.sanPhamChiTiet.giaGiamGia}" type="number" pattern="#,###" /> VNĐ
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span><fmt:formatNumber value="${item.sanPhamChiTiet.giaBan}" type="number" pattern="#,###" /> VNĐ</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                    </form>
                    <td class="text-center">
                        <div class="d-flex align-items-center justify-content-center">
                            <form action="${pageContext.request.contextPath}/gio-hang/updateQuantity" method="post" class="me-2">
                                <input type="hidden" name="sanPhamId" value="${item.sanPhamChiTiet.id}"/>
                                <input type="hidden" name="soLuong" value="${item.soLuong + 1}"/>
                                <button type="submit" class="btn btn-secondary">
                                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m5 15 7-7 7 7"/>
                                    </svg>
                                </button>
                            </form>

                            <input type="number" id="soLuong-${item.sanPhamChiTiet.id}" name="soLuong" value="${item.soLuong}" min="1" required class="form-control me-2" style="width: 60px; text-align: center;" />

                            <form action="${pageContext.request.contextPath}/gio-hang/updateQuantity" method="post" class="me-2">
                                <input type="hidden" name="sanPhamId" value="${item.sanPhamChiTiet.id}"/>
                                <input type="hidden" name="soLuong" value="${item.soLuong - 1}"/>
                                <button type="submit" class="btn btn-secondary" ${item.soLuong <= 1 ? 'disabled' : ''}>
                                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m19 9-7 7-7-7"/>
                                    </svg>
                                </button>
                            </form>
                        </div>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${item.sanPhamChiTiet.giaGiamGia != null and item.sanPhamChiTiet.giaGiamGia > 0}">
                                <fmt:formatNumber value="${item.sanPhamChiTiet.giaGiamGia * item.soLuong}" type="number" pattern="#,###" /> VNĐ
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${item.sanPhamChiTiet.giaBan * item.soLuong}" type="number" pattern="#,###" /> VNĐ
                            </c:otherwise>
                        </c:choose>
                    </td>
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
                    <button type="submit" class="btn btn-success btn-lg" id="checkoutBtn" onchange="toggleCheckoutButton()" disabled>Xác nhận giỏ hàng
                    </button>
                </div>
            </form>
        </c:if>
    </div>
</div>
<jsp:include page="../footer_user.jsp"/>
</body>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const selectAllCheckbox = document.getElementById('selectAll');
        const productCheckboxes = document.querySelectorAll('input[name="selectedItems"]');
        const checkoutBtn = document.getElementById('checkoutBtn');

        selectAllCheckbox.addEventListener('change', function () {
            const isChecked = this.checked;
            productCheckboxes.forEach(checkbox => {
                checkbox.checked = isChecked;
            });
            toggleCheckoutButton();
            updateTotalInvoice();
        });

        productCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function () {
                if (!this.checked) {
                    selectAllCheckbox.checked = false;
                } else if (Array.from(productCheckboxes).every(checkbox => checkbox.checked)) {
                    selectAllCheckbox.checked = true;
                }
                toggleCheckoutButton();
                updateTotalInvoice();
            });
        });
    });

    document.addEventListener('DOMContentLoaded', function () {
        const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
        const popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
            return new bootstrap.Popover(popoverTriggerEl, {
                html: true,
                trigger: 'manual'
            });
        });

        popoverTriggerList.forEach((element, index) => {
            element.addEventListener('mouseenter', function () {
                popoverList[index].show();
            });
            element.addEventListener('mouseleave', function () {
                popoverList[index].hide();
            });
        });
    });

    function updateTotalInvoice() {
        const checkboxes = document.querySelectorAll('input[name="selectedItems"]:checked');
        const selectedIds = Array.from(checkboxes).map(checkbox => checkbox.value);
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
                const formattedTotal = new Intl.NumberFormat('vi-VN').format(totalValue);
                document.getElementById('totalValue').textContent = formattedTotal + ' đ';
            })
            .catch(error => console.error('Error:', error));
    }

    document.querySelectorAll('input[name="selectedItems"]').forEach((checkbox) => {
        checkbox.addEventListener('change', updateTotalInvoice);
    });

    function toggleCheckoutButton() {
        const checkboxes = document.querySelectorAll('input[name="selectedItems"]');
        const anyChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);
        const checkoutBtn = document.getElementById('checkoutBtn');
        checkoutBtn.disabled = !anyChecked;
    }

    document.querySelectorAll('input[name="selectedItems"]').forEach((checkbox) => {
        checkbox.addEventListener('change', toggleCheckoutButton);
    });

    toggleCheckoutButton();

    document.querySelectorAll('input[type="number"]').forEach(input => {
        input.addEventListener('keydown', function(event) {
            if (event.key === 'Enter') {
                event.preventDefault();
                const productId = this.id.split('-')[1];
                const quantity = this.value;
                if (quantity && quantity > 0) {
                    const formData = new FormData();
                    formData.append('sanPhamId', productId);
                    formData.append('soLuong', quantity);

                    fetch('${pageContext.request.contextPath}/gio-hang/updateQuantity', {
                        method: 'POST',
                        body: formData
                    })
                        .then(response => {
                            if (response.ok) {
                                console.log('Số lượng đã được cập nhật thành công.');
                                window.location.reload();
                            } else {
                                console.error('Có lỗi xảy ra khi cập nhật số lượng.');
                            }
                        })
                        .catch(error => console.error('Có lỗi xảy ra:', error));
                } else {
                    alert('Vui lòng nhập số lượng hợp lệ.');
                }
            }
        });
    });
</script>
</html>