<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hóa đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <style>
        .navbar {
            background-color: #ffffff;
            padding: 15px 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .nav-link {
            color: #333333;
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 25px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .nav-link:hover {
            background-color: #f0f0f0;
            color: #0B745E;
        }

        .navbar-light .navbar-nav .nav-link.active,
        .navbar-light .navbar-nav .show>.nav-link {
            background-color: #0B745E;
            color: white !important;
        }

        .navbar-nav-group {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 30px;
        }

        .navbar-nav-group h5 {
            color: #333333;
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .navbar-nav-group .nav-item {
            margin: 5px 0;
        }

        .navbar-nav-group .navbar-nav {
            padding: 10px 15px;
            border-radius: 10px;
        }

        .navbar-nav-group .nav-item:hover {
            background-color: rgba(0, 0, 0, 0.05);
        }

    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const currentUrl = window.location.pathname + window.location.search;
            const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
            navLinks.forEach(link => {
                if (link.getAttribute('href') === currentUrl) {
                    link.classList.add('active');
                }
            });
        });
    </script>
</head>
<jsp:include page="../layout.jsp" />
<body>

<h2 class="d-flex justify-content-center mt-3 text-dark">Quản lý hóa đơn</h2>
<nav class="navbar navbar-expand-lg navbar-light mt-3">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="navbar-nav-group">
                <div class="navbar-nav">
                    <h5>Quản lý giao hàng</h5>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="/hoa-don/tinhTrang=all">Tất cả</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/hoa-don/tinhTrang=0">Chờ xác nhận</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/hoa-don/tinhTrang=1">Chờ giao</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/hoa-don/tinhTrang=2">Đang giao</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/hoa-don/tinhTrang=4">Hoàn thành</a>
                        </li>
                    </ul>
                </div>

                <div class="navbar-nav">
                    <h5>Quản lý đổi trả</h5>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="/hoa-don/tinhTrang=11">Chờ xác nhận đổi trả</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/hoa-don/tinhTrang=12">Chờ đổi trả</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/hoa-don/tinhTrang=13">Đã đổi trả</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/hoa-don/tinhTrang=14">Đã hủy</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

</body>
</html>
