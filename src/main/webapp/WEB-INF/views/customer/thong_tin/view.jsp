<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.3/angular.min.js"
            integrity="sha512-KZmyTq3PLx9EZl0RHShHQuXtrvdJ+m35tuOiwlcZfs/rE7NZv29ygNA8SFCkMXTnYZQK2OX0Gm2qKGfvWEtRXA=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <style>
        /* Sidebar styling */
        .sidebar {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 15px;
        }

        .sidebar .list-group-item {
            border: none;
            padding: 15px;
            font-size: 16px;
            font-weight: 600;
            color: #495057;
            transition: all 0.3s ease;
        }

        .sidebar .list-group-item i {
            font-size: 20px;
            margin-right: 10px;
            color: #6c757d;
        }

        .sidebar .list-group-item:hover {
            background-color: #f8f9fa;
            color: #007bff;
            transform: scale(1.02);
            border-radius: 8px;
        }

        .sidebar .list-group-item:hover i {
            color: #007bff;
        }

        .rotate-icon {
            transition: transform 0.3s ease;
        }

        [data-bs-toggle="collapse"][aria-expanded="true"] .rotate-icon {
            transform: rotate(90deg);
        }

        /* Card header gradient */
        .card-header {
            background: linear-gradient(45deg, #0B745E, #532B0E);
            color: #fff;
            border-radius: 8px 8px 0 0;
        }

        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .card-body .col {
            text-align: center;
            margin-bottom: 15px;
        }

        .card-body p {
            margin: 0;
            color: #495057;
        }

        .card-body strong {
            color: #343a40;
            font-weight: 700;
        }
    </style>
</head>
<body>
<jsp:include page="../header_user.jsp"/>
<img src="/lib/background_quanly.png" style="width: 100%; height: auto;">
<div class="container mt-5 mb-3">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 mb-3">
            <div class="sidebar">
                <div class="list-group">
                    <a href="#collapseAccount" class="list-group-item d-flex justify-content-between align-items-center"
                       data-bs-toggle="collapse" aria-expanded="false">
                        <i class="bi bi-person-circle"></i> Tài khoản của tôi
                        <i class="bi bi-chevron-right rotate-icon"></i>
                    </a>
                    <div class="collapse" id="collapseAccount">
                        <a class="list-group-item" href="/khach-hang/thong-tin"><i class="bi bi-info-circle"></i> Thông
                            tin cá nhân</a>
                        <a class="list-group-item" href="/khach-hang/doi-mat-khau"><i class="bi bi-key"></i> Thay đổi
                            mật khẩu</a>
                    </div>

                    <a href="#collapseOrders" class="list-group-item d-flex justify-content-between align-items-center"
                       data-bs-toggle="collapse" aria-expanded="false">
                        <i class="bi bi-box-seam"></i> Đơn hàng của tôi
                        <i class="bi bi-chevron-right rotate-icon"></i>
                    </a>
                    <div class="collapse" id="collapseOrders">
                        <a class="list-group-item" href="/doi-tra"><i class="bi bi-basket"></i> Đơn Hàng</a>
                    </div>

                    <a class="list-group-item d-flex align-items-center" href="/auth/logout">
                        <i class="bi bi-box-arrow-right"></i> <span class="ms-2">Đăng Xuất</span>
                    </a>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-9">
            <!-- Account Info Card -->
            <div class="card mb-4">
                <div class="card-header">
                    <h4>Thông tin tài khoản</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col">
                            <p><strong>Tên</strong></p>
                            <p>${khachHang.tenKhachHang}</p>
                        </div>
                        <div class="col">
                            <p><strong>Ngày Đăng Ký</strong></p>
                            <p>${khachHang.ngayDangKy}</p>
                        </div>
                        <div class="col">
                            <p><strong>Điểm tích lũy:</strong></p>
                            <p>
                                <c:choose>
                                    <c:when test="${empty khachHang.diemTichLuy}">
                                        0
                                    </c:when>
                                    <c:otherwise>
                                        ${khachHang.diemTichLuy}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col">
                            <p><strong>Hạng bậc (Rank)</strong></p>
                            <p>Bạc</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Orders Card -->
            <div class="card">
                <div class="card-header">
                    <h4>Đơn hàng của tôi</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col">
                            <p><strong>Tổng Đơn Hàng</strong></p>
                            <p>${orderStats.tongHoaDon}</p>
                        </div>
                        <div class="col">
                            <p><strong>Chờ xác nhận</strong></p>
                            <p>${orderStats.choXacNhan}</p>
                        </div>
                        <div class="col">
                            <p><strong>Chờ giao hàng</strong></p>
                            <p>${orderStats.choGiaoHang}</p>
                        </div>
                        <div class="col">
                            <p><strong>Đang giao hàng</strong></p>
                            <p>${orderStats.dangGiao}</p>
                        </div>
                        <div class="col">
                            <p><strong>Xác nhận thanh toán</strong></p>
                            <p>${orderStats.xacNhanThanhToan}</p>
                        </div>
                        <div class="col">
                            <p><strong>Hoàn thành</strong></p>
                            <p>${orderStats.hoanThanh}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../footer_user.jsp"/>
</body>
</html>
