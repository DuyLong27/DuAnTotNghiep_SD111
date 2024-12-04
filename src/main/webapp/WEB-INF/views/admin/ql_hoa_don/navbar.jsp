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
        .toast-container {
            z-index: 1050;
        }

        .toast {
            border-radius: 0.5rem;
            background-color: #0B745E;
            color: #fff;
            opacity: 1;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .toast-header {
            background-color: #0B745E;
            color: #fff;
        }

        .toast-body {
            background-color: #ffffff;
            color: #333;
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const currentUrl = window.location.href;
            const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
            navLinks.forEach(link => {
                if (currentUrl === link.href) {
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
    <div class="toast-container position-fixed top-0 start-50 translate-middle-x p-3">
        <div id="toastMessage" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <strong class="me-auto">Thông báo</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body">
                ${error}
            </div>
        </div>
    </div>
    <form class="d-flex" action="/hoa-don/tinhTrang=${tinhTrang}" method="get">
        <input type="hidden" name="tinhTrang" value="${tinhTrang}">
        <input class="form-control me-2" type="search" name="phoneNumber" placeholder="Tìm kiếm theo số điện thoại" aria-label="Search" value="${phoneNumber}">

        <input class="form-control me-2" type="date" name="startDate" value="${startDate}">
        <input class="form-control me-2" type="date" name="endDate" value="${endDate}">

        <select class="form-control me-2" name="kieuHoaDon">
            <option value="">Loại hóa đơn</option>
            <option value="0" ${kieuHoaDon == 0 ? 'selected' : ''}>Tại quầy</option>
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
                    <a class="nav-link" href="/hoa-don/tinhTrang=all">Tất cả</a>
                </div>
                <div class="navbar-nav">
                    <h5>Giao hàng</h5>
                    <a class="nav-link" href="/hoa-don/tinhTrang=0">
                        Chờ xác nhận
                        <span class="badge bg-danger">${chuaXacNhanCount}</span>
                    </a>
                    <a class="nav-link" href="/hoa-don/tinhTrang=1">
                        Chờ giao
                        <span class="badge bg-secondary">${choGiaoCount}</span>
                    </a>
                    <a class="nav-link" href="/hoa-don/tinhTrang=2">
                        Đang giao
                        <span class="badge bg-info">${dangGiaoCount}</span>
                    </a>
                    <a class="nav-link" href="/hoa-don/tinhTrang=4">
                        Hoàn thành
                        <span class="badge bg-success">${hoanThanhCount}</span>
                    </a>
                </div>
                <div class="navbar-nav">
                    <h5>Đổi trả</h5>
                    <a class="nav-link" href="/hoa-don/tinhTrang=11">
                        Chờ xác nhận đổi trả
                        <span class="badge bg-danger">${chuaXacNhanDoiTraCount}</span>
                    </a>
                    <a class="nav-link" href="/hoa-don/tinhTrang=12">
                        Chờ đổi trả
                        <span class="badge bg-warning">${choDoiTraCount}</span>
                    </a>
                    <a class="nav-link" href="/hoa-don/tinhTrang=13">
                        Đã đổi trả
                        <span class="badge bg-success">${daDoiTraCount}</span>
                    </a>
                    <a class="nav-link" href="/hoa-don/tinhTrang=14">
                        Đã hủy
                        <span class="badge bg-dark">${daHuyCount}</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</nav>
</body>
<script>
    <c:if test="${not empty error}">
    var toastElement = document.getElementById('toastMessage');
    var toast = new bootstrap.Toast(toastElement);
    toast.show();

    setTimeout(function() {
        toast.hide();
    }, 3500);
    </c:if>
</script>

</html>
