<%-- 
    Document   : user_IndexPage
    Created on : Nov 22, 2024, 6:22:27 PM
    Author     : hp
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OrthoCare</title>
    <link rel="icon" type="image/x-icon" href="images/ortho-logo.png">
    <link rel="stylesheet" href="css/style.css">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
   
    
    
   
</head>
<body>
    
    <header>
        <div class="container">
            <div class="logo">
                <img src="images/ortho-logo.png" alt="Hospital Icon" class="hospital-icon">
                <h1> OrthoCare</h1>
            </div>
            <nav>
                <ul class="nav-links">
                    <li><a href="#home">Home</a></li>
                    <li><a href="#about">About Us</a></li>
                    <li><a href="#services">Services</a></li>
                    <li><a href="#contact">Contact Us</a></li>
                    <li><a href="userLogin.jsp" class="btn">Login/Register</a></li>
                   
                </ul>
            </nav>
        </div>
    </header>

   
    <section id="home" class="banner">
        <div class="banner-content">
            <h2>Welcome to OrthoCare</h2>
            <p>Your trusted partner in quality healthcare</p>
            <a href="#services" class="btn">Explore Services</a>
        </div>
    </section>
    
    
   
    <section class="doctors">
        <div class="container">
            <h2>Meet Our Experts</h2>
            <div class="doctor-cards">
                <div class="doctor-card">
                    <img src="images/doctor1.jpg" alt="Doctor 1">
                    <p>Dr. Nirav Shah</p>
                    <p>Joint Replacement Specialist</p>
                    <p class="experience">10 years Experience</p>
                </div>
                <div class="doctor-card">
                    <img src="images/doctor2.jpg" alt="Doctor 2">
                    <p>Dr. Nisha Bhatt</p>
                    <p>Consultant Orthopedic</p>
                    <p class="experience">5 years Experience</p>
                </div>
                <div class="doctor-card">
                    <img src="images/doctor3.jpg" alt="Doctor 2">
                    <p>Dr. Tarun Goyal</p>
                    <p>Orthopedic Surgeon</p>
                    <p class="experience">15 years Experience in Surgery</p>
                </div>
                 <div class="doctor-card">
                    <img src="images/doctor4.jpg" alt="Doctor 2">
                    <p>Dr. Aarti Rai</p>
                    <p>Physiotherapist</p>
                    <p class="experience">5 years Experience in Physiotherapy</p>
                </div>
            </div>
        </div>
    </section>

    
    <section id="about" class="about">
        <div class="container">
            <!--<h2>About Us</h2>-->
            <div class="about-us-section">
    <h2>About Us</h2>
    <p>
        Welcome to <span>OrthoCare Hospital</span>, where we combine state-of-the-art technology with compassionate care to provide exceptional healthcare services. Our mission is to improve lives through innovative and personalized treatments.
    </p>
    <p>We offer comprehensive care and support to patients, including physiotherapy, 
        rehabilitation, and pain management. With our cutting-edge facilities and equipment, we provide the latest and most advanced treatments.</p>
    <p>
        For over <span>25 years</span>, OrthoCare has been a trusted name in the healthcare industry. Our team of expert doctors, nurses, and staff work tirelessly to ensure the best outcomes for our patients.
    </p>
    <p>
        At OrthoCare, we specialize in a wide range of medical services, including cardiology, orthopedics, pediatrics, and more. Your health and well-being are our top priorities, and we are committed to making a difference in your life.
    </p>
</div>

        </div>
    </section>

   
    <section id="services" class="services">
        <div class="container">
            <h2>Our Services</h2>
            <div class="slider">
                <div class="slide">
                    <img src="images/physyco.jpg" alt="Cardiology">
                    <p>Physiotherapy</p>
                </div>
                <div class="slide">
                    <img src="images/slider1.jpg" alt="X-rays">
                    <p>X-rays</p>
                </div>
                <div class="slide">
                    <img src="images/slider2.jpg" alt="Joint-Replacements">
                    <p>Joint Replacements</p>
                </div>
                <div class="slide">
                    <img src="images/slider3.jpg" alt="OPD Care">
                    <p>OPD Care</p>
                </div>
                <div class="slide">
                    <img src="images/emergency.jpg" alt="Emergency Care">
                    <p>Emergency Care</p>
                </div>
            </div>
        </div>
    </section>
    
    

    
    <section id="contact" class="contact">
        <div class="container">
            <h2>Contact Us</h2>
            <div class="contact-info">
                <p><i class="fas fa-phone"></i> +028 4569 8899</p>
                <p><i class="fas fa-envelope"></i> contact@orthocarepro.com</p>
                <p><i class="fas fa-map-marker-alt"></i> New Bus Stand, Dhoraji-360410, India</p>
            </div>
        </div>
    </section>

    
    <footer>
        <div class="container">
            <p>&copy; 2024 OrthoCare Pro. All Rights Reserved.</p>
        </div>
    </footer>
</body>
</html>
