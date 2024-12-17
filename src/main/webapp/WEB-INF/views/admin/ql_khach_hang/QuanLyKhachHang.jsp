<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600&display=swap" rel="stylesheet">

    <title>Quản Lý Khách Hàng</title>
</head>
<style>

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
<body>
<jsp:include page="../layout.jsp"/>
<div class="container mt-3">
    <h1 class="text-center mt-3">Danh Sách Khách Hàng</h1>
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
    <div class="filter-section mb-3">
        <form action="/quan-ly-khach-hang/hien-thi" method="get" id="filterSearchForm">
            <div class="row">
                <%--                <div class="col-md-4">--%>
                <%--                    <h5>Lọc Theo Tình Trạng</h5>--%>
                <%--                    <select name="tinhTrang" class="form-select" onchange="this.form.submit();">--%>
                <%--                        <option value="" ${param.tinhTrang == '' ? 'selected' : ''}>Tất Cả</option>--%>
                <%--                        <option value="1" ${param.tinhTrang == '1' ? 'selected' : ''}>Hoạt Động</option>--%>
                <%--                        <option value="0" ${param.tinhTrang == '0' ? 'selected' : ''}>Ngừng Hoạt Động</option>--%>
                <%--                    </select>--%>
                <%--                </div>--%>

                <div class="col-md-4">
                    <h5>Tìm Kiếm Theo Tên Khách Hàng</h5>
                    <input type="text" name="tenKhachHang" class="form-control" placeholder="Nhập tên khách hàng"
                           value="${param.tenKhachHang}">
                </div>
            </div>
        </form>
        <div class="mt-2">
            <button type="button" class="btn btn-create" data-bs-toggle="modal" data-bs-target="#productModal"
                    onclick="resetForm(); setModalTitle('Thêm Khách Hàng');">
                + Thêm Khách Hàng
            </button>
            <button type="button" class="btn btn-secondary-outline ms-2" onclick="resetFilters();">Reset</button>
        </div>
    </div>

    <!-- PopUp ThemKhachHang -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productModalLabel">Thêm Khách Hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="productForm" action="/quan-ly-khach-hang/add" method="post">
                        <input type="hidden" id="khachHangId" name="idKhachHang"/>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangName" class="form-label">Tên Khách Hàng</label>
                                    <input type="text" class="form-control" id="khachHangName" name="tenKhachHang"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangEmail" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="khachHangEmail" name="email" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangMatKhau" class="form-label">Mật Khẩu</label>
                                    <input type="password" class="form-control" id="khachHangMatKhau" name="matKhau"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangSoDienThoai" class="form-label">Số Điện thoại</label>
                                    <input type="number" class="form-control" id="khachHangSoDienThoai"
                                           name="soDienThoai" required>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="mb-3">
                                <label for="khachHangDiaChi" class="form-label">Địa Chỉ</label>
                                <input type="text" class="form-control" id="khachHangDiaChi" name="diaChi" required
                                       style="width: 100%;">
                            </div>
                        </div>

                        <%--                            <div class="col-md-6">--%>
                        <%--                                <label class="form-label">Tình Trạng</label><br>--%>
                        <%--                                <div class="form-check form-check-inline">--%>
                        <%--                                    <input class="form-check-input" type="radio" name="tinhTrang" id="tinhTrangHoatDong"--%>
                        <%--                                           value="1" required>--%>
                        <%--                                    <label class="form-check-label" for="tinhTrangHoatDong">Hoạt Động</label>--%>
                        <%--                                </div>--%>
                        <%--                                <div class="form-check form-check-inline">--%>
                        <%--                                    <input class="form-check-input" type="radio" name="tinhTrang" id="tinhTrangNgung"--%>
                        <%--                                           value="0" required>--%>
                        <%--                                    <label class="form-check-label" for="tinhTrangNgung">Ngừng Hoạt Động</label>--%>
                        <%--                                </div>--%>
                        <%--                            </div>--%>
                </div>
                <button type="submit" class="btn btn-create" id="submitButton">Lưu Khách Hàng</button>
                </form>
            </div>
        </div>
    </div>

    <!-- PopUp SuaKhachHang -->
    <div class="modal fade" id="productModal2" tabindex="-1" aria-labelledby="productModalLabel2" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productModalLabel2">Sửa Khách Hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="productForm2" action="/quan-ly-khach-hang/update" method="post">
                        <input type="hidden" id="idKhachHang" name="idKhachHang"/>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="tenKhachHang" class="form-label">Tên Khách Hàng</label>
                                    <input type="text" class="form-control" id="tenKhachHang" name="tenKhachHang"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="matKhau" class="form-label">Mật Khẩu</label>
                                    <input type="password" class="form-control" id="matKhau" name="matKhau"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="soDienThoai" class="form-label">Số Điện thoại</label>
                                    <input type="number" class="form-control" id="soDienThoai"
                                           name="soDienThoai" required>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="diaChi" class="form-label">Địa Chỉ</label>
                                <input type="text" class="form-control" id="diaChi" name="diaChi" required
                                       style="width: 200%;">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-create" id="submitButton2">Lưu Khách Hàng</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <table class="table table-striped table-hover table-bordered text-center">
        <thead>
        <tr>
            <th>STT</th>
            <th>Tên Khách Hàng</th>
            <th>Email</th>
            <th>Mật Khẩu</th>
            <th>Số Điện Thoại</th>
            <th>Địa Chỉ</th>
            <th>Điểm Tích Lũy</th>
            <th>Ngày Đăng Ký</th>
            <%--            <th>Tình Trạng</th>--%>
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
            <c:forEach items="${data.content}" var="kh" varStatus="i">
                <tr>
                    <th>${i.index + 1}</th>
                    <td>${kh.tenKhachHang}</td>
                    <td>${kh.email}</td>
                    <td>${kh.matKhau}</td>
                    <td>${kh.soDienThoai}</td>
                    <td>${kh.diaChi}</td>
                    <td>${kh.diemTichLuy}</td>
                    <td>${kh.ngayDangKy}</td>
                        <%--                    <td class="${kh.tinhTrang == 1 ? 'text-success' : 'text-danger'}">--%>
                        <%--                            ${kh.tinhTrang == 1 ? "Hoạt Động" : "Ngừng Hoạt Động"}--%>
                        <%--                    </td>--%>
                    <td>
                        <a onclick="openEditModal(${kh.idKhachHang}, '${kh.tenKhachHang}', '${kh.email}',
                                '${kh.matKhau}', '${kh.soDienThoai}', '${kh.diaChi}'
                            <%--, '${kh.tinhTrang}'--%>
                                )"
                           type="button" class="btn btn-outline-custom"><i class='bx bx-edit-alt'></i></a>
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
                <a class="page-link" href="/quan-ly-khach-hang/hien-thi?page=0&size=${kh.size}" aria-label="First">
                    <span aria-hidden="true">&laquo;&laquo; First</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/quan-ly-khach-hang/hien-thi?page=${currentPage - 1}&size=${kh.size}"
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
                <a class="page-link" href="/quan-ly-khach-hang/hien-thi?page=${currentPage + 1}&size=${kh.size}"
                   aria-label="Next">
                    <span aria-hidden="true">Next &raquo;</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/quan-ly-khach-hang/hien-thi?page=${totalPages - 1}&size=${kh.size}"
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
        document.getElementById('submitButton').innerText = 'Lưu Khách Hàng';
        document.getElementById('submitButton2').innerText = 'Lưu Khách Hàng';
    }

    function setModalTitle(title) {
        document.getElementById('productModalLabel').innerText = title;
    }

    function openEditModal(idKhachHang, tenKhachHang, email, matKhau, soDienThoai, diaChi, tinhTrang) {
        setModalTitle('Cập Nhật Thông Tin');
        document.getElementById('idKhachHang').value = idKhachHang;
        document.getElementById('tenKhachHang').value = tenKhachHang;
        document.getElementById('email').value = email;
        document.getElementById('matKhau').value = matKhau;
        document.getElementById('soDienThoai').value = soDienThoai;
        document.getElementById('diaChi').value = diaChi;

        const tinhTrangRadios = document.getElementsByName('tinhTrang');
        for (let radio of tinhTrangRadios) {
            radio.checked = (radio.value == tinhTrang);
        }

        document.getElementById('submitButton2').innerText = 'Cập Nhật Khách Hàng';
        document.getElementById('productForm2').action = `/quan-ly-khach-hang/update`;
        var myModal = new bootstrap.Modal(document.getElementById('productModal2'));
        myModal.show();
    }


    function resetFilters() {
        document.querySelector('input[name="tenKhachHang"]').value = '';

        document.getElementById('filterSearchForm').submit();
    }

    function validateName(name) {
        const regex = /^[A-Za-zÀ-ÖØ-öø-ÿ\s]+$/;
        if (!name.trim()) {
            alert("Tên khách hàng không được để trống.");
            return false;
        }
        return regex.test(name) && name.length <= 30;
    }

    function validateEmail(email) {
        const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!email.trim()) {
            alert("Email không được để trống.");
            return false;
        }
        return regex.test(email) && email.length <= 30;
    }

    function validatePhoneNumber(phone) {
        const regex = /^0\d{9,10}$/;
        if (!phone.trim()) {
            alert("Số điện thoại không được để trống.");
            return false;
        }
        return regex.test(phone);
    }

    function validateAddress(address) {
        if (!address.trim()) {
            alert("Địa chỉ không được để trống.");
            return false;
        }
        return address.length <= 100;
    }

    function validateForm() {
        const name = document.getElementById('khachHangName').value;
        const email = document.getElementById('khachHangEmail').value;
        const phone = document.getElementById('khachHangSoDienThoai').value;
        const address = document.getElementById('khachHangDiaChi').value;

        if (!validateName(name)) {
            alert("Tên khách hàng không hợp lệ.");
            return false;
        }
        if (!validateEmail(email)) {
            alert("Email không hợp lệ.");
            return false;
        }
        if (!validatePhoneNumber(phone)) {
            alert("Số điện thoại không hợp lệ.");
            return false;
        }
        if (!validateAddress(address)) {
            alert("Địa chỉ không hợp lệ.");
            return false;
        }
        return true;
    }

    document.getElementById('productForm').onsubmit = function () {
        return validateForm();
    }

    function validateUpdateForm() {
        const name = document.getElementById('tenKhachHang').value;
        const email = document.getElementById('email').value;
        const phone = document.getElementById('soDienThoai').value;
        const address = document.getElementById('diaChi').value;

        if (!validateName(name)) {
            alert("Tên khách hàng không hợp lệ.");
            return false;
        }
        if (!validateEmail(email)) {
            alert("Email không hợp lệ.");
            return false;
        }
        if (!validatePhoneNumber(phone)) {
            alert("Số điện thoại không hợp lệ.");
            return false;
        }
        if (!validateAddress(address)) {
            alert("Địa chỉ không hợp lệ.");
            return false;
        }
        return true;
    }

    document.getElementById('productForm2').onsubmit = function () {
        return validateUpdateForm();
    };




</script>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600&display=swap');

    body {
        background-color: #f8f9fa;
        position: relative;
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


    input[type="number"]::-webkit-inner-spin-button,
    input[type="number"]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }

    input[type="number"] {
        -moz-appearance: textfield;
    }
</style>
</body>
</html>