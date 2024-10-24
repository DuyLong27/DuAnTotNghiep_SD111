
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Danh sách sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

</head>
<body>
<jsp:include page="../header_user.jsp"/>


<div class="container my-5">
    <h1 class="text-center mb-4">Danh sách giỏ hàng</h1>

    <!-- Bảng danh sách sản phẩm trong giỏ hàng -->

        <table class="table table-hover">
            <thead class="table-light">
            <tr>
                <th scope="col-2">Chọn</th>
                <th scope="col-4">Tên sản phẩm</th>
                <th scope="col-2">Số lượng</th>
                <th scope="col-2">Đơn giá</th>
                <th scope="col-2">Tổng tiền</th>
                <th scope="col-2">Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listGioHang}" var="item">
                <tr>
                    <td>
                        <form action="/gio-hang/tam-tinh" method="post">
                        <!-- Thay đổi form submit cho việc tính tạm tính -->
                        <input class="form-check-input" type="checkbox" name="selectedProducts"
                               value="${item.id}" <c:if test="${selectedIds != null && selectedIds.contains(item.id)}">checked</c:if>
                               onchange="this.form.submit();">
                        </form>
                    </td>
                    <td>
                        <img style="width:70px"
                             src="${pageContext.request.contextPath}/uploads/${item.sanPhamChiTiet.hinhAnh}"
                             alt="${item.sanPhamChiTiet.sanPham.ten}">
                            ${item.sanPhamChiTiet.sanPham.ten}
                    </td>
                    <td>
                        <input type="number" value="${item.soLuong}" class="soLuong" readonly>
                    </td>
                    <td>${item.giaBan} VND</td>
                    <td>${item.soLuong * item.giaBan} VND</td>
                    <td>
                        <form action="xoa-san-pham" method="post" style="display: inline;">
                            <input type="hidden" name="id" value="${item.id}"/>
                            <button type="submit" class="btn btn-danger">Xóa</button>
                        </form>
                    </td>

                </tr>
            </c:forEach>
            </tbody>
        </table>
    <form action="/gio-hang/tam-tinh" method="post">
        <div>
            <h3 class="text-start">Tạm tính: <span style="color: red">${tamTinh} VND</span></h3>
        </div>
    </form>
</div>


<jsp:include page="../footer_user.jsp"/>
</body>
</html>