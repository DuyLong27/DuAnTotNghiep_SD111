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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css">
    <script src="https://unpkg.com/html5-qrcode" type="text/javascript">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
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
        /* Tạo hộp thông báo */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #4CAF50; /* Màu xanh thành công */
            color: white;
            padding: 16px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            display: none; /* Ẩn mặc định */
        }

        .notification.error {
            background-color: #f44336; /* Màu đỏ lỗi */
        }

        .notification.show {
            display: block; /* Hiển thị khi cần */
            animation: fadeInOut 3s; /* Hiệu ứng hiển thị */
        }

        @keyframes fadeInOut {
            0% { opacity: 0; }
            10% { opacity: 1; }
            90% { opacity: 1; }
            100% { opacity: 0; }
        }
    </style>
    <!-- Thêm SweetAlert2 -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>Bán Hàng</title>
</head>
<body>
<jsp:include page="../layout.jsp" />
<div class="container mt-3">
    <div id="notification" class="notification"></div>

    <h2>Trang Bán Hàng</h2>
    <br>
            <div class="mt-1">
                <div class="row">
                    <div class="col-md-6 filter-section">
                        <div class="d-flex align-items-center mb-3">
                            <form action="/ban-hang/addHoaDon" method="post" class="me-2">
                                <button class="btn btn-create">Tạo hóa đơn mới</button>
                            </form>
                            <div class="form-group me-2">
                                <label for="hoaDonSelect" class="visually-hidden">Chọn Hóa Đơn:</label>
                                <select id="hoaDonSelect" class="form-select" onchange="location = this.value;">
                                    <option value="">-- Chọn Hóa Đơn --</option>
                                    <c:forEach items="${hoaDonList}" var="hoaDon">
                                        <c:if test="${hoaDon.tinh_trang == 0}">
                                            <option value="${pageContext.request.contextPath}/ban-hang/${hoaDon.id}"
                                                    <c:if test="${hoaDon.id == selectedHoaDonId}">selected</c:if>>
                                                    ${hoaDon.soHoaDon}
                                            </option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <c:if test="${not empty selectedHoaDonId}">
                                <form action="/ban-hang/${selectedHoaDonId}/delete" method="post" class="me-2">
                                    <button class="btn btn-secondary-outline" onclick="return confirm('Bạn có chắc chắn muốn xóa hóa đơn này?');">Xóa</button>
                                </form>
                            </c:if>
                        </div>

                        <c:if test="${not empty selectedHoaDonId}">
                            <h3 class="text-primary">Hóa Đơn ID: ${selectedHoaDonId}</h3>
                            <button onclick="startQrCodeScanner()">Quét QR</button>
                            <div id="reader" style="width: 500px; margin-top: 20px;"></div>
                            <input type="hidden" id="hoaDonId" value="${selectedHoaDonId}">
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
                                    <tr type="hidden" id="hoaDonId" value="${selectedHoaDonId}">
                                        <td>${i.index + 1}</td>
                                        <td>${item.sanPhamChiTiet.sanPham.ten}</td>
                                        <td>${item.sanPhamChiTiet.giaBan}</td>
                                        <td>${item.so_luong}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/ban-hang/${selectedHoaDonId}/remove-product/${item.sanPhamChiTiet.id}" method="post" style="display:inline-block;">
                                                <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <!-- Tính tổng tiền dựa trên giá bán của SanPhamChiTiet -->
                                    <c:set var="tongTien" value="${tongTien + (item.so_luong * item.sanPhamChiTiet.giaBan)}" />
                                </c:forEach>

                                </tbody>
                            </table>

                            <h5>Tổng tiền: ${tongTien}</h5> <!-- Hiển thị tổng tiền -->

                            <form id="paymentMethodForm" action="${pageContext.request.contextPath}/ban-hang/${selectedHoaDonId}/update-all-payment-method" method="post" class="mb-3">
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
                                <input type="number" id="soTienKhachDua" class="form-control" oninput="calculateChange()" />
                            </div>
                            <h4 class="text-danger" id="soTienPhaiBu" style="display: none;">Số tiền phải bù lại: 0 VNĐ</h4>
                        </c:if>
                        <c:if test="${not empty selectedHoaDonId}">
                            <h4 class="mt-4">Ghi chú</h4>
                            <form id="noteForm" action="${pageContext.request.contextPath}/ban-hang/${selectedHoaDonId}/confirm" method="post">
                                <div class="form-group">
                                    <textarea name="ghiChu" class="form-control" rows="3">${hoaDon.ghiChu}</textarea>
                                </div>
                                <button type="submit" class="btn btn-create mt-2">Xác nhận hóa đơn</button>
                            </form>
                        </c:if>
                    </div>
                    <div class="col-md-6">
                        <c:if test="${not empty selectedHoaDonId}">
                            <div class="row">
                                <c:forEach items="${sanPhams}" var="sanPham">
                                    <div class="col-md-4 mb-3">
                                        <div class="card" style="border-radius: 20px">
                                            <div class="card-body text-center">
                                                <img style="width: 90px" height="70px" src="${pageContext.request.contextPath}/uploads/${sanPham.hinhAnh}">
                                                <h5 class="card-title">${sanPham.sanPham.ten}</h5>
                                                <p class="card-text">Giá: ${sanPham.giaBan} VNĐ</p>
                                                <p class="card-text">Số Lượng: ${sanPham.soLuong}</p>
                                                <form action="${pageContext.request.contextPath}/ban-hang/${selectedHoaDonId}/add-product" method="post">
                                                    <input type="hidden" name="sanPhamId" value="${sanPham.id}" />
                                                    <button type="submit" class="btn btn-outline-custom">
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
                </div>
    </div>
</div>



</body>
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

    function startQrCodeScanner() {
        const qrCodeReader = new Html5Qrcode("reader");

        qrCodeReader.start(
            { facingMode: "environment" },
            {
                fps: 10,
                qrbox: 250
            },
            async (decodedText) => {
                console.log("Decoded QR content:", decodedText);

                try {
                    const qrData = JSON.parse(decodedText);

                    // Kiểm tra dữ liệu QR
                    if (qrData.sanPhamId && qrData.sanPhamTen && qrData.giaBan) {
                        const hoaDonIdElement = document.getElementById("hoaDonId");

                        // Kiểm tra sự tồn tại của ID hóa đơn
                        if (!hoaDonIdElement) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Lỗi!',
                                text: 'Không tìm thấy ID hóa đơn!'
                            });
                            return;
                        }

                        const selectedHoaDonId = hoaDonIdElement.value;

                        // Kiểm tra giá trị hợp lệ
                        if (!selectedHoaDonId) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Lỗi!',
                                text: 'Hóa đơn không hợp lệ!'
                            });
                            return;
                        }

                        // Gửi yêu cầu POST để thêm sản phẩm
                        const response = await fetch(`/ban-hang/${selectedHoaDonId}/add-product`, {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/x-www-form-urlencoded",
                            },
                            body: new URLSearchParams({
                                hoaDonId: selectedHoaDonId, // Sử dụng selectedHoaDonId đúng
                                sanPhamId: qrData.sanPhamId
                            })
                        });

                        // Xử lý kết quả trả về
                        if (response.ok) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Thành công!',
                                text: 'Sản phẩm đã được thêm vào hóa đơn.'
                            }).then(() => {
                                // Sau khi nhấn OK, tải lại trang
                                window.location.reload();
                            });
                            qrCodeReader.stop(); // Dừng scanner
                        } else {
                            const errorData = await response.json();
                            Swal.fire({
                                icon: 'error',
                                title: 'Lỗi!',
                                text: errorData.message || 'Không thể thêm sản phẩm. Vui lòng thử lại.'
                            });
                        }
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Lỗi!',
                            text: 'Dữ liệu QR không hợp lệ!'
                        });
                    }
                } catch (error) {
                    console.error("QR scan failed:", error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Lỗi!',
                        text: 'Không thể đọc dữ liệu QR.'
                    });
                }
            },
            (errorMessage) => {
                console.log("QR scan failed:", errorMessage);
            }
        );
    }


    function showNotification(message, type = "success") {
        const notification = document.getElementById("notification");
        notification.textContent = message;
        notification.className = `notification ${type} show`;

        setTimeout(() => {
            notification.className = "notification"; // Ẩn sau 3 giây
        }, 3000);
    }

</script>
</html>
