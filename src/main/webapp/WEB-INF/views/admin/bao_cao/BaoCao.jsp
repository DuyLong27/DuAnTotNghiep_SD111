<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <!-- Form nhập thông tin -->
        <div class="row mb-3">
            <form action="/bao-cao/hang-ngay/xem" method="get">
                <div class="row">
                    <div class="col-md-3">
                        <label>Loại báo cáo</label>
                        <select class="form-select" name="reportType" required>
                            <option value="Doanh thu theo thu ngân"
                            ${param.reportType == 'Doanh thu theo thu ngân' ? 'selected' : ''}>Doanh thu theo thu ngân
                            </option>
                            <option value="Doanh thu theo sản phẩm"
                            ${param.reportType == 'Doanh thu theo sản phẩm' ? 'selected' : ''}>Doanh thu theo sản phẩm
                            </option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label>Ngày</label>
                        <input type="date" class="form-control" name="selectedDate" required
                               value="${selectedDate != null ? selectedDate : ''}">
                    </div>
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-primary mt-4">Xem báo cáo</button>
                </div>
            </form>
        </div>

        <br>

        <!-- Bảng dữ liệu báo cáo -->
        <c:if test="${not empty reportData}">
            <div class="row">
                <c:choose>
                    <%-- Báo cáo theo thu ngân --%>
                    <c:when test="${reportType == 'Doanh thu theo thu ngân'}">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th scope="col" class="text-center">Tên nhân viên</th>
                                <th scope="col" class="text-center">Tổng số đơn hoàn thành</th>
                                <th scope="col" class="text-center">Tổng tiền</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="data" items="${reportData}">
                                <tr>
                                    <td class="text-center">${data[0]}</td>
                                    <td class="text-center">${data[1]}</td>
                                    <td class="text-center">${data[2]} VND</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>

                    <%-- Báo cáo theo sản phẩm --%>
                    <c:when test="${reportType == 'Doanh thu theo sản phẩm'}">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th scope="col" class="text-center">Tên sản phẩm</th>
                                <th scope="col" class="text-center">Tổng số đơn hoàn thành</th>
                                <th scope="col" class="text-center">Tổng tiền</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="data" items="${reportData}">
                                <tr>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/uploads/${data[0]}"
                                             alt="${data[1]}" style="width: 100px; height: auto;">
                                        <div>${data[1]}</div>
                                    </td>
                                    <td class="text-center">${data[2]}</td>
                                    <td class="text-center">${data[3]} VND</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                </c:choose>
            </div>
        </c:if>
    </div>
</div>


</body>
</html>
