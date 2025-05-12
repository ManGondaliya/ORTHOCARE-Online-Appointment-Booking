<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

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
        String doctor_Name = (String) doctorSession1.getAttribute("doctorName");
%>

<%
    
    int doctorId = (int)session.getAttribute("doctorId");

    // Database credentials
    String url = "jdbc:mysql://localhost:3306/orthocare";
    String user = "root";
    String password = "man2815";

    // Variables to hold doctor details
    String doctorName = "", mobile = "", email = "", specialization = "", qualification = "", doctorPassword = "", availability = "";
    double consultationFee = 0;

    // Database connection and retrieval
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Query to retrieve doctor data based on doctor_id
        String query = "SELECT * FROM doctor WHERE DoctorID = ?";
        ps = conn.prepareStatement(query);
        ps.setInt(1, doctorId);
        rs = ps.executeQuery();

        if (rs.next()) {
            doctorName = rs.getString("DoctorName");
            mobile = rs.getString("Mobile");
            email = rs.getString("Email");
            specialization = rs.getString("Specialization");
            qualification = rs.getString("Qualification");
            doctorPassword = rs.getString("Password");
            consultationFee = rs.getDouble("ConsultationFee");
            availability = rs.getString("Availability");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Update Doctor Profile</title>
     <link rel="icon" type="image/x-icon" href="images/ortho-logo.png">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        
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
            justify-content: space-between;
            align-items: center;
        }

        .header .logo {
            font-size: 24px;
            font-weight: bold;
        }
        
         .logo {
            display: flex;
            align-items: center;
        }

        .hospital-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            margin-right: 10px;
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
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #0077b6;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 15px;
            width: 100%;
        }
        button:hover {
            background-color: #005f8a;
        }
    </style>
</head>
<body>
    
    <div class="header">
        <div class="logo">
             <img src="images/ortho-logo.png" alt="Hospital Icon" class="hospital-icon">
            OrthoCare Doctor Profile</div>
        <div class="navigation">
            <a href="doctorHomePage.jsp">Home</a>
            <!--<a href="adminLogin.jsp">Logout</a>-->
        </div>
    </div>
    
    <div class="container">
        <h2>Update Doctor Profile</h2>
       
        <form action="UpdateDoctorProfile" method="POST">
            <input type="hidden" name="doctor_id" value="<%= doctorId %>">

            <label for="doctor_name">Doctor Name:</label>
            <input type="text" name="doctor_name" value="<%= doctorName %>" required>

            <label for="mobile">Mobile:</label>
            <input type="text" name="mobile" value="<%= mobile %>" required>

            <label for="email">Email:</label>
            <input type="email" name="email" value="<%= email %>" required>

            <label for="specialization">Specialization:</label>
            <input type="text" name="specialization" value="<%= specialization %>" required>

            <label for="qualification">Qualification:</label>
            <input type="text" name="qualification" value="<%= qualification %>" required>

            <label for="password">Password:</label>
            <input type="password" name="password" value="<%= doctorPassword %>" required>

            <label for="consultation_fee">Consultation Fee:</label>
            <input type="text"  name="consultation_fee" value="<%= consultationFee %>" required>

            <label for="availability">Availability:</label>
             <input type="Text" name="availability" value="<%= availability %>" required>

            <button type="submit">Update Profile</button>
        </form>
    </div>
</body>
</html>
<% 
    }
%>