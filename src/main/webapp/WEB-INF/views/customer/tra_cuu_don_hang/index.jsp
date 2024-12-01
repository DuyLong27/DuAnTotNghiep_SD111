<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Tra cứu đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .info-card {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .info-header {
            font-weight: bold;
            color: #0B745E;
            font-size: 1.2rem;
            margin-bottom: 10px;
        }

        .mt-4 {
            margin-top: 1.5rem;
        }
    </style>
</head>
<body>
<jsp:include page="../header_user.jsp" />
<div class="container mt-5">
    <h2 class="text-center mb-4">Tra cứu đơn hàng</h2>

    <form action="/tra-cuu/tim-kiem" method="get" class="d-flex justify-content-center mb-4">
        <input type="text" name="soHoaDon" placeholder="Nhập số hóa đơn" class="form-control w-50">
        <button type="submit" class="btn btn-primary ms-3">Tìm kiếm</button>
    </form>

    <c:if test="${not empty error}">
        <div class="alert text-center">${error}</div>
    </c:if>

    <c:if test="${not empty hoaDon}">
        <div class="row">
            <div class="col-md-4">
                <div class="info-card">
                    <h4 class="info-header">Xử lý đơn hàng</h4>
                    <c:if test="${hoaDon.kieuHoaDon == 1 && hoaDon.tinh_trang !=14}">
                    <c:if test="${hoaDon.tinh_trang >= 0}">
                    <p><strong>${thoiGianTao}</strong> Đơn hàng đã được đặt </p>
                    </c:if>
                    <c:if test="${hoaDon.tinh_trang >= 1}">
                    <p><strong>${thoiGianXacNhan}</strong> Đơn hàng đã được xác nhận</p>
                    </c:if>
                    <c:if test="${hoaDon.tinh_trang >= 2}">
                    <p><strong>${banGiaoVanChuyen}</strong> Đơn hàng đã được bàn giao cho đơn vị vận chuyển </p>
                        <p><strong>Đơn hàng đang trong quá trình giao</strong></p>
                    <p>Thời gian nhận hàng dự kiến: <strong>${thoiGianDuKien}</strong></p>
                     </c:if>
                    <c:if test="${hoaDon.tinh_trang >= 4}">
                    <p><strong>${hoanThanh}</strong> Đơn hàng đã được giao thành công </p>
                    </c:if>
                    <c:if test="${hoaDon.tinh_trang >= 11}">
                        <p><strong>${hoanTra}</strong>: Yêu cầu đổi trả</p>
                    </c:if>
                    <c:if test="${hoaDon.tinh_trang >= 12}">
                        <p><strong>${xacNhanHoanTra}</strong>: Đã xác nhận yêu cầu đổi trả</p>
                    </c:if>
                    <c:if test="${hoaDon.tinh_trang >= 13}">
                        <p><strong>${daHoanTra}</strong>: Đổi trả thành công</p>
                    </c:if>
                    </c:if>
                    <c:if test="${hoaDon.kieuHoaDon == 0}">
                        <p>Đơn hàng đã được mua tại quầy vào lúc: <strong>${hoaDon.thoiGianTaoFormatted}</strong></p>
                    </c:if>
                    <c:if test="${hoaDon.tinh_trang ==14}">
                        <p><strong>${thoiGianTao}</strong> Đơn hàng đã được đặt </p>
                        <p><strong>${daHuy}</strong>: Đã hủy đơn hàng</p>
                    </c:if>
                </div>
            </div>

            <div class="col-md-8">

                <div class="info-card">
                    <h4 class="info-header">Thông tin hóa đơn</h4>
                    <p><strong>Số hóa đơn:</strong> ${hoaDon.soHoaDon}</p>
                    <p><strong>Số điện thoại:</strong> ${hoaDon.soDienThoai}</p>
                    <c:if test="${hoaDon.kieuHoaDon == 1}">
                    <p><strong>Địa chỉ:</strong> ${hoaDon.diaChi}</p>
                    <p><strong>Phương thức vận chuyển:</strong> ${hoaDon.phuongThucVanChuyen}</p>
                    <p><strong>Phí vận chuyển:</strong>
                        <c:choose>
                            <c:when test="${hoaDon.phuongThucVanChuyen == 'Giao Hàng Tiêu Chuẩn'}">20000 VNĐ</c:when>
                            <c:when test="${hoaDon.phuongThucVanChuyen == 'Giao Hàng Nhanh'}">33000 VNĐ</c:when>
                        </c:choose>
                    </p>
                    </c:if>
                    <p><strong>Tổng tiền:</strong> ${hoaDon.tongTien} VNĐ</p>
                    <p><strong>Loại hóa đơn:</strong> ${hoaDon.kieuHoaDon ==1 ? "Online" :"Tại quầy"}</p>
                    <p>
                        <strong>Trạng thái đơn hàng:</strong>
                        <c:choose>
                            <c:when test="${hoaDon.tinh_trang == 0}">Chờ xác nhận</c:when>
                            <c:when test="${hoaDon.tinh_trang == 1}">Chờ giao</c:when>
                            <c:when test="${hoaDon.tinh_trang == 2 || hoaDon.tinh_trang == 3}">Đang giao</c:when>
                            <c:when test="${hoaDon.tinh_trang == 4}">Hoàn thành</c:when>
                            <c:when test="${hoaDon.tinh_trang == 11}">Chờ xác nhận đổi trả</c:when>
                            <c:when test="${hoaDon.tinh_trang == 12}">Chờ đổi trả</c:when>
                            <c:when test="${hoaDon.tinh_trang == 13}">Đã đổi trả</c:when>
                            <c:when test="${hoaDon.tinh_trang == 14}">Đã hủy</c:when>
                            <c:otherwise>Không xác định</c:otherwise>
                        </c:choose>
                    </p>
                </div>

                <div class="info-card mt-4">
                    <h4 class="info-header">Danh sách sản phẩm</h4>
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>Hình ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${chiTietHoaDons}" var="item">
                            <tr>
                                <td><img style="width: 90px" src="/uploads/${item.sanPhamChiTiet.hinhAnh}" alt="${item.sanPhamChiTiet.sanPham.ten}"></td>
                                <td>${item.sanPhamChiTiet.sanPham.ten}</td>
                                <td>
                                        <c:choose>
                                            <c:when test="${item.gia_san_pham != item.sanPhamChiTiet.giaBan}">
                            <span style="text-decoration: line-through; color: gray;">
                                ${item.sanPhamChiTiet.giaBan} VNĐ
                            </span>
                                                <br>
                                                <span style="color: green;">
                                ${item.gia_san_pham} VNĐ
                            </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>${item.gia_san_pham} VNĐ</span>
                                            </c:otherwise>
                                        </c:choose>
                                </td>
                                <td>${item.so_luong}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:if>
</div>
<jsp:include page="../footer_user.jsp" />
</body>
</html>
