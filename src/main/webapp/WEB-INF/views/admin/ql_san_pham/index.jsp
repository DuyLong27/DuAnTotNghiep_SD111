<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Danh Sách Sản Phẩm</title>
    <style>
        body {
            background-color: #f8f9fa;
            position: relative; /* Để thông báo được căn chỉnh đúng */
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

        /* CSS cho thông báo */
        #successMessage {
            position: fixed; /* Sử dụng fixed để thông báo không di chuyển khi cuộn */
            top: 20px; /* Cách mép trên 20px */
            right: 20px; /* Cách mép bên phải 20px */
            z-index: 1050; /* Đảm bảo thông báo nằm trên các phần tử khác */
        }
    </style>
</head>
<body>
<jsp:include page="../layout.jsp" />
<div class="container mt-3">
    <h1 class="text-center mt-3">Danh Sách Sản Phẩm</h1>
    <!-- Thông báo -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert" id="successMessage">
                ${message}
        </div>
    </c:if>
    <form action="/san-pham/index" method="get" id="filterSearchForm">
        <div class="row">
            <div class="col-md-4">
                <h5>Lọc Theo Danh Mục</h5>
                <select name="danhMucId" class="form-select" onchange="this.form.submit();">
                    <option value="" ${param.danhMucId == '' ? 'selected' : ''}>Tất Cả</option>
                    <c:forEach var="dm" items="${danhMucList}">
                        <option value="${dm.id}" ${param.danhMucId == dm.id ? 'selected' : ''}>${dm.tenDanhMuc}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-4">
                <h5>Lọc Theo Tình Trạng</h5>
                <select name="tinhTrang" class="form-select" onchange="this.form.submit();">
                    <option value="" ${param.tinhTrang == '' ? 'selected' : ''}>Tất Cả</option>
                    <option value="1" ${param.tinhTrang == '1' ? 'selected' : ''}>Còn Hàng</option>
                    <option value="0" ${param.tinhTrang == '0' ? 'selected' : ''}>Hết Hàng</option>
                </select>
            </div>

            <div class="col-md-4">
                <h5>Tìm Kiếm Theo Nhà Cung Cấp</h5>
                <input type="text" name="nhaCungCapTen" class="form-control" placeholder="Nhập tên nhà cung cấp"
                       value="${param.nhaCungCapTen}">
            </div>
        </div>
    </form>


    <div class="mt-3">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#productModal"
                onclick="resetForm(); setModalTitle('Thêm Sản Phẩm');">
            Add Sản Phẩm
        </button>
        <button type="button" class="btn btn-danger ms-2" onclick="resetFilters();">Reset</button>
    </div>

    <!-- Bootstrap Modal -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productModalLabel">Thêm Sản Phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="productForm" action="/san-pham/add" method="post">
                        <input type="hidden" id="productId" name="id"/>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="productName" class="form-label">Tên Sản Phẩm</label>
                                    <input type="text" class="form-control" id="productName" name="ten" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="productPrice" class="form-label">Giá Cơ Bản</label>
                                    <input type="number" class="form-control" id="productPrice" name="giaBan" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label for="danhMuc" class="form-label">Danh Mục</label>
                                <select id="danhMuc" name="danhMuc.id" class="form-select">
                                    <c:forEach var="dm" items="${danhMucList}">
                                        <option value="${dm.id}">${dm.tenDanhMuc}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="nhaCungCap" class="form-label">Nhà Cung Cấp</label>
                                <select id="nhaCungCap" name="nhaCungCap.id" class="form-select">
                                    <c:forEach var="nhaCungCap" items="${nhaCungCapList}">
                                        <option value="${nhaCungCap.id}">${nhaCungCap.tenNCC}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Tình Trạng</label><br>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tinhTrang" id="tinhTrangConHang"
                                           value="1" required>
                                    <label class="form-check-label" for="tinhTrangConHang">Còn Hàng</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tinhTrang" id="tinhTrangHetHang"
                                           value="0" required>
                                    <label class="form-check-label" for="tinhTrangHetHang">Hết Hàng</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="productDescription" class="form-label">Mô Tả</label>
                                    <textarea class="form-control" id="productDescription" name="moTa"
                                              rows="3"></textarea>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary" id="submitButton">Lưu Sản Phẩm</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bảng hiển thị danh sách sản phẩm -->
    <table class="table table-hover table-bordered text-center mt-3">
        <thead>
        <tr>
            <th>STT</th>
            <th>Nhà Cung Cấp</th>
            <th>Danh Mục</th>
            <th>Tên</th>
            <th>Giá Cơ Bản</th>
            <th>Mô Tả</th>
            <th>Tình Trạng</th>
            <th>Thao Tác</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty data.content}">
            <tr>
                <td colspan="10">Không tìm thấy đối tượng nào.</td>
            </tr>
        </c:if>
        <c:if test="${not empty data.content}">
            <c:forEach items="${data.content}" var="sanPham" varStatus="i">
                <tr>
                    <th>${i.index + 1}</th>
                    <td>${sanPham.nhaCungCap.tenNCC}</td>
                    <td>${sanPham.danhMuc.tenDanhMuc}</td>
                    <td>${sanPham.ten}</td>
                    <td>${sanPham.giaBan}</td>
                    <td>${sanPham.moTa}</td>
                    <td class="${sanPham.tinhTrang == 1 ? 'text-success' : 'text-danger'}">
                            ${sanPham.tinhTrang == 1 ? "Còn Hàng" : "Hết Hàng"}
                    </td>
                    <td>
                        <a onclick="openEditModal(${sanPham.id}, '${sanPham.ten}', ${sanPham.giaBan}, '${sanPham.moTa}', ${sanPham.danhMuc.id}, ${sanPham.nhaCungCap.id}, ${sanPham.tinhTrang})"
                           class="btn btn-warning">Sửa</a>
                        <a onclick="return confirm('Bạn có chắc muốn xóa?')" href="/san-pham/delete/${sanPham.id}"
                           class="btn btn-danger">Xóa</a>
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
                <a class="page-link" href="/san-pham/index?page=0&size=${data.size}" aria-label="First">
                    <span aria-hidden="true">&laquo;&laquo; First</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/san-pham/index?page=${currentPage - 1}&size=${data.size}"
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
                <a class="page-link" href="/san-pham/index?page=${currentPage + 1}&size=${data.size}"
                   aria-label="Next">
                    <span aria-hidden="true">Next &raquo;</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/san-pham/index?page=${totalPages - 1}&size=${data.size}" aria-label="Last">
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
        document.getElementById('submitButton').innerText = 'Lưu Sản Phẩm';
    }

    function setModalTitle(title) {
        document.getElementById('productModalLabel').innerText = title;
    }

    function openEditModal(id, ten, giaBan, moTa, danhMucId, nhaCungCapId, tinhTrang) {
        setModalTitle('Cập Nhật Sản Phẩm');
        document.getElementById('productId').value = id;
        document.getElementById('productName').value = ten;
        document.getElementById('productPrice').value = giaBan;
        document.getElementById('productDescription').value = moTa;

        document.querySelector(`select[name='danhMuc.id']`).value = danhMucId;
        document.querySelector(`select[name='nhaCungCap.id']`).value = nhaCungCapId;

        const tinhTrangRadios = document.getElementsByName('tinhTrang');
        for (let radio of tinhTrangRadios) {
            radio.checked = (radio.value == tinhTrang);
        }

        document.getElementById('submitButton').innerText = 'Cập Nhật Sản Phẩm';
        document.getElementById('productForm').action = `/san-pham/update`; // Update action
        var myModal = new bootstrap.Modal(document.getElementById('productModal'));
        myModal.show();
    }


    function resetFilters() {
        // Reset các trường lọc về giá trị mặc định
        document.querySelector('select[name="danhMucId"]').value = '';
        document.querySelector('select[name="tinhTrang"]').value = '';
        document.querySelector('input[name="nhaCungCapTen"]').value = '';

        // Gửi lại form để lấy lại danh sách sản phẩm gốc
        document.getElementById('filterSearchForm').submit();
    }


    // Ẩn thông báo sau 3 giây
    window.onload = function () {
        var successMessage = document.getElementById("successMessage");
        if (successMessage) {
            setTimeout(function () {
                successMessage.style.display = 'none';
            }, 3000); // 3 giây
        }
    };
</script>
</body>
</html>
