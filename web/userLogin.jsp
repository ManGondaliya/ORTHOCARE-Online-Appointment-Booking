<%-- 
    Document   : userLogin
    Created on : Nov 21, 2024, 11:19:18 PM
    Author     : hp
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Login - OrthoCare</title>
    <link rel="icon" type="image/x-icon" href="images/ortho-logo.png">
    <link rel="stylesheet" type="text/css" href="css/user_login.css">
</head>
<body>
    <header>
        <!-- Left Section: Logo and Name -->
        <div class="header-left">
            <img src="images/ortho-logo.png" alt="Hospital Logo">
            <h1>OrthoCare</h1>
        </div>

        <!-- Center Section: Title -->
        <div class="header-center">
            <h2>User Login Form</h2>
        </div>

        <!-- Right Section: Home Navigation -->
        <div class="header-right">
            <a href="user_IndexPage.jsp">Home</a>
        </div>
    </header>

    <div class="main-container">
        <!-- Left Side: User Image -->
        <div class="image-container"></div>

        <!-- Right Side: Login Form -->
        <div class="form-container">
            <h2>Login</h2>
            <form action="UserLogin" method="post">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>

                <input type="submit" value="Login">
            </form>

            <!-- Navigation to New User Registration -->
            <div class="registration-link">
                <a href="user_Registration.jsp">New User Registration</a>
            </div>
        </div>
    </div>

    <footer>
        &copy; 2025 OrthoCare. All Rights Reserved.
    </footer>
</body>
</html>
