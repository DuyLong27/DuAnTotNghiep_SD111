<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
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
            background-color: #532B0E; /* Đặt màu nền cho dropdown */
            padding: 0px;
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
            color: white; /* Đặt màu chữ */
            padding: 10px;
            text-decoration: none;
            font-size: 16px;
        }

        .dropdown-custom .dropdown-item:hover {
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
        }

        /* Submenu */
        .dropdown-submenu .dropdown-menu {
            background-color: #532B0E;
            display: none;
            position: absolute;
            top: 0;
            left: 100%;
            padding: 0px;
            list-style: none;
            margin: 0;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            min-width: 160px;
        }

        .dropdown-submenu:hover .dropdown-menu {
            display: block;
        }

        .dropdown-submenu .dropdown-item {
            color: white;
            padding: 10px;
            text-decoration: none;
            font-size: 16px;
        }

        .dropdown-submenu .dropdown-item:hover {
            background-color: rgba(255, 255, 255, 0.1); /* Hiệu ứng hover giống menu chính */
            border-radius: 5px;
        }

        .dropdown-menu-custom, .dropdown-menu {
            pointer-events: auto;
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


        @media (min-width: 1400px) {
            .container,
            .container-lg,
            .container-md,
            .container-sm,
            .container-xl,
            .container-xxl {
                max-width: 1420px !important; /* Sử dụng !important để đảm bảo quy tắc này được ưu tiên */
            }
        }

    </style>

</head>
<body>
<%--header--%>
<nav class="navbar navbar-expand-sm navbar-dark sticky-top" style="background-color: #0B745E; height: 80px;">
    <div class="container d-flex align-items-center">
        <a href="#" class="navbar-brand d-flex align-items-center">
            <img src="../../uploads/logo_xanh.png" style="height: 60px; margin-right: 10px;" alt="Logo">
        </a>

        <ul class="navbar-nav mx-auto" style="flex-grow: 1; justify-content: center; gap: 20px;">
            <li class="nav-item">
                <a class="nav-link text-light" href="#">Trang chủ</a>
            </li>

            <!-- Dropdown Custom -->
            <li class="nav-item dropdown-custom">
                <a href="#" class="nav-link text-light">Sản phẩm</a>
                <ul class="dropdown-menu-custom">
                    <li class="dropdown-submenu">
                        <a class="dropdown-item" href="#">Cà phê</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Cà phê chuyên biệt</a></li>
                            <li><a class="dropdown-item" href="#">Cà phê rang xay</a></li>
                            <li><a class="dropdown-item" href="#">Cà phê hòa tan</a></li>
                            <li><a class="dropdown-item" href="#">Cà phê hạt</a></li>
                        </ul>
                    </li>
                    <li class="dropdown-submenu">
                        <a class="dropdown-item" href="#">Dụng cụ</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Dụng cụ hỗ trợ pha cà phê</a></li>
                            <li><a class="dropdown-item" href="#">Máy pha cà phê</a></li>
                            <li><a class="dropdown-item" href="#">Phụ kiện cà phê</a></li>
                        </ul>
                    </li>
                </ul>
            </li>

            <li class="nav-item">
                <a class="nav-link text-light" href="#">Khuyến mãi</a>
            </li>

            <li class="nav-item">
                <a class="nav-link text-light" href="#">Giới thiệu</a>
            </li>


            <li class="nav-item">
                <a class="nav-link text-light" href="#">Tin tức</a>
            </li>

            <li class="nav-item">
                <a class="nav-link text-light" href="#">Liên hệ</a>
            </li>
        </ul>

        <ul class="navbar-nav float-end">
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
</body>
</html>