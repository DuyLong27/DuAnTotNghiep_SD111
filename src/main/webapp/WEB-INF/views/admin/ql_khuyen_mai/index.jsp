<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý khuyến mãi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <style>
        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type="number"] {
            -moz-appearance: textfield;
        }

        #successMessage {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1050;
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
<body>
<jsp:include page="../layout.jsp"/>
<%--body--%>
<div class="container mt-3">
    <!-- Thông báo -->
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

    <div class="row">
        <div class="col-md-3 filter-section">
            <form action="/quan-ly-khuyen-mai/hien-thi" method="get">
                <div class="mb-3">
                    <label for="maKhuyenMai" class="form-label">Mã khuyến mãi</label>
                    <input type="text" class="form-control" id="maKhuyenMai" name="maKhuyenMai" value="${maKhuyenMai}">
                </div>
                <div class="mb-3">
                    <label for="tenKhuyenMai" class="form-label">Tên khuyến mãi</label>
                    <input type="text" class="form-control" id="tenKhuyenMai" name="tenKhuyenMai" value="${tenKhuyenMai}">
                </div>
                <div class="mb-3">
                    <label for="giaTriKhuyenMai" class="form-label">Giá trị khuyến mãi (Từ - Đến)</label>
                    <div class="d-flex gap-2">
                        <input type="number" class="form-control" name="giaTriMin" placeholder="Từ" value="${giaTriMin}">
                        <input type="number" class="form-control" name="giaTriMax" placeholder="Đến" value="${giaTriMax}">
                    </div>
                </div>
                <div class="mb-3">
                    <label for="ngayBatDau" class="form-label">Ngày bắt đầu</label>
                    <input type="date" class="form-control" id="ngayBatDau" name="ngayBatDau" value="${ngayBatDau}">
                </div>
                <div class="mb-3">
                    <label for="ngayKetThuc" class="form-label">Ngày kết thúc</label>
                    <input type="date" class="form-control" id="ngayKetThuc" name="ngayKetThuc" value="${ngayKetThuc}">
                </div>
                <button type="submit" class="btn btn-filter">Lọc</button>
                <a href="/quan-ly-khuyen-mai/hien-thi" class="btn btn-secondary-outline">Xóa lọc</a>
            </form>
        </div>

        <div class="col-md-9">
            <div class="d-flex justify-content-end mb-3">
                <c:if test="${sessionScope.role == 0}">
                    <button type="button" class="btn btn-create" data-bs-toggle="modal" data-bs-target="#addPromotionModal">
                        Tạo mới
                    </button>
                </c:if>

            </div>

            <table class="table table-striped table-hover table-bordered text-center">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Mã khuyến mãi</th>
                    <th>Tên khuyến mãi</th>
                    <th>Giá trị khuyến mãi</th>
                    <th>Ngày bắt đầu</th>
                    <th>Ngày kết thúc</th>
                    <th>Trạng thái</th>
                    <c:if test="${sessionScope.role == 0}">
                        <th>Hành động</th>
                    </c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${listKhuyenMai}" var="item">
                    <tr>
                        <td>${item.idKhuyenMai}</td>
                        <td>${item.maKhuyenMai}</td>
                        <td>${item.tenKhuyenMai}</td>
                        <td>${item.giaTriKhuyenMai}</td>
                        <td>${item.ngayBatDau}</td>
                        <td>${item.ngayKetThuc}</td>
                        <td class="${item.tinhTrang == 1 ? 'text-success': 'text-danger'}">
                                ${item.tinhTrang == 1 ? "Đang hoạt động":"Không hoạt động"}
                        </td>
                        <c:if test="${sessionScope.role == 0}">
                            <td style="width: 100px;">
                                <div class="d-flex justify-content-center gap-2">
                                    <a href="#" class="btn btn-outline-custom"
                                       data-bs-toggle="modal"
                                       data-bs-target="#editPromotionModal"
                                       onclick="showPromotionEdits(${item.idKhuyenMai}, '${item.maKhuyenMai}', '${item.tenKhuyenMai}', ${item.giaTriKhuyenMai}, '${item.ngayBatDau}', '${item.ngayKetThuc}', ${item.tinhTrang})">
                                        <i class="fa fa-edit"></i>
                                    </a>

                                    <c:choose>
                                        <c:when test="${item.tinhTrang == 1}">
                                            <a class="btn btn-outline-custom"
                                               href="/quan-ly-khuyen-mai/chi-tiet?id=${item.idKhuyenMai}"
                                               class="btn btn-outline-success">
                                                <i class="fa-solid fa-hand-point-right"></i>
                                            </a>                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-outline-custom" disabled><i class="fa-solid fa-hand-point-right"></i></button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                        <a class="page-link btn-custom"
                           href="?page=${currentPage - 1}&size=5&maKhuyenMai=${maKhuyenMai}&tenKhuyenMai=${tenKhuyenMai}&giaTriMin=${giaTriMin}&giaTriMax=${giaTriMax}&ngayBatDau=${ngayBatDau}&ngayKetThuc=${ngayKetThuc}">Previous</a>
                    </li>
                    <div class="pagination-info">
                        <span>Trang ${currentPage + 1} trên ${totalPages}</span>
                    </div>
                    <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                        <a class="page-link btn-custom"
                           href="?page=${currentPage + 1}&size=5&maKhuyenMai=${maKhuyenMai}&tenKhuyenMai=${tenKhuyenMai}&giaTriMin=${giaTriMin}&giaTriMax=${giaTriMax}&ngayBatDau=${ngayBatDau}&ngayKetThuc=${ngayKetThuc}">Next</a>
                    </li>
                </ul>
            </nav>


        </div>
    </div>
</div>

<!-- Pop-up -->
<div class="modal fade" id="addPromotionModal" tabindex="-1" aria-labelledby="addPromotionModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content modal-green">
            <div class="modal-header">
                <h5 class="modal-title" id="addPromotionModalLabel">Tạo mới khuyến mãi</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/quan-ly-khuyen-mai/them" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="maKhuyenMai" class="form-label">Mã khuyến mãi</label>
                        <input type="text" class="form-control" id="maKhuyenMai" name="maKhuyenMai" required>
                    </div>
                    <div class="mb-3">
                        <label for="tenKhuyenMai" class="form-label">Tên khuyến mãi</label>
                        <input type="text" class="form-control" id="tenKhuyenMai" name="tenKhuyenMai" required>
                    </div>
                    <div class="mb-3">
                        <label for="giaTriKhuyenMai" class="form-label">Giá trị khuyến mãi</label>
                        <input type="number" class="form-control" id="giaTriKhuyenMai" name="giaTriKhuyenMai" required>
                    </div>
                    <div class="mb-3">
                        <label for="ngayBatDau" class="form-label">Ngày bắt đầu</label>
                        <input type="date" class="form-control" id="ngayBatDau" name="ngayBatDau" required>
                    </div>
                    <div class="mb-3">
                        <label for="ngayKetThuc" class="form-label">Ngày kết thúc</label>
                        <input type="date" class="form-control" id="ngayKetThuc" name="ngayKetThuc" required>
                    </div>
                    <div class="mb-3">
                        <label for="tinhTrang" class="form-label">Tình trạng</label>
                        <div>
                            <input type="radio" id="hoatDong" name="tinhTrang" value="1" checked>
                            <label for="hoatDong">Hoạt động</label>
                            <input type="radio" id="khongHoatDong" name="tinhTrang" value="0">
                            <label for="khongHoatDong">Không hoạt động</label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-create">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal for Edit Promotion -->
<div class="modal fade" id="editPromotionModal" tabindex="-1" aria-labelledby="editPromotionModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editPromotionModalLabel">Sửa khuyến mãi</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/quan-ly-khuyen-mai/sua" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <input type="hidden" class="form-control" id="editIdKhuyenMai" name="id" required>
                    </div>
                    <div class="mb-3">
                        <label for="editMaKhuyenMai" class="form-label">Mã khuyến mãi</label>
                        <input type="text" class="form-control" id="editMaKhuyenMai" name="maKhuyenMai" required>
                    </div>
                    <div class="mb-3">
                        <label for="editTenKhuyenMai" class="form-label">Tên khuyến mãi</label>
                        <input type="text" class="form-control" id="editTenKhuyenMai" name="tenKhuyenMai" required>
                    </div>
                    <div class="mb-3">
                        <label for="editGiaTriKhuyenMai" class="form-label">Giá trị khuyến mãi</label>
                        <input type="number" class="form-control" id="editGiaTriKhuyenMai" name="giaTriKhuyenMai"
                               required>
                    </div>
                    <div class="mb-3">
                        <label for="editNgayBatDau" class="form-label">Ngày bắt đầu</label>
                        <input type="date" class="form-control" id="editNgayBatDau" name="ngayBatDau" required>
                    </div>
                    <div class="mb-3">
                        <label for="editNgayKetThuc" class="form-label">Ngày kết thúc</label>
                        <input type="date" class="form-control" id="editNgayKetThuc" name="ngayKetThuc" required>
                    </div>
                    <div class="mb-3">
                        <label for="editTinhTrang" class="form-label">Tình trạng</label>
                        <div>
                            <input type="radio" id="editHoatDong" name="tinhTrang" value="1">
                            <label for="editHoatDong">Hoạt động</label>
                            <input type="radio" id="editKhongHoatDong" name="tinhTrang" value="0">
                            <label for="editKhongHoatDong">Không hoạt động</label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary-outline" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>


</body>
<script>
    function showPromotionEdits(idKhuyenMai, maKhuyenMai, tenKhuyenMai, giaTriKhuyenMai, ngayBatDau, ngayKetThuc, tinhTrang) {
        document.getElementById('editIdKhuyenMai').value = idKhuyenMai;
        document.getElementById('editMaKhuyenMai').value = maKhuyenMai;
        document.getElementById('editTenKhuyenMai').value = tenKhuyenMai;
        document.getElementById('editGiaTriKhuyenMai').value = giaTriKhuyenMai;
        document.getElementById('editNgayBatDau').value = ngayBatDau;
        document.getElementById('editNgayKetThuc').value = ngayKetThuc;
        document.getElementById('editHoatDong').checked = (tinhTrang === 1);
        document.getElementById('editKhongHoatDong').checked = (tinhTrang === 0);
        document.getElementById('productForm').action = `/quan-ly-khuyen-mai/update`;
    }
    function removeVietnameseAccents(str) {
        var accents = [
            {base: 'a', letters: 'áàạảãâấầậẩẫăắằặẳẵ'},
            {base: 'e', letters: 'éèẹẻẽêếềệểễ'},
            {base: 'i', letters: 'íìịỉĩ'},
            {base: 'o', letters: 'óòọỏõôốồộổỗơớờợởỡ'},
            {base: 'u', letters: 'úùụủũưứừựửữ'},
            {base: 'y', letters: 'ýỳỵỷỹ'},
            {base: 'd', letters: 'đ'}
        ];

        for (var i = 0; i < accents.length; i++) {
            var letters = accents[i].letters.split('');
            for (var j = 0; j < letters.length; j++) {
                str = str.replace(letters[j], accents[i].base);
            }
        }

        return str;
    }

    document.querySelector("form").addEventListener("submit", function(event) {
        var maKhuyenMai = document.getElementById("maKhuyenMai").value.trim().toLowerCase();
        var tenKhuyenMai = document.getElementById("tenKhuyenMai").value.trim().toLowerCase();
        var giaTriMin = document.getElementsByName("giaTriMin")[0].value.trim();
        var giaTriMax = document.getElementsByName("giaTriMax")[0].value.trim();
        var ngayBatDau = document.getElementById("ngayBatDau").value.trim();
        var ngayKetThuc = document.getElementById("ngayKetThuc").value.trim();

        maKhuyenMai = removeVietnameseAccents(maKhuyenMai);
        tenKhuyenMai = removeVietnameseAccents(tenKhuyenMai);

        if (!maKhuyenMai && !tenKhuyenMai && !giaTriMin && !giaTriMax && !ngayBatDau && !ngayKetThuc) {
            alert("Vui lòng nhập ít nhất một trường để tìm kiếm.");
            event.preventDefault();
            return;
        }

        if (maKhuyenMai && !/^[a-z0-9]+$/.test(maKhuyenMai)) {
            alert("Mã khuyến mãi chỉ được chứa chữ và số.");
            event.preventDefault();
            return;
        }

        if (tenKhuyenMai && !/^[a-z0-9\s%]+$/.test(tenKhuyenMai)) {
            alert("Tên khuyến mãi không được chứa ký tự đặc biệt ngoài %.");
            event.preventDefault();
            return;
        }

        if (giaTriMin && giaTriMax && (isNaN(giaTriMin) || isNaN(giaTriMax) || parseFloat(giaTriMin) < 0 || parseFloat(giaTriMax) < 0)) {
            alert("Giá trị khuyến mãi phải là số và không được âm.");
            event.preventDefault();
            return;
        }

        if (giaTriMin && giaTriMax && parseInt(giaTriMin) > parseInt(giaTriMax)) {
            alert("Giá trị 'Từ' không được lớn hơn giá trị 'Đến'.");
            event.preventDefault();
            return;
        }

        if (ngayBatDau && ngayKetThuc && ngayBatDau > ngayKetThuc) {
            alert("Ngày bắt đầu không được lớn hơn ngày kết thúc.");
            event.preventDefault();
            return;
        }

        if (ngayBatDau && !/^\d{4}-\d{2}-\d{2}$/.test(ngayBatDau)) {
            alert("Ngày bắt đầu không hợp lệ.");
            event.preventDefault();
            return;
        }

        if (ngayKetThuc && !/^\d{4}-\d{2}-\d{2}$/.test(ngayKetThuc)) {
            alert("Ngày kết thúc không hợp lệ.");
            event.preventDefault();
            return;
        }
    });

    window.onload = function () {
        var successMessage = document.getElementById("successMessage");
        if (successMessage) {
            setTimeout(function () {
                successMessage.style.display = 'none';
            }, 3000);
        }
    };
</script>

</html>