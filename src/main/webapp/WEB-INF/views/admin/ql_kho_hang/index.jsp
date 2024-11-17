<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <title>Quản Lý Kho Hàng</title>
</head>
<body>
<jsp:include page="../layout.jsp" />
<div class="container mt-3">
    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productModalLabel">Chỉnh Sửa Thông Tin Kho</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="productForm" action="/kho-hang/update" method="POST">
                        <input type="hidden" name="idKhoHang" id="khId"/> <!-- Hidden input để lưu ID của kho hàng cần sửa -->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Tên Kho</label>
                                    <input type="text" class="form-control" name="tenKho" id="khName" value="${kh.tenKho}" required readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Địa Chỉ</label>
                                    <input type="text" class="form-control" name="diaChi" id="khDiaChi" value="${kh.diaChi}" required readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Sản Phẩm Trong Kho</label>
                                    <input type="text" class="form-control" name="spTrongKho" id="khSanPham" value="${kh.spTrongKho}" required readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Số Lượng Tồn Kho</label>
                                    <input type="number" class="form-control" name="slTonKho" id="khSoLuong" value="${kh.slTonKho}" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Ngày Thay Đổi Tồn Kho</label>
                                    <input type="date" class="form-control" name="ngayThayDoiTonKho" id="khNgayThayDoi" value="${kh.ngayThayDoiTonKho}" required>
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
        // Đảm bảo các tham số không rỗng
        console.log('Kho hàng ID:', id);
        console.log('Tên Kho:', tenKho);
        console.log('Địa Chỉ:', diaChi);
        console.log('Sản Phẩm Trong Kho:', spTrongKho);
        console.log('Số Lượng Tồn Kho:', slTonKho);
        console.log('Ngày Thay Đổi Tồn Kho:', ngayThayDoiTonKho);

        // Cập nhật các trường trong modal
        document.getElementById('khId').value = id;
        document.getElementById('khName').value = tenKho;
        document.getElementById('khDiaChi').value = diaChi;
        document.getElementById('khSanPham').value = spTrongKho;
        document.getElementById('khSoLuong').value = slTonKho;  // Chỉ cập nhật số lượng tồn kho
        document.getElementById('khNgayThayDoi').value = ngayThayDoiTonKho;

        // Đảm bảo modal dùng action đúng cho sửa
        document.getElementById('productModalLabel').textContent = 'Chỉnh Sửa Số Lượng Tồn Kho';
        document.getElementById('productForm').action = '/kho-hang/update';  // Đặt action là URL cho phương thức cập nhật
        document.getElementById('productForm').method = 'POST';  // POST hoặc PUT nếu sử dụng PUT cho cập nhật
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
        border-radius: 50%; /* Làm cho các nút có dạng hình tròn */
    }
</style>
</body>
</html>