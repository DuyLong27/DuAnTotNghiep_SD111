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
<jsp:include page="../layout.jsp" />
<div class="container mt-5">
    <h1 class="text-center mt-3">Danh Sách Nhà Cung Cấp</h1>
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
    <!-- Form tìm kiếm và lọc -->
    <form action="/nha-cung-cap" method="get" class="mb-4 filter-section">
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
            <c:if test="${sessionScope.role == 0}">
                <button type="button" class="btn btn-create" data-bs-toggle="modal" data-bs-target="#addNhaCungCapModal">Thêm Nhà Cung Cấp</button>
            </c:if>
            <button type="button" class="btn btn-secondary-outline ms-2" onclick="resetForm()">Reset</button>
        </div>
    </form>



    <!-- Bảng hiển thị nhà cung cấp -->
    <table class="table table-striped table-hover table-bordered text-center">
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
            <c:if test="${sessionScope.role == 0}">
                <th>Thao tác</th>
            </c:if>
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
                    <c:if test="${sessionScope.role == 0}">
                        <td >
                            <button class="btn btn-outline-custom"
                                    data-bs-toggle="modal"
                                    data-bs-target="#addNhaCungCapModal"
                                    onclick="editNhaCungCap(${ncc.id}, '${ncc.tenNCC}', '${ncc.soDienThoai}', '${ncc.email}', '${ncc.diaChi}', '${ncc.sanPhamCungCap}', '${ncc.nguonGoc}', ${ncc.tinhTrang})">
                                Sửa
                            </button>
                                <%--                        <a href="/nha-cung-cap/delete/${ncc.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?');">Xóa</a>--%>
                        </td>
                    </c:if>
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
                    <form action="/nha-cung-cap/add" method="post" onsubmit="return validateForm()">
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
                                    <input class="form-check-input" type="radio" id="tinhTrangHoatDong" name="tinhTrang" value="1" checked>
                                    <label class="form-check-label" for="tinhTrangHoatDong">Hoạt Động</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="tinhTrangKhongHoatDong" name="tinhTrang" value="0">
                                    <label class="form-check-label" for="tinhTrangKhongHoatDong">Không Hoạt Động</label>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-create">Lưu</button>
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
        const form = document.querySelector('#addNhaCungCapModal form');
        form.action = '/nha-cung-cap/update/' + id;
    }
    window.onload = function () {
        var successMessage = document.getElementById("successMessage");
        if (successMessage) {
            setTimeout(function () {
                successMessage.style.display = 'none';
            }, 3000);
        }
    };

    function resetForm() {
        document.querySelector('input[name="search"]').value = '';
        document.querySelector('select[name="tinhTrang"]').selectedIndex = 0;
        document.forms[0].submit();
    }




    function validateForm() {
        var tenNCC = document.getElementById('tenNCC').value;
        var soDienThoai = document.getElementById('soDienThoai').value;
        var email = document.getElementById('email').value;
        var diaChi = document.getElementById('diaChi').value;
        var tinhTrang = document.querySelector('input[name="tinhTrang"]:checked');
        var tenNCCPattern = /^[A-Za-zÀ-ÖØ-öø-ÿ\s]+$/;
        if (!tenNCCPattern.test(tenNCC)) {
            alert("Tên Nhà Cung Cấp không hợp lệ.");
            return false;
        }
        var phonePattern = /^0\d{9,10}$/;
        if (!phonePattern.test(soDienThoai)) {
            alert("Số điện thoại không hợp lệ. Phải bắt đầu bằng 0 và có từ 10-11 chữ số.");
            return false;
        }
        var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        if (!emailPattern.test(email)) {
            alert("Email không hợp lệ.");
            return false;
        }
        if (diaChi.length > 50) {
            alert("Địa chỉ không được quá 50 ký tự.");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
