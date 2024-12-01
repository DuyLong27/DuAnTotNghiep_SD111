<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hóa đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@12.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <style>
        .navbar-nav-group {
            display: flex;
            justify-content: space-around;
            flex-wrap: nowrap;
            text-align: center;
            gap: 30px;
        }

        .navbar-nav {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar-nav h5 {
            color: #0B745E;
            font-size: 1.25rem;
            font-weight: bold;
            text-transform: uppercase;
            white-space: nowrap;
        }

        .nav-link {
            color: #333;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 25px;
            transition: all 0.3s ease;
            text-decoration: none;
            white-space: nowrap;
        }

        .nav-link:hover {
            background-color: #0B745E;
            color: #ffffff;
        }

        .nav-link.active {
            background-color: #0B745E;
            color: white !important;
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const currentUrl = window.location.href;
            const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
            navLinks.forEach(link => {
                if (currentUrl.includes(link.getAttribute('href'))) {
                    link.classList.add('active');
                }
            });
        });
    </script>
</head>
<jsp:include page="../layout.jsp" />
<body>

<h2 class="d-flex justify-content-center mt-3 text-dark">Quản lý hóa đơn</h2>
<div class="container mt-4">
    <form class="d-flex" action="/hoa-don/tinhTrang=${tinhTrang}" method="get">
        <input type="hidden" name="tinhTrang" value="${tinhTrang}">
        <input class="form-control me-2" type="search" name="phoneNumber" placeholder="Tìm kiếm theo số điện thoại" aria-label="Search" value="${phoneNumber}">

        <input class="form-control me-2" type="date" name="startDate" value="${startDate}">
        <input class="form-control me-2" type="date" name="endDate" value="${endDate}">

        <!-- Thêm trường select cho kieuHoaDon -->
        <select class="form-control me-2" name="kieuHoaDon">
            <option value="">Loại hóa đơn</option>
            <option value="0" ${kieuHoaDon == 0 ? 'selected' : ''}>Offline</option>
            <option value="1" ${kieuHoaDon == 1 ? 'selected' : ''}>Online</option>
        </select>

        <button class="btn btn-outline-success" type="submit">Tìm kiếm</button>
    </form>
</div>
<nav class="navbar navbar-expand-lg navbar-light mt-4">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="navbar-nav-group">
                <div class="navbar-nav">
                    <h5>Chung</h5>
                    <a class="nav-link" href="/hoa-don/tinhTrang=all">Tất cả</a>
                </div>
                <div class="navbar-nav">
                    <h5>Quản lý giao hàng</h5>
                    <a class="nav-link" href="/hoa-don/tinhTrang=0">Chờ xác nhận</a>
                    <a class="nav-link" href="/hoa-don/tinhTrang=1">Chờ giao</a>
                    <a class="nav-link" href="/hoa-don/tinhTrang=2">Đang giao</a>
                    <a class="nav-link" href="/hoa-don/tinhTrang=4">Hoàn thành</a>
                </div>
                <div class="navbar-nav">
                    <h5>Quản lý đổi trả</h5>
                    <a class="nav-link" href="/hoa-don/tinhTrang=11">Chờ xác nhận đổi trả</a>
                    <a class="nav-link" href="/hoa-don/tinhTrang=12">Chờ đổi trả</a>
                    <a class="nav-link" href="/hoa-don/tinhTrang=13">Đã đổi trả</a>
                    <a class="nav-link" href="/hoa-don/tinhTrang=14">Đã hủy</a>
                </div>
            </div>
        </div>
    </div>
</nav>
</body>
</html>
