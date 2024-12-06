<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chọn Sản Phẩm Đổi Trả</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa; /* Màu nền nhạt */
            font-family: Arial, sans-serif; /* Phông chữ hiện đại */
        }
        .card {
            border: none; /* Bỏ viền thẻ card */
            border-radius: 10px; /* Bo tròn góc thẻ */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng cho thẻ */
            margin-bottom: 20px; /* Khoảng cách giữa các thẻ */
        }
        .custom-checkbox {
            display: flex;
            align-items: center;
            margin-bottom: 1rem; /* Tăng khoảng cách giữa các checkbox */
        }
        .custom-checkbox input[type="checkbox"] {
            width: 25px;  /* Đặt kích thước checkbox lớn hơn */
            height: 25px; /* Đặt chiều cao checkbox lớn hơn */
            margin-right: 10px; /* Khoảng cách giữa checkbox và nhãn */
        }
        .select-all {
            margin-bottom: 1rem; /* Khoảng cách cho checkbox chọn tất cả */
        }
        .product-image {
            width: 100px;
            height: auto;
            border-radius: 5px; /* Bo tròn hình ảnh sản phẩm */
            border: 1px solid #dee2e6; /* Viền cho hình ảnh */
        }
        .btn-primary {
            background-color: #007bff; /* Màu nút chính */
            border: none; /* Bỏ viền nút */
        }
        .btn-primary:hover {
            background-color: #0056b3; /* Màu nút khi hover */
        }
        .btn-warning {
            background-color: #ffc107; /* Màu nút quay lại */
            border: none; /* Bỏ viền nút */
        }
        .btn-warning:hover {
            background-color: #e0a800; /* Màu nút khi hover */
        }
    </style>
</head>
<body>
<jsp:include page="../header_user.jsp"/>
<div class="container my-4">
    <h2 class="text-center">Chọn Sản Phẩm Đổi Trả</h2>
    <c:if test="${not empty hoaDon}">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Mã Hóa Đơn: ${hoaDon.soHoaDon}</h5>
                <p>Ngày Tạo: ${hoaDon.ngayTao}</p>
                <p>Lý Do Đổi Trả: ${lyDo}</p>
                <form id="reasonForm" action="/doi-tra/luu-thong-tin" method="post">
                    <input type="hidden" name="hoaDonId" value="${hoaDon.id}"/>
                    <input type="hidden" name="lyDoDetail" id="lyDoDetail" value=""/>
                    <input type="hidden" name="lyDo" value="${lyDo}"/>
                    <h6>Danh Sách Sản Phẩm:</h6>
                    <div class="custom-checkbox select-all">
                        <input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)">
                        <label for="selectAll">Chọn Tất Cả</label>
                    </div>
                    <ul class="list-group">
                        <c:forEach var="chiTiet" items="${hoaDon.hoaDonChiTietList}">
                            <li class="list-group-item d-flex align-items-center">
                                <div class="custom-checkbox me-3">
                                    <input type="checkbox" name="sanPhamChiTietIds" value="${chiTiet.sanPhamChiTiet.id}" id="checkbox_${chiTiet.sanPhamChiTiet.id}" class="me-2">
                                    <label for="checkbox_${chiTiet.sanPhamChiTiet.id}"></label>
                                </div>
                                <img src="${pageContext.request.contextPath}/uploads/${chiTiet.sanPhamChiTiet.hinhAnh}"
                                     alt="Hình ảnh sản phẩm" class="product-image me-3">
                                <span>${chiTiet.sanPhamChiTiet.sanPham.ten}</span>
                                <div class="ms-auto">
                                    <label for="soLuong_${chiTiet.sanPhamChiTiet.id}">Số Lượng:</label>
                                    <input type="number" name="soLuong_${chiTiet.sanPhamChiTiet.id}"
                                           id="soLuong_${chiTiet.sanPhamChiTiet.id}"
                                           min="1" max="${chiTiet.so_luong}"
                                           class="form-control" style="width: 80px;"
                                           value="1">
                                </div>
                            </li>
                        </c:forEach>
                    </ul>

                    <div class="mt-3">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="loaiDichVu" id="doiHang" value="DoiHang" required>
                            <label class="form-check-label" for="doiHang">Đổi hàng</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="loaiDichVu" id="traHang" value="TraHang" required>
                            <label class="form-check-label" for="traHang">Trả hàng</label>
                        </div>
                    </div>


                    <div class="mt-3">
                        <a href="/doi-tra/chi-tiet?id=${hoaDon.id}" class="btn btn-warning">Quay Lại</a>
                        <button type="button" class="btn btn-success" onclick="showReasonModal(event)">Tiếp Tục</button>
                    </div>
                </form>
            </div>
        </div>
    </c:if>
</div>

<!-- Modal for selecting reason -->
<div class="modal fade" id="reasonModal" tabindex="-1" aria-labelledby="reasonModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success bg-gradient">
                <h5 class="modal-title text-white" id="reasonModalLabel">Chọn Lý Do Đổi Trả</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="reason" id="reason1" value="Sản phẩm bị hư hỏng hoặc lỗi">
                    <label class="form-check-label" for="reason1">Sản phẩm bị hư hỏng hoặc lỗi</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="reason" id="reason2" value="Hàng quá hạn sử dụng">
                    <label class="form-check-label" for="reason2">Hàng quá hạn sử dụng</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="reason" id="reason3" value="Sản phẩm không đúng như mô tả">
                    <label class="form-check-label" for="reason3">Sản phẩm không đúng như mô tả</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="reason" id="reason4" value="Nhầm lẫn khi đặt hàng">
                    <label class="form-check-label" for="reason3">Nhầm lẫn khi đặt hàng</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="reason" id="reason5" value="Chương trình khuyến mãi hoặc bảo hành">
                    <label class="form-check-label" for="reason3">Chương trình khuyến mãi hoặc bảo hành</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="reason" id="reason6" value="Chất lượng không đạt yêu cầu">
                    <label class="form-check-label" for="reason3">Chất lượng không đạt yêu cầu</label>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" onclick="confirmReason()">Xác Nhận</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../footer_user.jsp"/>
<script>
    function toggleSelectAll(source) {
        const checkboxes = document.querySelectorAll('input[name="sanPhamChiTietIds"]');
        checkboxes.forEach((checkbox) => {
            checkbox.checked = source.checked;
        });
    }
    function showReasonModal(event) {
        event.preventDefault();
        const selectedOption = document.querySelector('input[name="loaiDichVu"]:checked');
        if (!selectedOption) {
            alert("Vui lòng chọn loại dịch vụ!");
            return;
        }

        const loaiDichVu = selectedOption.value;
        if (loaiDichVu === "TraHang") {
            const modal = new bootstrap.Modal(document.getElementById('reasonModal'));
            modal.show();
        } else if (loaiDichVu === "DoiHang") {
            const modal = new bootstrap.Modal(document.getElementById('reasonModal'));
            modal.show();
        }
    }

    function confirmReason() {

        const selectedReason = document.querySelector('input[name="reason"]:checked');
        if (selectedReason) {
            document.getElementById('lyDoDetail').value = selectedReason.value;
            document.getElementById('reasonForm').submit(); // Submit form
        } else {
            alert('Vui lòng chọn lý do!');
        }

        const selectedOption = document.querySelector('input[name="loaiDichVu"]:checked');
        if (!selectedOption) {
            alert("Vui lòng chọn loại dịch vụ!");
            return;
        }

        const loaiDichVu = selectedOption.value;

        if (loaiDichVu === "TraHang") {
            // Hiển thị modal chọn lý do trả hàng
            document.getElementById("reasonForm").action = "/doi-tra/luu-thong-tin";
            document.getElementById("reasonForm").submit();
        } else if (loaiDichVu === "DoiHang") {
            // Gửi form đổi hàng trực tiếp
            document.getElementById("reasonForm").action = "/doi-tra/luu-thong-tin-doi-hang";
            document.getElementById("reasonForm").submit();
        }
    }


    function handleContinue() {
        const selectedOption = document.querySelector('input[name="loaiDichVu"]:checked');
        if (!selectedOption) {
            alert("Vui lòng chọn loại dịch vụ!");
            return;
        }

        const loaiDichVu = selectedOption.value;

        if (loaiDichVu === "TraHang") {
            const formData = new FormData();
            formData.append("hoaDonId", hoaDonId);  // Lấy hoaDonId từ đâu đó
            formData.append("lyDo", lyDo);          // Tương tự cho lý do

            // Gửi yêu cầu POST cho phần "TraHang"
            fetch('/doi-tra/luu-thong-tin', {
                method: 'POST',
                body: formData
            }).then(response => {
                if (response.ok) {
                    window.location.href = response.url; // Chuyển hướng đến URL trả về
                } else {
                    alert("Có lỗi xảy ra khi gửi yêu cầu đổi trả!");
                }
            }).catch(error => console.error("Error:", error));

        } else if (loaiDichVu === "DoiHang") {
            const formData = new FormData();
            formData.append("hoaDonId", hoaDonId);  // Lấy hoaDonId từ đâu đó
            formData.append("lyDo", lyDo);          // Tương tự cho lý do

            // Gửi yêu cầu POST cho phần "DoiHang"
            fetch('/doi-tra/doi-hang', {
                method: 'POST',  // Đảm bảo sử dụng phương thức POST
                body: formData  // Dữ liệu được gửi qua POST
            }).then(response => {
                if (response.ok) {
                    window.location.href = response.url;
                } else {
                    alert("Có lỗi xảy ra khi gửi yêu cầu đổi hàng!");
                }
            }).catch(error => console.error("Error:", error));
        }
    }

</script>
</body>
</html>
