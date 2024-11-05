<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <title>Quản Lý Kho Hàng</title>
</head>
<body>
<div class="container mt-3">
    <!-- Modal -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productModalLabel">Thêm Số Lượng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="productForm" action="/kho-hang/update" method="post">
                        <input type="hidden" name="idKhoHang"/>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Tên Kho</label>
                                    <input type="text" class="form-control" name="tenKho" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Sản Phẩm Tồn Kho</label>
                                    <input type="text" class="form-control" name="spTrongKho" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Số Lượng Tồn Hàng</label>
                                    <div class="input-group">
                                        <button class="btn btn-secondary" type="button" id="decrementBtn"
                                                onclick="changeQuantity(-10)">-
                                        </button>
                                        <input type="text" class="form-control" name="slTonKho"
                                               value="${khoHang.slTonKho}" id="slTonKhoInput" required>
                                        <button class="btn btn-secondary" type="button" id="incrementBtn"
                                                onclick="changeQuantity(10)">+
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <table class="table table-hover table-bordered text-center mt-3">
        <thead>
        <tr>
            <th>STT</th>
            <th>Tên Kho</th>
            <th>Dia Chi</th>
            <th>San Pham Trong Kho</th>
            <th>So Luong Ton Kho</th>
            <th>Ngay Thay Doi Ton Kho</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty data.content}">
            <tr>
                <td colspan="10">Không tìm thấy đối tượng nào.</td>
            </tr>
        </c:if>
        <c:if test="${not empty data.content}">
            <c:forEach items="${data.content}" var="kh" varStatus="i">
                <tr>
                    <th>${i.index + 1}</th>
                    <td>${kh.tenKho}</td>
                    <td>${kh.diaChi}</td>
                    <td>${kh.spTrongKho}</td>
                    <td>${kh.slTonKho}</td>
                    <td>${kh.ngayThayDoiTonKho}</td>
                    <td>
                        <button type="button" class="btn btn-default bordervien table__logo"
                                data-bs-toggle="modal"
                                data-bs-target="#productModal"
                                onclick="setModalData('${kh.id}', '${kh.tenKho}', '${kh.spTrongKho}', '${kh.slTonKho}')">
                            <i class='bx bx-edit-alt'></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
</div>

<nav aria-label="Page navigation" class="mt-3">
    <ul class="pagination justify-content-center">
        <c:if test="${currentPage > 0}">
            <li class="page-item">
                <a class="page-link" href="/kho-hang/hien-thi?page=0&size=${nv.size}" aria-label="First">
                    <span aria-hidden="true">&laquo;&laquo; First</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/kho-hang/hien-thi?page=${currentPage - 1}&size=${nv.size}"
                   aria-label="Previous">
                    <span aria-hidden="true">&laquo; Previous</span>
                </a>
            </li>
        </c:if>
        <li class="page-item disabled">
            <a class="page-link" href="#">Page ${currentPage + 1} of ${totalPages}</a>
        </li>
        <c:if test="${currentPage < totalPages - 1}">
            <li class="page-item">
                <a class="page-link" href="/kho-hang/hien-thi?page=${currentPage + 1}&size=${nv.size}"
                   aria-label="Next">
                    <span aria-hidden="true">Next &raquo;</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/kho-hang/hien-thi?page=${totalPages - 1}&size=${nv.size}"
                   aria-label="Last">
                    <span aria-hidden="true">Last &raquo;&raquo;</span>
                </a>
            </li>
        </c:if>
    </ul>
</nav>

<script>
    function resetForm() {
        document.getElementById('productForm').reset();
        document.getElementById('productId').value = '';
    }

    function setModalData(id, tenKho, spTrongKho, slTonKho) {
        // Kiểm tra giá trị của các tham số khi hàm được gọi
        console.log('ID Kho:', id);
        console.log('Tên Kho:', tenKho);
        console.log('Sản Phẩm Trong Kho:', spTrongKho);
        console.log('Số Lượng Tồn Kho:', slTonKho);

        // Cập nhật các trường input trong modal
        document.querySelector('input[name="idKhoHang"]').value = id; // Thiết lập ID kho
        document.querySelector('input[name="tenKho"]').value = tenKho; // Thiết lập tên kho
        document.querySelector('input[name="spTrongKho"]').value = spTrongKho; // Thiết lập sản phẩm trong kho
        document.querySelector('input[name="slTonKho"]').value = slTonKho; // Thiết lập số lượng tồn kho

        // Thay đổi tiêu đề modal nếu cần
        document.getElementById('productModalLabel').textContent = 'Chỉnh Sửa Số Lượng';
    }

    function changeQuantity(amount) {
        var quantityInput = document.getElementById('slTonHangInput'); // Lấy ô input
        var currentValue = parseInt(quantityInput.value); // Lấy giá trị hiện tại và chuyển thành số
        if (isNaN(currentValue)) { // Nếu giá trị hiện tại không phải là số
            currentValue = 0; // Thiết lập giá trị mặc định là 0
        }
        var newValue = currentValue + amount; // Thêm hoặc bớt 10
        quantityInput.value = newValue; // Cập nhật giá trị mới vào ô input
    }

    function changeQuantity(amount) {
        var quantityInput = document.getElementById('slTonHangInput');
        var currentValue = parseInt(quantityInput.value);

        if (isNaN(currentValue)) {
            currentValue = 0;
        }

        var newValue = currentValue + amount;

        // Giới hạn giá trị tối thiểu và tối đa
        if (newValue < 0) {
            newValue = 0; // Giới hạn không cho phép số âm
        }
        if (newValue > 1000) { // Ví dụ: Giới hạn số lượng tối đa là 1000
            newValue = 1000;
        }

        quantityInput.value = newValue;
    }
</script>

<style>
    body {
        background-color: #f8f9fa;
        position: relative; /* Để thông báo được căn chỉnh đúng */
    }

    .bordervien {
        border: 1px solid #030303;
    }

    .table__logo {
        font-size: 20px;
        margin-bottom: 2.5rem;
    }

    .input-group {
        flex: 1;
        max-width: 500px;
    }

    .form-control {
        flex: 1;
    }

    .input-group .btn {
        white-space: nowrap;
    }
</style>
</body>
</html>