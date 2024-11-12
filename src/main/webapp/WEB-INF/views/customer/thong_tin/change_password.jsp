<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Đổi mật khẩu</title>
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
<%--body--%>
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

        <div class="col-md-9">
            <form action="/khach-hang/doi-mat-khau" method="post">
                <div class="mt-3">
                    <label class="form-label">Mật khẩu hiện tại</label>
                    <input type="password" class="form-control" name="currentPassword" required>
                </div>
                <div class="mt-3">
                    <label class="form-label">Mật khẩu mới</label>
                    <input type="password" class="form-control" name="newPassword" required>
                </div>
                <div class="mt-3">
                    <label class="form-label">Xác nhận mật khẩu</label>
                    <input type="password" class="form-control" name="confirmPassword" required>
                </div>
                <div class="mt-3">
                    <a href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">Quên mật khẩu?</a>
                </div>
                <div class="mt-3">
                    <button type="submit" class="btn btn-success">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Modal Quên mật khẩu -->
<div class="modal fade" id="forgotPasswordModal" tabindex="-1" aria-labelledby="forgotPasswordModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="forgotPasswordModalLabel">Khôi phục mật khẩu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Form nhập email -->
                <div id="emailForm">
                    <form id="forgotPasswordForm" method="POST">
                        <div class="mb-3">
                            <label for="email" class="form-label">Nhập email của bạn</label>
                            <input type="email" class="form-control" id="email" name="email" required placeholder="Email của bạn">
                        </div>
                        <button type="submit" class="btn btn-primary">Gửi mã OTP</button>
                    </form>
                </div>

                <!-- Form xác nhận OTP -->
                <div id="otpForm" style="display: none;">
                    <form id="verifyOtpForm" method="POST">
                        <div class="mb-3">
                            <label for="otp" class="form-label">Nhập mã OTP đã gửi</label>
                            <input type="text" class="form-control" id="otp" name="otp" required placeholder="Mã OTP">
                        </div>
                        <button type="submit" class="btn btn-primary">Xác nhận OTP</button>
                    </form>
                </div>
                <!-- Form nhập mật khẩu mới -->
                <div id="newPasswordForm" style="display: none;">
                    <form id="updatePasswordForm" method="POST">
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Mật khẩu mới</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" required placeholder="Mật khẩu mới">
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required placeholder="Xác nhận mật khẩu mới">
                        </div>
                        <button type="submit" class="btn btn-primary">Cập nhật mật khẩu</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>



<script>
    function showForgotPasswordModal() {
        document.getElementById('forgotPasswordModal').style.display = 'block';
    }
    function closeModal() {
        document.getElementById('forgotPasswordModal').style.display = 'none';
    }
    // Gửi form OTP
    document.getElementById('forgotPasswordForm').addEventListener('submit', function(event) {
        event.preventDefault();

        const email = document.getElementById('email').value;

        fetch('/khach-hang/gui-ma-xac-minh', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'email=' + encodeURIComponent(email),
        })
            .then(response => response.json())
            .then(data => {
                // Hiển thị thông báo đơn giản bằng alert
                alert(data.message);

                // Chuyển sang form xác nhận OTP nếu gửi OTP thành công
                if (data.success) {
                    document.getElementById('emailForm').style.display = 'none';
                    document.getElementById('otpForm').style.display = 'block';
                }
            })
            .catch(error => {
                alert("Có lỗi xảy ra, vui lòng thử lại!");
            });
    });

    // Xác nhận OTP và chuyển sang form nhập mật khẩu mới
    document.getElementById('verifyOtpForm').addEventListener('submit', function(event) {
        event.preventDefault();

        const otp = document.getElementById('otp').value;

        fetch('/khach-hang/xac-nhan-otp', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'otp=' + encodeURIComponent(otp),
        })
            .then(response => response.json())
            .then(data => {
                // Hiển thị thông báo đơn giản bằng alert
                alert(data.message);

                // Nếu OTP chính xác, chuyển sang form nhập mật khẩu mới
                if (data.success) {
                    document.getElementById('otpForm').style.display = 'none';
                    document.getElementById('newPasswordForm').style.display = 'block';
                }
            })
            .catch(error => {
                alert("Có lỗi xảy ra, vui lòng thử lại!");
            });
    });

    // Cập nhật mật khẩu mới
    document.getElementById('updatePasswordForm').addEventListener('submit', function(event) {
        event.preventDefault();

        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        // Kiểm tra nếu mật khẩu và xác nhận mật khẩu trùng khớp
        if (newPassword !== confirmPassword) {
            alert("Mật khẩu và xác nhận mật khẩu không khớp!");
            return;
        }

        // Gửi yêu cầu cập nhật mật khẩu mới
        fetch('/khach-hang/cap-nhat-mat-khau', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'newPassword=' + encodeURIComponent(newPassword),
        })
            .then(response => response.json())
            .then(data => {
                // Hiển thị thông báo đơn giản bằng alert
                alert(data.message);

                // Đóng modal sau khi cập nhật mật khẩu thành công
                if (data.success) {
                    setTimeout(() => {
                        var modal = new bootstrap.Modal(document.getElementById('forgotPasswordModal'));
                        modal.hide();
                    }, 2000);
                }
            })
            .catch(error => {
                alert("Có lỗi xảy ra, vui lòng thử lại!");
            });
    });
</script>
<jsp:include page="../footer_user.jsp"/>
</body>
</html>