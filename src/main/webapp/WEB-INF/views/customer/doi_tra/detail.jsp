<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Hóa Đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .info-box {
            flex: 1;
            padding: 10px;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            background-color: #f8f9fa;
        }
        .custom-option {
            padding: 15px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-top: 10px;
            background-color: #f8f9fa;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .custom-option:hover {
            background-color: #e9ecef;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .custom-option.selected {
            background-color: #d1e7dd;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border: 1px solid #0d6efd;
        }
        .form-check-label {
            margin-left: 10px;
            font-weight: 500;
            color: #495057;
        }
    </style>
</head>
<body>
<jsp:include page="../header_user.jsp"/>
<div class="container mb-3">
    <h2 class="text-center my-4">Chi Tiết Hóa Đơn</h2>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center">${errorMessage}</div>
    </c:if>

    <c:if test="${not empty hoaDon}">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Mã Hóa Đơn: ${hoaDon.soHoaDon}</h5>
                <p>Ngày Tạo: ${hoaDon.ngayTao}</p>

                <div class="info-row">
                    <div class="info-box">
                        <h6>Thông Tin Khách Hàng:</h6>
                        <p>Tên Khách Hàng: ${tenKhachHang}</p>
                        <p>Số Điện Thoại: ${hoaDon.soDienThoai}</p>
                        <p>Địa Chỉ: ${hoaDon.diaChi}</p>
                    </div>
                    <div class="info-box">
                        <h6>Thông Tin Đơn Hàng:</h6>
                        <p>Phương Thức Thanh Toán: <strong>${hoaDon.phuong_thuc_thanh_toan}</strong></p>
                        <p>Phương Thức Vận Chuyển: <strong>${hoaDon.phuongThucVanChuyen}</strong></p>
                        <p>Tiền Vận Chuyển: <strong>${tienVanChuyen} đ</strong></p>
                        <p>Tổng Tiền: <strong>${hoaDon.tongTien} đ</strong></p>
                        <p>
                            Tình Trạng:
                            <c:choose>
                                <c:when test="${hoaDon.tinh_trang == 0}">
                                    Chờ xác nhận
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 1 }">
                                    Chờ giao
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 2 || hoaDon.tinh_trang == 3}">
                                    Đang giao
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 4}">
                                    Hoàn thành
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 11}">
                                    Chờ xác nhận đổi trả
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 12}">
                                    Chờ đổi trả
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 13}">
                                    Đã đổi trả
                                </c:when>
                                <c:when test="${hoaDon.tinh_trang == 14}">
                                    Đã hủy
                                </c:when>
                                <c:otherwise>
                                    Không xác định
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>

                <h6>Danh Sách Sản Phẩm:</h6>
                <ul class="list-group">
                    <c:forEach var="chiTiet" items="${hoaDon.hoaDonChiTietList}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/uploads/${chiTiet.sanPhamChiTiet.hinhAnh}"
                                     alt="Hình ảnh sản phẩm" class="me-3" style="width: 100px; height: auto;">
                                <div>
                                    <span>${chiTiet.sanPhamChiTiet.sanPham.ten}</span>
                                </div>
                            </div>
                            <span>Số Lượng: ${chiTiet.so_luong}</span>
                        </li>
                    </c:forEach>
                </ul>
                <c:if test="${hoaDon.tinh_trang == 13}">
                    <h6 class="mt-3">Sản phẩm đổi trả:</h6>
                    <ul class="list-group mt-3 ">
                        <c:forEach var="doiTraChiTiet" items="${doiTraChiTiets}">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <img src="${pageContext.request.contextPath}/uploads/${doiTraChiTiet.sanPhamChiTiet.hinhAnh}"
                                         alt="Hình ảnh sản phẩm" class="me-3" style="width: 100px; height: auto;">
                                    <div>
                                        <span>${doiTraChiTiet.sanPhamChiTiet.sanPham.ten}</span>
                                    </div>
                                </div>
                                <span>Số Lượng: ${doiTraChiTiet.soLuong}</span>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
                <div class="d-inline-flex mt-3 gap-2">
                    <a href="/doi-tra" class="btn btn-warning">Quay Lại</a>
                    <c:if test="${hoaDon.tinh_trang == 4}">
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#returnModal">Đổi Trả</button>
                    </c:if>
                    <c:if test="${hoaDon.tinh_trang <= 1}">
                        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmCancelModal">Hủy đơn</button>

                        <div class="modal fade" id="confirmCancelModal" tabindex="-1" aria-labelledby="confirmCancelModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="confirmCancelModalLabel">Xác nhận hủy đơn</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        Bạn có chắc chắn muốn hủy đơn này không?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                        <form action="/doi-tra/huy-don/${hoaDon.id}" method="post">
                                            <button type="submit" class="btn btn-danger">Xác nhận hủy</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </c:if>
</div>

<!-- Modal cho tùy chọn đổi trả -->
<div class="modal fade" id="returnModal" tabindex="-1" aria-labelledby="returnModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success bg-gradient">
                <h5 class="modal-title text-white" id="returnModalLabel">Lý Do Đổi Trả</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <label class="form-label">Chọn lý do đổi trả:</label>

                <!-- Form ẩn để gửi lý do đổi trả -->
                <form id="returnForm" action="/doi-tra/luu-ly-do-doi-tra" method="POST">
                    <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                    <input type="hidden" id="lyDo" name="lyDo" value="">

                    <!-- Tùy chọn nút radio được ẩn -->
                    <div class="form-check custom-option" onclick="submitReason('Hàng đã giao và đã thanh toán nhưng sản phẩm có vấn đề')">
                        <label class="form-check-label">
                            Hàng đã giao và đã thanh toán nhưng sản phẩm có vấn đề
                        </label>
                    </div>
                    <div class="form-check custom-option" onclick="submitReason('Tôi chưa nhận được hàng hoặc nhận thiếu hàng')">
                        <label class="form-check-label">
                            Tôi chưa nhận được hàng hoặc nhận thiếu hàng
                        </label>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../footer_user.jsp"/>
<script>
    function selectOption(selectedId) {
        // Bỏ chọn tất cả các tùy chọn trước khi chọn cái mới
        document.querySelectorAll('.custom-option').forEach(option => {
            option.classList.remove('selected');
        });

        // Đánh dấu tùy chọn được chọn
        document.getElementById(selectedId).checked = true;
        document.querySelector(`label[for=${selectedId}]`).parentElement.classList.add('selected');
    }

    function submitReason(reason) {
        document.getElementById('lyDo').value = reason;
        document.getElementById('returnForm').submit();
    }
</script>
</body>
</html>
