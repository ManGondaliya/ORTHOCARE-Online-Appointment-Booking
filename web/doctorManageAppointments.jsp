<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
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

        // Get search parameters
        String searchQuery = request.getParameter("searchQuery");
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
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h1 {
            text-align: center;
            color: #333;
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
            margin-top: 10px;
        }
        table th, table td {
            padding: 12px;
            border: 1px solid #ddd;
        }
        table th {
            background-color: #0077b6;
            color: white;
        }
        .action-button {
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            color: white;
        }
        .update-btn {
            background-color: #0077b6;
        }
        .update-btn:hover {
            background-color: #005f8a;
        }
    </style>
</head>
<body>

     <div class="header">
        <div class="logo-section">
            <img src="images/ortho-logo.png" alt="Hospital Logo">
            <div class="hospital-name">OrthoCare</div>
        </div>
        <div class="navigation">
            <a href="doctorHomePage.jsp">Home</a>
            <a href="Doctor_Logout">Logout</a>
        </div>
    </div>
    
    <!-- Manage Appointments Section -->
    <div class="container">
        <h1>Manage Appointments</h1>

        <!-- Search Form -->
          <div class="search-container">
            <form method="GET" action="doctorManageAppointments.jsp">
                <input type="text" name="searchQuery" placeholder="Search by ID or Patient Name" value="<%= request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : "" %>">
                <button type="submit">Search</button>
                <a href="doctorManageAppointments.jsp">
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
                    String url = "jdbc:mysql://localhost:3306/orthocare";
                    String user = "root";
                    String password = "man2815";

                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, user, password);

                        // Default query for the doctor's appointments
                        String query = "SELECT * FROM appointments WHERE doctor_name = ?";
                        
                        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                            query += " AND (appointment_id LIKE ? OR patient_name LIKE ?)";
                        }

                        stmt = conn.prepareStatement(query);
                        stmt.setString(1, doctor_Name);

                        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                            stmt.setString(2, "%" + searchQuery + "%");
                            stmt.setString(3, "%" + searchQuery + "%");
                        }

                        rs = stmt.executeQuery();

                        if (!rs.isBeforeFirst()) {
                            out.println("<tr><td colspan='7' style='color: red; text-align: center;'>No Appointments Found</td></tr>");
                        }

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
                        <form action="DoctorManageAppointment" method="POST">
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
                            <button type="submit" class="action-button update-btn">Update</button>
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
