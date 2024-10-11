<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý nhân viên</title>
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

    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600&display=swap" rel="stylesheet">

</head>
<body>
<header>
    <nav class="navbar navbar-expand-sm navbar-dark shadow-lg" style="background-color: #0B745E; height: 80px;">
        <div class="container d-flex align-items-center">
            <a href="#" class="navbar-brand d-flex align-items-center">
                <img src="../../lib/Green%20Elegant%20Coffee%20Shop%20Logo.png" style="height: 60px; margin-right: 10px;" alt="Logo">
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
                    <span class="btn rounded-pill text-white" style="padding: 10px 15px;"><i class="fa-solid fa-user"></i></span>
                </li>
            </ul>
        </div>
    </nav>
    <img src="/lib/background_quanly.png" style="width: 100%; height: auto;">
</header>
<div class="container mt-3">
    <div class="d-flex justify-content-between">
        <div class="div_left">
            <button id="btn-open" class="btn btn-outline-primary">+ THÊM NHÂN VIÊN</button>
        </div>
        <div class="div_center"></div>
        <div class="div_right">
            <form action="/nhan-vien/search" method="GET" class="mt-3">
                <div class="input-group container">
                    <input type="text" class="form-control" placeholder="Enter name" name="keyword" value="${keyword}">
                    <button class="btn btn-outline-dark button_search" type="submit">
                        <i class='bx bx-search' ></i>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <table class="table table-hover table-bordered text-center table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên Nhân Viên</th>
            <th>Email</th>
            <th>Mật Khẩu</th>
            <th>Số Điện Thoại</th>
            <th>Chức Vụ</th>
            <th>Ngày Đi Làm</th>
            <th>Thao Tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${nv.content}" var="nv" varStatus="i">
            <tr>
                <td>${nv.idNhanVien}</td>
                <td>${nv.tenNhanVien}</td>
                <td>${nv.email}</td>
                <td>${nv.matKhau}</td>
                <td>${nv.soDienThoai}</td>
                <td>${nv.chucVu}</td>
                <td>${nv.ngayDiLam}</td>
                <td>
                    <a href="#" type="button" class="btn btn-default bordervien table__logo">
                        <i class='bx bx-right-top-arrow-circle'></i>
                    </a>
                    <a id="btn-update-open" href="/nhan-vien/view-update/${nv.idNhanVien}" type="button" class="btn btn-default bordervien table__logo">
                        <i class='bx bx-edit-alt' ></i>
                    </a>
                    <a onclick="return confirm('Bạn có muốn xóa ?')" href="/nhan-vien/delete/${nv.idNhanVien}"
                       type="button" class="btn btn-default bordervien table__logo">
                        <i class='bx bx-trash' ></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <nav aria-label="Page navigation" class="mt-3">
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 0}">
                <li class="page-item">
                    <a class="page-link" href="/nhan-vien/hien-thi?page=0&size=${nv.size}" aria-label="First">
                        <span aria-hidden="true">&laquo;&laquo; First</span>
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="/nhan-vien/hien-thi?page=${currentPage - 1}&size=${nv.size}"
                       aria-label="Previous">
                        <span aria-hidden="true">&laquo; Previous</span>
                    </a>
                </li>
            </c:if>
            <li class="page-item disabled">
                <a class="page-link" href="#">Page ${currentPage + 1} of ${totalPages}</a>
            </li>
            <c:if test="${currentPage < totalPages - 1}">
                <li class="page-item">
                    <a class="page-link" href="/nhan-vien/hien-thi?page=${currentPage + 1}&size=${nv.size}"
                       aria-label="Next">
                        <span aria-hidden="true">Next &raquo;</span>
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="/nhan-vien/hien-thi?page=${totalPages - 1}&size=${nv.size}"
                       aria-label="Last">
                        <span aria-hidden="true">Last &raquo;&raquo;</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
<%--  Modal  --%>
<div id="modal-container">
    <div id="modal">
        <div class="modal-header">
            <h3>Thêm nhân viên</h3>
            <button id="btn-close"><i class='bx bx-x'></i></button>
        </div>
        <div class="modal-body">
            <form action="/nhan-vien/add" method="post">
                <div class="mt-3">
                    <label class="form-label">Tên nhân viên:</label>
                    <input type="text" class="form-control" name="tenNhanVien">
                    <c:if test="${not empty errors['tenNhanVien']}">
                        <small class="text-danger">${errors['tenNhanVien']}</small>
                    </c:if>
                </div>
                <div class="mt-3">
                    <label class="form-label">Email:</label>
                    <input type="text" class="form-control" name="email">
                    <c:if test="${not empty errors['email']}">
                        <small class="text-danger">${errors['email']}</small>
                    </c:if>
                </div>
                <div class="mt-3">
                    <label class="form-label">Mật khẩu:</label>
                    <input type="text" class="form-control" name="matKhau">
                    <c:if test="${not empty errors['matKhau']}">
                        <small class="text-danger">${errors['matKhau']}</small>
                    </c:if>
                </div>
                <div class="mt-3">
                    <label class="form-label">Số điện thoại:</label>
                    <input type="text" class="form-control" name="soDienThoai">
                    <c:if test="${not empty errors['soDienThoai']}">
                        <small class="text-danger">${errors['soDienThoai']}</small>
                    </c:if>
                </div>
                <div class="mt-3">
                    <label class="form-label">Chức vụ:</label>
                    <input type="text" class="form-control" name="chucVu">
                    <c:if test="${not empty errors['chucVu']}">
                        <small class="text-danger">${errors['chucVu']}</small>
                    </c:if>
                </div>
                <div class="mt-3">
                    <label class="form-label">Ngày đi làm:</label>
                    <input type="date" class="form-control" name="ngayDiLam">
                    <c:if test="${not empty errors['ngayDiLam']}">
                        <small class="text-danger">${errors['ngayDiLam']}</small>
                    </c:if>
                </div>
                <div class="mt-3">
                    <button class="btn btn-primary btn-submit" type="submit">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    const open = document.getElementById('btn-open');
    // console.log(show);
    const close = document.getElementById('btn-close');

    const modal_container = document.getElementById('modal-container');
    const modal_demo = document.getElementById('modal-demo');

    open.addEventListener('click', ()=>{
        modal_container.classList.add('show');
    });
    close.addEventListener('click', ()=>{
        modal_container.classList.remove('show');
    });
    modal_container.addEventListener('click', (e)=>{
        if(!modal_demo.contains(e.target)){
            close.click();
        }

    });
</script>

</body>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600&display=swap');

    /* Popup */
    button#btn-open {
        cursor: pointer;
        margin-bottom: 1rem;
        margin-top: 2rem
    }

    #modal-container {
        height: 100vh;
        background: rgba(0, 0,0,0.5);
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        opacity: 0;
        pointer-events: none;
        transition: all 0.3s ease-in-out;
    }

    #modal-container.show {
        opacity: 1;
        pointer-events: all;
    }

    #modal {
        background: #FFFFFF;
        max-width: 1000px;
        position: relative;
        left: 50%;
        top: 100px;
        transform: translateX(-50%);
        box-shadow: 0 2px 4px rgba(0,0,0, 0.3);
        transition: all 0.25s ease-in-out;
    }

    #modal-container.show .modal{
        top: 100px;
    }

    .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px 20px;
        border-bottom: 1px solid #dedede;
    }

    .modal-header h3 {
        margin: 0;
    }

    button#btn-close {
        outline: none;
        border: none;
        background: none;
        font-size: 18px;
        cursor: pointer;
    }

    #modal .modal-body {
        padding: 5px 20px 15px;
    }


    .pagination {
        justify-content: center;
    }

    .input-group {
        margin-top: 2rem;
        margin-bottom: 1rem;
    }

    .form-control {
        margin-right: .3rem;
        border: 1px solid #000000;
    }

    <%--  Button  --%>
    .bordervien {
        border: 1px solid #030303;
    }

    .table__logo {
        font-size: 20px;
        margin-bottom: 2.5rem;
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
</style>
</html>
