<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý khuyến mãi</title>
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

    <style>
        body {
            background-color: #f8f9fa;
            overflow-x: hidden; /* Ẩn cuộn ngang */
            font-family: 'Arial', sans-serif; /* Chọn phông chữ đẹp */
        }


        .sidebar {
            background-color: #0B745E; /* Màu nền sidebar */
            height: 100vh;
            width: 200px;
            padding: 20px; /* Thêm padding cho sidebar */
            position: fixed;
            left: -200px; /* Đặt sidebar bên ngoài màn hình */
            transition: left 0.3s; /* Hiệu ứng chuyển động */
            z-index: 1000; /* Đảm bảo sidebar nằm trên các thành phần khác */
        }

        .sidebar.open {
            left: 0; /* Hiện sidebar khi có class 'open' */
        }

        .sidebar img {
            width: 100%;
            max-width: 150px;
            margin-bottom: 20px;
            border-radius: 10px; /* Bo góc logo */
        }

        .sidebar h4 {
            margin-bottom: 20px;
            color: white;
            text-align: center;
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 15px 20px;
            display: flex;
            align-items: center;
            width: 100%;
            text-align: center;
            margin-bottom: 10px;
            border-radius: 5px; /* Bo góc cho các liên kết */
            transition: background-color 0.3s, transform 0.2s; /* Hiệu ứng chuyển động */
        }

        .sidebar a:hover {
            background-color: #005b46; /* Màu nền khi hover */
            transform: scale(1.05); /* Hiệu ứng phóng to nhẹ */
        }

        .dropdown-menu {
            background-color: grey;
            width: 168px;
            border-radius: 5px; /* Bo góc cho dropdown */
        }

        .dropdown-item {
            text-align: center;
            color: white;
            padding: 10px; /* Thêm padding cho dropdown item */
            transition: background-color 0.3s; /* Hiệu ứng chuyển động */
        }

        .dropdown-item:hover {
            background-color: #005b46; /* Màu nền khi hover */
            color: white;
        }


        .account-dropdown-menu {
            background-color: grey;
            width: 160px;
            border-radius: 5px; /* Bo góc cho dropdown */

        }

        .account-dropdown-item {
            text-align: center;
            color: white;
            padding: 10px; /* Thêm padding cho dropdown item */
            transition: background-color 0.3s; /* Hiệu ứng chuyển động */
            display: block; /* Hiển thị block cho item */
            text-decoration: none; /* Bỏ gạch chân */
        }

        .account-dropdown-item:hover {
            background-color: #0B745E; /* Màu nền khi hover */
            color: white; /* Đổi màu chữ khi hover */
            transform: scale(1.05); /* Hiệu ứng phóng to nhẹ */
            border-radius: 5px; /* Bo góc cho dropdown */
        }


        .sidebar a i {
            margin-right: 10px;
        }

        .toggle-btn {
            position: fixed;
            left: 10px;
            top: 20px;
            background-color: transparent; /* Nền trong suốt */
            border: 2px solid #0B745E; /* Đường viền màu xanh */
            color: white; /* Màu chữ */
            padding: 10px 15px; /* Thay đổi padding */
            border-radius: 5px; /* Bo góc cho nút */
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s; /* Hiệu ứng chuyển động */
            z-index: 1100; /* Đảm bảo nút nằm trên overlay */
        }

        .toggle-btn:hover {
            background-color: #0B745E; /* Màu nền khi hover */
            color: white; /* Đổi màu chữ khi hover */
            transform: scale(1.05); /* Hiệu ứng phóng to nhẹ */
        }

        .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: none;
            border: none;
            color: white;
            font-size: 20px;
            cursor: pointer;
        }

        .overlay-content {
            position: absolute;
            top: 10px;  /* Khoảng cách từ cạnh trên */
            right: 10px;  /* Khoảng cách từ cạnh phải */
            background-color: rgba(0, 0, 0, 0.5); /* Màu nền nửa trong suốt */
            color: white;  /* Màu chữ */
            padding: 10px; /* Khoảng cách bên trong */
            border-radius: 5px; /* Bo góc */
            z-index: 999; /* Đảm bảo nằm trên ảnh */
        }

        /* Thêm lớp overlay */
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* Màu nền tối */
            display: none;
            z-index: 999; /* Hiển thị trên các phần khác */
        }

        .overlay.show {
            display: block; /* Hiển thị khi sidebar mở */
        }

        /*n*/



        .filter-section {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Table */
        table.table {
            background-color: white;
            border-collapse: separate;
            border-spacing: 0 15px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }

        table thead th {
            background-color: #0B745E;
            font-size: 16px;
            padding: 15px;
        }

        table tbody tr {
            transition: background-color 0.3s;
        }

        table tbody tr:hover {
            background-color: #f1f1f1;
        }

        .table td, .table th {
            vertical-align: middle;
        }

        th:nth-child(7), td:nth-child(7) {
            width: 100px;
        }

        .btn-custom {
            width: 45px;
            height: 28px;
            font-size: 12px;
            padding: 4px 6px;
            margin-right: 4px;
        }

        /* Pagination */
        .pagination {
            margin: 20px 0;
        }

        .pagination .page-item {
            margin: 0 5px;
        }

        .pagination .page-link {
            padding: 8px 0;
            border-radius: 5px;
            border: 2px solid #0B745E;
            color: #0B745E;
            transition: background-color 0.3s, color 0.3s;
            width: 90px;
            text-align: center;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 35px;
        }

        .pagination .page-link:hover {
            background-color: #0B745E;
            color: white;
        }

        .pagination .page-item.disabled .page-link {
            color: #c0c0c0;
            border-color: #c0c0c0;
            pointer-events: none;
        }

        .pagination .page-item.active .page-link {
            background-color: #0B745E;
            color: white;
            border-color: #0B745E;
            pointer-events: none;
        }

        /* Nút với đường viền */
        .btn-outline-custom {
            color: #0B745E;
            border: 2px solid #0B745E;
            background-color: transparent;
            border-radius: 5px;
            padding: 6px 12px;
            transition: background-color 0.3s, color 0.3s;
            font-size: 14px;
        }

        .btn-outline-custom:hover {
            background-color: #0B745E;
            color: white;
            text-decoration: none;
        }

        /* Custom style for the Filter and Create buttons */
        .btn-filter, .btn-create {
            width: 90px;
            height: 35px;
            font-size: 14px;
            padding: 5px 10px;
            border: 2px solid #0B745E;
            background-color: #0B745E;
            color: white;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        /* Hover effect for the buttons */
        .btn-filter:hover, .btn-create:hover {
            background-color: transparent;
            color: #0B745E;
        }


        /* Custom style for secondary buttons */
        .btn-secondary-outline {
            color: #6c757d; /* Màu chữ xám */
            border: 2px solid #6c757d; /* Viền xám */
            background-color: transparent; /* Không có nền */
            border-radius: 5px; /* Bo góc cho nút */
            padding: 6px 12px; /* Đặt khoảng cách trong nút */
            transition: background-color 0.3s, color 0.3s; /* Hiệu ứng chuyển màu */
            font-size: 14px;
        }

        .btn-secondary-outline:hover {
            background-color: #6c757d; /* Màu nền xám khi hover */
            color: white; /* Màu chữ trắng khi hover */
            text-decoration: none; /* Bỏ gạch chân */
        }

        /* Popup Modal Edit */
        .modal-content {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .modal-header {
            background-color: #0B745E;
            color: white;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .modal-footer {
            border-top: 1px solid #e9ecef;
        }

        .form-label {
            font-weight: bold;
            color: #0B745E;
        }

        .form-control {
            border-radius: 5px;
            border: 1px solid #ced4da;
        }

        .form-control:focus {
            border-color: #0B745E;
            box-shadow: 0 0 0 0.2rem rgba(11, 116, 94, 0.25);
        }

        /* Styles for the buttons in the modal */
        .modal-footer .btn-primary {
            background-color: #0B745E;
            border: 2px solid #0B745E;
            color: white;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .modal-footer .btn-primary:hover {
            background-color: transparent;
            color: #0B745E;
        }

        .btn-secondary {
            color: white; /* Màu chữ xám */
            border: 2px solid #0B745E; /* Viền xám */
            background-color: transparent; /* Không có nền */
            border-radius: 5px; /* Bo góc cho nút */
            padding: 6px 12px; /* Đặt khoảng cách trong nút */
            transition: background-color 0.3s, color 0.3s; /* Hiệu ứng chuyển màu */
            width:160px
        }

        .btn-secondary:hover {
            background-color: #0B745E; /* Màu nền xám khi hover */
            color: white; /* Màu chữ trắng khi hover */
            text-decoration: none; /* Bỏ gạch chân */
        }

    </style>

</head>
<body>
<%--header--%>
<button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">
    <i class="fas fa-bars"></i> <!-- Icon để mở sidebar -->
</button>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">

    <img src="../../lib/logo_xanh.png" alt="Logo">

    <a href="#"><i class="fas fa-tachometer-alt"></i>Tổng quan</a>

    <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
        <i class="fas fa-box"></i>Hàng hóa
    </a>
    <ul class="dropdown-menu">
        <li><a class="dropdown-item" href="#"><i class="fas fa-cube"></i>Sản phẩm</a></li>
        <li><a class="dropdown-item" href="#"><i class="fas fa-warehouse"></i>Kho hàng</a></li>
    </ul>

    <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
        <i class="fas fa-exchange-alt"></i>Giao dịch
    </a>
    <ul class="dropdown-menu">
        <li><a class="dropdown-item" href="#"><i class="fas fa-shopping-cart"></i>Bán hàng</a></li>
        <li><a class="dropdown-item" href="#"><i class="fas fa-download"></i>Nhập hàng</a></li>
        <li><a class="dropdown-item" href="#"><i class="fas fa-file-invoice"></i>Hóa đơn</a></li>
    </ul>

    <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
        <i class="fas fa-handshake"></i>Đối tác
    </a>
    <ul class="dropdown-menu">
        <li><a class="dropdown-item" href="#"><i class="fas fa-user"></i>Khách hàng</a></li>
        <li><a class="dropdown-item" href="#"><i class="fas fa-truck"></i>Nguồn nhập</a></li>
    </ul>

    <a href="#"><i class="fas fa-users"></i>Nhân viên</a>
</div>

<!-- Overlay khi sidebar mở -->
<div class="overlay" id="overlay"></div>

<!-- Hình nền và nội dung tài khoản -->
<img src="/lib/background_quanly.png" alt="Background" class="img-fluid" style="width: 100%; height: auto;">
<div class="overlay-content">
    <div class="dropdown">
        <button class="btn btn-secondary dropdown-toggle" type="button" id="accountDropdown" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fas fa-user"></i> Tài khoản
        </button>
        <ul class="account-dropdown-menu dropdown-menu" aria-labelledby="accountDropdown">
            <li><a class="account-dropdown-item" href="#">Thông tin</a></li>
            <li><a class="account-dropdown-item" href="#">Đăng xuất</a></li>
        </ul>
    </div>
</div>

<%--body--%>
<div class="container mt-3">
    <div class="row">

        <div class="col-md-3 filter-section">
            <form action="/khuyen-mai/hien-thi" method="get">
                <div class="mb-3">
                    <label for="maKhuyenMai" class="form-label">Mã khuyến mãi</label>
                    <input type="text" class="form-control" id="maKhuyenMai" name="maKhuyenMai" value="${maKhuyenMai}">
                </div>
                <div class="mb-3">
                    <label for="tenKhuyenMai" class="form-label">Tên khuyến mãi</label>
                    <input type="text" class="form-control" id="tenKhuyenMai" name="tenKhuyenMai" value="${tenKhuyenMai}">
                </div>
                <div class="mb-3">
                    <label for="giaTriKhuyenMai" class="form-label">Giá trị khuyến mãi (Từ - Đến)</label>
                    <div class="d-flex gap-2">
                        <input type="number" class="form-control" name="giaTriMin" placeholder="Từ" value="${giaTriMin}">
                        <input type="number" class="form-control" name="giaTriMax" placeholder="Đến" value="${giaTriMax}">
                    </div>
                </div>
                <div class="mb-3">
                    <label for="ngayBatDau" class="form-label">Ngày bắt đầu</label>
                    <input type="date" class="form-control" id="ngayBatDau" name="ngayBatDau" value="${ngayBatDau}">
                </div>
                <div class="mb-3">
                    <label for="ngayKetThuc" class="form-label">Ngày kết thúc</label>
                    <input type="date" class="form-control" id="ngayKetThuc" name="ngayKetThuc" value="${ngayKetThuc}">
                </div>
                <button type="submit" class="btn btn-filter">Lọc</button>
                <a href="/khuyen-mai/hien-thi" class="btn btn-secondary-outline">Xóa lọc</a>
            </form>
        </div>

        <div class="col-md-9">
            <div class="d-flex justify-content-end mb-3">

                <button type="button" class="btn btn-create" data-bs-toggle="modal" data-bs-target="#addPromotionModal">
                    Tạo mới
                </button>

            </div>

            <table class="table table-striped table-hover table-bordered text-center">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Mã khuyến mãi</th>
                    <th>Tên khuyến mãi</th>
                    <th>Giá trị khuyến mãi</th>
                    <th>Ngày bắt đầu</th>
                    <th>Ngày kết thúc</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${listKhuyenMai}" var="item">
                    <tr>
                        <td>${item.idKhuyenMai}</td>
                        <td>${item.maKhuyenMai}</td>
                        <td>${item.tenKhuyenMai}</td>
                        <td>${item.giaTriKhuyenMai}</td>
                        <td>${item.ngayBatDau}</td>
                        <td>${item.ngayKetThuc}</td>
                        <td>${item.tinhTrang ==1?"Đang hoạt động":"Không hoạt động"}</td>
                        <td style="width: 100px;">
                            <div class="d-flex justify-content-center gap-2">
                                <a href="#" class="btn btn-outline-custom"
                                   data-bs-toggle="modal"
                                   data-bs-target="#editPromotionModal"
                                   onclick="showPromotionEdits(${item.idKhuyenMai}, '${item.maKhuyenMai}', '${item.tenKhuyenMai}', ${item.giaTriKhuyenMai}, '${item.ngayBatDau}', '${item.ngayKetThuc}', ${item.tinhTrang})">
                                    <i class="fa fa-edit"></i>
                                </a>
                                <a href="/khuyen-mai/xoa?id=${item.idKhuyenMai}" class="btn btn-outline-custom">
                                    <i class="fa fa-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                        <a class="page-link btn-custom" href="?page=${currentPage - 1}&size=5&maKhuyenMai=${maKhuyenMai}&tenKhuyenMai=${tenKhuyenMai}&giaTriMin=${giaTriMin}&giaTriMax=${giaTriMax}&ngayBatDau=${ngayBatDau}&ngayKetThuc=${ngayKetThuc}">Previous</a>
                    </li>
                    <c:forEach var="i" begin="0" end="${totalPages - 1}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link btn-custom" href="?page=${i}&size=5&maKhuyenMai=${maKhuyenMai}&tenKhuyenMai=${tenKhuyenMai}&giaTriMin=${giaTriMin}&giaTriMax=${giaTriMax}&ngayBatDau=${ngayBatDau}&ngayKetThuc=${ngayKetThuc}">${i + 1}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                        <a class="page-link btn-custom" href="?page=${currentPage + 1}&size=5&maKhuyenMai=${maKhuyenMai}&tenKhuyenMai=${tenKhuyenMai}&giaTriMin=${giaTriMin}&giaTriMax=${giaTriMax}&ngayBatDau=${ngayBatDau}&ngayKetThuc=${ngayKetThuc}">Next</a>
                    </li>
                </ul>
            </nav>



        </div>
    </div>
</div>

<!-- Pop-up -->
<div class="modal fade" id="addPromotionModal" tabindex="-1" aria-labelledby="addPromotionModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content modal-green">
            <div class="modal-header">
                <h5 class="modal-title" id="addPromotionModalLabel">Tạo mới khuyến mãi</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/khuyen-mai/them" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="maKhuyenMai" class="form-label">Mã khuyến mãi</label>
                        <input type="text" class="form-control" id="maKhuyenMai" name="maKhuyenMai" required>
                    </div>
                    <div class="mb-3">
                        <label for="tenKhuyenMai" class="form-label">Tên khuyến mãi</label>
                        <input type="text" class="form-control" id="tenKhuyenMai" name="tenKhuyenMai" required>
                    </div>
                    <div class="mb-3">
                        <label for="giaTriKhuyenMai" class="form-label">Giá trị khuyến mãi</label>
                        <input type="number" class="form-control" id="giaTriKhuyenMai" name="giaTriKhuyenMai" required>
                    </div>
                    <div class="mb-3">
                        <label for="ngayBatDau" class="form-label">Ngày bắt đầu</label>
                        <input type="date" class="form-control" id="ngayBatDau" name="ngayBatDau" required>
                    </div>
                    <div class="mb-3">
                        <label for="ngayKetThuc" class="form-label">Ngày kết thúc</label>
                        <input type="date" class="form-control" id="ngayKetThuc" name="ngayKetThuc" required>
                    </div>
                    <div class="mb-3">
                        <label for="tinhTrang" class="form-label">Tình trạng</label>
                        <div>
                            <input type="radio" id="hoatDong" name="tinhTrang" value="1" checked>
                            <label for="hoatDong">Hoạt động</label>
                            <input type="radio" id="khongHoatDong" name="tinhTrang" value="0">
                            <label for="khongHoatDong">Không hoạt động</label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-create">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal for Edit Promotion -->
<div class="modal fade" id="editPromotionModal" tabindex="-1" aria-labelledby="editPromotionModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editPromotionModalLabel">Sửa khuyến mãi</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/khuyen-mai/sua" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <input type="hidden" class="form-control" id="editIdKhuyenMai" name="id" required>
                    </div>
                    <div class="mb-3">
                        <label for="editMaKhuyenMai" class="form-label">Mã khuyến mãi</label>
                        <input type="text" class="form-control" id="editMaKhuyenMai" name="maKhuyenMai" required>
                    </div>
                    <div class="mb-3">
                        <label for="editTenKhuyenMai" class="form-label">Tên khuyến mãi</label>
                        <input type="text" class="form-control" id="editTenKhuyenMai" name="tenKhuyenMai" required>
                    </div>
                    <div class="mb-3">
                        <label for="editGiaTriKhuyenMai" class="form-label">Giá trị khuyến mãi</label>
                        <input type="number" class="form-control" id="editGiaTriKhuyenMai" name="giaTriKhuyenMai" required>
                    </div>
                    <div class="mb-3">
                        <label for="editNgayBatDau" class="form-label">Ngày bắt đầu</label>
                        <input type="date" class="form-control" id="editNgayBatDau" name="ngayBatDau" required>
                    </div>
                    <div class="mb-3">
                        <label for="editNgayKetThuc" class="form-label">Ngày kết thúc</label>
                        <input type="date" class="form-control" id="editNgayKetThuc" name="ngayKetThuc" required>
                    </div>
                    <div class="mb-3">
                        <label for="editTinhTrang" class="form-label">Tình trạng</label>
                        <div>
                            <input type="radio" id="editHoatDong" name="tinhTrang" value="1">
                            <label for="editHoatDong">Hoạt động</label>
                            <input type="radio" id="editKhongHoatDong" name="tinhTrang" value="0">
                            <label for="editKhongHoatDong">Không hoạt động</label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>



</body>
<script>
    function showPromotionEdits(idKhuyenMai, maKhuyenMai, tenKhuyenMai, giaTriKhuyenMai, ngayBatDau, ngayKetThuc, tinhTrang) {
        document.getElementById('editIdKhuyenMai').value = idKhuyenMai;
        document.getElementById('editMaKhuyenMai').value = maKhuyenMai;
        document.getElementById('editTenKhuyenMai').value = tenKhuyenMai;
        document.getElementById('editGiaTriKhuyenMai').value = giaTriKhuyenMai;
        document.getElementById('editNgayBatDau').value = ngayBatDau;
        document.getElementById('editNgayKetThuc').value = ngayKetThuc;
        document.getElementById('editHoatDong').checked = (tinhTrang === 1);
        document.getElementById('editKhongHoatDong').checked = (tinhTrang === 0);
        document.getElementById('productForm').action = `/khuyen-mai/update`; // Update action
    }

    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const overlay = document.getElementById('overlay');

        sidebar.classList.toggle('open');
        overlay.classList.toggle('show'); // Hiển thị hoặc ẩn overlay
    }
</script>

</html>