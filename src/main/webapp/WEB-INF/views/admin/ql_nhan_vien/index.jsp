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

    <title>Danh Sách Sản Phẩm</title>
</head>
<body>
<jsp:include page="../layout.jsp" />
<div class="container mt-3">
    <h1 class="text-center mt-3">Danh Sách Nhân Viên</h1>
    <div class="filter-section mb-3">
        <form action="/nhan-vien/hien-thi" method="get" id="filterSearchForm">
            <div class="row">
                <div class="col-md-4">
                    <h5>Lọc Theo Tình Trạng</h5>
                    <select name="tinhTrang" class="form-select" onchange="this.form.submit();">
                        <option value="" ${param.tinhTrang == '' ? 'selected' : ''}>Tất Cả</option>
                        <option value="1" ${param.tinhTrang == '1' ? 'selected' : ''}>Làm Việc</option>
                        <option value="0" ${param.tinhTrang == '0' ? 'selected' : ''}>Tan Ca</option>
                    </select>
                </div>

                <div class="col-md-4">
                    <h5>Tìm Kiếm Theo Tên Nhân Viên</h5>
                    <input type="text" name="tenNhanVien" class="form-control" placeholder="Nhập tên nhân viên"
                           value="${param.tenNhanVien}">
                </div>
            </div>
        </form>
        <div class="mt-2">
            <button type="button" class="btn btn-create" data-bs-toggle="modal" data-bs-target="#productModal"
                    onclick="resetForm(); setModalTitle('Thêm Nhân Viên');">
                + Thêm Nhân Viên
            </button>
            <button type="button" class="btn btn-secondary-outline ms-2" onclick="resetFilters();">Reset</button>
        </div>
    </div>

    <!-- Bootstrap Modal -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productModalLabel">Thêm Nhân Viên</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="productForm" action="/nhan-vien/add" method="post">
                        <input type="hidden" id="nhanVienId" name="id"/>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="nhanVienName" class="form-label">Tên Nhân Viên</label>
                                    <input type="text" class="form-control" id="nhanVienName" name="tenNhanVien" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="nhanVienEmail" class="form-label">Email</label>
                                    <input type="text" class="form-control" id="nhanVienEmail" name="email" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="nhanVienMatKhau" class="form-label">Mật Khẩu</label>
                                    <input type="text" class="form-control" id="nhanVienMatKhau" name="matKhau" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="nhanVienSoDienThoai" class="form-label">Số Điện thoại</label>
                                    <input type="number" class="form-control" id="nhanVienSoDienThoai" name="soDienThoai" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="nhanVienNgayDiLam" class="form-label">NgayDiLam</label>
                                    <input type="date" class="form-control" id="nhanVienNgayDiLam" name="ngayDiLam" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="nhanVienChucVu" class="form-label">Chức Vụ</label>
                                    <input type="text" class="form-control" id="nhanVienChucVu" name="chucVu" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Tình Trạng</label><br>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tinhTrang" id="tinhTrangConHang"
                                           value="1" required>
                                    <label class="form-check-label" for="tinhTrangConHang">Làm việc</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tinhTrang" id="tinhTrangHetHang"
                                           value="0" required>
                                    <label class="form-check-label" for="tinhTrangHetHang">Tan ca</label>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary mt-3" id="submitButton">Lưu Nhân Viên</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bảng hiển thị danh sách sản phẩm -->
    <table class="table table-striped table-hover table-bordered text-center">
        <thead>
        <tr>
            <th>STT</th>
            <th>Tên Nhân Viên</th>
            <th>Email</th>
            <th>Mật Khẩu</th>
            <th>Số Điện Thoại</th>
            <th>Chức Vụ</th>
            <th>Ngày Đi Làm</th>
            <th>Tình Trạng</th>
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
            <c:forEach items="${data.content}" var="nv" varStatus="i">
                <tr>
                    <th>${i.index + 1}</th>
                    <td>${nv.tenNhanVien}</td>
                    <td>${nv.email}</td>
                    <td>${nv.matKhau}</td>
                    <td>${nv.soDienThoai}</td>
                    <td>${nv.chucVu}</td>
                    <td>${nv.ngayDiLam}</td>
                    <td class="${nv.tinhTrang == 1 ? 'text-success' : 'text-danger'}">
                            ${nv.tinhTrang == 1 ? "Đang làm" : "Tan ca"}
                    </td>
                    <td>
                        <a onclick="openEditModal(${nv.id}, '${nv.tenNhanVien}', '${nv.email}', '${nv.matKhau}', '${nv.soDienThoai}', '${nv.chucVu}', '${nv.ngayDiLam}', ${nv.tinhTrang})"
                           type="button" class="btn btn-default bordervien table__logo">
                            <i class='bx bx-edit-alt'></i>
                        </a>
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
                <a class="page-link" href="/nhan-vien/hien-thi?page=0&size=${nv.size}" aria-label="First">
                    <span aria-hidden="true">&laquo;&laquo; First</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/nhan-vien/hien-thi?page=${currentPage - 1}&size=${nv.size}"
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
                <a class="page-link" href="/nhan-vien/hien-thi?page=${currentPage + 1}&size=${nv.size}"
                   aria-label="Next">
                    <span aria-hidden="true">Next &raquo;</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/nhan-vien/hien-thi?page=${totalPages - 1}&size=${nv.size}"
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
        document.getElementById('submitButton').innerText = 'Lưu Nhân Viên';
    }

    function setModalTitle(title) {
        document.getElementById('productModalLabel').innerText = title;
    }

    function openEditModal(id, tenNhanVien, email, matKhau, soDienThoai, chucVu, ngayDiLam, tinhTrang) {
        setModalTitle('Cập Nhật Nhân Viên');
        document.getElementById('nhanVienId').value = id;
        document.getElementById('nhanVienName').value = tenNhanVien;
        document.getElementById('nhanVienEmail').value = email;
        document.getElementById('nhanVienMatKhau').value = matKhau;
        document.getElementById('nhanVienSoDienThoai').value = soDienThoai;
        document.getElementById('nhanVienChucVu').value = chucVu;
        document.getElementById('nhanVienNgayDiLam').value = ngayDiLam;

        // Xử lý radio button tình trạng
        const tinhTrangRadios = document.getElementsByName('tinhTrang');
        for (let radio of tinhTrangRadios) {
            radio.checked = (radio.value == tinhTrang);
        }

        // Cập nhật text button và action form
        document.getElementById('submitButton').innerText = 'Cập Nhật Nhân Viên';
        document.getElementById('productForm').action = `/nhan-vien/update`; // Đổi action để gửi form cập nhật

        // Mở modal bằng bootstrap
        var myModal = new bootstrap.Modal(document.getElementById('productModal'));
        myModal.show();
    }

    function resetFilters() {
        // Reset các trường lọc về giá trị mặc định
        document.querySelector('select[name="tinhTrang"]').value = '';

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
