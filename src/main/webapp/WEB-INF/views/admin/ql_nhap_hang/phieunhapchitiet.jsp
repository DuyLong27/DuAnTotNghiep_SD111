<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nhập hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha384-dyB3z1Vv3Pq9xJHqGZEXr2O6bUJ1FglF8fx7IDzW3a0BIcGoZsI6T3ez3/1p7byC" crossorigin="anonymous">
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
    </style>
</head>
<jsp:include page="../layout.jsp" />
<body>
<div class="container mt-3">
    <div class="mt-3 mb-3">
        <a href="/nhap-hang/hien-thi" class="btn btn-outline-success">Quay lại</a>
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
                    <p><strong>Ngày tạo:</strong> ${nhapHang.ngayTao}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Ngày nhập:</strong> ${nhapHang.ngayNhap}</p>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-6">
                    <p><strong>Tổng giá trị:</strong> ${nhapHang.tongGiaTri}</p>
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
                        <td>${nhct.tongTien} VND</td>
                        <td>${nhct.hanSuDung} VND</td>
                        <td>${nhct.ngaySanXuat} VND</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <p class="text-end fw-bold">
                Tổng giá trị: ${nhapHang.tongGiaTri} VND
            </p>
        </div>
    </div>
</div>
</body>
</html>