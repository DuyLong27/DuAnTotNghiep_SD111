<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Thông tin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>

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

        .alert-warning {
            color: red;
        }
        .text-danger {
            color: red;
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
                    <a href="#collapseAccount" class="list-group-item d-flex justify-content-between align-items-center" data-bs-toggle="collapse" aria-expanded="false">
                        <i class="bi bi-person-circle"></i> Tài khoản của tôi
                        <i class="bi bi-chevron-right rotate-icon"></i>
                    </a>
                    <div class="collapse" id="collapseAccount">
                        <a class="list-group-item" href="/khach-hang/thong-tin"><i class="bi bi-info-circle"></i> Thông tin cá nhân</a>
                        <a class="list-group-item" href="/khach-hang/doi-mat-khau"><i class="bi bi-key"></i> Thay đổi mật khẩu</a>
                    </div>

                    <a href="#collapseOrders" class="list-group-item d-flex justify-content-between align-items-center" data-bs-toggle="collapse" aria-expanded="false">
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

        <!-- Phần thông tin cá nhân -->
        <div class="col-md-9">
            <h5><strong>Thông tin cá nhân</strong></h5>

            <div class="row">
                <div class="col-md-6 mt-3">
                    <p><strong>Tên:</strong> ${khachHang.tenKhachHang}</p>
                    <c:if test="${empty khachHang.tenKhachHang}">
                        <p class="text-danger">Mời bạn bổ sung tên!</p>
                    </c:if>
                </div>
                <div class="col-md-6 mt-3">
                    <p><strong>Email:</strong> ${khachHang.email}</p>
                    <c:if test="${empty khachHang.email}">
                        <p class="text-danger">Mời bạn bổ sung email!</p>
                    </c:if>
                </div>
                <div class="col-md-6 mt-3">
                    <p><strong>Số điện thoại:</strong> ${khachHang.soDienThoai}</p>
                    <c:if test="${empty khachHang.soDienThoai}">
                        <p class="text-danger">Mời bạn bổ sung số điện thoại!</p>
                    </c:if>
                </div>
                <div class="col-md-6 mt-3">
                    <p><strong>Địa chỉ:</strong> ${khachHang.diaChi}</p>
                    <c:if test="${empty khachHang.diaChi}">
                        <p class="text-danger">Mời bạn bổ sung địa chỉ!</p>
                    </c:if>
                </div>
                <div class="col-md-6 mt-3">
                    <p><strong>Điểm tích lũy:</strong>
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
                <div class="col-md-6 mt-3">
                    <p><strong>Ngày đăng ký:</strong> ${khachHang.ngayDangKy}</p>
                </div>
            </div>
            <div class="mt-3">
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#editModal">Thay Đổi</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal for editing info -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content rounded-4 shadow-lg">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title" id="editModalLabel">Chỉnh sửa thông tin cá nhân</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/khach-hang/cap-nhat-thong-tin" method="post">
                    <div class="mb-3">
                        <label for="tenKhachHang" class="form-label">Tên</label>
                        <input type="text" class="form-control" id="tenKhachHang" name="tenKhachHang" value="${khachHang.tenKhachHang}">
                        <c:if test="${empty khachHang.tenKhachHang}">
                            <p class="text-danger">Mời bạn bổ sung tên!</p>
                        </c:if>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="${khachHang.email}">
                        <c:if test="${empty khachHang.email}">
                            <p class="text-danger">Mời bạn bổ sung email!</p>
                        </c:if>
                    </div>
                    <div class="mb-3">
                        <label for="soDienThoai" class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" id="soDienThoai" name="soDienThoai" value="${khachHang.soDienThoai}">
                        <c:if test="${empty khachHang.soDienThoai}">
                            <p class="text-danger">Mời bạn bổ sung số điện thoại!</p>
                        </c:if>
                    </div>
                    <div class="mb-3">
                        <label for="diaChi" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="diaChi" name="diaChi" value="${khachHang.diaChi}">
                        <c:if test="${empty khachHang.diaChi}">
                            <p class="text-danger">Mời bạn bổ sung địa chỉ!</p>
                        </c:if>
                    </div>
                    <button type="submit" class="btn btn-success">Lưu thay đổi</button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer_user.jsp"/>
</body>
</html>
