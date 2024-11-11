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
<jsp:include page="../layout.jsp"/>
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
                    <form id="productForm" action="/kho-hang/update" method="POST">
                        <input type="hidden" name="idKhoHang" id="khId"/> <!-- Hidden input để lưu ID của kho hàng cần sửa -->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Tên Kho</label>
                                    <input type="text" class="form-control" name="tenKho" id="khName" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Địa Chỉ</label>
                                    <input type="text" class="form-control" name="diaChi" id="khDiaChi" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Sản Phẩm Trong Kho</label>
                                    <input type="text" class="form-control" name="spTrongKho" id="khSanPham" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Số Lượng Tồn Kho</label>
                                    <input type="number" class="form-control" name="slTonKho" id="khSoLuong" value="0" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Ngày Thay Đổi Tồn Kho</label>
                                    <input type="date" class="form-control" name="ngayThayDoiTonKho" id="khNgayThayDoi" required>
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
                                onclick="setModalData('${kh.id}', '${kh.tenKho}', '${kh.diaChi}', '${kh.spTrongKho}', '${kh.slTonKho}', '${kh.ngayThayDoiTonKho}')">
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

    function setModalData(id, tenKho, diaChi, spTrongKho, slTonKho, ngayThayDoiTonKho) {
        // Kiểm tra giá trị của các tham số khi hàm được gọi (Đảm bảo giá trị không rỗng)
        console.log('ID Kho:', id);
        console.log('Tên Kho:', tenKho);
        console.log('Địa Chỉ:', diaChi);
        console.log('Sản Phẩm Trong Kho:', spTrongKho);
        console.log('Số Lượng Tồn Kho:', slTonKho);
        console.log('Ngày Thay Đổi Tồn Kho:', ngayThayDoiTonKho);

        // Cập nhật giá trị cho các trường trong modal
        document.getElementById('khId').value = id;
        document.getElementById('khName').value = tenKho;
        document.getElementById('khDiaChi').value = diaChi;
        document.getElementById('khSanPham').value = spTrongKho;
        document.getElementById('khSoLuong').value = slTonKho;
        document.getElementById('khNgayThayDoi').value = ngayThayDoiTonKho;
        // document.querySelector('input[name="idKhoHang"]').value = id;
        // document.querySelector('input[name="tenKho"]').value = tenKho;
        // document.querySelector('input[name="diaChi"]').value = diaChi;
        // document.querySelector('input[name="spTrongKho"]').value = spTrongKho;
        // document.querySelector('input[name="slTonKho"]').value = slTonKho;
        // document.querySelector('input[name="ngayThayDoiTonKho"]').value = ngayThayDoiTonKho;

        // Đảm bảo tên của nút lưu thay đổi
        document.getElementById('productModalLabel').textContent = 'Chỉnh Sửa Thông Tin Kho';

        // Đặt method PUT/PATCH cho form khi sửa
        document.getElementById('productForm').action = '/kho-hang/update';  // Chỉ định URL đúng cho action sửa
        document.getElementById('productForm').method = 'POST';  // Hoặc 'PUT' nếu sử dụng phương thức PUT
    }

    // function changeQuantity(amount) {
    //     // Lấy giá trị hiện tại của input số lượng tồn kho
    //     var quantityInput = document.getElementById('slTonKhoInput');
    //     var currentValue = parseInt(quantityInput.value);
    //
    //     // Nếu giá trị không phải là một số, gán giá trị mặc định là 0
    //     if (isNaN(currentValue)) {
    //         currentValue = 0;
    //     }
    //
    //     // Tính toán giá trị mới sau khi thay đổi
    //     var newValue = currentValue + amount;
    //
    //     // Giới hạn giá trị không được âm và không vượt quá 1000
    //     if (newValue < 0) {
    //         newValue = 0; // Không cho phép số lượng âm
    //     }
    //     if (newValue > 1000) {
    //         newValue = 1000; // Giới hạn số lượng tối đa là 1000
    //     }
    //
    //     // Cập nhật lại giá trị trong input
    //     quantityInput.value = newValue;
    // }
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
        border-radius: 50%; /* Làm cho các nút có dạng hình tròn */
    }

    /* Giảm kích thước các nút + và - */
    .btn-sm {
        font-size: 14px; /* Giảm kích thước chữ */
        padding: 5px 10px; /* Giảm padding */
        width: 35px; /* Đặt chiều rộng cụ thể */
        height: 35px; /* Đặt chiều cao cụ thể */
        color: black; /* Màu chữ trắng */
    }
</style>
</body>
</html>