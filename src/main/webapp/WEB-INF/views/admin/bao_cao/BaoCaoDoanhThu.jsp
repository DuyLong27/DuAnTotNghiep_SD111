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

<<<<<<< HEAD
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>

=======
>>>>>>> main
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.3/angular.min.js"
            integrity="sha512-KZmyTq3PLx9EZl0RHShHQuXtrvdJ+m35tuOiwlcZfs/rE7NZv29ygNA8SFCkMXTnYZQK2OX0Gm2qKGfvWEtRXA=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<body>
<<<<<<< HEAD
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
                <span class="btn rounded-pill text-white" style="padding: 10px 15px;"><i
                        class="fa-solid fa-user"></i></span>
            </li>
        </ul>
    </div>
</nav>
<img src="/lib/background_quanly.png" style="width: 100%; height: auto;">

=======
<jsp:include page="../layout.jsp" />
>>>>>>> main
<div class="row" style="padding-left: 100px;">
    <%--body--%>
    <div class="row" style="text-align: center">
        <H1>Doanh Thu Cửa Hàng</H1>
    </div>

    <br>

    <div class="row">
        <div class="col-3">
            <div class="row">
                <label>Loại báo cáo</label>
            </div>
            <div class="row">
                <select class="form-select" aria-label="Default select example">
                    <option selected>Doanh thu theo thu ngân</option>
                    <option value="1">One</option>
                    <option value="2">Two</option>
                    <option value="3">Three</option>
                </select>
            </div>
        </div>

        <div class="col-3" style="padding-left: 100px">
            <div class="row">
                <label>Thời gian</label>
            </div>
            <div class="row">
                <select class="form-select" aria-label="Default select example">
                    <option selected>Tháng này</option>
                    <option value="1">One</option>
                    <option value="2">Two</option>
                    <option value="3">Three</option>
                </select>
            </div>
        </div>

        <div class="col-3" style="padding-left: 100px">
            <div class="row">
                <label>Giờ</label>
            </div>
            <div class="row">
                <select class="form-select" aria-label="Default select example">
                    <option selected>07:00 - 08:00 GMT+7</option>
                    <option value="1">One</option>
                    <option value="2">Two</option>
                    <option value="3">Three</option>
                </select>
            </div>
        </div>

        <div class="col-3" style="padding-left: 100px">
            <div class="row mt-4">
                <div>
                    <button type="button" class="btn btn-primary">Xem báo cáo</button>
                </div>
            </div>
        </div>

    </div>
</div>
<br>
<div class="row" style="padding-left: 100px">
    <div class="col-3">
        <H4 class="text-uppercase" style="font-weight: bold">Doanh thu tổng quan</H4>
        <p class="fst-italic" style="color: #AFAFAF">Xem vào lúc 7:00 CH 10/07/2024</p>
    </div>
    <div class="col-6"></div>
    <div class="col-3">
        <button type="button" class="btn btn-success" style="margin-left: 70px">Xuất file Excel</button>
    </div>
</div>
<br>
<div class="row" style="padding-left: 100px">
    <table class="table table-borderless">
        <thead>
        <tr>
            <th scope="col" style="color: darkorchid">Tổng số hóa đơn</th>
            <th scope="col" style="color: darkorchid">Số hóa đơn hủy</th>
            <th scope="col" style="color: darkorchid">Số lượng mặt hàng</th>
            <th scope="col" style="color: darkorchid">TB mặt hàng / HĐ</th>
            <th scope="col" style="color: darkorchid">TB doanh thu / HĐ</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th scope="row">0</th>
            <td style="font-weight: bold">0</td>
            <td style="font-weight: bold">0</td>
            <td style="font-weight: bold">0</td>
            <td style="font-weight: bold">0</td>
        </tr>
        </tbody>
    </table>
</div>

<div class="row" style="padding-left: 90px;  padding-right: 150px;">
    <canvas id="myBarChart" width="900" height="300"></canvas>
</div>


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

<script>
    var ctx = document.getElementById('myBarChart').getContext('2d');
    var myBarChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['07:00', '08:00', '09:00', '10:00', '11:00', '12:00','13:00','14:00','15:00','16:00','17:00'],
            datasets: [{
                label: 'Doanh thu (triệu VND)',
                data: [12, 19, 3, 5, 2, 3],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 3
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        font: {
                            weight: 'bold',
                            size: 14
                        }
                    }
                },
                x: {
                    ticks: {
                        font: {
                            weight: 'bold',
                            size: 14
                        }
                    }
                }
            },
            plugins: {
                legend: {
                    labels: {
                        font: {
                            weight: 'bold',
                            size: 16
                        }
                    }
                }
            }
        }
    });
</script>

</html>

