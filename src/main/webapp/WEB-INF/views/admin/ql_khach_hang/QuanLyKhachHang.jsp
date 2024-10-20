<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
<<<<<<< HEAD
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Giao diện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.3/angular.min.js"
            integrity="sha512-KZmyTq3PLx9EZl0RHShHQuXtrvdJ+m35tuOiwlcZfs/rE7NZv29ygNA8SFCkMXTnYZQK2OX0Gm2qKGfvWEtRXA=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
<%--header--%>
<nav class="navbar navbar-expand-sm navbar-dark shadow-lg" style="background-color: #0B745E; height: 80px;">
    <div class="container d-flex align-items-center">
        <a href="#" class="navbar-brand d-flex align-items-center">
            <img src="../../lib/logo_xanh.png" style="height: 60px; margin-right: 10px;" alt="Logo">
        </a>

        <ul class="navbar-nav mx-auto" style="flex-grow: 1; justify-content: center; gap: 20px;">
            <li class="nav-item">
                <a class="nav-link text-light" href="#">Tổng quan</a>
            </li>

            <!-- Dropdown Custom -->
            <li class="nav-item dropdown-custom">
                <a href="#" class="nav-link text-light">Hàng hóa</a>
                <ul class="dropdown-menu-custom">
                    <li><a class="dropdown-item" href="#">Sản phẩm</a></li>
                    <li><a class="dropdown-item" href="#">Kho hàng</a></li>
                </ul>
            </li>

            <li class="nav-item dropdown-custom">
                <a href="#" class="nav-link text-light">Giao dịch</a>
                <ul class="dropdown-menu-custom">
                    <li><a class="dropdown-item" href="#">Bán hàng</a></li>
                    <li><a class="dropdown-item" href="#">Nhập hàng</a></li>
                    <li><a class="dropdown-item" href="#">Hóa đơn</a></li>
                </ul>
            </li>

            <li class="nav-item dropdown-custom">
                <a href="#" class="nav-link text-light">Đối tác</a>
                <ul class="dropdown-menu-custom">
                    <li><a class="dropdown-item" href="#">Khách hàng</a></li>
                    <li><a class="dropdown-item" href="#">Nguồn nhập</a></li>
                </ul>
            </li>

            <li class="nav-item">
                <a class="nav-link text-light" href="#">Nhân viên</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-light" href="#">Khuyến mãi</a>
            </li>
        </ul>

        <ul class="navbar-nav">
            <li class="nav-item dropdown-custom">
                <a href="#" class="nav-link text-light">Tài khoản</a>
                <ul class="dropdown-menu-custom">
                    <li><a class="dropdown-item" href="#">Thông tin</a></li>
                    <li><a class="dropdown-item" href="#">Đăng xuất</a></li>
                </ul>
            </li>
            <li class="nav-item">
                <span class="btn rounded-pill text-white" style="padding: 10px 15px;"><i class="fa-solid fa-user"></i></span>
            </li>
        </ul>
    </div>
</nav>
<img src="/lib/background_quanly.png" style="width: 100%; height: auto;">

<%--body--%>
<div class="row" style="text-align: center">
    <H1>Quản Lý Khách Hàng</H1>
</div>

<table class="table">
    <thead>
    <tr>
        <th scope="col">Tên khách hàng</th>
        <th scope="col">Email</th>
        <th scope="col">Mật khẩu</th>
        <th scope="col">Số điện thoại</th>
        <th scope="col">Địa chỉ</th>
        <th scope="col">Điểm tích lũy</th>
        <th scope="col">Ngày đăng ký</th>
        <th scope="col">Lịch sử mua hàng</th>
        <th scope="col">Khuyến mãi đa dụng</th>
        <th scope="col">Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="kh" items="${lists}">
        <tr>
            <td>${kh.ten_khach_hang}</td>
            <td>${kh.email}</td>
            <td>${kh.mat_khau}</td>
            <td>${kh.so_dien_thoai}</td>
            <td>${kh.dia_chi}</td>
            <td>${kh.diem_tich_luy}</td>
            <td>${kh.ngay_dang_ky}</td>
            <td>${kh.lich_su_mua_hang}</td>
            <td>${kh.khuyen_mai_da_dung}</td>
            <td>
                <a href="/khach-hang/view-add" class="btn btn-info">Thêm</a>
                <a href="/khach-hang/update/" class="btn btn-warning">Sửa</a>
                <a href="/khach-hang/delete/" class="btn btn-danger">Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>


</body>

<style>
    /* Dropdown Custom */
    .dropdown-custom {
        position: relative;
    }

    .dropdown-custom .dropdown-menu-custom {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        background-color: #0B745E;
        padding: 10px;
        list-style: none;
        margin: 0;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
        min-width: 160px;
    }

    .dropdown-custom:hover .dropdown-menu-custom {
        display: block;
    }

    .dropdown-custom .dropdown-item {
        color: white;
        padding: 10px;
        text-decoration: none;
        font-size: 16px;
    }

    .dropdown-custom .dropdown-item:hover {
        background-color: rgba(255, 255, 255, 0.1);
        border-radius: 5px;
    }

    /* Hover Effect for Nav Items */
    .nav-link:hover {
        background-color: rgba(255, 255, 255, 0.1);
        border-radius: 5px;
    }

    /* Logo Styling */
    .navbar-brand {
        font-size: 24px;
        color: white;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .navbar-nav {
            flex-direction: column;
        }
    }
</style>
</html>

=======
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600&display=swap" rel="stylesheet">

    <title>Quản Lý Khách Hàng</title>
</head>
<body>
<jsp:include page="../layout.jsp"/>
<div class="container mt-3">
    <h1 class="text-center mt-3">Danh Sách Khách Hàng</h1>
    <div class="filter-section mb-3">
        <form action="/khach-hang/hien-thi" method="get" id="filterSearchForm">
            <div class="row">
                <div class="col-md-4">
                    <h5>Lọc Theo Tình Trạng</h5>
                    <select name="tinhTrang" class="form-select" onchange="this.form.submit();">
                        <option value="" ${param.tinhTrang == '' ? 'selected' : ''}>Tất Cả</option>
                        <option value="1" ${param.tinhTrang == '1' ? 'selected' : ''}>Hoạt Động</option>
                        <option value="0" ${param.tinhTrang == '0' ? 'selected' : ''}>Ngừng Hoạt Động</option>
                    </select>
                </div>

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

    <!-- Bootstrap Modal -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productModalLabel">Thêm Khách Hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="productForm" action="/khach-hang/add" method="post">
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
                                    <input type="text" class="form-control" id="khachHangEmail" name="email" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangMatKhau" class="form-label">Mật Khẩu</label>
                                    <input type="text" class="form-control" id="khachHangMatKhau" name="matKhau"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangSoDienThoai" class="form-label">Số Điện thoại</label>
                                    <input type="text" class="form-control" id="khachHangSoDienThoai"
                                           name="soDienThoai" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangDiaChi" class="form-label">Địa Chỉ</label>
                                    <input type="text" class="form-control" id="khachHangDiaChi" name="diaChi" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangDiem" class="form-label">Điểm Tích Lũy</label>
                                    <input type="number" class="form-control" id="khachHangDiem" name="diemTichLuy"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangNgayDangKy" class="form-label">Ngày Đăng Ký</label>
                                    <input type="date" class="form-control" id="khachHangNgayDangKy" name="ngayDangKy"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangLSM" class="form-label">Lịch Sử Mua Hàng</label>
                                    <input type="text" class="form-control" id="khachHangLSM" name="lichSuMuaHang"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangKM" class="form-label">Khuyến Mãi Đa Dụng</label>
                                    <input type="text" class="form-control" id="khachHangKM" name="khuyenMaiDaDung"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Tình Trạng</label><br>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tinhTrang" id="tinhTrangHoatDong"
                                           value="1" required>
                                    <label class="form-check-label" for="tinhTrangHoatDong">Hoạt Động</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tinhTrang" id="tinhTrangNgung"
                                           value="0" required>
                                    <label class="form-check-label" for="tinhTrangNgung">Ngừng Hoạt Động</label>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-create" id="submitButton">Lưu Khách Hàng</button>
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
            <th>Lịch Sử Mua Hàng</th>
            <th>Khuyến Mãi Đa Dụng</th>
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
                    <td>${kh.lichSuMuaHang}</td>
                    <td>${kh.khuyenMaiDaDung}</td>
                    <td class="${kh.tinhTrang == 1 ? 'text-success' : 'text-danger'}">
                            ${kh.tinhTrang == 1 ? "Hoạt Động" : "Ngừng Hoạt Động"}
                    </td>
                    <td>
                        <a onclick="openEditModal(${kh.idKhachHang}, '${kh.tenKhachHang}', '${kh.email}',
                                '${kh.matKhau}', '${kh.soDienThoai}', '${kh.diaChi}', ${kh.diemTichLuy},
                                '${kh.ngayDangKy}', '${kh.lichSuMuaHang}', '${kh.khuyenMaiDaDung}', '${kh.tinhTrang}')"
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
                <a class="page-link" href="/khach-hang/hien-thi?page=0&size=${kh.size}" aria-label="First">
                    <span aria-hidden="true">&laquo;&laquo; First</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/khach-hang/hien-thi?page=${currentPage - 1}&size=${kh.size}"
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
                <a class="page-link" href="/khach-hang/hien-thi?page=${currentPage + 1}&size=${kh.size}"
                   aria-label="Next">
                    <span aria-hidden="true">Next &raquo;</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/khach-hang/hien-thi?page=${totalPages - 1}&size=${kh.size}"
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
        document.getElementById('submitButton').innerText = 'Lưu Khách Hàng';
    }

    function setModalTitle(title) {
        document.getElementById('productModalLabel').innerText = title;
    }

    function openEditModal(idKhachHang, tenKhachHang, email, matKhau, soDienThoai, diaChi, diemTichLuy, ngayDangKy,
                           lichSuMuaHang, khuyenMaiDaDung, tinhTrang) {
        setModalTitle('Cập Nhật Sản Phẩm');
        document.getElementById('khachHangId').value = idKhachHang;
        document.getElementById('khachHangName').value = tenKhachHang;
        document.getElementById('khachHangEmail').value = email;
        document.getElementById('khachHangMatKhau').value = matKhau;
        document.getElementById('khachHangSoDienThoai').value = soDienThoai;
        document.getElementById('khachHangDiaChi').value = diaChi;
        document.getElementById('khachHangDiem').value = diemTichLuy;
        document.getElementById('khachHangNgayDangKy').value = ngayDangKy;
        document.getElementById('khachHangLSM').value = lichSuMuaHang;
        document.getElementById('khachHangKM').value = khuyenMaiDaDung;

        const tinhTrangRadios = document.getElementsByName('tinhTrang');
        for (let radio of tinhTrangRadios) {
            radio.checked = (radio.value == tinhTrang);
        }

        document.getElementById('submitButton').innerText = 'Cập Nhật Khách Hàng';
        document.getElementById('productForm').action = `/khach-hang/update`; // Update action
        var myModal = new bootstrap.Modal(document.getElementById('productModal'));
        myModal.show();
    }


    function resetFilters() {
        // Reset các trường lọc về giá trị mặc định
        document.querySelector('select[name="tinhTrang"]').value = '';

        // Gửi lại form để lấy lại danh sách sản phẩm gốc
        document.getElementById('filterSearchForm').submit();
    }
</script>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600&display=swap');

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
>>>>>>> main
