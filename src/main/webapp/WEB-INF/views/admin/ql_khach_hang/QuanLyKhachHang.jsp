<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600&display=swap" rel="stylesheet">

    <title>Quản Lý Khách Hàng</title>
</head>
<body>
<jsp:include page="../layout.jsp"/>
<div class="container mt-3">
    <h1 class="text-center mt-3">Danh Sách Khách Hàng</h1>
    <div class="filter-section mb-3">
        <form action="/khach-hang/hien-thi" method="get" id="filterSearchForm">
            <div class="row">
                <%--                <div class="col-md-4">--%>
                <%--                    <h5>Lọc Theo Tình Trạng</h5>--%>
                <%--                    <select name="tinhTrang" class="form-select" onchange="this.form.submit();">--%>
                <%--                        <option value="" ${param.tinhTrang == '' ? 'selected' : ''}>Tất Cả</option>--%>
                <%--                        <option value="1" ${param.tinhTrang == '1' ? 'selected' : ''}>Hoạt Động</option>--%>
                <%--                        <option value="0" ${param.tinhTrang == '0' ? 'selected' : ''}>Ngừng Hoạt Động</option>--%>
                <%--                    </select>--%>
                <%--                </div>--%>

                <div class="col-md-4">
                    <h5>Tìm Kiếm Theo Tên Khách Hàng</h5>
                    <input type="text" name="tenKhachHang" class="form-control" placeholder="Nhập tên khách hàng"
                           value="${param.tenKhachHang}">
                </div>
            </div>
        </form>
        <div class="mt-2">
            <button type="button" class="btn btn-create" data-bs-toggle="modal" data-bs-target="#productModal"
                    onclick="resetForm(); setModalTitle('Thêm Khách Hàng');">
                + Thêm Khách Hàng
            </button>
            <button type="button" class="btn btn-secondary-outline ms-2" onclick="resetFilters();">Reset</button>
        </div>
    </div>

    <!-- Bootstrap Modal -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productModalLabel">Thêm Khách Hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="productForm" action="/khach-hang/add" method="post">
                        <input type="hidden" id="khachHangId" name="idKhachHang"/>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangName" class="form-label">Tên Khách Hàng</label>
                                    <input type="text" class="form-control" id="khachHangName" name="tenKhachHang"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangEmail" class="form-label">Email</label>
                                    <input type="text" class="form-control" id="khachHangEmail" name="email" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangMatKhau" class="form-label">Mật Khẩu</label>
                                    <input type="text" class="form-control" id="khachHangMatKhau" name="matKhau"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangSoDienThoai" class="form-label">Số Điện thoại</label>
                                    <input type="text" class="form-control" id="khachHangSoDienThoai"
                                           name="soDienThoai" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangDiaChi" class="form-label">Địa Chỉ</label>
                                    <input type="text" class="form-control" id="khachHangDiaChi" name="diaChi" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangDiem" class="form-label">Điểm Tích Lũy</label>
                                    <input type="number" class="form-control" id="khachHangDiem" name="diemTichLuy"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangNgayDangKy" class="form-label">Ngày Đăng Ký</label>
                                    <input type="date" class="form-control" id="khachHangNgayDangKy" name="ngayDangKy"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangLSM" class="form-label">Lịch Sử Mua Hàng</label>
                                    <input type="text" class="form-control" id="khachHangLSM" name="lichSuMuaHang"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="khachHangKM" class="form-label">Khuyến Mãi Đa Dụng</label>
                                    <input type="text" class="form-control" id="khachHangKM" name="khuyenMaiDaDung"
                                           required>
                                </div>
                            </div>
                            <%--                            <div class="col-md-6">--%>
                            <%--                                <label class="form-label">Tình Trạng</label><br>--%>
                            <%--                                <div class="form-check form-check-inline">--%>
                            <%--                                    <input class="form-check-input" type="radio" name="tinhTrang" id="tinhTrangHoatDong"--%>
                            <%--                                           value="1" required>--%>
                            <%--                                    <label class="form-check-label" for="tinhTrangHoatDong">Hoạt Động</label>--%>
                            <%--                                </div>--%>
                            <%--                                <div class="form-check form-check-inline">--%>
                            <%--                                    <input class="form-check-input" type="radio" name="tinhTrang" id="tinhTrangNgung"--%>
                            <%--                                           value="0" required>--%>
                            <%--                                    <label class="form-check-label" for="tinhTrangNgung">Ngừng Hoạt Động</label>--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>
                        </div>
                        <button type="submit" class="btn btn-create" id="submitButton">Lưu Khách Hàng</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <table class="table table-striped table-hover table-bordered text-center">
        <thead>
        <tr>
            <th>STT</th>
            <th>Tên Khách Hàng</th>
            <th>Email</th>
            <th>Mật Khẩu</th>
            <th>Số Điện Thoại</th>
            <th>Địa Chỉ</th>
            <th>Điểm Tích Lũy</th>
            <th>Ngày Đăng Ký</th>
            <th>Lịch Sử Mua Hàng</th>
            <th>Khuyến Mãi Đa Dụng</th>
            <%--            <th>Tình Trạng</th>--%>
            <th>Thao Tác</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty data.content}">
            <tr>
                <td colspan="10">Không tìm thấy đối tượng nào.</td>
            </tr>
        </c:if>
        <c:if test="${not empty data.content}">
            <c:forEach items="${data.content}" var="kh" varStatus="i">
                <tr>
                    <th>${i.index + 1}</th>
                    <td>${kh.tenKhachHang}</td>
                    <td>${kh.email}</td>
                    <td>${kh.matKhau}</td>
                    <td>${kh.soDienThoai}</td>
                    <td>${kh.diaChi}</td>
                    <td>${kh.diemTichLuy}</td>
                    <td>${kh.ngayDangKy}</td>
                    <td>${kh.lichSuMuaHang}</td>
                    <td>${kh.khuyenMaiDaDung}</td>
                        <%--                    <td class="${kh.tinhTrang == 1 ? 'text-success' : 'text-danger'}">--%>
                        <%--                            ${kh.tinhTrang == 1 ? "Hoạt Động" : "Ngừng Hoạt Động"}--%>
                        <%--                    </td>--%>
                    <td>
                        <a onclick="openEditModal(${kh.idKhachHang}, '${kh.tenKhachHang}', '${kh.email}',
                                '${kh.matKhau}', '${kh.soDienThoai}', '${kh.diaChi}', ${kh.diemTichLuy},
                                '${kh.ngayDangKy}', '${kh.lichSuMuaHang}', '${kh.khuyenMaiDaDung}'
                            <%--, '${kh.tinhTrang}'--%>
                                )"
                           type="button" class="btn btn-outline-custom"><i class='bx bx-edit-alt'></i></a>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
</div>

<nav aria-label="Page navigation" class="mt-3">
    <ul class="pagination justify-content-center">
        <c:if test="${currentPage > 0}">
            <li class="page-item">
                <a class="page-link" href="/khach-hang/hien-thi?page=0&size=${kh.size}" aria-label="First">
                    <span aria-hidden="true">&laquo;&laquo; First</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/khach-hang/hien-thi?page=${currentPage - 1}&size=${kh.size}"
                   aria-label="Previous">
                    <span aria-hidden="true">&laquo; Previous</span>
                </a>
            </li>
        </c:if>
        <li class="page-item disabled">
            <a class="page-link" href="#">Page ${currentPage + 1} of ${totalPages}</a>
        </li>
        <c:if test="${currentPage < totalPages - 1}">
            <li class="page-item">
                <a class="page-link" href="/khach-hang/hien-thi?page=${currentPage + 1}&size=${kh.size}"
                   aria-label="Next">
                    <span aria-hidden="true">Next &raquo;</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/khach-hang/hien-thi?page=${totalPages - 1}&size=${kh.size}"
                   aria-label="Last">
                    <span aria-hidden="true">Last &raquo;&raquo;</span>
                </a>
            </li>
        </c:if>
    </ul>
</nav>

<script>
    function resetForm() {
        document.getElementById('productForm').reset();
        document.getElementById('productId').value = '';
        document.getElementById('submitButton').innerText = 'Lưu Khách Hàng';
    }

    function setModalTitle(title) {
        document.getElementById('productModalLabel').innerText = title;
    }

    function openEditModal(idKhachHang, tenKhachHang, email, matKhau, soDienThoai, diaChi, diemTichLuy, ngayDangKy,
                           lichSuMuaHang, khuyenMaiDaDung, tinhTrang) {
        setModalTitle('Cập Nhật Sản Phẩm');
        document.getElementById('khachHangId').value = idKhachHang;
        document.getElementById('khachHangName').value = tenKhachHang;
        document.getElementById('khachHangEmail').value = email;
        document.getElementById('khachHangMatKhau').value = matKhau;
        document.getElementById('khachHangSoDienThoai').value = soDienThoai;
        document.getElementById('khachHangDiaChi').value = diaChi;
        document.getElementById('khachHangDiem').value = diemTichLuy;
        document.getElementById('khachHangNgayDangKy').value = ngayDangKy;
        document.getElementById('khachHangLSM').value = lichSuMuaHang;
        document.getElementById('khachHangKM').value = khuyenMaiDaDung;

        const tinhTrangRadios = document.getElementsByName('tinhTrang');
        for (let radio of tinhTrangRadios) {
            radio.checked = (radio.value == tinhTrang);
        }

        document.getElementById('submitButton').innerText = 'Cập Nhật Khách Hàng';
        document.getElementById('productForm').action = `/khach-hang/update`; // Update action
        var myModal = new bootstrap.Modal(document.getElementById('productModal'));
        myModal.show();
    }


    function resetFilters() {
        document.querySelector('input[name="tenKhachHang"]').value = '';

        // Gửi lại form để lấy lại danh sách sản phẩm gốc
        document.getElementById('filterSearchForm').submit();
    }
</script>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600&display=swap');

    body {
        background-color: #f8f9fa;
        position: relative; /* Để thông báo được căn chỉnh đúng */
    }

    .bordervien {
        border: 1px solid #030303;
    }

    .table__logo {
        font-size: 20px;
        margin-bottom: 2.5rem;
    }

    .input-group {
        flex: 1;
        max-width: 500px;
    }

    .form-control {
        flex: 1;
    }

    .input-group .btn {
        white-space: nowrap;
    }
</style>
</body>
</html>
