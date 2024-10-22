<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Danh sách sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        /* Styles for the product image */
        .product-image {
            width: 100%;
            height: 250px;
            object-fit: cover; /* Prevents image distortion */
        }

        /* Sidebar styles */
        #sidebar {
            background-color: #f8f9fa; /* Sidebar background color */
            border-right: 1px solid #dee2e6; /* Sidebar right border */
            padding: 20px;
            height: 100%; /* Ensures full height */
        }

        /* Sidebar links */
        #sidebar .nav-link {
            color: #0B745E; /* Default link color */
            font-weight: 500; /* Bold text */
            padding: 10px 15px;
            border-radius: 5px; /* Rounded corners */
            transition: background-color 0.3s ease, color 0.3s ease; /* Transition for color and background */
        }

        /* Sidebar hover effect */
        #sidebar .nav-link:hover {
            background-color: #0B745E; /* Background color on hover */
            color: #ffffff; /* Text color on hover */
        }

        /* Submenu items */
        #sidebar .collapse .nav-item .nav-link {
            padding-left: 30px; /* Indentation for submenu items */
        }

        /* Submenu hover effect */
        #sidebar .collapse .nav-item .nav-link:hover {
            background-color: #e9ecef; /* Background color on hover for submenu */
            color: #0B745E; /* Text color on hover for submenu */
        }

        /* Collapse arrow icon */
        #sidebar .nav-item a[data-bs-toggle="collapse"]:after {
            content: '\f107'; /* Font Awesome caret down icon */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            float: right;
            transition: transform 0.3s ease; /* Smooth arrow rotation */
        }

        /* Rotate arrow when expanded */
        #sidebar .nav-item a[data-bs-toggle="collapse"][aria-expanded="true"]:after {
            transform: rotate(180deg);
        }

        /* Expanded collapse effect */
        #sidebar .collapse.show {
            border-left: 2px solid #0B745E;
            margin-left: 10px;
            transition: border-left 0.5s ease, margin-left 0.5s ease;
            opacity: 1;
        }

        /* Collapsed collapse effect */
        #sidebar .collapse {
            border-left: 2px solid transparent;
            transition: border-left 0.5s ease, margin-left 0.5s ease;
        }

        /* Active link in the sidebar */
        #sidebar .nav-item a.active {
            background-color: #0B745E;
            color: #ffffff;
        }

        /* Combobox (dropdown for sorting) styling */
        .form-select {
            width: 200px; /* Set width */
            padding: 5px;
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            background-color: #fff;
            transition: border-color 0.3s ease-in-out;
        }

        /* Hover effect for combobox */
        .form-select:hover {
            border-color: #0B745E;
        }

        /* Focus effect for combobox */
        .form-select:focus {
            border-color: #0B745E;
            box-shadow: 0 0 5px rgba(11, 116, 94, 0.5);
        }

        /* Combobox option style */
        .form-select option {
            padding: 5px;
            font-size: 14px;
        }

        /* Product card layout */
        .product-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            transition: box-shadow 0.3s ease;
            background-color: #fff;
        }

        /* Hover effect for product card */
        .product-card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Product card title */
        .product-card-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }

        /* Product card description */
        .product-card-description {
            font-size: 14px;
            color: #777;
            margin-bottom: 10px;
        }


        .product-card-price {
            font-size: 16px;
            font-weight: bold;
            color: #0B745E;
        }


        .product-card .btn {
            background-color: #0B745E;
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }


        .product-card .btn:hover {
            background-color: #084d3c;
            color: white;
        }

        .product-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }


        .product-grid-item {
            flex: 1 1 calc(33.333% - 20px);
            max-width: calc(33.333% - 20px);
        }

        /* Responsive for smaller screens */
        @media (max-width: 768px) {
            .product-grid-item {
                flex: 1 1 calc(50% - 20px);
                max-width: calc(50% - 20px);
            }
        }

        @media (max-width: 576px) {
            .product-grid-item {
                flex: 1 1 100%;
                max-width: 100%;
            }
        }


        .nav-link {
            color: #0B745E;
            transition: color 0.3s ease;
        }


        .nav-link:hover {
            color: #084d3c;
            text-decoration: none;
        }

        .card {
            overflow: hidden; /* Đảm bảo ảnh không tràn ra ngoài card */
        }

        .product-image {
            transition: transform 0.3s ease; /* Thêm hiệu ứng chuyển đổi cho ảnh */
        }

        .card:hover .product-image {
            transform: scale(1.1); /* Phóng to ảnh lên 110% khi hover */
        }

        .product-quantity {
            display: none; /* Ẩn số lượng sản phẩm mặc định */
            background-color: rgba(0, 0, 0, 0.7); /* Nền mờ đen */
            color: white; /* Màu chữ trắng */
            padding: 10px; /* Khoảng cách */
            border-radius: 5px; /* Bo tròn góc */
            z-index: 10; /* Đảm bảo nó nằm trên các phần tử khác */
        }

        .card:hover .product-quantity {
            display: block; /* Hiện số lượng khi hover */
        }

    </style>
</head>
<body>
<jsp:include page="../header_user.jsp" />
<div class="container mt-3">
    <div class="d-flex justify-content-end align-items-center">
        <div class="d-flex justify-content-end align-items-center">
            <div class="float-end">
                <select class="form-select" onchange="location = this.value;">
                    <option value="#">Sắp Xếp</option>
                    <option value="/danh-sach-san-pham/hien-thi">Tất Cả</option>
                    <option value="/danh-sach-san-pham/hien-thi?sort=asc">Giá Thấp Nhất</option>
                    <option value="/danh-sach-san-pham/hien-thi?sort=desc">Giá Cao Nhất</option>
                </select>
            </div>
        </div>
    </div>
    <div class="row mt-3">
        <!-- Sidebar -->
        <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
            <div class="position-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="collapse" href="#collapsePhanGia">
                            Giá Tiền
                        </a>
                        <div class="collapse" id="collapsePhanGia">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="/danh-sach-san-pham/hien-thi">Tất cả</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="?minPrice=0&maxPrice=100000">Dưới 100,000 VNĐ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="?minPrice=100000&maxPrice=200000">100,000 - 200,000 VNĐ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="?minPrice=200000&maxPrice=500000">200,000 - 500,000 VNĐ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="?minPrice=500000&maxPrice=1000000">500,000 - 1,000,000 VNĐ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="?minPrice=1000000">Trên 1,000,000 VNĐ</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="collapse" href="#collapseThuongHieu" aria-expanded="false">
                            Thương Hiệu
                        </a>
                        <div class="collapse" id="collapseThuongHieu">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="/danh-sach-san-pham/hien-thi">Tất cả</a>
                                </li>
                                <li class="nav-item">
                                    <c:forEach items="${listThuongHieu}" var="item">
                                        <a class="nav-link" href="?thuongHieuId=${item.id}">${item.ten}</a>
                                    </c:forEach>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="collapse" href="#collapseLoaiCaPhe">
                            Loại Cà Phê
                        </a>
                        <div class="collapse" id="collapseLoaiCaPhe">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="/danh-sach-san-pham/hien-thi">Tất cả</a>
                                </li>
                                <li class="nav-item">
                                    <c:forEach items="${listLoaiCaPhe}" var="item">
                                        <a class="nav-link" href="?loaiCaPheId=${item.id}">${item.ten}</a>
                                    </c:forEach>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " data-bs-toggle="collapse" href="#collapseHuongVi">
                            Hương Vị
                        </a>
                        <div class="collapse" id="collapseHuongVi">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="/danh-sach-san-pham/hien-thi">Tất cả</a>
                                </li>
                                <li class="nav-item">
                                    <c:forEach items="${listHuongVi}" var="item">
                                        <a class="nav-link" href="?huongViId=${item.id}">${item.ten}</a>
                                    </c:forEach>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " data-bs-toggle="collapse" href="#collapseLoaiHat">
                            Loại Hạt
                        </a>
                        <div class="collapse" id="collapseLoaiHat">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="/danh-sach-san-pham/hien-thi">Tất cả</a>
                                </li>
                                <li class="nav-item">
                                    <c:forEach items="${listLoaiHat}" var="item">
                                        <a class="nav-link" href="?loaiHatId=${item.id}">${item.ten}</a>
                                    </c:forEach>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="collapse" href="#collapseMucDoRang">
                            Mức Độ Rang
                        </a>
                        <div class="collapse" id="collapseMucDoRang">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="/danh-sach-san-pham/hien-thi">Tất cả</a>
                                </li>
                                <li class="nav-item">
                                    <c:forEach items="${listMucDoRang}" var="item">
                                        <a class="nav-link" href="?mucDoRangId=${item.id}">${item.ten}</a>
                                    </c:forEach>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Content -->
        <div class="col-md-9 col-lg-10">
            <div class="row">
                <c:forEach items="${listSanPham}" var="item">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100 shadow-sm position-relative">
                            <a href="#">
                                <img src="${pageContext.request.contextPath}/uploads/${item.hinhAnh}" class="card-img-top product-image" alt="${item.sanPham.ten}">
                            </a>
                            <div class="card-body text-center">
                                <h5 class="card-title">${item.sanPham.ten}</h5>
                                <p class="card-text">${item.giaBan} VNĐ</p>
                                <div class="product-detail-link rounded-bottom-3" style="background-color: #0B745E;">
                                    <a class="nav-link text-light" href="#">
                                        <i class="fa-solid fa-link"></i> Chi Tiết Sản Phẩm
                                    </a>
                                </div>
                            </div>
                            <div class="product-quantity position-absolute top-50 start-50 translate-middle">
                                <span class="quantity-text">${item.soLuong} sản phẩm</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../footer_user.jsp" />
</body>
</html>
