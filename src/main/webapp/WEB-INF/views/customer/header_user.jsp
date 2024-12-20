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
            right: 0;
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

        /* Cart */
        /*.icon-cart{*/
        /*    padding-right: 99px;*/
        /*    padding-top: 7px;*/
        /*    color: white;*/
        /*}*/
        /*.icon-cart span{*/
        /*    display: flex;*/
        /*    width: 20px;*/
        /*    height: 20px;*/
        /*    background-color: red;*/
        /*    justify-content: center;*/
        /*    align-items: center;*/
        /*    color: #dddddd;*/
        /*    border-radius: 68%;*/
        /*    position: absolute;*/
        /*    top: 0%;*/
        /*    right: -10px;*/
        /*}*/
        .icon-cart a {
            position: relative;
            display: inline-block;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            padding-right: 20px;
        }

        .icon-cart a:hover {
            transform: translateY(-5px); /* Nâng icon lên một chút khi hover */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Thêm bóng đổ */
        }

        .icon-cart svg {
            transition: color 0.3s ease, fill 0.3s ease;
        }

        .icon-cart a:hover svg {
            color: #FFD700; /* Đổi màu icon khi hover */
        }

        .icon-cart span {
            display: flex;
            width: 20px;
            height: 20px;
            background-color: red;
            justify-content: center;
            align-items: center;
            color: #fff;
            border-radius: 50%;
            position: absolute;
            top: -10px;
            right: -15px;
            font-size: 12px;
            font-weight: bold;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2); /* Thêm bóng đổ cho số lượng */
        }

        .icon-cart a:hover span {
            background-color: #FF4500; /* Đổi màu nền cho số lượng khi hover */
            transform: scale(1.1); /* Phóng to nhẹ khi hover */
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
        <a href="/trang-chu" class="navbar-brand d-flex align-items-center">
            <img src="../../uploads/logo_xanh.png" style="height: 60px; margin-right: 10px;" alt="Logo">
        </a>

        <ul class="navbar-nav mx-auto" style="flex-grow: 1; justify-content: center; gap: 20px;">
            <li class="nav-item">
                <a class="nav-link text-light" href="/trang-chu">Trang chủ</a>
            </li>

            <li class="nav-item">
                <a href="/danh-sach-san-pham/hien-thi" class="nav-link text-light">Sản phẩm</a>
            </li>

            <li class="nav-item">
                <a class="nav-link text-light" href="/khuyen-mai">Khuyến mãi</a>
            </li>

            <li class="nav-item">
                <a class="nav-link text-light" href="/gioi-thieu">Giới thiệu</a>
            </li>

            <li class="nav-item">
                <a class="nav-link text-light" href="/lien-he">Liên hệ</a>
            </li>

            <li class="nav-item">
                <a class="nav-link text-light" href="/tra-cuu/tim-kiem">Tra cứu đơn hàng</a>
            </li>
        </ul>
        <ul class="navbar-nav icon-cart">
            <li class="nav-item dropdown-custom">
                <a href="/gio-hang/cart" class="nav-link text-light" style="position: relative;">
                    <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 4h1.5L9 16m0 0h8m-8 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm8 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm-8.5-3h9.25L19 7H7.312"/>
                    </svg>
                    <span>${tongSoLuong}</span> <!-- Hiển thị tổng số lượng giỏ hàng -->
                </a>
            </li>
        </ul>
        <ul class="navbar-nav float-end">
            <%--            <li class="nav-item">--%>
            <%--                <span class="btn rounded-pill text-white" style="padding: 10px 15px;"><i class="fa-solid fa-user"></i></span>--%>
            <%--            </li>--%>
            <li class="nav-item dropdown-custom">
                <a href="#" class="nav-link text-light">
                    <c:choose>
                        <c:when test="${not empty sessionScope.khachHang}">
                            ${sessionScope.khachHang.tenKhachHang}
                        </c:when>
                        <c:otherwise>
                            Tài khoản
                        </c:otherwise>
                    </c:choose>
                </a>
                <ul class="dropdown-menu-custom">
                    <c:choose>
                        <c:when test="${not empty sessionScope.khachHang}">
                            <li><a class="dropdown-item" href="/khach-hang">Thông tin</a></li>
                            <li><a class="dropdown-item" href="/auth/logout">Đăng xuất</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a class="dropdown-item" href="/auth/login">Đăng nhập</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </li>
        </ul>
    </div>
</nav>
</body>

</html>