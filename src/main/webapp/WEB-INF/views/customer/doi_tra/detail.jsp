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

                <div class="info-row">
                    <div class="info-box">
                        <h6>Thông Tin Khách Hàng:</h6>
                        <p>Tên Khách Hàng: <strong>${tenKhachHang}</strong></p>
                        <p>Số Điện Thoại: <strong>${hoaDon.soDienThoai}</strong></p>
                        <c:if test="${hoaDon.diaChi != null}">
                        <p>Địa Chỉ: <strong>${hoaDon.diaChi}</strong></p>
                        </c:if>
                    </div>
                    <div class="info-box">
                        <h6>Thông Tin Đơn Hàng:</h6>
                        <p>Phương Thức Thanh Toán: <strong>${hoaDon.phuong_thuc_thanh_toan}</strong></p>
                        <c:if test="${hoaDon.phuongThucVanChuyen != null}">
                        <p>Phương Thức Vận Chuyển: <strong>${hoaDon.phuongThucVanChuyen}</strong></p>
                        </c:if>
                        <c:if test="${hoaDon.phuongThucVanChuyen != null}">
                        <p>Tiền Vận Chuyển: <strong>${tienVanChuyen} đ</strong></p>
                        </c:if>
                        <c:if test="${hoaDon.tongTien != 33000 && hoaDon.tongTien != 20000}">
                            <p>Tổng Tiền: <strong>${hoaDon.tongTien} đ</strong></p>
                        </c:if>
                        <p>Đơn hàng được mua: <strong>${hoaDon.kieuHoaDon==1 ? "Online" :"Tại quầy"}</strong></p>
                        <p>
                            Trạng thái đơn hàng:
                            <c:choose>
                                <c:when test="${hoaDon.tinh_trang == 0}"><strong>Chờ xác nhận</strong></c:when>
                                <c:when test="${hoaDon.tinh_trang == 1}"><strong>Chờ giao</strong></c:when>
                                <c:when test="${hoaDon.tinh_trang == 2 || hoaDon.tinh_trang == 3}"><strong>Đang giao</strong></c:when>
                                <c:when test="${hoaDon.tinh_trang == 4}"><strong>Hoàn thành</strong></c:when>
                                <c:when test="${hoaDon.tinh_trang == 11}"><strong>Chờ xác nhận đổi trả</strong></c:when>
                                <c:when test="${hoaDon.tinh_trang == 12}"><strong>Chờ đổi trả</strong></c:when>
                                <c:when test="${hoaDon.tinh_trang == 13}"><strong>Đã đổi trả</strong></c:when>
                                <c:when test="${hoaDon.tinh_trang == 14}"><strong>Đã hủy</strong></c:when>
                                <c:otherwise><strong>Không xác định</strong></c:otherwise>
                            </c:choose>
                        </p>
                        <c:if test="${hoaDon.tinh_trang >=11 && hoaDon.tinh_trang <14}">
                            <p>Hình thức hoàn trả: <strong>${doiTra.hinhThuc}</strong></p>
                        </c:if>
                    </div>
                </div>

                <!-- Mục xử lý đơn hàng -->
                <div class="info-row">
                    <div class="info-box">
                        <h6>Xử Lý Đơn Hàng:</h6>
                        <c:choose>
                            <c:when test="${hoaDon.kieuHoaDon != 0}">
                        <c:if test="${hoaDon.tinh_trang == 14}">
                            <p><strong>${thoiGianTao}</strong>: Đơn hàng đã được đặt</p>
                            <p><strong>${daHuy}</strong>: Đã hủy đơn hàng</p>
                        </c:if>
                        <c:if test="${hoaDon.tinh_trang != 14}">
                            <c:if test="${hoaDon.tinh_trang >= 0}">
                                <p><strong>${thoiGianTao}</strong>: Đơn hàng đã được đặt</p>
                            </c:if>
                            <c:if test="${hoaDon.tinh_trang >= 1}">
                                <p><strong>${thoiGianXacNhan}</strong>: Đơn hàng đã được xác nhận</p>
                            </c:if>
                            <c:if test="${hoaDon.tinh_trang >= 2}">
                                <p><strong>${banGiaoVanChuyen}</strong>: Đơn hàng đã được bàn giao cho đơn vị vận chuyển</p>
                                <p>Thời gian nhận hàng dự kiến: <strong>${thoiGianDuKien}</strong></p>
                            </c:if>
                            <c:if test="${hoaDon.tinh_trang >= 4}">
                                <p><strong>${hoanThanh}</strong>: Đơn hàng đã được giao thành công</p>
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
                            </c:when>
                            <c:otherwise>
                                <p>Hóa đơn được mua tại quầy vào lúc: ${hoaDon.thoiGianTaoFormatted}</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <c:if test="${not empty hoaDon.hoaDonChiTietList}">
                    <h6>Sản phẩm trong hóa đơn:</h6>
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
                                <div>
                                    <c:choose>
                                        <c:when test="${chiTiet.gia_san_pham != chiTiet.sanPhamChiTiet.giaBan}">
                            <span style="text-decoration: line-through; color: gray;">
                                ${chiTiet.sanPhamChiTiet.giaBan} VNĐ
                            </span>
                                            <br>
                                            <span style="color: green;">
                                ${chiTiet.gia_san_pham} VNĐ
                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span>${chiTiet.gia_san_pham} VNĐ</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <span>Số Lượng: ${chiTiet.so_luong}</span>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${hoaDon.tinh_trang == 11 || hoaDon.tinh_trang == 12}">
                    <h6 class="mt-3">Sản phẩm muốn đổi trả:</h6>
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
                                <div>
                                    <c:choose>
                                        <c:when test="${doiTraChiTiet.giaSanPham != doiTraChiTiet.sanPhamChiTiet.giaBan}">
                                <span style="text-decoration: line-through; color: gray;">
                                    ${doiTraChiTiet.sanPhamChiTiet.giaBan} VNĐ
                                </span>
                                            <br>
                                            <span style="color: green;">
                                    ${doiTraChiTiet.giaSanPham} VNĐ
                                </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span>${doiTraChiTiet.giaSanPham} VNĐ</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <span>Số Lượng: ${doiTraChiTiet.soLuong}</span>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${hoaDon.tinh_trang == 13}">
                    <h6 class="mt-3">Sản phẩm đã đổi trả:</h6>
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
                                <div>
                                    <c:choose>
                                        <c:when test="${doiTraChiTiet.giaSanPham != doiTraChiTiet.sanPhamChiTiet.giaBan}">
                                <span style="text-decoration: line-through; color: gray;">
                                    ${doiTraChiTiet.sanPhamChiTiet.giaBan} VNĐ
                                </span>
                                            <br>
                                            <span style="color: green;">
                                    ${doiTraChiTiet.giaSanPham} VNĐ
                                </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span>${doiTraChiTiet.giaSanPham} VNĐ</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <span>Số Lượng: ${doiTraChiTiet.soLuong}</span>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
                <div class="d-inline-flex mt-3 gap-2">
                    <a href="/doi-tra" class="btn btn-warning">Quay Lại</a>
                    <c:if test="${hoaDon.tinh_trang == 4 && hoaDon.kieuHoaDon == 1}">
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#returnModal">Đổi Trả</button>
                    </c:if>
                    <c:if test="${hoaDon.tinh_trang == 0}">
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
