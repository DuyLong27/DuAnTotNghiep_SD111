<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Hóa Đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous">
</head>
<jsp:include page="../layout.jsp"/>
<body>
<h2 class="d-flex justify-content-center mt-3">Lịch Sử Hóa Đơn</h2>

<form action="/lich-su/hien-thi" method="get" id="filterSearchForm">
    <div class="row filter-section">
        <div class="col-md-4">
            <h5>Mã Số Hóa Đơn</h5>
            <input type="text" name="soHoaDon" class="form-control" placeholder="Nhập Mã Số Hóa Đơn"
                   value="${param.soHoaDon}">
        </div>
        <%--        <div class="col-md-4">--%>
        <%--            <h5>Tên Khách Hàng</h5>--%>
        <%--            <input type="text" name="tenKhachHang" class="form-control" placeholder="Nhập Tên Khách Hàng"--%>
        <%--                   value="${param.tenKhachHang}">--%>
        <%--        </div>--%>
        <div class="col-md-4">
            <h5>Ngày Tạo</h5>
            <input type="date" name="ngayTao" class="form-control"
                   value="${param.ngayTao}">
        </div>
        <div class="mt-2">
            <button type="button" class="btn btn-secondary-outline ms-2" onclick="resetFilters();">Reset</button>
        </div>
    </div>
</form>

<table class="table table-hover table-bordered text-center">
    <thead>
    <tr>
        <th>Mã số hóa đơn</th>
        <th>Tên khách hàng</th>
        <th>Tổng tiền</th>
        <th>Ghi chú</th>
        <th>Ngày tạo</th>
        <th>Trạng Thái</th>
        <th>Hàng động</th>
    </tr>
    </thead>
    <tbody>
    <c:if test="${empty data}">
        <tr>
            <td colspan="6">Không có hóa đơn nào để hiển thị.</td>
        </tr>
    </c:if>
    <c:forEach items="${data}" var="item">
        <tr>
            <td>${item.soHoaDon}</td>
            <td>${empty item.khachHang.tenKhachHang ? "Khách vãng lai" : item.khachHang.tenKhachHang}</td>
            <td>${item.tongTien}</td>
            <td>${empty item.ghiChu ? "Không" : item.ghiChu}</td>
            <td>
                <fmt:formatDate value="${item.ngayTao}" pattern="dd/MM/yyyy" />
            </td>
            <td>${item.tinh_trang == 4 ? "Hoàn Thành" : (item.tinh_trang == 13 ? "Hoàn Thành" : "Đã Hủy")}</td>
            <td>
                <a href="detail/${item.id}" class="btn btn-outline-custom">
                    <i class="fa-solid fa-circle-info"></i>
                </a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<nav aria-label="Page navigation" class="mt-3">
    <ul class="pagination justify-content-center">
        <c:if test="${currentPage > 0}">
            <li class="page-item">
                <a class="page-link" href="/lich-su/hien-thi?page=0&size=${size}" aria-label="First">
                    <span aria-hidden="true">&laquo;&laquo; First</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/lich-su/hien-thi?page=${currentPage - 1}&size=${size}"
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
                <a class="page-link" href="/lich-su/hien-thi?page=${currentPage + 1}&size=${size}"
                   aria-label="Next">
                    <span aria-hidden="true">Next &raquo;</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="/lich-su/hien-thi?page=${totalPages - 1}&size=${size}"
                   aria-label="Last">
                    <span aria-hidden="true">Last &raquo;&raquo;</span>
                </a>
            </li>
        </c:if>
    </ul>
</nav>

<script>
    function resetFilters() {
        document.querySelector('input[name="soHoaDon"]').value = '';

        // document.querySelector('input[name="tenKhachHang"]').value = '';

        document.querySelector('input[name="ngayTao"]').value = `${yyyy}-${mm}-${dd}`;

        document.getElementById('filterSearchForm').submit();
    }
</script>


</body>
</html>