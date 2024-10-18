<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Sản Phẩm Chi Tiết</title>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 20px;
        }

        h4 {
            color: #343a40;
        }

        .form-label {
            font-weight: bold;
        }

        .table {
            margin-top: 20px;
        }

        .table th {
            background-color: #007bff;
            color: white;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }


        #productInfo {
            border: 1px solid #007bff;
            border-radius: 5px;
            padding: 10px;
            background-color: #e9f7ff;
            margin-top: 10px;
        }

        #productInfo p {
            margin: 0;
        }

        #editProductInfo {
            border: 1px solid #007bff;
            border-radius: 5px;
            padding: 10px;
            background-color: #e9f7ff;
            margin-top: 10px;
        }

        #editProductInfo p {
            margin: 0;
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
<jsp:include page="../layout.jsp" />
<div class="container mt-3">
    <h4>Danh sách sản phẩm chi tiết</h4>
    <!-- Thông báo -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert" id="successMessage">
                ${message}
        </div>
    </c:if>
    <form method="get" action="/spct/index" class="d-flex align-items-center">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
            Thêm sản phẩm
        </button>
        <div class="col-md-2 me-2 ms-3">
            <select name="tinhTrang" class="form-select" onchange="this.form.submit();">
                <option value="" ${param.tinhTrang == '' ? 'selected' : ''}>Tất Cả</option>
                <option value="1" ${param.tinhTrang == '1' ? 'selected' : ''}>Hoạt Động</option>
                <option value="0" ${param.tinhTrang == '0' ? 'selected' : ''}>Không Hoạt Động</option>
            </select>
        </div>
    </form>





    <!-- Modal Thêm -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Thêm Sản Phẩm Chi Tiết Mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/spct/add" method="post" id="productForm">
                        <div class="mb-3">
                            <label for="sanPham" class="form-label">Sản phẩm</label>
                            <select class="form-select" id="sanPham" name="sanPham.id" required onchange="displayProductInfo()">
                                <option value="" disabled selected>Chọn sản phẩm</option>
                                <c:forEach var="sp" items="${sanPhamList}">
                                    <!-- Chỉ hiển thị các sản phẩm có tình trạng là Hoạt Động -->
                                    <c:if test="${sp.tinhTrang == 1}">
                                        <option value="${sp.id}" data-price="${sp.giaBan}">${sp.ten}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>

                        <div id="productInfo" style="display:none;">
                            <p id="productId">ID: </p>
                            <p id="productName">Tên sản phẩm: </p>
                            <p id="productPrice">Giá Ban Đầu: </p>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label for="ma" class="form-label">Mã sản phẩm</label>
                                <input type="text" class="form-control" id="ma" name="ma" required>
                            </div>
                            <div class="col-md-4">
                                <label for="soLuong" class="form-label">Số lượng</label>
                                <input type="number" class="form-control" id="soLuong" name="soLuong" required>
                            </div>
                            <div class="col-md-4">
                                <label for="giaBan" class="form-label">Giá Bán</label>
                                <input type="number" class="form-control" id="giaBan" name="giaBan" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Tình Trạng</label><br>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tinhTrang" id="conHang" value="1"
                                           required>
                                    <label class="form-check-label" for="conHang">Hoạt Động</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tinhTrang" id="hetHang" value="0"
                                           required>
                                    <label class="form-check-label" for="hetHang">Không Hoạt Động</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label for="loaiCaPhe" class="form-label">Loại cà phê</label>
                                <select class="form-select" id="loaiCaPhe" name="loaiCaPhe.id" required>
                                    <option value="" disabled selected>Chọn loại cà phê</option>
                                    <c:forEach var="lcp" items="${loaiCaPheList}">
                                        <option value="${lcp.id}">${lcp.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label for="canNang" class="form-label">Cân nặng</label>
                                <select class="form-select" id="canNang" name="canNang.id" required>
                                    <option value="" disabled selected>Chọn cân nặng</option>
                                    <c:forEach var="cn" items="${canNangList}">
                                        <option value="${cn.id}">${cn.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="loaiHat" class="form-label">Loại hạt</label>
                                <select class="form-select" id="loaiHat" name="loaiHat.id" required>
                                    <option value="" disabled selected>Chọn loại hạt</option>
                                    <c:forEach var="lh" items="${loaiHatList}">
                                        <option value="${lh.id}">${lh.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="loaiTui" class="form-label">Loại túi</label>
                                <select class="form-select" id="loaiTui" name="loaiTui.id" required>
                                    <option value="" disabled selected>Chọn loại túi</option>
                                    <c:forEach var="loaitui" items="${loaiTuiList}">
                                        <option value="${loaitui.id}">${loaitui.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label for="mucDoRang" class="form-label">Mức độ rang</label>
                                <select class="form-select" id="mucDoRang" name="mucDoRang.id" required>
                                    <option value="" disabled selected>Chọn mức độ rang</option>
                                    <c:forEach var="mdr" items="${mucDoRangList}">
                                        <option value="${mdr.id}">${mdr.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="huongVi" class="form-label">Hương vị</label>
                                <select class="form-select" id="huongVi" name="huongVi.id" required>
                                    <option value="" disabled selected>Chọn hương vị</option>
                                    <c:forEach var="hv" items="${huongViList}">
                                        <option value="${hv.id}">${hv.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="thuongHieu" class="form-label">Thương hiệu</label>
                                <select class="form-select" id="thuongHieu" name="thuongHieu.id" required>
                                    <option value="" disabled selected>Chọn thương hiệu</option>
                                    <c:forEach var="th" items="${thuongHieuList}">
                                        <option value="${th.id}">${th.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                        <button type="button" class="btn btn-secondary" onclick="resetForm()">Reset</button>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <!-- Modal Sửa -->
    <div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProductModalLabel">Sửa Sản Phẩm Chi Tiết</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/spct/update" method="post" id="editProductForm">
                        <input type="hidden" id="editProductId" name="id"> <!-- Hidden field to store product ID -->
                        <div class="mb-3">
                            <label for="editSanPham" class="form-label">Sản phẩm</label>
                            <select class="form-select" id="editSanPham" name="sanPham.id" hidden>
                                <option value="" disabled selected>Chọn sản phẩm</option>
                                <c:forEach var="sp" items="${sanPhamList}">
                                    <option value="${sp.id}" data-price="${sp.giaBan}">${sp.ten}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div id="editProductInfo" style="display:none;">
                            <p id="editProductIdDisplay">ID: </p>
                            <p id="editProductName">Tên sản phẩm: </p>
                            <p id="editProductPrice">Giá Ban Đầu: </p>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label for="editMa" class="form-label">Mã sản phẩm</label>
                                <input type="text" class="form-control" id="editMa" name="ma" required>
                            </div>
                            <div class="col-md-4">
                                <label for="editSoLuong" class="form-label">Số lượng</label>
                                <input type="number" class="form-control" id="editSoLuong" name="soLuong" required>
                            </div>
                            <div class="col-md-4">
                                <label for="editGiaBan" class="form-label">Giá Bán</label>
                                <input type="number" class="form-control" id="editGiaBan" name="giaBan" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Tình Trạng</label><br>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tinhTrang" id="updateconHang"
                                           value="1" required>
                                    <label class="form-check-label" for="updateconHang">Hoạt Động</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tinhTrang" id="updatehetHang"
                                           value="0" required>
                                    <label class="form-check-label" for="updatehetHang">Không Hoạt Động</label>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label for="loaiCaPhe" class="form-label">Loại cà phê</label>
                                <select class="form-select" id="updateloaiCaPhe" name="loaiCaPhe.id" required>
                                    <option value="" disabled selected>Chọn loại cà phê</option>
                                    <c:forEach var="lcp" items="${loaiCaPheList}">
                                        <option value="${lcp.id}">${lcp.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label for="canNang" class="form-label">Cân nặng</label>
                                <select class="form-select" id="updatecanNang" name="canNang.id" required>
                                    <option value="" disabled selected>Chọn cân nặng</option>
                                    <c:forEach var="cn" items="${canNangList}">
                                        <option value="${cn.id}">${cn.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="loaiHat" class="form-label">Loại hạt</label>
                                <select class="form-select" id="updateloaiHat" name="loaiHat.id" required>
                                    <option value="" disabled selected>Chọn loại hạt</option>
                                    <c:forEach var="lh" items="${loaiHatList}">
                                        <option value="${lh.id}">${lh.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="loaiTui" class="form-label">Loại túi</label>
                                <select class="form-select" id="updateloaiTui" name="loaiTui.id" required>
                                    <option value="" disabled selected>Chọn loại túi</option>
                                    <c:forEach var="loaitui" items="${loaiTuiList}">
                                        <option value="${loaitui.id}">${loaitui.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label for="mucDoRang" class="form-label">Mức độ rang</label>
                                <select class="form-select" id="updatemucDoRang" name="mucDoRang.id" required>
                                    <option value="" disabled selected>Chọn mức độ rang</option>
                                    <c:forEach var="mdr" items="${mucDoRangList}">
                                        <option value="${mdr.id}">${mdr.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="huongVi" class="form-label">Hương vị</label>
                                <select class="form-select" id="updatehuongVi" name="huongVi.id" required>
                                    <option value="" disabled selected>Chọn hương vị</option>
                                    <c:forEach var="hv" items="${huongViList}">
                                        <option value="${hv.id}">${hv.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="thuongHieu" class="form-label">Thương hiệu</label>
                                <select class="form-select" id="updatethuongHieu" name="thuongHieu.id" required>
                                    <option value="" disabled selected>Chọn thương hiệu</option>
                                    <c:forEach var="th" items="${thuongHieuList}">
                                        <option value="${th.id}">${th.ten}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-warning">Cập nhật sản phẩm</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <table class="table table-bordered table-hover text-center">
        <thead class="table-light">
        <tr>
            <th>STT</th>
            <th>Mã</th>
            <th>Ngày hết hạn</th>
            <th>Số lượng</th>
            <th>Giá Bán</th>
            <th>Tên Sản Phẩm</th>
            <th>Loại cà phê</th>
            <th>Cân nặng</th>
            <th>Loại hạt</th>
            <th>Loại túi</th>
            <th>Mức độ rang</th>
            <th>Hương vị</th>
            <th>Thương hiệu</th>
            <th>Tình trạng</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty sanPhamChiTietList}">
            <tr>
                <td colspan="15">Không tìm thấy đối tượng nào.</td>
            </tr>
        </c:if>
        <c:if test="${not empty sanPhamChiTietList}">
            <c:forEach var="sanPhamChiTiet" items="${sanPhamChiTietList}" varStatus="i">
                <tr>
                    <td>${i.index + 1}</td>
                    <td>${sanPhamChiTiet.ma}</td>
                    <td>${sanPhamChiTiet.ngayHetHan}</td>
                    <td>${sanPhamChiTiet.soLuong}</td>
                    <td>${sanPhamChiTiet.giaBan}</td>
                    <td>${sanPhamChiTiet.sanPham.ten}</td>
                    <td>${sanPhamChiTiet.loaiCaPhe.ten}</td>
                    <td>${sanPhamChiTiet.canNang.ten}</td>
                    <td>${sanPhamChiTiet.loaiHat.ten}</td>
                    <td>${sanPhamChiTiet.loaiTui.ten}</td>
                    <td>${sanPhamChiTiet.mucDoRang.ten}</td>
                    <td>${sanPhamChiTiet.huongVi.ten}</td>
                    <td>${sanPhamChiTiet.thuongHieu.ten}</td>
                    <td class="${sanPhamChiTiet.tinhTrang == 1 ? 'text-success' : 'text-danger'}">
                            ${sanPhamChiTiet.tinhTrang == 1 ? 'Hoạt Động' : 'Không Hoạt Động'}</td>
                    <td>
                        <div class="d-flex justify-content-center">
                            <a class="btn btn-warning btn-sm me-2" data-bs-toggle="modal" data-bs-target="#editProductModal" data-id="${sanPhamChiTiet.id}" data-ma="${sanPhamChiTiet.ma}" data-soLuong="${sanPhamChiTiet.soLuong}" data-giaBan="${sanPhamChiTiet.giaBan}" data-sanPhamId="${sanPhamChiTiet.sanPham.id}" data-loaiCaPheId="${sanPhamChiTiet.loaiCaPhe.id}" data-canNangId="${sanPhamChiTiet.canNang.id}" data-loaiHatId="${sanPhamChiTiet.loaiHat.id}" data-loaiTuiId="${sanPhamChiTiet.loaiTui.id}" data-mucDoRangId="${sanPhamChiTiet.mucDoRang.id}" data-huongViId="${sanPhamChiTiet.huongVi.id}" data-thuongHieuId="${sanPhamChiTiet.thuongHieu.id}" data-tinhTrang="${sanPhamChiTiet.tinhTrang}"><i class="fas fa-edit"></i> Sửa</a>
<%--                            <a href="${pageContext.request.contextPath}/spct/delete/${sanPhamChiTiet.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?')"><i class="fas fa-trash-alt"></i> Xóa</a>--%>
                        </div>
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
                    <a class="page-link" href="/spct/index?page=0&size=${data.size}" aria-label="First">
                        <span aria-hidden="true">&laquo;&laquo; First</span>
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="/spct/index?page=${currentPage - 1}&size=${data.size}"
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
                    <a class="page-link" href="/spct/index?page=${currentPage + 1}&size=${data.size}"
                       aria-label="Next">
                        <span aria-hidden="true">Next &raquo;</span>
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="/spct/index?page=${totalPages - 1}&size=${data.size}" aria-label="Last">
                        <span aria-hidden="true">Last &raquo;&raquo;</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

<script>
    function displayProductInfo() {
        var select = document.getElementById("sanPham");
        var productInfo = document.getElementById("productInfo");
        var selectedOption = select.options[select.selectedIndex];

        if (selectedOption) {
            document.getElementById("productId").innerText = "ID: " + selectedOption.value;
            document.getElementById("productName").innerText = "Tên sản phẩm: " + selectedOption.text;
            document.getElementById("productPrice").innerText = "Giá Ban Đầu: " + selectedOption.getAttribute("data-price");
            productInfo.style.display = "block";
        } else {
            productInfo.style.display = "none";
        }
    }


    function resetForm() {
        document.getElementById("productForm").reset();
        document.getElementById("productInfo").style.display = "none";
    }


    const editProductModal = document.getElementById('editProductModal');
    editProductModal.addEventListener('show.bs.modal', (event) => {
        const button = event.relatedTarget; // Button that triggered the modal
        const id = button.getAttribute('data-id');
        const ma = button.getAttribute('data-ma');
        const soLuong = button.getAttribute('data-soLuong');
        const giaBan = button.getAttribute('data-giaBan');
        const sanPhamId = button.getAttribute('data-sanPhamId'); // ID sản phẩm chính
        const loaiCaPheId = button.getAttribute('data-loaiCaPheId');
        const canNangId = button.getAttribute('data-canNangId');
        const loaiHatId = button.getAttribute('data-loaiHatId');
        const loaiTuiId = button.getAttribute('data-loaiTuiId');
        const mucDoRangId = button.getAttribute('data-mucDoRangId');
        const huongViId = button.getAttribute('data-huongViId');
        const thuongHieuId = button.getAttribute('data-thuongHieuId');
        const tinhTrang = button.getAttribute('data-tinhTrang');

        const editProductId = editProductModal.querySelector('#editProductId');
        const editMa = editProductModal.querySelector('#editMa');
        const editSoLuong = editProductModal.querySelector('#editSoLuong');
        const editGiaBan = editProductModal.querySelector('#editGiaBan');
        const editSanPham = editProductModal.querySelector('#editSanPham');
        const editLoaicaPhe = editProductModal.querySelector('#updateloaiCaPhe');
        const editCanNang = editProductModal.querySelector('#updatecanNang');
        const editLoaiHat = editProductModal.querySelector('#updateloaiHat');
        const editLoaiTui = editProductModal.querySelector('#updateloaiTui');
        const editMucDoRang = editProductModal.querySelector('#updatemucDoRang');
        const editHuongVi = editProductModal.querySelector('#updatehuongVi');
        const editThuongHieu = editProductModal.querySelector('#updatethuongHieu');

        editProductId.value = id;
        editMa.value = ma;
        editSoLuong.value = soLuong;
        editGiaBan.value = giaBan;
        editSanPham.value = sanPhamId;
        editLoaicaPhe.value = loaiCaPheId;
        editCanNang.value = canNangId;
        editLoaiHat.value = loaiHatId;
        editLoaiTui.value = loaiTuiId;
        editMucDoRang.value = mucDoRangId;
        editHuongVi.value = huongViId;
        editThuongHieu.value = thuongHieuId;

        // Đặt tình trạng sản phẩm
        if (tinhTrang == 1) {
            document.getElementById('updateconHang').checked = true;
        } else {
            document.getElementById('updatehetHang').checked = true;
        }

        // Hiển thị thông tin sản phẩm
        const selectedSanPham = editSanPham.options[editSanPham.selectedIndex];
        const productPrice = selectedSanPham.getAttribute('data-price');

        // Hiển thị ID sản phẩm chính
        document.getElementById('editProductIdDisplay').innerText = 'ID Sản Phẩm: ' + sanPhamId; // Sử dụng sanPhamId
        document.getElementById('editProductName').innerText = 'Tên Sản Phẩm: ' + selectedSanPham.text;
        document.getElementById('editProductPrice').innerText = 'Giá Ban Đầu: ' + productPrice;

        // Hiển thị thông tin chi tiết
        document.getElementById('editProductInfo').style.display = 'block';
    });




    // Ẩn thông báo sau 3 giây
    window.onload = function () {
        var successMessage = document.getElementById("successMessage");
        if (successMessage) {
            setTimeout(function () {
                successMessage.style.display = 'none';
            }, 3000); // 3 giây
        }
    };



    document.addEventListener("DOMContentLoaded", function () {
        // Lấy giá trị query parameter
        const urlParams = new URLSearchParams(window.location.search);
        const productId = urlParams.get('id');
        const openModal = urlParams.get('openModal');

        if (openModal === 'true' && productId) {
            // Tự động mở modal
            $('#addProductModal').modal('show');

            // Chọn sản phẩm theo ID
            var select = document.getElementById("sanPham");
            for (let i = 0; i < select.options.length; i++) {
                if (select.options[i].value == productId) {
                    select.selectedIndex = i; // Chọn sản phẩm
                    displayProductInfo();  // Hiển thị thông tin sản phẩm đã chọn
                    break;
                }
            }
        }
    });
</script>
</body>
</html>
