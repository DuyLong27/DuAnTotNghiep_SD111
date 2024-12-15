<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nhập hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
          integrity="sha384-dyB3z1Vv3Pq9xJHqGZEXr2O6bUJ1FglF8fx7IDzW3a0BIcGoZsI6T3ez3/1p7byC" crossorigin="anonymous">
    <style>
        .order-status {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }

        .status-item {
            text-align: center;
            color: #6c757d;
            font-size: 14px;
            flex: 1;
        }

        .status-item.active {
            color: #28a745;
            font-weight: bold;
        }

        .status-icon {
            font-size: 24px;
            display: block;
            margin-bottom: 5px;
        }

        .card-header {
            background-color: #0B745E !important;
            color: white;
            font-weight: bold;
            text-align: center;
        }

        #alertMessage {
            position: fixed;
            right: -300px; /* Ẩn thông báo ra ngoài màn hình */
            top: 20px;
            width: 250px;
            transition: right 0.5s ease-in-out;
            z-index: 1050;
        }

        #alertMessage.show {
            right: 20px; /* Di chuyển vào bên trong màn hình khi hiện */
        }
        .alert {
            font-size: 16px;
            font-weight: 500;
            line-height: 1.5;
            border-left: 4px solid #28a745;
            padding: 15px 20px;
            background-color: #d4edda;
            color: #155724;
        }

        .alert i {
            color: #28a745;
        }


        .alert .btn-close {
            background-color: transparent;
            opacity: 0.8;
        }

        #autoCloseAlert {
            animation: fadeOut 3s forwards;
        }

        @keyframes fadeOut {
            0% {
                opacity: 1;
            }
            80% {
                opacity: 1;
            }
            100% {
                opacity: 0;
                display: none;
            }
        }
    </style>
</head>
<jsp:include page="../layout.jsp"/>
<body>
<div class="container mt-3">

    <div class="container mt-3">
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <strong>Thành công!</strong> ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Lỗi!</strong> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
    </div>
    <div class="container mt-3 position-relative">
        <c:if test="${not empty message}">
            <div id="autoCloseAlert" class="alert alert-success alert-dismissible fade show shadow-lg rounded"
                 role="alert"
                 style="max-width: 500px; margin: 0 auto; position: fixed; top: 20px; left: 50%; transform: translateX(-50%); z-index: 1050;">
                <i class="fa-solid fa-check-circle me-2"></i>
                <span>${message}</span>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
    </div>


    <div class="col-md-6">
        <a href="/nhap-hang/hien-thi" class="btn btn-outline-success me-2">Quay lại</a>

        <c:if test="${nhapHang.tinhTrang == 0}">
            <form action="/nhap-hang/da-nhan-hang/${nhapHang.id}" method="post" style="display: inline;">
                <button type="submit" class="btn btn-warning">Đã Nhận Hàng</button>
            </form>
        </c:if>
    </div>


    <!-- Thông tin phiếu nhập -->
    <div class="card mb-4 mt-3">
        <div class="card-header">Thông tin phiếu nhập</div>
        <div class="card-body">
            <div class="row mb-2">
                <div class="col-md-6">
                    <p><strong>Mã phiếu nhập:</strong> ${nhapHang.maPhieuNhap} </p>
                </div>
                <div class="col-md-6">
                    <p><strong>Tên nhân viên:</strong> ${nhapHang.nhanVien.tenNhanVien}</p>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-6">
                    <p><strong>Tên nhà cung cấp:</strong> ${nhapHang.nhaCungCap.tenNCC}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Ghi chú:</strong> ${nhapHang.ghiChu}</p>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-6">
                    <p><strong>Ngày tạo:</strong> ${formattedNgayTao}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Ngày nhập:</strong> ${formattedNgayNhap}</p>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-6">
                    <p><strong>Tổng giá trị:</strong><fmt:formatNumber value="${nhapHang.tongGiaTri}" type="number" pattern="#,###" /> </p>
                </div>
                <div class="col-md-6">
                    <p><strong>Tình trạng:</strong> ${nhapHang.tinhTrang == 0 ? 'Đang trên đường' : 'Đã hoàn thành'}</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Thông tin tình trạng và sản phẩm -->
    <div class="card mb-4">
        <div class="card-header">Chi tiết sản phẩm</div>
        <div class="card-body">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Giá nhập</th>
                    <th>Tổng tiền</th>
                    <th>HSD</th>
                    <th>NSX</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${nhapHangChiTiets}" var="nhct">
                    <tr>
                        <td>${nhct.sanPham.ten}</td>
                        <td>${nhct.soLuong}</td>
                        <td>${nhct.giaNhap} VND</td>
                        <td><fmt:formatNumber value="${nhct.tongTien}" type="number" pattern="#,###" /> VND</td>
                        <td>${nhct.hanSuDung} VND</td>
                        <td>${nhct.ngaySanXuat} VND</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <p class="text-end fw-bold">
                Tổng giá trị: <fmt:formatNumber value="${nhapHang.tongGiaTri}" type="number" pattern="#,###" />  VND
            </p>
        </div>
    </div>
</div>
</body>
</html>