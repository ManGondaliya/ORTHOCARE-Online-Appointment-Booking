<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="jakarta.servlet.http.HttpSession" %>

<% 
    
    HttpSession doctorSession1 = request.getSession(false);

    if (doctorSession1 == null || 
        doctorSession1.getAttribute("doctorName") == null || 
        doctorSession1.getAttribute("doctorId") == null) {
        
        response.sendRedirect("doctorLogin.jsp");
        return;
    } else {
        
        int doctor_id = (int) doctorSession1.getAttribute("doctorId"); 
        String doctorName = (String) doctorSession1.getAttribute("doctorName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="icon" type="image/x-icon" href="images/ortho-logo.png">
    <link rel="stylesheet" type="text/css" href="css/admin_home.css">
    
</head>
<body>
    <!-- Header Section -->
    <div class="header">
        <div class="logo">
            <img src="images/ortho-logo.png" alt="Hospital Icon" class="hospital-icon">
                <h1> OrthoCare</h1>
            <!--OrthoCare Admin-->
        </div>
        <div class="navigation">
            <a href="doctorManageAppointments.jsp">Manage Appointments</a>
            <a href="updateDoctorProfile.jsp">Update Profile</a>
            <a href="Doctor_Logout">Logout</a>
        </div>
    </div>

    <!-- Welcome Section -->
    <div class="welcome-section">
        <h1>Welcome, <%= doctorName %> !</h1>
        <p>Your dashboard to manage the OrthoCare system effectively</p>
    </div>

    <!-- Features Section -->
    <div class="features">
        
        <div class="feature-box">
            <h3>Manage Appointments</h3>
            <p>View and update patient appointments and schedules.</p>
            <a href="doctorManageAppointments.jsp">Manage Appointments</a>
        </div>
        <div class="feature-box">
            <h3>Update Profile</h3>
            <p> update Your doctor profile.</p>
            <a href="updateDoctorProfile.jsp">Go to Update</a>
        </div>
        
        
    </div>
</body>
</html>

<%
    }
%>
