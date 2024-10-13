<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Giao diện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.3/angular.min.js"
            integrity="sha512-KZmyTq3PLx9EZl0RHShHQuXtrvdJ+m35tuOiwlcZfs/rE7NZv29ygNA8SFCkMXTnYZQK2OX0Gm2qKGfvWEtRXA=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

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

        /*Select bar*/
        .search-bar {
            display: flex;
            flex-grow: 1;
            margin: 0 20px;
        }

        .search-bar input[type="text"] {
            width: 90%;
            padding: 10px;
            margin-right: 5px;
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px;
        }

        .search-bar button {
            padding: 10px;
            border: 1px solid #ddd;
            border-left: none;
            background-color: #545252;
            color: white;
            border-radius: 0 4px 4px 0;
        }

        .select-category {
            font-size: 23px;
            margin-top: 20px;
            margin-bottom: 20px;
            padding-left: 32px;
        }

        /*Product list*/
        .listProduct .item img {
            width: 90%;
        }

        .listProduct {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            padding: 5px 5px;
        }

        .listProduct .item {
            background-color: #eeee;
            padding: 20px;
            border-radius: 20px;
            position: relative;
            text-align: center;
            width: 190px;
            height: 264px;
        }

        .listProduct .item .price1 {
            letter-spacing: 3px;
            font-size: 20px;
            text-decoration-line: line-through;
            color: #AFAFAF;
        }

        .listProduct .item .price2 {
            letter-spacing: 3px;
            font-size: 20px;
            font-weight: bold;
            color: #F62400;
        }

        .listProduct .item h2 {
            font-size: 15px;
            padding-top: 10px;
        }

        .listProduct .item span {
            width: 40px;
            height: 30px;
            background-color: darkgreen;
            justify-content: center;
            align-items: center;
            color: #fff;
            border-radius: 20%;
            position: absolute;
            top: 2%;
            left: -20px;
            text-align: center;
        }

        /*Thong tin don hang*/
        .order-summary {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            height: 915px;
        }

        .order-summary .amount span {
            border: 1px #dddddd solid;
            border-radius: 30%;
            width: 30px;
            text-align: center;
            margin-left: 5px;
            margin-right: 5px;
        }

        .order-summary .amount svg {
            border: 1px #dddddd solid;
            border-radius: 30%;
            width: 30px;
            height: 32px;
        }

        .order-summary table {
            width: 100%;
            border-top: 1px solid #888;
        }

        .order-summary table tbody {
            /*height: 200px;*/
        }

        .order-summary table thead tr th:first-child {
            text-align: left;
        }

        .order-summary table td {
            /*border-bottom: 1px solid #ddd;*/
            /*padding: 12px 0;*/
        }

        .order-summary table thead tr th:last-child {
            text-align: right;
        }

        .order-summary table tbody tr td:last-child {
            text-align: center;
        }

        .order-summary table thead tr th {
            border-right: 1px solid #888;
            border-bottom: 1px solid #888;
        }

        .order-summary table tbody tr td {
            /*border-right: 1px solid #888;*/
        }


        .total {
            font-size: 1.5em;
            font-weight: bold;
        }

        .add-product {
            width: 100%;
            border-bottom-right-radius: 50%;
            border-bottom-left-radius: 50%;
        }


        /* Responsive adjustments */
        @media (max-width: 768px) {
            .navbar-nav {
                flex-direction: column;
            }
        }

    </style>

</head>
<body>
<%--header--%>
<nav class="navbar navbar-expand-sm navbar-dark shadow-lg" style="background-color: #0B745E; height: 80px;">
    <div class="container d-flex align-items-center">
        <a href="#" class="navbar-brand d-flex align-items-center">
            <img src="../../lib/logo_xanh.png" style="height: 60px; margin-right: 10px;" alt="Logo">
        </a>

        <ul class="navbar-nav mx-auto" style="flex-grow: 1; justify-content: center; gap: 20px;">
            <li class="nav-item">
                <a class="nav-link text-light" href="#">Tổng quan</a>
            </li>

            <!-- Dropdown Custom -->
            <li class="nav-item dropdown-custom">
                <a href="#" class="nav-link text-light">Hàng hóa</a>
                <ul class="dropdown-menu-custom">
                    <li><a class="dropdown-item" href="#">Sản phẩm</a></li>
                    <li><a class="dropdown-item" href="#">Kho hàng</a></li>
                </ul>
            </li>

            <li class="nav-item dropdown-custom">
                <a href="#" class="nav-link text-light">Giao dịch</a>
                <ul class="dropdown-menu-custom">
                    <li><a class="dropdown-item" href="#">Bán hàng</a></li>
                    <li><a class="dropdown-item" href="#">Nhập hàng</a></li>
                    <li><a class="dropdown-item" href="#">Hóa đơn</a></li>
                </ul>
            </li>

            <li class="nav-item dropdown-custom">
                <a href="#" class="nav-link text-light">Đối tác</a>
                <ul class="dropdown-menu-custom">
                    <li><a class="dropdown-item" href="#">Khách hàng</a></li>
                    <li><a class="dropdown-item" href="#">Nguồn nhập</a></li>
                </ul>
            </li>

            <li class="nav-item">
                <a class="nav-link text-light" href="#">Nhân viên</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-light" href="#">Khuyến mãi</a>
            </li>
        </ul>

        <ul class="navbar-nav">
            <li class="nav-item dropdown-custom">
                <a href="#" class="nav-link text-light">Tài khoản</a>
                <ul class="dropdown-menu-custom">
                    <li><a class="dropdown-item" href="#">Thông tin</a></li>
                    <li><a class="dropdown-item" href="#">Đăng xuất</a></li>
                </ul>
            </li>
            <li class="nav-item">
                <span class="btn rounded-pill text-white" style="padding: 10px 15px;"><i
                        class="fa-solid fa-user"></i></span>
            </li>
        </ul>
    </div>
</nav>
<img src="/lib/background_quanly.png" style="width: 100%; height: auto;">

<%--body--%>
<div class="container mt-3">
    <div class="row">
        <h2 class="d-flex justify-content-center">Trang Bán Hàng</h2>
        <!-- Select option -->
        <div class="search-bar">
            <input type="text" placeholder="Tìm kiếm sản phẩm">
            <button type="submit">Tìm kiếm</button>
        </div>
        <div class="select-category">
            <select name="categories" id="categories">
                <option value="all">Sắp xếp</option>
                <option value="phones">Mới Nhất</option>
                <option value="electronics">Thứ Tự Theo Mức Độ Phổ Biến</option>
                <option value="accessories">Giá Tăng Dần</option>
                <option value="laptops">Giá Giảm Dần</option>
            </select>
        </div>
        <ul class="nav justify-content-end" style="padding-right: 24px">
            <button class="nav-item" onclick="createPendingInvoice(); displayPendingInvoices()">Tạo hóa đơn mới</button>
            <select class="nav-item" style="margin-left: 20px" id="invoiceSelector" onchange="selectInvoice()">
                <option value="">Chọn hóa đơn</option>
            </select>
        </ul>
        <div class="row" style="padding-top: 15px">
            <div class="col-8" style="display: flex; max-height: 820px;">
                <div class="row">
                    <c:forEach var="product" items="${productList}">
                        <div class="col-3 listProduct">
                            <div class="item">
                                <span>-10%</span>
                                <img src="/lib/logo_xanh.png" alt="${product.ten}" style="width: 90%;">
                                <h2>${product.ten}</h2>
                                <div class="price1">899.000<sup>$</sup></div>
                                <div class="price2">${product.giaBan}<sup>$</sup></div>
                                    <%--                                <button class="add-product" onclick="addToInvoice('${product.ten}', ${product.giaBan})">Add</button>--%>
                                <form class="add-product" action="<c:url value='add-to-invoice'/>" method="post">
                                    <input type="hidden" name="productId" value="${product.id}"/>
                                    <button type="submit">Thêm</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                    <div>
                        <ul class="pagination justify-content-center" style="margin:20px 0">
                            <li class="page-item">
                            <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item"><a class="page-link" href="#">Next</a></li>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="pendingInvoices" class="col-4 order-summary">
                <h2>Hóa đơn</h2>
                <ul id="pendingInvoiceList">
                    <li>Chưa có hóa đơn nào.</li>
                </ul>
                <form action="">
                    <table>
                        <thead>
                        <tr>
                            <th>Sản Phẩm</th>
                            <th>Giá</th>
                            <th>Số Lượng</th>
                            <th>Chọn</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${invoice}" var="invoice">
                            <tr>
                                <td style="display: flex; font-size: small; align-items: center;">
                                    <img style="width: 70px; margin-right: 10px" src="/lib/logo_xanh.png"
                                         alt="${invoice.ten}">${invoice.ten}
                                </td>
                                <td style="font-size: small; padding-top: 18px; padding-left: 5px; padding-right: 5px">
                                    <p><span>${invoice.giaBan}</span><sup>$</sup></p>
                                </td>
                                <td style="font-size: small; padding-left: 25px;">
                                    <input style="width: 30px; outline: none;" type="number" value="${item.quantity}1"
                                           min="0">
                                </td>
                                <td>
                                    <button onclick="deleteItem('${item.product}')">Xóa</button>
                                </td>
                            </tr>
                        </c:forEach>
                        <td>Tạm tính: <c:out value="${total}"/></td>
                        </tbody>
                    </table>
                </form>
                <div class="mb-3">
                    <h3>Khuyến mãi</h3>
                    <hr>
                    <div style="display:flex;">
                        <label for="promotion" class="form-label" style="padding-right: 180px">
                            Mã khuyến mãi
                        </label>
                        <a href="/khuyen-mai/hien-thi">Xem tất cả
                            <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                                 xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                                 viewBox="0 0 24 24">
                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                      stroke-width="2" d="m9 5 7 7-7 7"/>
                            </svg>
                        </a>
                    </div>
                    <input type="text" class="form-control" id="promotion" value="Không có" readonly>
                </div>
                <hr>
                <div class="mb-3">
                    <label for="notes" class="form-label"><h3>Ghi chú đơn hàng</h3></label>
                    <textarea class="form-control" id="notes" rows="3"></textarea>
                </div>
                <hr>
                <div class="mb-3 total" style="align-items: center">
                    <h3>Tổng tiền</h3>
                    <hr>
                    <span style="font-weight: bold; display: flex; justify-content: center; font-size: 30px"><c:out value="${total}"/></span>
                </div>
                <hr>
                <div style="display: flex; justify-content: center; height: 6%; margin-top: 26px">
                    <button type="button" class="btn btn-primary" style="width: 189px;font-size: 26px;">Thanh toán
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>

<%--<script>--%>
<%--    let invoiceCounter = 0;--%>
<%--    let invoices = [];--%>
<%--    let selectedInvoiceId = null;--%>

<%--    function createNewInvoice() {--%>
<%--        invoiceCounter++;--%>
<%--        let newInvoice = {--%>
<%--            id: invoiceCounter,--%>
<%--            items: [],--%>
<%--            totalAmount: 0--%>
<%--        };--%>
<%--        invoices.push(newInvoice);--%>
<%--        updateInvoiceSelector();--%>
<%--        selectInvoiceById(invoiceCounter);--%>
<%--    }--%>

<%--    function addToInvoice(ten, giaBan) {--%>
<%--        if (!selectedInvoiceId) {--%>
<%--            alert("Vui lòng chọn hóa đơn trước khi thêm sản phẩm.");--%>
<%--            return;--%>
<%--        }--%>

<%--        const currentInvoice = invoices.find(invoice => invoice.id === parseInt(selectedInvoiceId));--%>

<%--        // Kiểm tra xem sản phẩm đã tồn tại trong hóa đơn chưa--%>
<%--        const existingItem = currentInvoice.items.find(item => item.product === ten);--%>

<%--        if (existingItem) {--%>
<%--            existingItem.quantity += 1; // Tăng số lượng nếu sản phẩm đã tồn tại--%>
<%--        } else {--%>
<%--            currentInvoice.items.push({ product: ten, price: giaBan, quantity: 1 });--%>
<%--        }--%>

<%--        currentInvoice.totalAmount += giaBan; // Cập nhật tổng tiền--%>
<%--        console.log(ten,giaBan)--%>
<%--        displayInvoices(); // Hiển thị hóa đơn--%>
<%--    }--%>


<%--    function deleteInvoice(id) {--%>
<%--        invoices = invoices.filter(invoice => invoice.id !== id);--%>
<%--        selectedInvoiceId = null;--%>
<%--        updateInvoiceSelector();--%>
<%--        displayInvoices();--%>
<%--    }--%>

<%--    function selectInvoice() {--%>
<%--        const selector = document.getElementById('invoiceSelector');--%>
<%--        selectedInvoiceId = selector.value;--%>
<%--        displayInvoices();--%>
<%--    }--%>

<%--    function selectInvoiceById(id) {--%>
<%--        const selector = document.getElementById('invoiceSelector');--%>
<%--        selectedInvoiceId = id;--%>
<%--        selector.value = id;--%>
<%--        displayInvoices();--%>
<%--    }--%>

<%--    function updateInvoiceSelector() {--%>
<%--        const selector = document.getElementById('invoiceSelector');--%>
<%--        selector.innerHTML = '<option value="">Chọn hóa đơn</option>';--%>
<%--        invoices.forEach(invoice => {--%>
<%--            const option = document.createElement('option');--%>
<%--            option.value = invoice.id;--%>
<%--            option.textContent = `Hóa Đơn ${invoice.id}`;--%>
<%--            selector.appendChild(option);--%>
<%--        });--%>
<%--    }--%>

<%--    function displayInvoices() {--%>
<%--        const tbody = document.querySelector("#invoices tbody");--%>
<%--        tbody.innerHTML = ''; // Xóa nội dung hiện tại của tbody--%>

<%--        if (!selectedInvoiceId) {--%>
<%--            tbody.innerHTML = '<tr><td colspan="4">Chưa có hóa đơn nào được chọn.</td></tr>';--%>
<%--            return;--%>
<%--        }--%>

<%--        let currentInvoice = invoices.find(invoice => invoice.id === parseInt(selectedInvoiceId));--%>

<%--        if (currentInvoice) {--%>
<%--            console.log(currentInvoice.items); // Thêm dòng này để kiểm tra items--%>
<%--            console.log("Selected Invoice ID:", selectedInvoiceId);--%>
<%--            currentInvoice.items.forEach(item => {--%>
<%--                tbody.innerHTML += ``;--%>
<%--            });--%>

<%--            // Cập nhật tổng tiền--%>
<%--            const totalRow = document.createElement('tr');--%>
<%--            totalRow.innerHTML = `<td colspan="3">Tạm tính: </td><td>${currentInvoice.totalAmount}<sup>$</sup></td>`;--%>
<%--            tbody.appendChild(totalRow);--%>
<%--        }--%>
<%--    }--%>

<%--    // Hàm xóa sản phẩm--%>
<%--    function deleteItem(ten) {--%>
<%--        let currentInvoice = invoices.find(invoice => invoice.id === parseInt(selectedInvoiceId));--%>
<%--        currentInvoice.items = currentInvoice.items.filter(item => item.product !== ten);--%>
<%--        currentInvoice.totalAmount -= currentInvoice.items.find(item => item.product === ten)?.price || 0;--%>

<%--        displayInvoices();--%>
<%--    }--%>

<%--</script>--%>
</html>