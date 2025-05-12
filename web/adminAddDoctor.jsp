<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    <title>Add New Doctor</title>
    <link rel="icon" type="image/x-icon" href="images/ortho-logo.png">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .header {
            background-color: #0077b6;
            color: white;
            padding: 15px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header .logo-section {
            display: flex;
            align-items: center;
        }

        .header img {
            height: 50px;
            margin-right: 15px;
        }

        .header .hospital-name {
            font-size: 24px;
            font-weight: bold;
        }

        .header .navigation a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-size: 16px;
            padding: 10px 15px;
            background-color: #005f8a;
            border-radius: 5px;
        }

        .header .navigation a:hover {
            background-color: #004d6f;
        }

        .container {
            width: 50%;
            margin: 30px auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-top: 10px;
            font-weight: bold;
        }

        input, select {
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .submit-btn {
            background-color: #0077b6;
            color: white;
            border: none;
            padding: 10px;
            margin-top: 20px;
            font-size: 18px;
            border-radius: 5px;
            cursor: pointer;
        }

        .submit-btn:hover {
            background-color: #005f8a;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="logo-section">
            <img src="images/ortho-logo.png" alt="Hospital Logo">
            <div class="hospital-name">OrthoCare</div>
        </div>
        <div class="navigation">
            <a href="adminHomePage.jsp">Home</a>
            <a href="adminManageDoctors.jsp">Back</a>
        </div>
    </div>

    <!-- Form Section -->
    <div class="container">
        <h2>Add New Doctor</h2>
        <form action="AddDoctor" method="post">
            <label for="doctorName">Doctor Name:</label>
            <input type="text" id="doctorName" name="doctorName" required>

            <label for="mobile">Mobile:</label>
            <input type="text" id="mobile" name="mobile" required pattern="[0-9]{10}" title="Enter a valid 10-digit phone number">

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="specialization">Specialization:</label>
            <input type="text" id="specialization" name="specialization" required>

            <label for="qualification">Qualification:</label>
            <input type="text" id="qualification" name="qualification" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <label for="consultationFee">Consultation Fee:</label>
            <input type="number" id="consultationFee" name="consultationFee" required>

            <label for="availability">Availability:</label>
            <input type="text" id="availability" name="availability" placeholder="e.g. Monday to Friday, 10AM - 4PM" required>

            <button type="submit" class="submit-btn">Add Doctor</button>
        </form>
    </div>
</body>
</html>

<%
    }
%>
