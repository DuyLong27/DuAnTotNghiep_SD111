<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Mã giá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">

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


        .sublist {
            list-style: none;
            padding-left: 0;
        }

        .list-group-item {
            border: none;
        }


        .ticket {
            border: 1px solid #0B745E;
            border-radius: 10px;
            padding: 15px;
            margin: 15px 0;
            position: relative;
            background: #f8f9fa;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .ticket h5 {
            margin-bottom: 10px;
        }
        .ticket .details {
            display: none; /* Ẩn chi tiết mặc định */
        }
        .ticket:hover {
            cursor: pointer;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }


        .rotate-icon {
            transition: transform 0.2s ease-in-out;
        }

        .collapse.show + a .rotate-icon, /* Khi phần collapse được mở */
        a[aria-expanded="true"] .rotate-icon {
            transform: rotate(90deg); /* Xoay mũi tên 90 độ */
        }
    </style>

</head>
<body>
<nav class="navbar navbar-expand-sm navbar-dark shadow-lg" style="background-color: #0B745E; height: 80px;">
    <div class="container d-flex align-items-center">
        <a href="#" class="navbar-brand d-flex align-items-center">
            <img src="../../../lib/logo_xanh.png" style="height: 60px; margin-right: 10px;" alt="Logo">
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

        <ul class="navbar-nav">
            <li class="nav-item dropdown-custom">
                <a href="/khach-hang" class="nav-link text-light">Tài khoản</a>
                <ul class="dropdown-menu-custom">
                    <li><a class="dropdown-item" href="/khach-hang">Thông tin</a></li>
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

<div class="container mt-5">
    <div class="row">

        <div class="col-md-3">
            <div class="list-group">
                <!-- Tài khoản của tôi -->
                <a href="#collapseAccount" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" data-bs-toggle="collapse" aria-expanded="false">
                    <h5><strong>Tài khoản của tôi</strong></h5>
                    <i class="bi bi-chevron-right rotate-icon"></i> <!-- Icon mũi tên -->
                </a>
                <div class="collapse" id="collapseAccount">
                    <ul class="list-group sublist">
                        <li><a class="list-group-item" href="/khach-hang/thong-tin">Thông tin cá nhân</a></li>
                        <li><a class="list-group-item" href="/khach-hang/doi-mat-khau">Thay đổi mật khẩu</a></li>
                    </ul>
                </div>

                <!-- Khuyến mãi của tôi -->
                <a href="#collapsePromotion" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" data-bs-toggle="collapse" aria-expanded="false">
                    <h5><strong>Khuyến mãi của tôi</strong></h5>
                    <i class="bi bi-chevron-right rotate-icon"></i> <!-- Icon mũi tên -->
                </a>
                <div class="collapse" id="collapsePromotion">
                    <ul class="list-group sublist">
                        <li><a class="list-group-item" href="/khach-hang/ma-giam-gia">Phiếu giảm giá</a></li>
                        <li><a class="list-group-item" href="/khach-hang/diem-thuong">Điểm thưởng</a></li>
                    </ul>
                </div>

                <!-- Đơn hàng của tôi -->
                <a href="#collapseOrders" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" data-bs-toggle="collapse" aria-expanded="false">
                    <h5><strong>Đơn hàng của tôi</strong></h5>
                    <i class="bi bi-chevron-right rotate-icon"></i> <!-- Icon mũi tên -->
                </a>
                <div class="collapse" id="collapseOrders">
                    <ul class="list-group sublist">
                        <li><a class="list-group-item" href="/khach-hang/tat-ca-don-hang">Tất cả đơn hàng</a></li>
                        <li><a class="list-group-item" href="#">Đơn hàng xử lý</a></li>
                        <li><a class="list-group-item" href="#">Đơn hàng chờ lấy hàng</a></li>
                        <li><a class="list-group-item" href="#">Đơn hàng đang giao</a></li>
                        <li><a class="list-group-item" href="#">Đơn hàng đã giao</a></li>
                        <li><a class="list-group-item" href="#">Đã đánh giá</a></li>
                        <li><a class="list-group-item" href="#">Chưa đánh giá</a></li>
                        <li><a class="list-group-item" href="#">Đơn hàng đã hủy</a></li>
                        <li><a class="list-group-item" href="#">Đơn hàng trả lại</a></li>
                    </ul>
                </div>

                <!-- Đăng xuất -->
                <a class="list-group-item" href="#"><h5><strong>Đăng xuất</strong></h5></a>
            </div>
        </div>


        <div class="col-md-9">
            <h5><strong>Mã giảm giá của tôi</strong></h5>

            <div class="ticket">
                <h5>Mã Giảm Giá: DISCOUNT10</h5>
                <p>Giá Trị Giảm: 10%</p>
                <p>Ngày Bắt Đầu: 01/01/2024</p>
                <p>Ngày Kết Thúc: 31/12/2024</p>
                <button class="btn btn-secondary" onclick="copyCouponCode('DISCOUNT10')">Sao Chép</button>
                <a class="btn btn-info" data-bs-toggle="collapse" href="#details1" role="button" aria-expanded="false" aria-controls="details1">Chi tiết</a>
                <div class="collapse" id="details1">
                    <div class="card card-body mt-2">
                        <h6>Chi tiết:</h6>
                        <p>Mã giảm giá này có thể sử dụng cho tất cả các sản phẩm trên trang web. Không áp dụng cho sản phẩm khuyến mãi.</p>
                    </div>
                </div>
            </div>

            <div class="ticket">
                <h5>Mã Giảm Giá: FREE20000</h5>
                <p>Giá Trị Giảm: 20,000 VNĐ</p>
                <p>Ngày Bắt Đầu: 01/10/2024</p>
                <p>Ngày Kết Thúc: 30/10/2024</p>
                <button class="btn btn-secondary" onclick="copyCouponCode('FREE20000')">Sao Chép</button>
                <a class="btn btn-info" data-bs-toggle="collapse" href="#details2" role="button" aria-expanded="false" aria-controls="details2">Chi tiết</a>
                <div class="collapse" id="details2">
                    <div class="card card-body mt-2">
                        <h6>Chi tiết:</h6>
                        <p>Mã giảm giá này chỉ áp dụng cho đơn hàng từ 200,000 VNĐ trở lên.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Chi Tiết -->
<div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detailModalLabel">Chi Tiết Mã Giảm Giá</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="modalBody">
                <!-- Nội dung chi tiết mã giảm giá sẽ được thêm vào đây -->
            </div>
        </div>
    </div>
</div>

<footer style="background-color: #532B0E; color: white; padding: 40px 0;">
    <div class="container">
        <div class="row align-items-center">

            <div class="col-md-3">
                <img src="/lib/logo_nau.png" style="height: 250px; margin-bottom: 20px;" alt="Logo">
            </div>


            <div class="col-md-3">
                <h5>Về chúng tôi</h5>
                <ul style="list-style: none; padding-left: 0;">
                    <li><a href="#" style="color: white;">Giới thiệu</a></li>
                    <li><a href="#" style="color: white;">Vị trí cửa hàng</a></li>
                    <li><a href="#" style="color: white;">Câu hỏi thường gặp</a></li>
                    <li><a href="#" style="color: white;">Chính sách và điều khoản</a></li>
                    <li><a href="#" style="color: white;">Chính sách bảo mật</a></li>
                    <li><a href="#" style="color: white;">Đăng ký trở thành đối tác</a></li>
                </ul>
            </div>

            <div class="col-md-3">
                <h5>Đối tác</h5>
                <ul style="list-style: none; padding-left: 0;">
                    <li><a href="#" style="color: white;">Đối tác thanh toán</a></li>
                    <li><a href="#" style="color: white;">Cách thức thanh toán</a></li>
                    <li><a href="#" style="color: white;">Đối tác vận chuyển</a></li>
                    <li><a href="#" style="color: white;">Chính sách giao nhận</a></li>
                    <li><a href="#" style="color: white;">Chính sách bảo hành</a></li>
                    <li><a href="#" style="color: white;">Chính sách đổi trả</a></li>
                </ul>
            </div>

            <div class="col-md-3">
                <h5>Liên hệ</h5>
                <p>Địa chỉ: Số 123 Tây Tựu, Bắc Từ Liêm, Hà Nội, Việt Nam</p>
                <p>Điện thoại: 123456789</p>
                <h5>Mạng xã hội</h5>
                <a href="#" style="color: white;">Facebook</a>
                <a href="#" style="color: white;">Twitter</a>
                <a href="#" style="color: white;">Zalo</a>
            </div>

        </div>
        <div class="row">

            <div class="col-md-12 text-center">
                <h5>The Nature Coffee</h5>
                <p>Thưởng thức tinh túy thiên nhiên trong từng ngụm cà phê</p>
                <p>&copy; 2023 The Nature Coffee</p>
            </div>
        </div>
    </div>
</footer>
</body>
</html>