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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Doctors</title>
    <link rel="icon" type="image/x-icon" href="images/ortho-logo.png">
    <style>
        /* General Body Styling */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        /* Header Section */
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

        /* Content Section */
        .container {
            width: 90%;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #0077b6;
            color: white;
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        .action-button {
            text-decoration: none;
            color: white;
            background-color: #0077b6;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
        }

        .action-button:hover {
            background-color: #005f8a;
        }

        .add-button {
            text-decoration: none;
            color: white;
            background-color: #28a745;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            display: inline-block;
            margin-bottom: 15px;
        }

        .add-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <div class="header">
        <div class="logo-section">
            <img src="images/ortho-logo.png" alt="Hospital Logo">
            <div class="hospital-name">OrthoCare</div>
        </div>
        <div class="navigation">
            <a href="adminHomePage.jsp">Home</a>
            <a href="adminAddDoctor.jsp">Add New Doctor</a>
        </div>
    </div>

    <!-- Content Section -->
    <div class="container">
        <h1>Manage Doctors</h1>
        <a href="adminAddDoctor.jsp" class="add-button">+ Add New Doctor</a>
        <table>
            <thead>
                <tr>
                    <th>Doctor ID</th>
                    <th>Name</th>
                    <th>Specialization</th>
                    <th>Qualification</th>
                    <th>Consultation Fee</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database Connection
                    String url = "jdbc:mysql://localhost:3306/orthocare";
                    String user = "root";
                    String password = "man2815";

                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, user, password);
                        stmt = conn.createStatement();
                        String query = "SELECT * FROM doctor";

                        rs = stmt.executeQuery(query);

                        while (rs.next()) {
                            int doctorId = rs.getInt("DoctorID");
                            String doctorName = rs.getString("DoctorName");
                            String specialization = rs.getString("Specialization");
                            String qualification = rs.getString("Qualification");
                            double consultationFee = rs.getDouble("ConsultationFee");
                            String status = rs.getString("Status");
                %>
                <tr>
                    <td><%= doctorId %></td>
                    <td><%= doctorName %></td>
                    <td><%= specialization %></td>
                    <td><%= qualification %></td>
                    <td><%= consultationFee %></td>
                    <td><%= status %></td>
                    <td>
                        <a href="adminUpdateDoctorData.jsp?doctor_id=<%= doctorId %>" class="action-button">Edit</a>
                        <!--<a href="deleteDoctor?doctor_id=<%= doctorId %>" class="action-button" style="background-color: #d9534f;">Delete</a>-->
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='7' style='color: red; text-align: center;'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>

<% 
    }
%>