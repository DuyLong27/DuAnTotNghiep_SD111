<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <title>The Nature Coffee</title>
    <style>
        /* Importing Google fonts */
        @import url('https://fonts.googleapis.com/css?family=Miniver& family=Poppins:ital,wght@0,400;0,500;0,600;0,700;1,400&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Poppins, sans-serif;
        }

        :root {
            /* Colors */
            --white-color: #fff;
            --dark-color: #0B745E;
            --primary-color: #532A0E;
            --secondary-color: #0B745E;
            --light-pink-color: #faf4f5;
            medium-gray-color: #ccc;

            /*Font size */
            --font-size-s: 0.9rem;
            --font-size-n: 1rem;
            --font-size-m: 1.12rem;
            --font-size-1: 1.5rem;
            --font-size-xl: 2rem;
            --font-size-xxl: 2.3rem;

            /* Font weight */
            --font-weight-normal: 400;
            --font-weight-medium: 500;
            --font-weight-semibold: 600;
            --font-weight-bold: 700;

            /*Border radius */
            --border-radius-s: 8px;
            --border-radius-m: 30px;
            --border-radius-circle: 50%;

            /* Site max width */
            --site-max-width: 1300px;
        }

        html {
            scroll-behavior: smooth;
        }

        ul {
            list-style: none;
        }

        a {
            text-decoration: none;
        }

        button {
            cursor: pointer;
            border: none;
            background: none;
        }

        img {
            width: 125%;
        }

        .section-content {
            margin: 0px auto;
            padding: 0 20px;
            max-width: var(--site-max-width);
        }

        .section-title {
            text-align: center;
            padding: 60px 0 100px;
            text-transform: uppercase;
            font-size: var(--font-size-xl);
        }

        .section-title::after {
           content: "";
            width: 80px;
            height: 5px;
            display: block;
            margin: 10px auto 0;
            border-radius: var(--border-radius-s);
            background: var(--secondary-color);
        }

        header {
            position: fixed;
            width: 100%;
            z-index: 5;
            background: var(--primary-color);
        }

        header .navbar {
            display: flex;
            padding: 20px;
            align-items: center;
            justify-content: space-between;
        }

        .navbar .nav-logo .logo-text {
            color: var(--secondary-color);
            font-size: var(--font-size-xl);
            font-weight: var(--font-weight-semibold);
        }

        .navbar .nav-menu {
            display: flex;
            gap: 10px;
        }

        .navbar .nav-menu .nav-link {
            padding: 10px 18px;
            color: var(--white-color);
            font-size: var(--font-size-m);
            border-radius: var(--border-radius-m);
            transition: 0.3s ease;
        }

        .navbar .nav-menu .nav-link:hover {
            color: var(--primary-color);
            background: var(--secondary-color);
        }

        .navbar :where(#menu-close-button, #menu-open-button) {
            display: none;
        }

        .hero-section {
            min-height: 100vh;
            background: var(--primary-color);
        }

        .hero-section .section-content {
            display: flex;
            align-items: center;
            min-height: 100vh;
            color: var(--white-color);
            justify-content: space-between;
        }

        .hero-section .hero-details .title {
            font-size: var(--font-size-xxl);
            color: var(--secondary-color);
            font-family: "Miniver", sans-serif;
        }

        .hero-section .hero-details .subtitle {
            margin-top: 8px;
            max-width: 70%;
            font-size: var(--font-size-xl);
            font-weight: var(--font-weight-semibold);
        }

        .hero-section .hero-details .description {
            max-width: 70%;
            margin: 24px 0 40px;
            font-size: var(--font-size-m);

        }

        .hero-section .hero-details .buttons {
            display: flex;
            gap: 23px;
        }

        .hero-section .hero-details .button {
            padding: 10px 26px;
            border: 2px solid transparent;
            color: var(--primary-color);
            border-radius: var(--border-radius-m);
            background: var(--secondary-color);
            font-weight: var(--font-weight-medium);
            transition: 0.3s ease;
        }

        .hero-section .hero-details .button:hover,
        .hero-section .hero-details .contact-us {
            color: var(--white-color);
            border-color: var(--white-color);
            background: transparent;
        }

        .hero-section .hero-details .contact-us:hover {
            color: var(--primary-color);
            border-color: var(--secondary-color);
            background: var(--secondary-color);
        }

        .hero-section .hero-image-wrapper {
            max-width: 500px;
            margin-right: 30px;
        }

        .about-section {
            padding: 120px 0;
            background: var(--light-pink-color);
        }

        .about-section .section-content {
            display: flex;
            gap: 50px;
            align-items: center;
            justify-content:  space-between;
        }

        .about-section .about-image-wrapper .about-image {
            width: 400px;
            height: 400px;
            object-fit: cover;
            border-radius: var(--border-radius-circle);
        }

        .about-section .about-details .section-title {
            padding: 0;
        }

        .about-section .about-details {
            max-width: 50%;
        }

        .about-section .about-details .text {
            line-height: 30px;
            margin: 50px 0 30px;
            text-align: center;
            font-size: var(--font-size-m);
        }

        .about-section .about-details .social-link-list {
            display: flex;
            gap: 25px;
            justify-content: center;
        }

        .about-section .social-link-list .social-link {
            color: var(--primary-color);
            font-size: var(--font-size-1);
            transition: 0.2s ease;
        }

        .about-section .social-link-list .social-link:hover {
            color: var(--secondary-color);
        }
        /*Menu section*/
        .menu-section {
            color: var(--white-color);
            background: var(--dark-color);
            padding: 50px 0 100px;
        }

        .menu-section .menu-list {
            display: flex;
            flex-wrap: wrap;
            gap: 110px;
            align-items: center;
            justify-content: space-between;
        }

        .menu-section .menu-list .menu-item {
            display: flex;
            align-items: center;
            text-align: center;
            flex-direction: column;
            justify-content: space-between;
            width: calc(100% / 3 - 110px);
        }

        .menu-section .menu-list .menu-item .menu-image {
            max-width: 83%;
            aspect-ratio: 1;
            margin-bottom: 15px;
            object-fit: contain;
        }

        .menu-section .menu-list .menu-item .name {
            margin: 12px 0;
            font-size: var(--font-size-1);
            font-weight: var(--font-weight-semibold);
        }

        .menu-section .menu-list .menu-item .text {
            font-size: var(--font-size-m);
        }

        /*Danh Gia San Pham*/
        .testimonials-section {
            padding: 50px 0 100px;
            background: var(--light-pink-color);
        }

        .testimonials-section .slider-wrapper {
            overflow: hidden;
            margin: 0 60px 50px;
        }

        .testimonials-section .testimonial {
            user-select: none;
            display: flex;
            padding: 35px;
            text-align: center;
            flex-direction: column;
            align-items: center;
        }

        .testimonials-section .testimonial .user-image {
            width: 180px;
            height: 180px;
            object-fit: cover;
            margin-bottom: 50px;
            border-radius: var(--border-radius-circle);
        }

        .testimonials-section .testimonial .name {
            margin-bottom: 16px;
            font-style: var(--font-size-m);
        }

        .testimonials-section .testimonial .feedback {
            line-height: 25px;
        }

        .testimonials-section .swiper-pagination-bullet {
            width: 15px;
            height: 15px;
            opacity: 1;
            background: var(--secondary-color);
        }

        .testimonials-section .swiper-slide-button {
            margin-top: -50px;
            color: var(--secondary-color);
            transition: 0.3s ease;
        }

        .testimonials-section .swiper-slide-button:hover {
            color: var(--primary-color);
        }

        .gallery-section {
            padding: 50px 0 100px;
        }

        .gallery-section .gallery-list {
            display: flex;
            flex-wrap: wrap;
            gap: 32px;
        }

        .gallery-section .gallery-list .gallery-item {
            overflow: hidden;
            border-radius: var(--border-radius-s);
            width: calc(100% / 3 - 32px);
        }

        .gallery-section .gallery-item .gallery-image {
            width: 100%;
            height: 100%;
            cursor: zoom-in;
            transition:  0.3s ease;
        }

        .gallery-section .gallery-item:hover .gallery-image {
            transform: scale(1.3);
        }

        .contact-section {
            padding: 50px 0 100px;
            background: var(--light-pink-color);
        }

        .contact-section .section-content {
            display: flex;
            gap: 48px;
            align-items: flex-start;
            justify-content: space-between;
        }

        .contact-section .contact-info-list .contact-info {
            display: flex;
            gap: 20px;
            margin: 20px 0;
            align-items: center;
        }

        .contact-section .contact-info-list .contact-info i {
            font-style: var(--font-size-m);
        }

        .contact-section .contact-form .form-input {
            width: 100%;
            height: 50px;
            padding: 0 12px;
            outline: none;
            margin-bottom: 16px;
            background: var(--border-radius-s);
            border: 1px solid grey;
        }

        .contact-section .contact-form {
            max-width: 50%;
        }

        .contact-section .contact-form .form-input:focus {
            border-color: var(--secondary-color);
        }

        .contact-section .contact-form textarea.form-input {
            height: 100px;
            padding: 12px;
            resize: vertical;
        }

        .contact-section .contact-form .submit-button {
            padding: 10px 26px;
            margin-top: 10px;
            color: var(--white-color);
            font-style: var(--font-size-m);
            font-weight: var(--font-weight-medium);
            background: var(--primary-color);
            border-radius: var(--border-radius-m);
            border: 1px solid var(--primary-color);
            transition:  0.3s ease;
        }

        .contact-section .contact-form .submit-button:hover {
            color: var(--primary-color);
            background: transparent;
        }


        @media screen and (max-width: 1024px) {
            .menu-section .menu-list {
                gap: 60px;
            }
            .menu-section .menu-list .menu-item {
                width: calc(100% / 3 - 60px);
            }
        }

        @media screen and (max-width: 900px) {
            :root {
                --font-size-m: 1rem;
                --font-size-1: 1.3rem;
                --font-size-xl: 1.5rem;
                --font-size-xxl: 1.8rem;
            }

            body.show-mobile-menu header::before {
                content: "";
                position: fixed;
                left: 0;
                top: 0;
                height: 100%;
                width: 100%;
                backdrop-filter: blur(5px);
                background: rgba(0, 0, 0, 0.2);
            }

            .navbar :where(#menu-close-button, #menu-open-button) {
                display: block;
                font-size: var(--font-size-1);
            }

            .navbar #menu-close-button {
                position: absolute;
                right: 30px;
                top: 30px;
            }

            .navbar #menu-open-button {
                color: var(--white-color);
            }


            .navbar .nav-menu {
                display: block;
                position: fixed;
                left: -300px;
                top: 0;
                width: 300px;
                height: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                padding-top: 100px;
                background: var(--white-color);
                transition: left 0.2s ease;
            }

            body.show-mobile-menu .navbar .nav-menu {
                left: 0;
            }

            .navbar .nav-menu .nav-link {
                color: var(--dark-color);
                display: block;
                margin-top: 17px;
                font-size: var(--font-size-1);
            }

            .hero-section .section-content {
                gap: 50px;
                text-align: center;
                padding: 30px 20px 20px;
                flex-direction: column-reverse;
                justify-content: center;
            }

            .hero-section .hero-details :is( .subtitle, .description)
            , .about-section .about-details, .contact-section .contact-form {
                max-width: 100%;
            }

            .hero-section .hero-details .buttons {
                justify-content: center;
            }

            .hero-section .hero-image-wrapper {
                max-width: 270px;
                margin-right: 0;
            }

            .about-section .section-content {
                gap: 70px;
                flex-direction: column-reverse;
            }

            .about-section .about-image-wrapper .about-image {
                width: 100%;
                height: 100%;
                max-width: 250px;
                aspect-ratio: 1;
            }

            .menu-section .menu-list {
                gap: 30px;
            }
            .menu-section .menu-list .menu-item {
                width: calc(100% / 2 - 30px);
            }

            .menu-section .menu-list .menu-item .menu-image {
              max-width: 200px;
            }

            .gallery-section .gallery-list {
                gap: 30px;
            }

            .gallery-section .gallery-list .gallery-item {
                width: calc(100% / 2 - 30px);
            }

            .contact-section

            .contact-section .section-content {
                align-items: center;
                flex-direction: column-reverse;
            }
        }
        
        @media screen and (max-width: 640px) {
            .menu-section .menu-item {
                gap: 60px;
            }

            .menu-section .menu-list .menu-item,
            .gallery-section .gallery-list .gallery-item{
                width: 100%;
            }

            .testimonials-section .slider-wrapper {
                margin:  0 0 30px;
            }

            .testimonials-section .swiper-slide-button {
                display: none;
            }
        }

    </style>
</head>
<body>
<header>
    <nav class="navbar section-content">
        <a href="#" class="nav-logo">
            <h2 class="logo-text"> The Nature Coffee</h2>
        </a>
        <ul class="nav-menu">
            <button id="menu-close-button" class="fas fa-times"></button>
            <li class="nav-item">
                <a href="#" class="nav-link">Home</a>
            </li>
            <li class="nav-item">
                <a href="#about" class="nav-link">About</a>
            </li>
            <li class="nav-item">
                <a href="#testimonials" class="nav-link">Review</a>
            </li>
            <li class="nav-item">
                <a href="#gallery" class="nav-link">Bundled</a>
            </li>
            <li class="nav-item">
                <a href="#contact" class="nav-link">Contact</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">Shopping</a>
            </li>
        </ul>

        <button id="menu-open-button" class="fas fa-bars"></button>
    </nav>
</header>
<main>
<%--header--%>
    <section class="hero-section">
        <div class="section-content">
            <div class="hero-details">
                <h2 class="title">Best Coffee</h2>
                <h3 class="subtitle">Make your day great with our special coffee!</h3>
                <p class="description">Welcome to our coffee paradise, where every bean tells a story and every cup
                    sparks joy.</p>
                <div class="buttons">
                    <a href="#" class="button order-now">Order Now</a>
                    <a href="#" class="button contact-us">Contact Us</a>
                </div>
            </div>
            <div class="hero-image-wrapper">
                <img src="../images/art-removebg-preview.png" alt="Hero" class="hero-image">
            </div>
        </div>
    </section>
<%-- About--%>
    <section class="about-section" id="about" >
        <div class="section-content">
            <div class="about-image-wrapper">
                <img src="../images/about-image.jpg" alt="About"
                     class="about-image">
            </div>
            <div class="about-details">
                <h2 class="section-title">About Us</h2>
                <p class="text">The Nature Coffee was founded with a simple mission: to bring you the finest coffee experience sourced directly from nature. We take pride in offering a wide selection of high-quality coffee, meticulously sourced from renowned coffee-growing regions around the world. At The Nature Coffee, every coffee bean carries its own unique flavor and story, nurtured with care from the harvest to your cup.
                </p>
                <div class="social-link-list">
                    <a href="#" class="social-link"><i class="fa-brands fa-facebook"></i></a>
                    <a href="#" class="social-link"><i class="fa-brands
                    fa-instagram"></i></a>
                    <a href="#" class="social-link"><i class="fa-brands
                    fa-x-twitter"></i></a>
                </div>
            </div>
        </div>
    </section>
<%--Menu section--%>
    <section class="menu-section" id="menu" >
        <h2 class="section-title">Our Prodct!</h2>
        <div class="section-content">
            <ul class="menu-list">
                <li class="menu-item">
                    <img src="../images/Arabica-removebg-preview.png" alt="Hot Beverages"
                         class="menu-image">
                    <div class="menu-details">
                        <h3 class="name">Arabica</h3>
                        <p class="text">Silky smooth with delightful sweetness and nuanced fruity undertones.
                        </p>
                    </div>
                </li>
                <li class="menu-item">
                    <img src="../images/Robusta-removebg-preview.png" alt="Cold Beverages"
                         class="menu-image">
                    <div class="menu-details">
                        <h3 class="name">Robusta</h3>
                        <p class="text">Bold and robust, offering earthy depth with a captivating bitterness.</p>
                    </div>
                </li>
                <li class="menu-item">
                    <img src="../images/Liberica-removebg-preview.png" alt="Refreshment"
                         class="menu-image">
                    <div class="menu-details">
                        <h3 class="name">Liberica</h3>
                        <p class="text">Uniquely aromatic, featuring smoky, woody notes with a hint of floral elegance.</p>
                    </div>
                </li>
                <li class="menu-item">
                    <img src="../images/Excelsa-removebg-preview.png" alt="Special Combos"
                         class="menu-image">
                    <div class="menu-details">
                        <h3 class="name">Excelsa</h3>
                        <p class="text">Lively and tart, bursting with vibrant fruity flavors and spice complexities.</p>
                    </div>
                </li>
                <li class="menu-item">
                    <img src="../images/Geisha-removebg-preview.png" alt="Dessert"
                         class="menu-image">
                    <div class="menu-details">
                        <h3 class="name">Geisha</h3>
                        <p class="text">Exquisitely floral, showcasing a sweet, tea-like quality with intricate layers.</p>
                    </div>
                </li>
                <li class="menu-item">
                    <img src="../images/Bourbon-removebg-preview.png" alt="burger & French Fries"
                         class="menu-image">
                    <div class="menu-details">
                        <h3 class="name">Bourbon</h3>
                        <p class="text">Luxuriously rich, with a sweet profile and luscious hints of chocolate and caramel.</p>
                    </div>
                </li>
            </ul>
        </div>
    </section>
<%--  Đánh Giá Từ Khách Hàng  --%>
    <section class="testimonials-section" id="testimonials" >
        <h2 class="section-title">Review From Customer</h2>
        <div class="section-content">
            <div class="slider-container swiper">
                <div class="slider-wrapper">
                    <ul class="testimonials-list swiper-wrapper">
                        <li class="testimonial swiper-slide">
                            <img src="../images/user-1.jpg" alt="User" class="user-image">
                            <h3 class="name">Sarah Johnson</h3>
                            <i class="feedback">"Loved the French roast. Perfectly balanced and rich. Will order again!"</i>
                        </li>
                        <li class="testimonial swiper-slide">
                            <img src="../images/user-2.jpg" alt="User" class="user-image">
                            <h3 class="name">James Wilson</h3>
                            <i class="feedback">"Great espresso blend! Smooth and bold flavor. Fast shipping tool"</i>
                        </li>
                        <li class="testimonial swiper-slide">
                            <img src="../images/user-3.jpg" alt="User" class="user-image">
                            <h3 class="name">Michael Brown</h3>
                            <i class="feedback">"Fantastic mocha flavor. Fresh and aromatic. Quick shipping!"</i>
                        </li>
                        <li class="testimonial swiper-slide">
                            <img src="../images/user-4.jpg" alt="User" class="user-image">
                            <h3 class="name">Emily Harris</h3>
                            <i class="feedback">"Excellent quality! Fresh beans and quick delivery. Highly recommend."</i>
                        </li>
                        <li class="testimonial swiper-slide">
                            <img src="../images/user-5.jpg" alt="User" class="user-image">
                            <h3 class="name">Anthony Thompson</h3>
                            <i class="feedback">"Best decaf I've tried! Smooth and flavorful. Arrived promptly."</i>
                        </li>
                    </ul>

                    <div class="swiper-pagination"></div>
                    <div class="swiper-slide-button swiper-button-prev"></div>
                    <div class="swiper-slide-button swiper-button-next"></div>
                </div>
            </div>
        </div>
    </section>
<%--  Cac San Pham Ban Kem--%>
    <section class="gallery-section" id="gallery">
        <h2 class="section-title">Bundled Products</h2>
        <div class="section-content">
            <ul class="gallery-list">
                <li class="gallery-item">
                    <img src="../images/cup.webp" alt="Gallery"
                         class="gallery-image">
                </li>
                <li class="gallery-item">
                    <img src="../images/coffeemaker.webp" alt="Gallery"
                         class="gallery-image">
                </li>
                <li class="gallery-item">
                    <img src="../images/filter.jpg" alt="Gallery"
                         class="gallery-image">
                </li>
                <li class="gallery-item">
                    <img src="../images/Siphon%20Brewer.png" alt="Gallery"
                         class="gallery-image">
                </li>
                <li class="gallery-item">
                    <img src="../images/Carafe.webp" alt="Gallery"
                         class="gallery-image">
                </li>
                <li class="gallery-item">
                    <img src="../images/French%20Press.webp" alt="Gallery"
                         class="gallery-image">
                </li>
            </ul>
        </div>
    </section>
<%--    Contact Us--%>
    <section class="contact-section" id="contact">
        <h2 class="section-title">Contact Us</h2>
        <div class="section-content">
            <ul class="contact-info-list">
                <li class="contact-info">
                    <i class="fa-solid fa-location-crosshairs"></i>
                    <p>123 Campsite Avenue, Wilderness, CA 98765</p>
                </li>
                <li class="contact-info">
                    <i class="fa-regular fa-envelope"></i>
                    <p>info@coffeeshopwebsite.com</p>
                </li>
                <li class="contact-info">
                    <i class="fa-solid fa-phone"></i>
                    <p>(123) 456-78909</p>
                </li>
                <li class="contact-info">
                    <i class="fa-regular fa-clock"></i>
                    <p>Monday - Friday: 9:00 AM - 5:00 PM</p>
                </li><li class="contact-info">
                    <i class="fa-regular fa-clock"></i>
                    <p>Saturday: 10:00 AM - 3:00 PM</p>
                </li>
                <li class="contact-info">
                    <i class="fa-regular fa-clock"></i>
                    <p>Sunday: Closed</p>
                </li>
                <li class="contact-info">
                    <i class="fa-solid fa-globe"></i>
                    <p>www.codingnepalweb.com</p>
                </li>
            </ul>

            <form action="#" class="contact-form">
                <input type="text" placeholder="Your name" class="form-input"
                       required>
                <input type="email" placeholder="Your email" class="form-input"
                       required>
                <textarea placeholder="Your message" class="form-input"
                          required></textarea>
                <button class="submit-button">Submit</button>
            </form>
        </div>
    </section>
</main>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script>
    const navLinks = document.querySelectorAll(".nav-menu .nav-link");
    const menuOpenButton = document.querySelector("#menu-open-button");
    const menuCloseButton = document.querySelector("#menu-close-button");
    menuOpenButton.addEventListener("click", () => {
        document.body.classList.toggle("show-mobile-menu");
    });
    menuCloseButton.addEventListener("click", () => menuOpenButton.click());

    navLinks.forEach(link => {
        link.addEventListener("click", () => menuOpenButton.click());
    });

    const swiper = new Swiper('.slider-wrapper', {
        loop: true,
        grabCursor: true,
        spaceBetween: 25,

        pagination: {
            el: '.swiper-pagination',
            clickable: true,
            dynamicBullets: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },

        breakpoints: {
            0: {
                slidesPerView: 1
            },
            768: {
                slidesPerView: 2
            },
            1024: {
                slidesPerView: 3
            }
        }
    });

</script>
</body>
</html>
