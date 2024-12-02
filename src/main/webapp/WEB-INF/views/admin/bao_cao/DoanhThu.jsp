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

    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.3/angular.min.js"
            integrity="sha512-KZmyTq3PLx9EZl0RHShHQuXtrvdJ+m35tuOiwlcZfs/rE7NZv29ygNA8SFCkMXTnYZQK2OX0Gm2qKGfvWEtRXA=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>

</head>
<body>
<jsp:include page="../layout.jsp"/>
<div class="row" style="padding-left: 100px;">
    <%--body--%>
    <div class="row" style="text-align: center">
        <H1>Doanh Thu Cửa Hàng</H1>
    </div>
    <!-- Modal hiển thị báo cáo -->
    <div class="modal" tabindex="-1" id="reportModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Báo cáo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="reportContent">Đang tải báo cáo...</div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
</div>

<br>
<div class="row" style="padding-left: 100px">
    <div class="col-3">
        <h4 class="text-uppercase" style="font-weight: bold">Doanh thu tổng quan</h4>
        <p class="fst-italic" style="color: #AFAFAF">
            Xem vào lúc ${currentTime}
        </p>
    </div>
    <div class="col-6"></div>
    <div class="col-3 d-flex align-items-center">
        <button type="button" class="btn btn-success" onclick="exportToExcel()">Xuất file Excel</button>
    </div>
</div>

<br>
<div class="row" style="padding-left: 100px; padding-right: 100px">
    <table class="table table-borderless">
        <thead>
        <tr>
            <th scope="col" style="text-align: center; color: darkorchid">Số hóa đơn hoàn thành</th>
            <th scope="col" style="text-align: center; color: darkorchid">Số hóa đơn hủy</th>
            <th scope="col" style="text-align: center; color: darkorchid">Sản phẩm bán ra</th>
            <th scope="col" style="text-align: center; color: darkorchid">Sản phẩm bán chạy nhất</th>
            <th scope="col" style="text-align: center; color: darkorchid">TB doanh thu một ngày</th>
            <th scope="col" style="text-align: center; color: darkorchid">Tổng doanh thu tháng</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td class="text-center"><p><strong>${completedInvoices}</strong></p></td>
            <td class="text-center"><p><strong>${cancelledInvoices}</strong></p></td>
            <td class="text-center"><p><strong>${totalItemsSold}</strong></p></td>
            <td class="text-center"><p><strong>${bestProductName} - Đã bán ${bestProductQuantity}</strong></p></td>
            <td class="text-center"><p><strong>${averageDailyRevenue}</strong></p></td>
            <td class="text-center"><p><strong>${totalRevenue} VND</strong></p></td>
        </tr>

        </tbody>
    </table>
</div>

<div class="row" style="padding-left: 90px; padding-right: 150px;">
    <canvas id="myLineChart" width="600" height="200"></canvas> <!-- Giảm chiều cao từ 300 xuống 200 -->
</div>


</body>

<style>
    /* Dropdown Custom */
    .dropdown-custom {
        position: relative;
    }

    .dropdown-custom .dropdown-menu-custom {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        background-color: #0B745E;
        padding: 10px;
        list-style: none;
        margin: 0;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
        min-width: 160px;
    }

    .dropdown-custom:hover .dropdown-menu-custom {
        display: block;
    }

    .dropdown-custom .dropdown-item {
        color: white;
        padding: 10px;
        text-decoration: none;
        font-size: 16px;
    }

    .dropdown-custom .dropdown-item:hover {
        background-color: rgba(255, 255, 255, 0.1);
        border-radius: 5px;
    }

    /* Hover Effect for Nav Items */
    .nav-link:hover {
        background-color: rgba(255, 255, 255, 0.1);
        border-radius: 5px;
    }

    /* Logo Styling */
    .navbar-brand {
        font-size: 24px;
        color: white;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .navbar-nav {
            flex-direction: column;
        }
    }
</style>

<script>
    // Dữ liệu doanh thu theo ngày được truyền từ controller
    var dailyRevenue = ${dailyRevenue};  // Lấy dữ liệu doanh thu theo ngày từ model

    // Lấy thời gian hiện tại từ model
    var currentTime = "${currentTime}";

    // Lấy thông tin ngày tháng từ dữ liệu doanh thu
    var daysInMonth = dailyRevenue.length;  // Số ngày trong tháng (dựa trên độ dài của mảng dailyRevenue)

    // Tạo mảng các ngày trong tháng (ví dụ: "01", "02", "03", ..., "30")
    var daysLabels = [];
    for (var i = 1; i <= daysInMonth; i++) {
        daysLabels.push(i < 10 ? '0' + i : i.toString());
    }

    // Vẽ biểu đồ
    var ctx = document.getElementById('myLineChart').getContext('2d');
    var myLineChart = new Chart(ctx, {
        type: 'line',  // Loại biểu đồ là line chart
        data: {
            labels: daysLabels,  // Dữ liệu ngày (nhãn trên trục x)
            datasets: [{
                label: 'Doanh thu (VND)',  // Chú thích biểu đồ
                data: dailyRevenue,  // Dữ liệu doanh thu theo ngày
                borderColor: 'rgba(75, 192, 192, 1)',  // Màu viền của đường biểu đồ
                backgroundColor: 'rgba(75, 192, 192, 0.2)',  // Màu nền của biểu đồ
                borderWidth: 2  // Độ dày của viền đường biểu đồ
            }]
        },
        options: {
            responsive: true,  // Biểu đồ sẽ tự động điều chỉnh kích thước theo kích thước màn hình
            plugins: {
                legend: {
                    position: 'top',  // Vị trí của legend (chú thích biểu đồ)
                }
            },
            scales: {
                y: {
                    beginAtZero: true,  // Đặt trục y bắt đầu từ 0
                    ticks: {
                        callback: function (value) {
                            return value.toLocaleString();  // Hiển thị số tiền với định dạng địa phương (VND)
                        }
                    }
                }
            }
        }
    });
</script>

<script>
    // Hàm xuất dữ liệu ra Excel
    function exportToExcel() {
        var ws = XLSX.utils.table_to_sheet(document.querySelector("table"));
        var wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, "Doanh Thu");
        XLSX.writeFile(wb, "doanh_thu.xlsx");
    }
</script>


</html>