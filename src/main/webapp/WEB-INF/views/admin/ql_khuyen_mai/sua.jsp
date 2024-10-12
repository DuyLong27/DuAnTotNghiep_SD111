<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
    <meta charset="UTF-8">
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

</head>
<body>
<%--header--%>
<nav class="navbar navbar-expand-sm navbar-dark shadow-lg" style="background-color: #0B745E; height: 80px;">
    <div class="container d-flex align-items-center">
        <a href="#" class="navbar-brand d-flex align-items-center">
            <img src="../../../lib/logo_xanh.png" style="height: 60px; margin-right: 10px;" alt="Logo">
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
                <a class="nav-link text-light" href="/khuyen-mai/hien-thi">Khuyến mãi</a>
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
<div class="container mt-3">
    <h2 class="d-flex justify-content-center">CHI TIẾT KHUYẾN MÃI</h2>
    <form action="/khuyen-mai/sua/${khuyenMaiEdit.idKhuyenMai}" method="post">
        <div class="mb-3">
            <label class="form-label">ID</label>
            <input type="text" class="form-control" name="idKhuyenMai" readonly value="${khuyenMaiEdit.idKhuyenMai}" disabled>
        </div>
        <div class="mb-3">
            <label class="form-label">Mã khuyến mãi</label>
            <input type="text" class="form-control" name="maKhuyenMai" value="${khuyenMaiEdit.maKhuyenMai}">
        </div>
        <div class="mb-3">
            <label class="form-label">Tên khuyến mãi</label>
            <input type="text" class="form-control" name="tenKhuyenMai" value="${khuyenMaiEdit.tenKhuyenMai}">
        </div>
        <div class="mb-3">
            <label class="form-label">Giá trị khuyến mãi</label>
            <input type="text" class="form-control" name="giaTriKhuyenMai" value="${khuyenMaiEdit.giaTriKhuyenMai}">
        </div>
        <div class="mb-3">
            <label class="form-label">Ngày bắt đầu</label>
            <input type="text" class="form-control" name="ngayBatDau" value="${khuyenMaiEdit.ngayBatDau}">
        </div>
        <div class="mb-3">
            <label class="form-label">Ngày kết thúc</label>
            <input type="text" class="form-control" name="ngayKetThuc" value="${khuyenMaiEdit.ngayKetThuc}">
        </div>

        <div class="mt-3 text-center">
            <a href="/khuyen-mai/hien-thi" class="btn btn-secondary">Quay lại</a>
            <button type="submit" class="btn btn-success">Sửa</button>
        </div>
    </form>

</div>

</body>
</html>