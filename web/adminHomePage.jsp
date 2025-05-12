<%-- 
    Document   : adminHomePage
    Created on : Nov 29, 2024, 6:52:56 PM
    Author     : hp
--%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Retrieve session
    HttpSession session1 = request.getSession(false);
    
if (session1 == null || session1.getAttribute("admin") == null ) {
    response.sendRedirect("adminLogin.jsp");
    return;

    } else {
        
        String name = (String) session1.getAttribute("admin");
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
            <a href="manageUsers.jsp">Manage Users</a>
            <a href="manageAppointment.jsp">Manage Appointments</a>
            <a href="adminManageDoctors.jsp">Manage Doctors</a>
            <a href="adminUpdateProfile.jsp">Update Profile</a>
            <a href="AdminLogout">Logout</a>
        </div>
    </div>

    <!-- Welcome Section -->
    <div class="welcome-section">
        <h1>Welcome, Admin!</h1>
        <p>Your dashboard to manage the OrthoCare system effectively</p>
    </div>

    <!-- Features Section -->
    <div class="features">
        <div class="feature-box">
            <h3>Manage Users</h3>
            <p>Add, update, or delete user accounts in the system.</p>
            <a href="manageUsers.jsp">Go to Users</a>
        </div>
        <div class="feature-box">
            <h3>Manage Appointments</h3>
            <p>View and update patient appointments and schedules.</p>
            <a href="manageAppointment.jsp">Manage Appointments</a>
        </div>
        <div class="feature-box">
            <h3>Manage Doctors</h3>
            <p>Add new Doctors, view doctor information and update their details.</p>
            <a href="adminManageDoctors.jsp">View Reports</a>
        </div>
    </div>
</body>
</html>
<%
    }
%>
