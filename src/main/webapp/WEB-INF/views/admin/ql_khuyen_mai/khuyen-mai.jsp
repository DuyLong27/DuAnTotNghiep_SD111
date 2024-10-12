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
        body {
            background-color: #f8f9fa;
        }

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
        /* Buttons */
        /* Adjust the Action Column Width */
        th:nth-child(7), td:nth-child(7) {
            width: 100px; /* Adjust as per your needs */
        }

        /* Ensure Buttons Stay Compact */
        .btn-custom {
            width: 45px; /* Smaller width */
            height: 28px; /* Smaller height */
            font-size: 11px; /* Smaller font size */
            padding: 4px 6px; /* Reduce padding */
        }

        .d-flex.gap-2 .btn-custom {
            margin-right: 4px; /* Reduce gap between buttons */
        }

        @media (max-width: 768px) {
            .btn-custom {
                width: 60px; /* Adjust further for small screens */
                height: 25px;
            }
        }

        .pagination .page-item.active .page-link {
            background-color: #0B745E;
            border-color: #0B745E;
        }

        /* Nút với đường viền */
        .btn-outline-custom {
            color: #0B745E; /* Màu chữ */
            border: 2px solid #0B745E; /* Đường viền */
            background-color: transparent; /* Không có màu nền */
            border-radius: 5px;
            padding: 6px 12px; /* Padding hợp lý */
            transition: background-color 0.3s, color 0.3s; /* Hiệu ứng mượt khi hover */
            font-size: 14px; /* Cỡ chữ */
        }

        /* Hiệu ứng hover */
        .btn-outline-custom:hover {
            background-color: #0B745E; /* Màu nền khi hover */
            color: white; /* Màu chữ khi hover */
            text-decoration: none; /* Xóa gạch chân nếu là link */
        }

        /* Custom style for the Filter and Create buttons */
        .btn-custom-action {
            width: 90px; /* Adjust the width to fit your button text */
            height: 35px; /* Adjust the height for consistency */
            font-size: 14px; /* Adjust the font size */
            padding: 5px 10px; /* Set padding for a balanced look */
            border: 1px solid #0B745E; /* Add a border to match the theme */
            background-color: transparent; /* No background color */
            color: #0B745E; /* Text color matching your theme */
            transition: background-color 0.3s ease; /* Smooth transition */
        }

        /* Hover effect for the buttons */
        .btn-custom-action:hover {
            background-color: rgba(11, 116, 94, 0.1); /* Light background on hover */
            color: #0B745E; /* Text color stays the same */
        }

        /* Custom style for the Filter and Create buttons with full background color */
        .btn-filter {
            width: 90px; /* Adjust width to fit button text */
            height: 35px; /* Set consistent height */
            font-size: 14px; /* Font size for the buttons */
            padding: 5px 10px; /* Add padding for space inside the button */
            background-color: #0B745E; /* Dark green background for "Lọc" */
            color: white; /* White text */
            border: none; /* Remove border */
            border-radius: 5px; /* Slightly rounded corners */
            transition: background-color 0.3s ease; /* Smooth hover transition */
        }

        /* Hover effect for "Lọc" button */
        .btn-filter:hover {
            background-color: #095F4D; /* Darker green on hover */
        }

        /* Custom style for "Tạo mới" button with full green background */
        .btn-create {
            width: 90px;
            height: 35px;
            font-size: 14px;
            padding: 5px 10px;
            background-color: #28a745; /* Green background */
            color: white;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        /* Hover effect for "Tạo mới" button */
        .btn-create:hover {
            background-color: #218838; /* Darker green on hover */
        }




    </style>

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
                <a class="nav-link text-light" href="/khuyen-mai/hien-thi">Khuyến mãi</a>
            </li>
        </ul>

        <ul class="navbar-nav">
            <li class="nav-item dropdown-custom">
                <a href="#" class="nav-link text-light">Tài khoản</a>
                <ul class="dropdown-menu-custom">
                    <li><a class="dropdown-item" href="">Thông tin</a></li>
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
    <div class="row">

        <div class="col-md-3 filter-section">
            <h5>Bộ lọc khuyến mãi</h5>
            <form action="/khuyen-mai/hien-thi" method="get">
                <div class="mb-3">
                    <label for="maKhuyenMai" class="form-label">Mã khuyến mãi</label>
                    <input type="text" class="form-control" id="maKhuyenMai" name="maKhuyenMai">
                </div>
                <div class="mb-3">
                    <label for="tenKhuyenMai" class="form-label">Tên khuyến mãi</label>
                    <input type="text" class="form-control" id="tenKhuyenMai" name="tenKhuyenMai">
                </div>
                <div class="mb-3">
                    <label for="giaTriKhuyenMai" class="form-label">Giá trị khuyến mãi (Từ - Đến)</label>
                    <div class="d-flex gap-2">
                        <input type="number" class="form-control" name="giaTriMin" placeholder="Từ">
                        <input type="number" class="form-control" name="giaTriMax" placeholder="Đến">
                    </div>
                </div>
                <div class="mb-3">
                    <label for="ngayBatDau" class="form-label">Ngày bắt đầu</label>
                    <input type="date" class="form-control" id="ngayBatDau" name="ngayBatDau">
                </div>
                <div class="mb-3">
                    <label for="ngayKetThuc" class="form-label">Ngày kết thúc</label>
                    <input type="date" class="form-control" id="ngayKetThuc" name="ngayKetThuc">
                </div>
                <button type="submit" class="btn btn-filter">Lọc</button>
                <a href="/khuyen-mai/hien-thi" class="btn btn-secondary">Xóa lọc</a>
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
                                <a href="/khuyen-mai/chi-tiet?id=${item.idKhuyenMai}" class="btn btn-outline-custom">
                                    <i class="fa fa-info-circle"></i>
                                </a>
                                <a href="/khuyen-mai/sua/${item.idKhuyenMai}" class="btn btn-outline-custom">
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
                        <a class="page-link" href="?page=${currentPage - 1}&size=5">Previous</a>
                    </li>
                    <c:forEach var="i" begin="0" end="${totalPages - 1}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&size=5">${i + 1}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage + 1}&size=5">Next</a>
                    </li>
                </ul>
            </nav>

        </div>
    </div>
</div>

<!-- Pop-up -->
<div class="modal fade" id="addPromotionModal" tabindex="-1" aria-labelledby="addPromotionModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addPromotionModalLabel">Thêm Khuyến Mãi</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/khuyen-mai/them" method="post">
                    <div class="mb-3">
                        <label class="form-label">Mã khuyến mãi</label>
                        <input type="text" class="form-control" name="maKhuyenMai">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tên khuyến mãi</label>
                        <input type="text" class="form-control" name="tenKhuyenMai">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Giá trị khuyến mãi</label>
                        <input type="text" class="form-control" name="giaTriKhuyenMai">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ngày bắt đầu</label>
                        <input type="date" class="form-control" name="ngayBatDau">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ngày kết thúc</label>
                        <input type="date" class="form-control" name="ngayKetThuc">
                    </div>
                    <div class="mb-3">
                        <p>Tình trạng</p>
                        <div class="d-flex">
                            <div class="form-check me-3">
                                <input class="form-check-input" type="radio" name="tinhTrang" value="1" id="dangHoatDong">
                                <label class="form-check-label" for="dangHoatDong">
                                    Đang hoạt động
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="tinhTrang" value="0" id="khongHoatDong">
                                <label class="form-check-label" for="khongHoatDong">
                                    Không hoạt động
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3 text-center">
                        <a href="/khuyen-mai/hien-thi" class="btn btn-secondary" data-bs-dismiss="modal">Quay lại</a>
                        <button type="submit" class="btn btn-success">Tạo mới</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>