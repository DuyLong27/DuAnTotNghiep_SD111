<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Khuyến Mãi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .modal-content {
            border-radius: 10px;
        }
        .info-box {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .info-box h5 {
            color: #007bff;
            font-size: 1.2rem;
        }
        .info-box p {
            font-size: 1rem;
            color: #333;
        }
        .info-box span {
            font-weight: bold;
        }
        .select-wrapper {
            border-radius: 10px;
            border: 1px solid #007bff;
            padding: 10px;
            background-color: #f1f1f1;
            margin-bottom: 20px;
        }
        .select-wrapper select {
            background-color: transparent;
            border: none;
            font-size: 1.1rem;
            width: 100%;
        }
        .card-wrapper {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            justify-content: center;
        }

        .card-item {
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .card {
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background-color: white;
            min-height: 300px;
            height: 100%;
        }

        .card-body {
            padding: 15px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
            justify-content: space-between;
            text-align: center;
            min-height: 250px;
        }

        .card-title {
            font-size: 1.1rem;
            color: #007bff;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .card-text {
            font-size: 1rem;
            margin-bottom: 15px;
            color: #333;
        }

        .card-price {
            font-weight: bold;
            color: #28a745;
        }

        .card-quantity {
            font-size: 0.9rem;
            color: #6c757d;
        }

        .card-img {
            max-height: 180px;
            object-fit: cover;
            margin-bottom: 15px;
            border-radius: 8px;
            width: 100%;
        }

        .card-btn {
            padding: 5px 10px;
            font-size: 1rem;
            text-transform: uppercase;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 50%;
            transition: background-color 0.3s;
            align-self: center;
            margin-top: auto;
        }

        .card-btn:hover {
            background-color: #0056b3;
        }

        .card-btn i {
            font-size: 1.2rem;
        }

        /* Hiệu ứng hover cho thông tin khuyến mãi */
        .khuyen-mai-info {
            position: relative;
            padding: 10px;
            border: 1px solid #e5e5e5;
            border-radius: 5px;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .khuyen-mai-info:hover {
            background-color: #f0faff; /* Tông màu nhẹ nhàng */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Shadow mềm */
            cursor: pointer;
        }

        /* Dropdown container */
        .product-info-dropdown {
            display: none; /* Ẩn mặc định */
            position: absolute;
            top: calc(100% + 10px); /* Hiển thị ngay dưới cell */
            left: 0;
            width: 250px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 15px;
            z-index: 1000;
            opacity: 0;
            transform: translateY(-10px); /* Hiệu ứng ẩn */
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        /* Hiển thị dropdown khi hover hoặc khi có lớp active */
        .khuyen-mai-info:hover .product-info-dropdown,
        .khuyen-mai-info.active .product-info-dropdown {
            display: block;
            opacity: 1;
            transform: translateY(0);
        }

        /* Dropdown tiêu đề */
        .dropdown-title {
            margin-bottom: 10px;
            font-size: 16px;
            font-weight: 600;
            color: #333;
            border-bottom: 1px solid #e5e5e5;
            padding-bottom: 5px;
        }

        /* Danh sách sản phẩm */
        .dropdown-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        /* Sản phẩm item */
        .dropdown-item {
            padding: 8px 10px;
            font-size: 14px;
            color: #555;
            transition: background-color 0.3s ease, color 0.3s ease;
            border-radius: 3px;
        }

        .dropdown-item:hover {
            background-color: #f9f9f9;
            color: #007bff;
        }

        /* Nút X đẹp hơn */
        .delete-link {
            margin-left: 10px;
            color: red;
            cursor: pointer;
            font-size: 16px;
        }

        .delete-link:hover {
            color: #dc3545;
        }


        .delete-link {
            margin-left: 10px;
            font-weight: bold;
            font-size: 16px;
            text-decoration: none;
            padding: 2px 6px;
            border-radius: 50%;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .delete-link:hover {
            background-color: #dc3545;
            color: white !important;
        }


        .delete-link:focus {
            outline: none;
        }

        /* Ẩn mũi tên của input */
        input[type="number"]::-webkit-outer-spin-button,
        input[type="number"]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* Ẩn mũi tên trong Firefox */
        input[type="number"] {
            -moz-appearance: textfield;
        }



    </style>
</head>
<body>
<jsp:include page="../layout.jsp" />

<div class="container mt-4">
    <form method="get" action="/khuyen-mai/chi-tiet">
        <div class="row mb-4 d-flex align-items-center">
            <div class="col-md-3">
                <input type="text" class="form-control" placeholder="Tìm kiếm theo tên khuyến mãi" name="tenKhuyenMai" value="${tenKhuyenMai}">
            </div>
            <div class="col-md-3">
                <input type="number" class="form-control" placeholder="Giá trị khuyến mãi từ" name="giaTriFrom" value="${giaTriFrom}">
            </div>
            <div class="col-md-3">
                <input type="number" class="form-control" placeholder="Giá trị khuyến mãi đến" name="giaTriTo" value="${giaTriTo}">
            </div>
            <div class="col-md-3 d-flex justify-content-between">
                <button type="submit" class="btn btn-primary" hidden="">Lọc</button>
            </div>
        </div>
    </form>

    <!-- Nút áp dụng -->
    <div class="text-start mt-4">
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#applyModal">
            Áp dụng
        </button>
        <a href="/khuyen-mai/chi-tiet" class="btn btn-secondary-outline">Reset</a>
    </div>



    <!-- Bảng hiển thị khuyến mãi chi tiết -->
    <div class="mt-4">
        <table class="table table-bordered table-striped mt-3">
            <thead>
            <tr>
                <th scope="col">STT</th>
                <th scope="col">Khuyến mãi</th>
                <th scope="col">Giá trị khuyến mãi</th>
                <th scope="col">Ngày bắt đầu</th>
                <th scope="col">Ngày kết thúc</th>
                <th scope="col">Số lượng sản phẩm áp dụng</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listKhuyenMai}" var="km" varStatus="i">
                <tr>
                    <td>${i.index + 1}</td>
                    <td>${km.tenKhuyenMai}</td>
                    <td>${km.giaTriKhuyenMai} %</td>
                    <td>${km.ngayBatDau}</td>
                    <td>${km.ngayKetThuc}</td>
                    <td class="khuyen-mai-info">
                        <c:out value="${khuyenMaiCounts[km.idKhuyenMai]}" />
                        <div class="product-info-dropdown">
                            <h5 class="dropdown-title">Sản phẩm áp dụng:</h5>
                            <ul class="dropdown-list">
                                <c:forEach items="${listKhuyenMaiChiTiet}" var="kmct">
                                    <c:if test="${kmct.khuyenMai.idKhuyenMai == km.idKhuyenMai}">
                                        <li class="dropdown-item">
                                                ${kmct.sanPhamChiTiet.sanPham.ten}
                                            <!-- Nút X với lớp 'delete-link' -->
                                            <a href="#" class="text-danger delete-link" onclick="deleteProductFromPromotion(${kmct.id})">X</a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </td>




                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>


    <!-- Modal -->
    <div class="modal fade" id="applyModal" tabindex="-1" aria-labelledby="applyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="applyModalLabel">Chọn Khuyến Mãi và Sản Phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form method="post" action="/khuyen-mai/apply">
                    <div class="modal-body">
                        <div class="row">
                            <!-- Danh sách khuyến mãi -->
                            <div class="col-md-12 mb-1">
                                <h5>Chọn Khuyến Mãi</h5>
                                <div class="select-wrapper">
                                    <input type="hidden" id="selectedProducts" name="sanPhamChiTietIds">
                                    <select class="form-select" id="khuyenMaiSelect" name="khuyenMaiId" required>
                                        <option value="" selected disabled>Chọn khuyến mãi</option>
                                        <c:forEach items="${listKhuyenMai}" var="km">
                                            <option value="${km.idKhuyenMai}"
                                                    data-ten="${km.tenKhuyenMai}"
                                                    data-gia-tri="${km.giaTriKhuyenMai}%"
                                                    data-ngay-bat-dau="${km.ngayBatDau}"
                                                    data-ngay-ket-thuc="${km.ngayKetThuc}">
                                                    ${km.tenKhuyenMai}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <!-- Hiển thị thông tin khuyến mãi -->
                            <div class="col-md-12" id="khuyenMaiInfo" style="display: none;">
                                <div class="info-box">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <p>Tên Khuyến Mãi:</p>
                                            <span id="tenKhuyenMai"></span>
                                        </div>
                                        <div class="col-md-3">
                                            <p>Giá Trị Khuyến Mãi:</p>
                                            <span id="giaTriKhuyenMai"></span>
                                        </div>
                                        <div class="col-md-3">
                                            <p>Ngày Bắt Đầu:</p>
                                            <span id="ngayBatDau"></span>
                                        </div>
                                        <div class="col-md-3">
                                            <p>Ngày Kết Thúc:</p>
                                            <span id="ngayKetThuc"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <!-- Danh sách sản phẩm chi tiết -->
                            <div class="col-md-12">
                                <div class="card-wrapper">
                                    <c:forEach items="${listSanPhamChiTiet}" var="sp">
                                        <c:set var="isApplied" value="false"/>
                                        <c:forEach items="${listKhuyenMaiChiTiet}" var="kmct">
                                            <c:if test="${kmct.sanPhamChiTiet.id == sp.id}">
                                                <c:set var="isApplied" value="true"/>
                                            </c:if>
                                        </c:forEach>

                                        <!-- Hiển thị sản phẩm chỉ khi chưa có khuyến mãi -->
                                        <c:if test="${isApplied == false}">
                                            <div class="card-item" data-product-id="${sp.id}">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <c:if test="${sp.hinhAnh != null}">
                                                            <img src="${pageContext.request.contextPath}/uploads/${sp.hinhAnh}" class="card-img" />
                                                        </c:if>
                                                        <h5 class="card-title">${sp.sanPham.ten}</h5>
                                                        <p class="card-text">Giá: ${sp.giaBan} VND</p>
                                                        <button type="button" class="card-btn toggle-button">
                                                            <i class="bi bi-plus"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Xử lý khi chọn khuyến mãi
        $('#khuyenMaiSelect').change(function() {
            const selectedOption = $(this).find('option:selected');
            $('#khuyenMaiInfo').show();
            $('#tenKhuyenMai').text(selectedOption.data('ten'));
            $('#giaTriKhuyenMai').text(selectedOption.data('gia-tri'));
            $('#ngayBatDau').text(selectedOption.data('ngay-bat-dau'));
            $('#ngayKetThuc').text(selectedOption.data('ngay-ket-thuc'));
        });

        // Sự kiện khi nhấn nút cộng hoặc dấu kiểm
        $('.toggle-button').click(function() {
            const icon = $(this).find('i');
            const productId = $(this).closest('.card-item').data('product-id');
            let selectedProducts = $('#selectedProducts').val() ? $('#selectedProducts').val().split(',') : [];

            // Kiểm tra nếu sản phẩm đã được chọn rồi
            if (icon.hasClass('bi-plus')) {
                if (!selectedProducts.includes(String(productId))) {  // Chỉ thêm nếu chưa có
                    icon.removeClass('bi-plus').addClass('bi-check');
                    selectedProducts.push(productId);
                }
            } else {
                icon.removeClass('bi-check').addClass('bi-plus');
                selectedProducts = selectedProducts.filter(id => id !== String(productId));  // Xóa khỏi danh sách
            }

            // Cập nhật lại giá trị của input hidden
            $('#selectedProducts').val(selectedProducts.join(','));
        });

        // Tự động chọn khuyến mãi từ URL
        const urlParams = new URLSearchParams(window.location.search);
        const khuyenMaiId = urlParams.get('id');
        if (khuyenMaiId) {
            $('#khuyenMaiSelect').val(khuyenMaiId).change();
            $('#applyModal').modal('show');
        }

        // Kiểm tra sản phẩm khi form được gửi
        $('#applyModal form').submit(function() {
            if ($('#selectedProducts').val() === '') {
                alert('Vui lòng chọn ít nhất một sản phẩm.');
                return false; // Ngừng gửi form
            }
            return true;
        });
    });


    document.querySelectorAll('.khuyen-mai-info').forEach(item => {
        item.addEventListener('click', function(event) {
            // Kiểm tra nếu phần tử không phải là nút X (vì muốn giữ dropdown khi nhấn nút X)
            if (!event.target.classList.contains('delete-link')) {
                // Toggle lớp active
                this.classList.toggle('active');
            }
        });
    });

</script>

<script type="text/javascript">
    function deleteProductFromPromotion(khuyenMaiChiTietId) {
        if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này khỏi khuyến mãi?")) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/khuyen-mai/xoa-san-pham", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        // Tải lại trang sau khi xóa thành công
                        location.reload();
                    } else {
                        alert("Có lỗi xảy ra khi xóa sản phẩm.");
                    }
                }
            };
            xhr.send("khuyenMaiChiTietId=" + khuyenMaiChiTietId);
        }
    }
</script>


</body>
</html>