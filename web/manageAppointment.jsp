<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Retrieve session
    HttpSession session1 = request.getSession(false);

    if (session1 == null || session1.getAttribute("admin") == null) {
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
    <title>Manage Appointments</title>
    <link rel="icon" type="image/x-icon" href="images/ortho-logo.png">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
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
            width: 90%;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .search-container {
            text-align: center;
            margin-bottom: 20px;
        }
        .search-container input {
            padding: 8px;
            width: 200px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .search-container button {
            padding: 8px 15px;
            background-color: #0077b6;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .search-container button:hover {
            background-color: #005f8a;
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
            border: none;
            cursor: pointer;
        }
        .action-button:hover {
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

    <!-- Manage Appointments Section -->
    <div class="container">
        <h1>Manage Appointments</h1>

        <!-- Search Filter -->
        <div class="search-container">
            <form method="GET" action="manageAppointment.jsp">
                <input type="text" name="searchValue" placeholder="Search by ID or Patient Name" value="<%= request.getParameter("searchValue") != null ? request.getParameter("searchValue") : "" %>">
                <button type="submit">Search</button>
                <a href="manageAppointment.jsp">
                    <button type="button" style="background-color: #d9534f;">Reset</button>
                </a>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Appointment ID</th>
                    <th>Patient Name</th>
                    <th>Doctor Name</th>
                    <th>Appointment Date</th>
                    <th>Appointment Time</th>
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
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, user, password);

                        // Get search parameter
                        String searchValue = request.getParameter("searchValue");
                        String query;

                        if (searchValue != null && !searchValue.trim().isEmpty()) {
                            query = "SELECT * FROM appointments WHERE appointment_id LIKE ? OR patient_name LIKE ?";
                            stmt = conn.prepareStatement(query);
                            stmt.setString(1, "%" + searchValue.trim() + "%");
                            stmt.setString(2, "%" + searchValue.trim() + "%");
                        } else {
                            query = "SELECT * FROM appointments";
                            stmt = conn.prepareStatement(query);
                        }

                        rs = stmt.executeQuery();

                        while (rs.next()) {
                            int appointmentId = rs.getInt("appointment_id");
                            String patientName = rs.getString("patient_name");
                            String doctorName = rs.getString("doctor_name");
                            Date appointmentDate = rs.getDate("appointment_date");
                            Time appointmentTime = rs.getTime("appointment_time");
                            String status = rs.getString("status");
                %>
                <tr>
                    <td><%= appointmentId %></td>
                    <td><%= patientName %></td>
                    <td><%= doctorName %></td>
                    <td>
                        <form action="AdminManageAppointment" method="POST">
                            <input type="hidden" name="appointment_id" value="<%= appointmentId %>">
                            <input type="date" name="appointment_date" value="<%= appointmentDate %>" required>
                    </td>
                    <td>
                            <input type="time" name="appointment_time" value="<%= appointmentTime %>" required>
                    </td>
                    <td>
                            <select name="status">
                                <option value="Scheduled" <%= status.equals("Scheduled") ? "selected" : "" %>>Scheduled</option>
                                <option value="Confirmed" <%= status.equals("Confirmed") ? "selected" : "" %>>Confirmed</option>
                                <option value="Canceled" <%= status.equals("Canceled") ? "selected" : "" %>>Cancelled</option>
                            </select>
                    </td>
                    <td>
                            <button type="submit" class="action-button">Update</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='7' style='color: red; text-align: center;'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
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
