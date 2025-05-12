<%-- 
    Document   : updateUserProfile
    Created on : Nov 29, 2024, 3:05:38 PM
    Author     : hp
--%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

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

<% 
    String userId = (String) session.getAttribute("user_id"); // Assuming user ID is stored in session
    String fullname = "", mobile = "", email = "", address = "", gender = "", dob = "", password = "";

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/orthocare";
    String dbUser = "root";
    String dbPassword = "man2815";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Fetch user details
        String query = "SELECT * FROM user WHERE user_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, userId);

        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            fullname = rs.getString("full_name");
            mobile = rs.getString("phone_number");
            email = rs.getString("email");
            address = rs.getString("address");
            gender = rs.getString("gender");
            dob = rs.getString("date_of_birth");
            password = rs.getString("password");
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
    <title>User Profile Update</title>
    <link rel="icon" type="image/x-icon" href="images/ortho-logo.png">
    <link rel="stylesheet" type="text/css" href="css/update_profile.css">
    
</head>
<body>
    
    <header>
        <div class="head">
            
            <div class="logo">
                <img src="images/ortho-logo.png" alt="Hospital Icon" class="hospital-icon">
                <h1>OrthoCare</h1>
            </div>
            
            <nev>
                <ul class="nav-links">
                    <li><a href="userHomePage.jsp">Home</a></li>
                </ul>
            </nev>
            
        </div>
    </header>
    <div class="container">
        <h1>Update Profile</h1>
        <form action="UpdateUserProfile" method="post">
            <label for="fullname">Full Name</label>
            <input type="text" id="fullname" name="fullname" value="<%= fullname %>" required>

            <label for="mobile">Mobile Number</label>
            <input type="text" id="mobile" name="mobile" value="<%= mobile %>" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="<%= email %>" required>

            <label for="address">Address</label>
            <input type="text" id="address" name="address" value="<%= address %>" required>

            <label for="gender">Gender</label>
            <select id="gender" name="gender" required>
                <option value="Male" <%= "Male".equalsIgnoreCase(gender) ? "selected" : "" %>>Male</option>
                <option value="Female" <%= "Female".equalsIgnoreCase(gender) ? "selected" : "" %>>Female</option>
                <option value="Other" <%= "Other".equalsIgnoreCase(gender) ? "selected" : "" %>>Other</option>
            </select>

            <label for="dob">Date of Birth</label>
            <input type="date" id="dob" name="dob" value="<%= dob %>" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" value="<%= password %>" required>

            <button type="submit">Update</button>
        </form>
    </div>
</body>
</html>

<% 
    }
%>
 