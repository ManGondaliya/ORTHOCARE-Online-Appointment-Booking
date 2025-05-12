

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Retrieve session
    HttpSession session1 = request.getSession(false);

if (session1 == null || session1.getAttribute("name") == null || session.getAttribute("user_id") == null) {
    response.sendRedirect("userLogin.jsp");
    return;

    } else {
        // Retrieve user data from session
        String user_id = (String) session1.getAttribute("user_id");
        String name = (String) session1.getAttribute("name");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Home - OrthoCare</title>
    <link rel="icon" type="image/x-icon" href="images/ortho-logo.png">
    <link rel="stylesheet" href="css/userHome_style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    
    
    
    <!-- Header Section -->
    <header>
        <div class="container">
            <div class="logo">
                <img src="images/ortho-logo.png" alt="Hospital Icon" class="hospital-icon">
                <h1>OrthoCare</h1>
            </div>
            <nav>
                <ul class="nav-links">
                    
                    <li><a href="#home">Home</a></li>
                    <li><a href="#appointment-section">Book Appoinment</a></li>
                    <li><a href="userAppointmentHistory.jsp">Appoinment Histroy</a></li>
                    <li><a href="#contact">Contact Us</a></li>
                    <li><a href="updateUserProfile.jsp">Update Profile</a></li>
                     <li>  <form action="UserLogout" method="get">
                             <button type="submit" class="btn">Logout</button>
                         </form></li>
                </ul>
            </nav>
        </div>
    </header>

     <!-- Banner Section -->
    <section id="home" class="banner">
        <div class="banner-content">
          
            <h2>Welcome to OrthoCare, <%= name %></h2>
            <p>Your trusted partner in quality healthcare</p>
            <a href="#appointment-section" class="btn">Book Appoinment</a>
        </div>
    </section>
    
    <section id="health-tips">
    <div class="container">
        <h2>Orthopedic Health Tips</h2>
        <p class="section-description">Stay informed and take care of your bones, joints, and muscles with these helpful tips:</p>
        <div class="tips">
            <div class="tip">
                <img src="images/healthy-diet.jpg" alt="Healthy Diet for Bones">
                <h3>Maintain a Balanced Diet</h3>
                <p>Include calcium-rich foods like milk, cheese, and leafy greens, along with vitamin D for strong bones.</p>
            </div>
            <div class="tip">
                <img src="images/exercise.jpeg" alt="Regular Exercise">
                <h3>Exercise Regularly</h3>
                <p>Engage in weight-bearing exercises like walking, jogging, or yoga to keep your joints flexible and strong.</p>
            </div>
            <div class="tip">
                <img src="images/posture.jpg" alt="Posture Correction">
                <h3>Maintain Good Posture</h3>
                <p>Practice proper posture while sitting and standing to avoid unnecessary stress on your spine.</p>
            </div>
            <div class="tip">
                <img src="images/foot-pain.jpg" alt="Proper Footwear">
                <h3>Wear Supportive Footwear</h3>
                <p>Use orthopedic or comfortable footwear to prevent foot pain and support overall alignment.</p>
            </div>
        </div>
    </div>
</section>



    
    <main>
        <section id="appointment-section" class="appointment-section">
            <h2>Book an Appointment</h2>
            <form action="BookAppointment" method="post" class="appointment-form">
                
                
                <input type="hidden" name="user_id" value="<%= user_id %>">
                <label for="appointmentName">Patient Name:</label>
                <input type="text" id="appointmentName" name="patient_name" placeholder="enter patient name" required>
                


                <label for="doctor">Select Doctor:</label>
                <select id="doctor" name="doctor_name" placeholder="select doctor" required>
                    <!--<option value="select">Select Doctor</option>-->
                    <option value="Dr. Nirav Shah">Dr. Nirav Shah - Joint Replacement Specialist</option>
                    <option value="Dr. Nisha Bhatt">Dr. Nisha Bhatt - Consultant Orthopedic</option>
                    <option value="Dr. Tarun Goyal">Dr. Tarun Goyal - Orthopedic Surgeon</option>
                </select>

                <label for="appointmentDate">Select Date:</label>
                <input type="date" id="appointmentDate" name="appointmentDate" required>
                
                <label for="appointmentTime">Select Time:</label>
                <input type="time" id="appointmentTime" name="appointmentTime" required>

                <button type="submit" class="book-btn">Book Appointment</button>
            </form>
        </section>

        <!-- Other Sections -->
        <section id="facilities">
    <div class="facilities-container">
        <h2>Facilities at OrthoCare</h2>
        <div class="facility-grid">
            <div class="facility-item">
                <img src="images/operation.jpg" alt="Modern Operation Theatres">
                <h3>Modern Operation Theatres</h3>
                <p>Equipped with state-of-the-art technology for precise orthopedic surgeries.</p>
            </div>
            <div class="facility-item">
                <img src="images/emergency.jpg" alt="24/7 Emergency Services">
                <h3>24/7 Emergency Services</h3>
                <p>Quick response for all orthopedic emergencies round the clock.</p>
            </div>
            <div class="facility-item">
                <img src="images/mri.jpg" alt="Advanced Diagnostics">
                <h3>Advanced Diagnostics</h3>
                <p>Comprehensive diagnostic tools including MRI, CT, and X-rays.</p>
            </div>
            <div class="facility-item">
                <img src="images/therapy.jpg" alt="Physiotherapy Center">
                <h3>Physiotherapy Center</h3>
                <p>Dedicated space for rehabilitation and post-surgery recovery.</p>
            </div>
        </div>
    </div>
</section>

       <section id="contact">
    <div class="contact-container">
        <h2>Contact Us</h2>
        <p>We'd love to hear from you! Reach out to us using the details below:</p>
        <div class="contact-details">
            <div class="contact-item">
                <h3>Phone</h3>
                <p>+028 8929 6677</p>
            </div>
            <div class="contact-item">
                <h3>Email</h3>
                <p>contact@orthocare.com</p>
            </div>
            <div class="contact-item">
                <h3>Address</h3>
                <p>New Bus Stand, Dhoraji - 360410.</p>
            </div>
        </div>
    </div>
</section>
    </main>

    <!-- Footer Section -->
    <footer>
        <p>&copy; 2025 OrthoCare Hospital. All rights reserved.</p>
    </footer>
    

</body>
</html>
<%
    }
%>

