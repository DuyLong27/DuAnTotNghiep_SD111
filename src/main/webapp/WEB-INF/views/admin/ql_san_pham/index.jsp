<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type="number"] {
            -moz-appearance: textfield;
        }

        #successMessage {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1050;
        }

        .alert {
            font-size: 16px;
            font-weight: 500;
            line-height: 1.5;
            border-left: 4px solid #28a745;
            padding: 15px 20px;
            background-color: #d4edda;
            color: #155724;
        }

        .alert i {
            color: #28a745;
        }


        .alert .btn-close {
            background-color: transparent;
            opacity: 0.8;
        }

        #autoCloseAlert {
            animation: fadeOut 3s forwards;
        }

        @keyframes fadeOut {
            0% {
                opacity: 1;
            }
            80% {
                opacity: 1;
            }
            100% {
                opacity: 0;
                display: none;
            }
        }
    </style>
</head>
<body>
<jsp:include page="../layout.jsp" />
<div class="container mt-3">
    <h1 class="text-center mt-3">Danh Sách Sản Phẩm</h1>
    <!-- Thông báo -->
    <div class="container mt-3 position-relative">
        <c:if test="${not empty message}">
            <div id="autoCloseAlert" class="alert alert-success alert-dismissible fade show shadow-lg rounded"
                 role="alert"
                 style="max-width: 500px; margin: 0 auto; position: fixed; top: 20px; left: 50%; transform: translateX(-50%); z-index: 1050;">
                <i class="fa-solid fa-check-circle me-2"></i>
                <span>${message}</span>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
    </div>
    <form action="/san-pham/index" method="get" id="filterSearchForm">
        <div class="row filter-section">
            <div class="col-md-4">
                <h5>Lọc Theo Danh Mục</h5>
                <select name="danhMucId" class="form-select" onchange="this.form.submit();">
                    <option value="" ${param.danhMucId == '' ? 'selected' : ''}>Tất Cả</option>
                    <c:forEach var="dm" items="${danhMucList}">
                        <option value="${dm.id}" ${param.danhMucId == dm.id ? 'selected' : ''}>${dm.ten}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-4">
                <h5>Lọc Theo Tình Trạng</h5>
                <select name="tinhTrang" class="form-select" onchange="this.form.submit();">
                    <option value="" ${param.tinhTrang == '' ? 'selected' : ''}>Tất Cả</option>
                    <option value="1" ${param.tinhTrang == '1' ? 'selected' : ''}>Hoạt Động</option>
                    <option value="0" ${param.tinhTrang == '0' ? 'selected' : ''}>Không Hoạt Động</option>
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
        <c:if test="${sessionScope.role == 0}">
            <button type="button" class="btn btn-create" data-bs-toggle="modal" data-bs-target="#productModal"
                    onclick="resetForm(); setModalTitle('Thêm Sản Phẩm');">
                Tạo mới
            </button>
        </c:if>
        <button type="button" class="btn btn-secondary-outline" onclick="resetFilters();">Reset</button>
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
                                        <option value="${dm.id}">${dm.ten}</option>
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
                                    <label class="form-check-label" for="tinhTrangConHang">Hoạt Động</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tinhTrang" id="tinhTrangHetHang"
                                           value="0" required>
                                    <label class="form-check-label" for="tinhTrangHetHang">Không Hoạt Động</label>
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
                        <button type="submit" class="btn btn-create" id="submitButton">Tạo mới</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bảng hiển thị danh sách sản phẩm -->
    <table class="table table-striped table-hover table-bordered text-center">
        <thead>
        <tr>
            <th>STT</th>
            <th>Nhà Cung Cấp</th>
            <th>Danh Mục</th>
            <th>Tên</th>
            <th>Giá Cơ Bản</th>
            <th>Mô Tả</th>
            <th>Tình Trạng</th>
            <c:if test="${sessionScope.role == 0}">
                <th>Thao tác</th>
            </c:if>
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
                    <td>${sanPham.danhMuc.ten}</td>
                    <td>${sanPham.ten}</td>
                    <td><fmt:formatNumber value="${sanPham.giaBan}" type="number" pattern="#,###" /></td>
                    <td>${sanPham.moTa}</td>
                    <td class="${sanPham.tinhTrang == 1 ? 'text-success' : 'text-danger'}">
                            ${sanPham.tinhTrang == 1 ? "Hoạt Động" : "Không Hoạt Động"}
                    </td>
                    <c:if test="${sessionScope.role == 0}">
                        <td>
                            <c:choose>
                                <c:when test="${sanPham.tinhTrang == 1}">
                                    <a href="/spct/index?id=${sanPham.id}&openModal=true" class="btn btn-outline-custom">Chi tiết</a>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-outline-custom" disabled>Chi tiết</button>
                                </c:otherwise>
                            </c:choose>
                            <a onclick="openEditModal(${sanPham.id}, '${sanPham.ten}', ${sanPham.giaBan}, '${sanPham.moTa}', ${sanPham.danhMuc.id}, ${sanPham.nhaCungCap.id}, ${sanPham.tinhTrang})"
                               class="btn btn-outline-custom">Sửa</a>
                            <!-- Nút Xóa -->
                                <%--                        <a href="/san-pham/delete/${sanPham.id}" class="btn btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">Xóa</a>--%>
                        </td>
                    </c:if>
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

        document.getElementById('submitButton').innerText = 'Cập Nhật';
        document.getElementById('productForm').action = `/san-pham/update`; // Update action
        var myModal = new bootstrap.Modal(document.getElementById('productModal'));
        myModal.show();
    }


    function resetFilters() {
        document.querySelector('select[name="danhMucId"]').value = '';
        document.querySelector('select[name="tinhTrang"]').value = '';
        document.querySelector('input[name="nhaCungCapTen"]').value = '';
        document.getElementById('filterSearchForm').submit();
    }


    window.onload = function () {
        var successMessage = document.getElementById("successMessage");
        if (successMessage) {
            setTimeout(function () {
                successMessage.style.display = 'none';
            }, 3000);
        }
    };

    document.getElementById("productForm").addEventListener("submit", function (e) {
        const ten = document.getElementById("productName").value;
        const giaBan = document.getElementById("productPrice").value;
        const moTa = document.getElementById("productDescription").value;
        let errors = [];
        if (ten.length < 3 || ten.length > 20) {
            e.preventDefault();
            alert("Tên sản phẩm phải từ 3 đến 20 ký tự!");
        }
        if (!/^[a-zA-Z0-9\sÀ-ỹà-ỹ]+$/.test(ten)) {
            errors.push("Tên sản phẩm không được chứa ký tự đặc biệt!");
        }
        if (!giaBan || giaBan < 60000) {
            errors.push("Giá bán phải lớn hơn 60000!");
        }
        if (moTa.length < 10 || moTa.length > 50) {
            errors.push("Mô tả phải từ 10 đến 50 ký tự!");
        }
        if (errors.length > 0) {
            e.preventDefault();
            alert(errors.join("\n"));
        }
    });


</script>
</body>
</html>
