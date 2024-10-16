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

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.3/angular.min.js"
            integrity="sha512-KZmyTq3PLx9EZl0RHShHQuXtrvdJ+m35tuOiwlcZfs/rE7NZv29ygNA8SFCkMXTnYZQK2OX0Gm2qKGfvWEtRXA=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
<jsp:include page="../layout.jsp" />
<%--body--%>
<div class="row" style="text-align: center">
    <H1>Quản Lý Khách Hàng</H1>
</div>

<table class="table table-striped table-hover table-bordered text-center">
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
                <a href="/khach-hang/view-add" class="btn btn-outline-custom">Thêm</a>
                <a href="/khach-hang/update/" class="btn btn-outline-custom">Sửa</a>
                <a href="/khach-hang/delete/" class="btn btn-outline-custom">Xóa</a>
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

