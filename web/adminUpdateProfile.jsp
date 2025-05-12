
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<%
    // Retrieve session
    HttpSession session1 = request.getSession(false);

if (session1 == null || session1.getAttribute("admin") == null ) {
    response.sendRedirect("adminLogin.jsp");
    return;

    } else {
        
        String name = (String) session1.getAttribute("admin");
%>

<% 
    String username = (String) session.getAttribute("admin"); // Assuming user ID is stored in session
    String adminID = "" ;
    String password = "";

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/orthocare";
    String dbUser = "root";
    String dbPassword = "man2815";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

        
        String query = "SELECT * FROM admin WHERE Username = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, username);

        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
           
            password = rs.getString("Password");
            adminID = rs.getString("AdminID");
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
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
            <a href="AdminLogout">Logout</a>
        </div>
    </div>

    <!-- Form Section -->
    <div class="container">
        <h2>Update Admin Profile</h2>
        <form action="UpdateAdminProfile" method="post">
            <label for="Username">UserName:</label>
            <input type="text" id="UserName" name="username" value="<%= username %>" required>
            <input type="hidden" name="adminID" value="<%= adminID %>" >

            <label for="password">Password:</label>
            <input type="text" id="Password" name="password" value="<%= password %>" required>

            <button type="submit" class="submit-btn">Update</button>
           
        </form>
    </div>
</body>
</html>

<%
    }
%>
