<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Danh Sách Hóa Đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYzIY0LIzj+PZrXsSOJo9ORpB0d6BSZ/S30R7rpkhwn/tI3oU7j7Sk" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css">
    <style>
        table {
            width: 100%;
            margin-top: 20px;
        }
        table th, table td {
            text-align: center;
            padding: 10px;
        }
        .card {
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        .card-body {
            padding: 20px;
        }
        .btn-outline-primary {
            border-radius: 50%;
            padding: 8px 12px;
        }

    /*    show hoa don*/
        .invoice {
            display: none; /* Ẩn hóa đơn ban đầu */
            position: fixed;
            top: 20%;
            right: -300px; /* Đặt bên ngoài màn hình */
            width: 250px;
            border: 1px solid #ccc;
            padding: 10px;
            background-color: white;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            transition: right 0.5s ease; /* Hiệu ứng trượt */
            z-index: 2; /* Đảm bảo hóa đơn nằm trên cùng */
        }
        .invoice.show {
            display: block; /* Hiện hóa đơn */
            right: 20px; /* Vị trí khi hiện ra */
        }
        .overlay {
            display: none; /* Ẩn lớp mờ ban đầu */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: #000000; /* Màu mờ */
            opacity: 0.4;
            z-index: 1; /* Đảm bảo lớp mờ nằm dưới hóa đơn */
        }
        .content {
            z-index: 0; /* Nội dung trang bán hàng nằm dưới lớp mờ */
        }
    </style>
    <title>Bán Hàng</title>
</head>
<body>
<div class="overlay" id="overlay"></div>
<div class="container mt-5 content">
    <div class="row">
        <div class="col-md-6">
            <c:if test="${not empty selectedHoaDonId}">
                <h4 class="mt-4">Thêm Sản Phẩm</h4>
                <div class="row">
                    <c:forEach items="${sanPhams}" var="sanPham">
                        <div class="col-md-4 mb-3">
                            <div class="card">
                                <div class="card-body text-center">
                                    <h5 class="card-title">${sanPham.sanPham.ten}</h5>
                                    <p class="card-text">Giá: ${sanPham.giaBan} VNĐ</p>
                                    <form action="${pageContext.request.contextPath}/hoa-don/${selectedHoaDonId}/add-product" method="post">
                                        <input type="hidden" name="sanPhamId" value="${sanPham.id}" />
                                        <button type="submit" class="btn btn-outline-primary">
                                            <i class="bi bi-plus"></i> <!-- Icon dấu cộng -->
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>

        <div class="col-md-6">
            <h2 class="text-primary">Danh Sách Hóa Đơn</h2>
            <div class="d-flex align-items-center mb-3">
                <form action="/hoa-don/addHoaDon" method="post" class="me-2">
                    <button class="btn btn-success">Tạo hóa đơn mới</button>
                </form>
                <div class="form-group me-2">
                    <label for="hoaDonSelect" class="visually-hidden">Chọn Hóa Đơn:</label>
                    <select id="hoaDonSelect" class="form-select" onchange="location = this.value;">
                        <option value="">-- Chọn Hóa Đơn --</option>
                        <c:forEach items="${hoaDonList}" var="hoaDon">
                            <option value="${pageContext.request.contextPath}/hoa-don/${hoaDon.id}"
                                    <c:if test="${hoaDon.id == selectedHoaDonId}">selected</c:if>>
                                    ${hoaDon.so_hoa_don}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <form action="${pageContext.request.contextPath}/hoa-don/${selectedHoaDonId}/delete" method="post" class="ms-2">
                    <input type="hidden" name="hoaDonId" value="${selectedHoaDonId}"/>
                    <button type="submit" class="btn btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa hóa đơn này?');">Xóa</button>
                </form>
            </div>

            <c:if test="${not empty selectedHoaDonId}">
                <h3 class="text-primary">Chi Tiết Hóa Đơn ID: ${selectedHoaDonId}</h3>
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                    <tr>
                        <th>STT</th>
                        <th>Tên Sản Phẩm</th>
                        <th>Giá Bán</th>
                        <th>Số Lượng</th>
                        <th>Thao Tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="tongTien" value="0" /> <!-- Khởi tạo tổng tiền -->
                    <c:forEach items="${hoaDonChiTiets}" var="item" varStatus="i">
                        <tr>
                            <td>${i.index + 1}</td>
                            <td>${item.sanPhamChiTiet.sanPham.ten}</td>
                            <td>${item.sanPhamChiTiet.giaBan}</td>
                            <td><input type="number" id="so_luong" value="${item.so_luong}"/></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/hoa-don/${selectedHoaDonId}/remove-product/${item.sanPhamChiTiet.id}" method="post" style="display:inline-block;">
                                    <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                                </form>
                            </td>
                        </tr>
                        <!-- Tính tổng tiền dựa trên giá bán của SanPhamChiTiet -->
                        <c:set var="tongTien" value="${tongTien + (item.so_luong * item.sanPhamChiTiet.giaBan)}" />
                    </c:forEach>

                    </tbody>
                </table>

                <c:if test="${not empty selectedHoaDonId}">
                    <h4 class="text-primary">Tổng Tiền: ${tongTien} VNĐ</h4> <!-- Hiển thị tổng tiền -->
                </c:if>

                <form id="paymentMethodForm" action="${pageContext.request.contextPath}/hoa-don/${selectedHoaDonId}/update-all-payment-method" method="post" class="mb-3">
                    <div class="form-group">
                        <label for="phuongThucThanhToan">Chọn phương thức thanh toán:</label>
                        <select id="phuongThucThanhToan" name="phuongThucThanhToan" class="form-select" onchange="this.form.submit();">
                            <option value="Tiền mặt" <c:if test="${phuongThucThanhToan == 'Tiền mặt'}">selected</c:if>>Tiền mặt</option>
                            <option value="Chuyển khoản" <c:if test="${phuongThucThanhToan == 'Chuyển khoản'}">selected</c:if>>Chuyển khoản</option>
                            <option value="Thẻ tín dụng" <c:if test="${phuongThucThanhToan == 'Thẻ tín dụng'}">selected</c:if>>Thẻ tín dụng</option>
                            <!-- Thêm các phương thức thanh toán khác nếu cần -->
                        </select>
                    </div>
                </form>

                <div class="mb-3" id="cashPaymentSection" style="display: none;">
                    <label for="soTienKhachDua" class="form-label">Số tiền khách đưa:</label>
                    <input id="soTienKhachDua" class="form-control" oninput="calculateChange()" />
                </div>
                <h4 class="text-danger" id="soTienPhaiBu" style="display: none;">Số tiền phải bù lại: 0 VNĐ</h4>
            </c:if>
            <c:forEach items="${hoaDonChiTiets}" var="item" varStatus="i">
            <form action="${pageContext.request.contextPath}/hoa-don/${selectedHoaDonId}/update-note" method="post">
                <div class="mb-3">
                    <label for="ghi_chu" class="form-label">Ghi chú</label>
                    <textarea name="ghi_chu" id="ghi_chu" class="form-control" rows="3">${item.ghi_chu}</textarea>
                </div>
                <button type="submit" class="btn btn-primary">Cập nhật ghi chú</button>
            </form>
            </c:forEach>
            <button id="checkoutBtn">Thanh Toán</button>
            <div class="invoice" id="invoice">
                <h2>Hóa Đơn</h2>
                <p>Sản phẩm: CF chon</p>
                <p>Giá: 200.000 VNĐ</p>
                <p>Tổng: 200.000 VNĐ</p>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Kiểm tra và hiển thị phần thanh toán ban đầu
        toggleCashPaymentSection();

        // Bắt sự kiện khi thay đổi phương thức thanh toán
        document.getElementById("phuongThucThanhToan").addEventListener("change", toggleCashPaymentSection);
    });

    function toggleCashPaymentSection() {
        var paymentMethod = document.getElementById("phuongThucThanhToan").value;
        var cashPaymentSection = document.getElementById("cashPaymentSection");
        var changeSection = document.getElementById("soTienPhaiBu");

        if (paymentMethod === "Tiền mặt") {
            cashPaymentSection.style.display = "block";
            changeSection.style.display = "block";
        } else {
            cashPaymentSection.style.display = "none";
            changeSection.style.display = "none";
        }
    }

    function calculateChange() {
        var tongTien = ${tongTien};
        var soTienKhachDua = document.getElementById("soTienKhachDua").value || 0;
        var soTienPhaiBu = soTienKhachDua - tongTien;

        document.getElementById("soTienPhaiBu").innerText = "Số tiền phải bù lại: " + Math.max(0, soTienPhaiBu) + " VNĐ";
    }

    //show hoa don khi chon thanh toan
        document.getElementById('checkoutBtn').addEventListener('click', function() {
        const invoice = document.getElementById('invoice');
        const overlay = document.getElementById('overlay');

        // Hiện lớp mờ
        overlay.style.display = overlay.style.display === 'block' ? 'none' : 'block';

        // Đợi 0.5 giây để hiển thị hóa đơn
        setTimeout(() => {
        invoice.classList.toggle('show'); // Thay đổi trạng thái hiển thị
    }, 500); // Hiện hóa đơn sau 0.5 giây
    });
</script>
</body>
</html>
