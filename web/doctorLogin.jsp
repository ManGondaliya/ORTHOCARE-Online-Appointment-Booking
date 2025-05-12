<%-- 
    Document   : doctorLogin
    Created on : Nov 21, 2024, 7:50:02 PM
    Author     : hp
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctor Login</title>
    <link rel="icon" type="image/x-icon" href="images/ortho-logo.png">
    <style>
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f9ff;
            color: #333;
        }

        
       header {
         background-color: #0177d8;
         color: white;
         padding: 20px 0;
         text-align: center;
       }

        .header-container {
               display: flex;
               align-items: center;
               justify-content: left;
               gap: 10px; 
               margin-left: 20px;
        }
        
                
        .hospital-icon {
            width: 50px; 
            height: 50px; 
            border-radius: 50%; 
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); 
        }

        header h1 {
            font-size: 24px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin: 0; 
        }
        
        header h2 {
            font-size: 24px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-left: 470px;
        }
   
            
        .main-container {
            display: flex;
            justify-content: center;
            align-items: center;
            max-width: 900px;
            margin: 50px auto;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

       
        .image-container {
            flex: 1;
            background: url('img/doctor.jpg') no-repeat center center;
            background-size: cover;
            min-height: 400px;
           
        }

       
        .login-container {
            flex: 1;
            padding: 30px;
        }

        .login-container h2 {
            text-align: center;
            color: #0177d8;
            margin-bottom: 20px;
            font-size: 22px;
        }

        .login-container label {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
            color: #555;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .login-container input[type="submit"] {
            width: 100%;
            background-color: #0177d8;
            color: white;
            border: none;
            padding: 10px;
            font-size: 18px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .login-container input[type="submit"]:hover {
            background-color: #025ab5;
        }

        .back-link {
            text-align: center;
            margin-top: 15px;
        }

        .back-link a {
            text-decoration: none;
            color: #0177d8;
            font-size: 16px;
            transition: color 0.3s;
        }

        .back-link a:hover {
            color: #025ab5;
        }

        
        footer {
            background-color: #0177d8;
            color: white;
            text-align: center;
            padding: 15px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <header>
       <div class="header-container">
           <img src="images/ortho-logo.png" alt="Hospital Icon" class="hospital-icon">
           <h1>OrthoCare</h1> 
           <h2>Doctor Login</h2>
       </div>
        
    </header>
    <div class="main-container">
        <!-- Left Side: Doctor Image -->
        <div class="image-container"></div>

        <!-- Right Side: Login Form -->
        <div class="login-container">
            <h2>Doctor Login</h2>
            <form action="DoctorLogin" method="post">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>

                <input type="submit" value="Login">
            </form>
            <div class="back-link">
                <a href="index.html">Back to Home</a>
            </div>
        </div>
    </div>
    <footer>
        &copy; 2025 OrthoCare. All Rights Reserved.
    </footer>
</body>
</html>