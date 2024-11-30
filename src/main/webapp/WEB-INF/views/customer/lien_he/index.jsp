<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Liên Hệ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.3/angular.min.js"
            integrity="sha512-KZmyTq3PLx9EZl0RHShHQuXtrvdJ+m35tuOiwlcZfs/rE7NZv29ygNA8SFCkMXTnYZQK2OX0Gm2qKGfvWEtRXA=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        /* Contact Page Styles */
        .contact-page {
            padding: 50px 15px;
            background-color: #ffffff;
            color: #333;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            max-width: 1200px;
            margin: 30px auto;
        }

        .contact-title {
            color: #0B745E;
            font-size: 36px;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
        }

        .contact-description {
            text-align: center;
            color: #555;
            margin-bottom: 40px;
            font-size: 18px;
        }

        .contact-info {
            background-color: #eafaf4;
            border-radius: 8px;
            padding: 20px;
            color: #0B745E;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .contact-info h3 {
            font-size: 24px;
            margin-bottom: 15px;
            color: #0B745E;
        }

        .contact-info p {
            margin-bottom: 10px;
            font-size: 16px;
        }

        /* Form Styles */
        .contact-form {
            background-color: #f9f9f9;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .contact-form .form-group {
            margin-bottom: 20px;
        }

        .contact-form label {
            display: block;
            font-size: 14px;
            color: #333;
            margin-bottom: 5px;
        }

        .contact-form input,
        .contact-form textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            color: #333;
            box-sizing: border-box;
        }

        .contact-form input:focus,
        .contact-form textarea:focus {
            border-color: #0B745E;
            outline: none;
        }

        .contact-form button {
            background-color: #0B745E;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        .contact-form button:hover {
            background-color: #095c49;
        }
    </style>

</head>
<body>
<jsp:include page="../header_user.jsp"/>
<div class="contact-page">
    <div class="container">
        <h1 class="contact-title">Liên hệ với The Nature Coffee</h1>
        <p class="contact-description">
            Chúng tôi rất vui lòng được hỗ trợ bạn! Vui lòng điền vào biểu mẫu dưới đây hoặc liên hệ trực tiếp với chúng tôi qua các thông tin liên lạc.
        </p>
        <div class="row">
            <!-- Contact Form -->
            <div class="col-lg-7 col-md-12">
                <form class="contact-form">
                    <div class="form-group">
                        <label for="name">Họ và Tên</label>
                        <input type="text" id="name" class="form-control" placeholder="Nhập họ và tên của bạn" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" class="form-control" placeholder="Nhập email của bạn" required>
                    </div>
                    <div class="form-group">
                        <label for="subject">Tiêu đề</label>
                        <input type="text" id="subject" class="form-control" placeholder="Nhập tiêu đề liên hệ" required>
                    </div>
                    <div class="form-group">
                        <label for="message">Nội dung</label>
                        <textarea id="message" class="form-control" rows="5" placeholder="Nhập nội dung liên hệ" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Gửi liên hệ</button>
                </form>
            </div>
            <!-- Contact Info -->
            <div class="col-lg-5 col-md-12 contact-info">
                <h3>Thông tin liên hệ</h3>
                <p><strong>Địa chỉ:</strong> Số 123 Tây Tựu, Bắc Từ Liêm, Hà Nội, Việt Nam</p>
                <p><strong>Email:</strong> contact@thenaturecoffee.com</p>
                <p><strong>Hotline:</strong> 0123-456-789</p>
                <p><strong>Giờ làm việc:</strong> Thứ 2 - Thứ 6: 8:00 - 18:00</p>
                <p>Thứ 7 - Chủ nhật: 9:00 - 17:00</p>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../footer_user.jsp"/>
</body>
</html>