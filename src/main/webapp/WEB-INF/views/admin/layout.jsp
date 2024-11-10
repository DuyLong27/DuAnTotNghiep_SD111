<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    <style>

        body {
            background-color: #f8f9fa;
            overflow-x: hidden;
            font-family: 'Arial', sans-serif;
        }


        .sidebar {
            background-color: #0B745E;
            height: 100vh;
            width: 200px;
            padding: 20px;
            position: fixed;
            left: -200px;
            transition: left 0.3s;
            z-index: 1000;
        }

        .sidebar.open {
            left: 0;
        }

        .sidebar img {
            width: 100%;
            max-width: 150px;
            margin-bottom: 20px;
            border-radius: 10px;
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
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.2s;
        }

        .sidebar a:hover {
            background-color: #005b46;
            transform: scale(1.05);
        }

        .dropdown-menu {
            display: none;
            background-color:grey !important;
            width: 168px;
            border-radius: 5px;

        }

        .dropdown-item {
            text-align: center;
            color: grey;
            padding: 10px;
            transition: background-color 0.3s;
        }

        .dropdown-item:hover {
            background-color: #005b46;
            color: white;
        }


        .account-dropdown-menu {
            background-color: grey;
            width: 160px;
            border-radius: 5px;

        }

        .account-dropdown-item {
            text-align: center;
            color: white;
            padding: 10px;
            transition: background-color 0.3s;
            display: block;
            text-decoration: none;
        }

        .account-dropdown-item:hover {
            color: white;
            transform: scale(1.05);
            border-radius: 5px;
            background-color: #005b46;
        }


        .sidebar a i {
            margin-right: 10px;
        }

        .toggle-btn {
            position: fixed;
            left: 10px;
            top: 20px;
            background-color: transparent;
            border: 2px solid #0B745E;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            z-index: 1100;
        }

        .toggle-btn:hover {
            background-color: #0B745E;
            color: white;
            transform: scale(1.05);
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
            top: 10px;
            right: 10px;
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            padding: 10px;
            border-radius: 5px;
            z-index: 999;
        }


        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: none;
            z-index: 999;
        }

        .overlay.show {
            display: block;
        }


        .btn-secondary {
            color: white;
            border: 2px solid #0B745E;
            background-color: transparent;
            border-radius: 5px;
            padding: 6px 12px;
            transition: background-color 0.3s, color 0.3s;
            width:160px
        }

        .btn-secondary:hover {
            background-color: #0B745E;
            color: white;
            text-decoration: none;
        }

        .filter-section {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

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
    </style>



</head>
<body>


<button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">
    <i class="fas fa-bars"></i>
</button>


<div class="sidebar" id="sidebar">

    <img src="../../uploads/logo_xanh.png" alt="Logo">

    <a href="/bao-cao/hien-thi"><i class="fa-solid fa-chart-simple"></i>Tổng quan</a>

    <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
        <i class="fas fa-box"></i>Hàng hóa
    </a>
    <ul class="dropdown-menu">
        <li><a class="dropdown-item" href="/san-pham/index"><i class="fas fa-cube"></i>Sản phẩm</a></li>
        <li><a class="dropdown-item" href="/spct/index"><i class="fas fa-cube"></i>CT Sản phẩm</a></li>
        <li><a class="dropdown-item" href="/thuoc-tinh"><i class="fas fa-cube"></i>Thuộc Tính</a></li>
        <li><a class="dropdown-item" href="#"><i class="fas fa-warehouse"></i>Kho hàng</a></li>
    </ul>

    <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
        <i class="fas fa-exchange-alt"></i>Giao dịch
    </a>
    <ul class="dropdown-menu">
        <li><a class="dropdown-item" href="/ban-hang"><i class="fas fa-shopping-cart"></i>Bán hàng</a></li>
        <li><a class="dropdown-item" href="#"><i class="fas fa-download"></i>Nhập hàng</a></li>
        <li><a class="dropdown-item" href="/hoa-don/tinhTrang=all"><i class="fas fa-file-invoice"></i>Hóa đơn</a></li>
    </ul>

    <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
        <i class="fas fa-handshake"></i>Đối tác
    </a>
    <ul class="dropdown-menu">
        <li><a class="dropdown-item" href="/khach-hang/hien-thi"><i class="fas fa-user"></i>Khách hàng</a></li>
        <li><a class="dropdown-item" href="/nha-cung-cap"><i class="fas fa-truck"></i>Nhà cung cấp</a></li>
    </ul>

    <a href="/nhan-vien/hien-thi"><i class="fas fa-users"></i>Nhân viên</a>
    <a href="/khuyen-mai/hien-thi"><i class="fa-solid fa-tag"></i>Khuyến mãi</a>

</div>


<div class="overlay" id="overlay"></div>


<img src="/uploads/background_quanly.png" alt="Background" class="img-fluid" style="width: 100%; height: auto;">
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



</body>
<script>
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const overlay = document.getElementById('overlay');

        sidebar.classList.toggle('open');
        overlay.classList.toggle('show'); // Hiển thị hoặc ẩn overlay
    }

</script>
</html>
