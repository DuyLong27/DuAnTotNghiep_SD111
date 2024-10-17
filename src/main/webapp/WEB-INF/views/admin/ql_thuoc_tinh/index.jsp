<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Quản Lý Thuộc Tính Sản Phẩm</title>
    <style>
        body {
            background-color: #f8f9fa;
            position: relative; /* Để thông báo được căn chỉnh đúng */
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
<div class="container mt-5">
    <h1 class="text-center mb-4 text-primary">Quản Lý Thuộc Tính Sản Phẩm</h1>
    <!-- Thông báo -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert" id="successMessage">
                ${message}
        </div>
    </c:if>
    <div class="d-flex justify-content-start align-items-center mb-4">
        <form method="get" action="/thuoc-tinh" class="me-3">
            <select name="entity" id="entitySelect" class="form-select" onchange="this.form.submit()">
                <option value="canNang" ${param.entity == 'canNang' ? 'selected' : ''}>Cân Nặng</option>
                <option value="huongVi" ${param.entity == 'huongVi' ? 'selected' : ''}>Hương Vị</option>
                <option value="loaiCaPhe" ${param.entity == 'loaiCaPhe' ? 'selected' : ''}>Loại Cà Phê</option>
                <option value="loaiHat" ${param.entity == 'loaiHat' ? 'selected' : ''}>Loại Hạt</option>
                <option value="loaiTui" ${param.entity == 'loaiTui' ? 'selected' : ''}>Loại Túi</option>
                <option value="mucDoRang" ${param.entity == 'mucDoRang' ? 'selected' : ''}>Mức Độ Rang</option>
                <option value="thuongHieu" ${param.entity == 'thuongHieu' ? 'selected' : ''}>Thương Hiệu</option>
            </select>
        </form>

        <form method="post" action="/thuoc-tinh/add" class="d-flex">
            <input type="hidden" name="entity" value="${param.entity}"/>
            <div class="input-group">
                <input type="text" name="propertyName" id="propertyName" class="form-control" placeholder="Tên thuộc tính mới" required/>
                <button type="submit" class="btn btn-outline-primary">Thêm Thuộc Tính</button>
            </div>
        </form>
    </div>

    <!-- Bảng thuộc tính -->
    <table class="table table-hover table-bordered text-center">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Thao Tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${items}">
            <tr>
                <td>${item.id}</td>
                <td>${item.ten}</td>
                <td>
                    <form action="/thuoc-tinh/update" method="post" class="d-inline">
                        <input type="hidden" name="entity" value="${entity}"/>
                        <input type="hidden" name="id" value="${item.id}"/>
                        <input type="text" name="propertyName" value="${item.ten}" class="form-control d-inline-block w-50" required/>
                        <button type="submit" class="btn btn-sm btn-warning">Sửa</button>
                    </form>
                    <form action="/thuoc-tinh/delete" method="post" class="d-inline">
                        <input type="hidden" name="entity" value="${entity}"/>
                        <input type="hidden" name="id" value="${item.id}"/>
                        <button onclick="return confirm('Bạn có chắc muốn xóa?')" type="submit" class="btn btn-sm btn-danger">Xóa</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <nav aria-label="Page navigation" class="mt-3">
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 0}">
                <li class="page-item">
                    <a class="page-link" href="?entity=${entity}&page=0&size=5" aria-label="First">
                        <span aria-hidden="true">&laquo;&laquo; First</span>
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="?entity=${entity}&page=${currentPage - 1}&size=5" aria-label="Previous">
                        <span aria-hidden="true">&laquo; Previous</span>
                    </a>
                </li>
            </c:if>
            <li class="page-item disabled">
                <a class="page-link">Page ${currentPage + 1} of ${totalPages}</a>
            </li>
            <c:if test="${currentPage < totalPages - 1}">
                <li class="page-item">
                    <a class="page-link" href="?entity=${entity}&page=${currentPage + 1}&size=5" aria-label="Next">
                        <span aria-hidden="true">Next &raquo;</span>
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="?entity=${entity}&page=${totalPages - 1}&size=5" aria-label="Last">
                        <span aria-hidden="true">Last &raquo;&raquo;</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
<script>
    // Ẩn thông báo sau 3 giây
    window.onload = function() {
        var successMessage = document.getElementById("successMessage");
        if (successMessage) {
            setTimeout(function() {
                successMessage.style.display = 'none';
            }, 3000); // 3 giây
        }
    };
</script>
</body>
</html>
