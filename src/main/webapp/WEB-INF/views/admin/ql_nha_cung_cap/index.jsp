<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Quản Lý Nhà Cung Cấp</title>
    <style>
        /* CSS cho thông báo */
        #successMessage {
            position: fixed; /* Sử dụng fixed để thông báo không di chuyển khi cuộn */
            top: 20px; /* Cách mép trên 20px */
            right: 20px; /* Cách mép bên phải 20px */
            z-index: 1050; /* Đảm bảo thông báo nằm trên các phần tử khác */
        }
    </style>
</head>
<body>
<jsp:include page="../layout.jsp" />
<div class="container mt-5">
    <h1 class="text-center mt-3">Danh Sách Nhà Cung Cấp</h1>
    <!-- Thông báo -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert" id="successMessage">
                ${message}
        </div>
    </c:if>
    <!-- Form tìm kiếm và lọc -->
    <form action="/nha-cung-cap" method="get" class="mb-4">
        <div class="row mb-3">
            <div class="col-md-8">
                <input type="text" class="form-control" placeholder="Tìm kiếm theo tên nhà cung cấp" name="search" value="${search}" onkeypress="if(event.keyCode == 13) { this.form.submit(); }">
            </div>
            <div class="col-md-4">
                <select class="form-select" name="tinhTrang" onchange="this.form.submit()">
                    <option value="">Tất cả tình trạng</option>
                    <option value="1" ${tinhTrang == 1 ? 'selected' : ''}>Hoạt Động</option>
                    <option value="0" ${tinhTrang == 0 ? 'selected' : ''}>Không Hoạt Động</option>
                </select>
            </div>
        </div>
        <div class="d-flex justify-content-start mb-3">
            <!-- Nút mở form pop-up -->
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addNhaCungCapModal">Thêm Nhà Cung Cấp</button>
            <!-- Nút reset -->
            <button type="button" class="btn btn-secondary ms-2" onclick="resetForm()">Reset</button>
        </div>
    </form>



    <!-- Bảng hiển thị nhà cung cấp -->
    <table class="table table-hover table-bordered text-center mt-3">
        <thead>
        <tr>
            <th>STT</th>
            <th>Tên Nhà Cung Cấp</th>
            <th>Số Điện Thoại</th>
            <th>Email</th>
            <th>Địa Chỉ</th>
            <th>Sản Phẩm Cung Cấp</th>
            <th>Nguồn Gốc Xuất Xứ</th>
            <th>Tình Trạng</th>
            <th>Thao Tác</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty nhaCungCapList}">
            <tr>
                <td colspan="9" class="align-middle">Không tìm thấy đối tượng nào.</td>
            </tr>
        </c:if>
        <c:if test="${not empty nhaCungCapList}">
            <c:forEach var="ncc" items="${nhaCungCapList}" varStatus="i">
                <tr>
                    <td class="align-middle">${i.index + 1}</td>
                    <td class="align-middle">${ncc.tenNCC}</td>
                    <td class="align-middle">${ncc.soDienThoai}</td>
                    <td class="align-middle">${ncc.email}</td>
                    <td class="align-middle">${ncc.diaChi}</td>
                    <td class="align-middle">${ncc.sanPhamCungCap}</td>
                    <td class="align-middle">${ncc.nguonGoc}</td>
                    <td class="align-middle ${ncc.tinhTrang == 1 ? 'text-success' : 'text-danger'}">
                            ${ncc.tinhTrang == 1 ? 'Hoạt Động' : 'Không Hoạt Động'}
                    </td>
                    <td class="d-flex align-middle justify-content-center">
                        <button class="btn btn-warning btn-sm me-2"
                                data-bs-toggle="modal"
                                data-bs-target="#addNhaCungCapModal"
                                onclick="editNhaCungCap(${ncc.id}, '${ncc.tenNCC}', '${ncc.soDienThoai}', '${ncc.email}', '${ncc.diaChi}', '${ncc.sanPhamCungCap}', '${ncc.nguonGoc}', ${ncc.tinhTrang})">
                            Sửa
                        </button>
<%--                        <a href="/nha-cung-cap/delete/${ncc.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?');">Xóa</a>--%>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
    <nav aria-label="Page navigation" class="mt-3">
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 0}">
                <li class="page-item">
                    <a class="page-link" href="/nha-cung-cap?page=0&size=5" aria-label="First">
                        <span aria-hidden="true">&laquo;&laquo; First</span>
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="/nha-cung-cap?page=${currentPage - 1}&size=5" aria-label="Previous">
                        <span aria-hidden="true">&laquo; Previous</span>
                    </a>
                </li>
            </c:if>
            <li class="page-item disabled">
                <a class="page-link" href="#">Page ${currentPage + 1} of ${totalPages}</a>
            </li>
            <c:if test="${currentPage < totalPages - 1}">
                <li class="page-item">
                    <a class="page-link" href="/nha-cung-cap?page=${currentPage + 1}&size=5" aria-label="Next">
                        <span aria-hidden="true">Next &raquo;</span>
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="/nha-cung-cap?page=${totalPages - 1}&size=5" aria-label="Last">
                        <span aria-hidden="true">Last &raquo;&raquo;</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>


    <!-- Modal thêm nhà cung cấp -->
    <div class="modal fade" id="addNhaCungCapModal" tabindex="-1" aria-labelledby="addNhaCungCapLabel"
         aria-hidden="true">
        <!-- Sử dụng modal-lg để mở rộng kích thước modal -->
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addNhaCungCapLabel">Thêm Nhà Cung Cấp</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="/nha-cung-cap/add" method="post">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="tenNCC" class="form-label">Tên Nhà Cung Cấp</label>
                                <input type="text" class="form-control" id="tenNCC" name="tenNCC" required>
                            </div>
                            <div class="col-md-6">
                                <label for="soDienThoai" class="form-label">Số Điện Thoại</label>
                                <input type="text" class="form-control" id="soDienThoai" name="soDienThoai" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="col-md-6">
                                <label for="diaChi" class="form-label">Địa Chỉ</label>
                                <input type="text" class="form-control" id="diaChi" name="diaChi" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="sanPhamCungCap" class="form-label">Sản Phẩm Cung Cấp</label>
                                <input type="text" class="form-control" id="sanPhamCungCap" name="sanPhamCungCap">
                            </div>
                            <div class="col-md-6">
                                <label for="nguonGoc" class="form-label">Nguồn Gốc Xuất Xứ</label>
                                <input type="text" class="form-control" id="nguonGoc" name="nguonGoc">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Tình Trạng</label><br>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="tinhTrangHoatDong" name="tinhTrang"
                                           value="1" checked>
                                    <label class="form-check-label" for="tinhTrangHoatDong">Hoạt Động</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="tinhTrangKhongHoatDong"
                                           name="tinhTrang" value="0">
                                    <label class="form-check-label" for="tinhTrangKhongHoatDong">Không Hoạt Động</label>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function editNhaCungCap(id, tenNCC, soDienThoai, email, diaChi, sanPhamCungCap, nguonGoc, tinhTrang) {
        document.getElementById('tenNCC').value = tenNCC;
        document.getElementById('soDienThoai').value = soDienThoai;
        document.getElementById('email').value = email;
        document.getElementById('diaChi').value = diaChi;
        document.getElementById('sanPhamCungCap').value = sanPhamCungCap;
        document.getElementById('nguonGoc').value = nguonGoc;
        document.getElementById('tinhTrangHoatDong').checked = (tinhTrang === 1);
        document.getElementById('tinhTrangKhongHoatDong').checked = (tinhTrang === 0);

        // Cập nhật action của form
        const form = document.querySelector('#addNhaCungCapModal form');
        form.action = '/nha-cung-cap/update/' + id;
    }

    // Ẩn thông báo sau 3 giây
    window.onload = function () {
        var successMessage = document.getElementById("successMessage");
        if (successMessage) {
            setTimeout(function () {
                successMessage.style.display = 'none';
            }, 3000); // 3 giây
        }
    };

    // Hàm thiết lập lại form
    function resetForm() {
        document.querySelector('input[name="search"]').value = '';
        document.querySelector('select[name="tinhTrang"]').selectedIndex = 0;
        // Gửi lại form để áp dụng các thay đổi
        document.forms[0].submit();
    }
</script>
</body>
</html>
