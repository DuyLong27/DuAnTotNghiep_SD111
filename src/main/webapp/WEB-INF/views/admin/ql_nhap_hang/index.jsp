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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <title>Quản Lý Nhập Hàng</title>
</head>
<body>
<jsp:include page="../layout.jsp"/>
<div class="container mt-3">
    <h1 class="text-center mt-3">Danh Sách Phiếu Nhập Hàng</h1>
    <div class="filter-section mb-3">
        <form action="/nhap-hang/hien-thi" method="get" id="filterSearchForm">
            <div class="row">
                <div class="col-md-4">
                    <h5>Nhà Cung Cấp</h5>
                    <select name="nhaCungCapId" class="form-select" onchange="this.form.submit();">
                        <option value="" ${param.nhaCungCapId == '' ? 'selected' : ''}>Tất Cả</option>
                        <c:forEach var="ncc" items="${nhaCungCapList}">
                            <option value="${ncc.id}" ${param.nhaCungCapId == ncc.id ? 'selected' : ''}>${ncc.tenNCC}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <h5>Tên Nhân Viên</h5>
                    <input type="text" name="tenNhanVien" class="form-control" placeholder="Nhập tên nhân viên"
                           value="${param.tenNhanVien}">
                </div>
                <div class="col-md-4">
                    <h5>Ngày Tạo</h5>
                    <input type="date" name="ngayTao" class="form-control"
                           value="${param.ngayTao}">
                </div>
            </div>
        </form>
        <div class="mt-2">
            <a href="/nhap-hang/dat-hang" type="button" class="btn btn-create">
                <i class="fa-solid fa-truck"></i> Nhập Hàng
            </a>

            <button type="button" class="btn btn-secondary-outline ms-2" onclick="resetFilters();">Reset</button>
        </div>
    </div>

    <table class="table table-striped table-hover table-bordered text-center">
        <thead>
        <tr>
            <th>STT</th>
            <th>Mã Phiếu Nhập</th>
            <th>Nhà Cung Cấp</th>
            <th>Nhân Viên</th>
            <th>Ngày Nhập</th>
            <th>Ngày Tạo</th>
            <th>Tổng Giá Trị</th>
            <th>Ghi Chú</th>
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
            <c:forEach items="${data.content}" var="nh" varStatus="i">
                <tr>
                    <th>${i.index + 1}</th>
                    <td>${nh.maPhieuNhap}</td>
                    <td>${nh.nhaCungCap.tenNCC}</td>
                    <td>${nh.nhanVien.tenNhanVien}</td>
                    <td>${nh.ngayNhap}</td>
                    <td>${nh.ngayTao}</td>
                    <td>${nh.tongGiaTri}</td>
                    <td>${nh.ghiChu}</td>
                    <td class="${nh.tinhTrang == 1 ? 'text-success' : 'text-danger'}">
                            ${nh.tinhTrang == 1 ? "Đã hoàn thành" : "Đang trên đường"}
                    </td>
                    <td>
                        <a href="chi-tiet/${nh.id}"><i class="fa-solid fa-circle-info"></i></a>
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
                <a class="page-link" href="/nhap-hang/hien-thi?page=0&size=${nh.size}" aria-label="First">
                    <span aria-hidden="true">&laquo;&laquo; First</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/nhap-hang/hien-thi?page=${currentPage - 1}&size=${nh.size}"
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
                <a class="page-link" href="/nhap-hang/hien-thi?page=${currentPage + 1}&size=${nh.size}"
                   aria-label="Next">
                    <span aria-hidden="true">Next &raquo;</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/nhap-hang/hien-thi?page=${totalPages - 1}&size=${nh.size}"
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
        document.getElementById('idNhapHang').value = '';
        document.getElementById('submitButton').innerText = 'Đặt Hàng';
    }

    function setModalTitle(title) {
        document.getElementById('productModalLabel').innerText = title;
    }

    function resetFilters() {
        document.querySelector('input[name="tenNhanVien"]').value = '';
        document.querySelector('select[name="nhaCungCapId"]').value = '';
        document.querySelector('input[name="ngayTao"]').value = '';
        document.getElementById('filterSearchForm').submit();
    }
</script>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600&display=swap');

    body {
        background-color: #f8f9fa;
        position: relative;
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