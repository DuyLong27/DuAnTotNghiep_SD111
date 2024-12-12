<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Giao diện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

</head>
<body>
<jsp:include page="../layout.jsp"/>
<div class="row" style="padding-left: 100px;">
    <div class="row" style="text-align: center">
        <H1>Báo Cáo</H1>
    </div>
    <div class="container">
        <div class="row mb-3">
            <form action="/bao-cao/hien-thi" method="get">
                <div class="row">
                    <div class="col-md-3">
                        <label>Ngày</label>
                        <input type="date" class="form-control" name="selectedDate" required
                               value="${selectedDate != null ? selectedDate : 'null'}" onchange="this.form.submit()">
                    </div>
                </div>
            </form>
        </div>

        <br>

        <div class="row">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th scope="col" class="text-center">Tổng số hóa đơn</th>
                    <th scope="col" class="text-center">Tổng sản phẩm bán được</th>
                    <th scope="col" class="text-center">Tổng doanh thu</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="text-center">${tongSoHoaDon != null ? tongSoHoaDon : 0}</td>
                    <td class="text-center">${tongSanPham != null ? tongSanPham : 0}</td>
                    <td class="text-center"><fmt:formatNumber value="${tongDoanhThu != null ? tongDoanhThu : 0}" type="number" pattern="#,###" /> VND</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
