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
        String userId = (String) session1.getAttribute("user_id");
        String name = (String) session1.getAttribute("name");

        // Get search parameters
        String searchQuery = request.getParameter("searchQuery");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Appointment History</title> 
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
                text-align: center;
            }
            table th {
                background-color: #0077b6;
                color: white;
            }
            .cancel-btn {
                background-color: #ff4d4d;
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 5px;
                cursor: pointer;
            }
            .cancel-btn:hover {
                background-color: #cc0000;
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
            <a href="userHomePage.jsp">Home</a>
            <a href="UserLogout">Logout</a>
        </div>
    </div>

        <div class="container">
            <h1>Appointment History</h1>

            <!-- Search Form -->

              <div class="search-container">
            <form method="GET" action="userAppointmentHistory.jsp">
                <input type="text" name="searchQuery" placeholder="Search by AppointmentID or Patient Name" width="10px" value="<%= request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : "" %>">
                <button type="submit">Search</button>
                <a href="userAppointmentHistory.jsp">
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
                        <th>Appointment Status</th>
                        <th>Cancel Appointment</th>
                        <th>Delete Appointment</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Database Connection Variables
                        String url = "jdbc:mysql://localhost:3306/orthocare";
                        String user = "root";
                        String password = "man2815";

                        Connection conn = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;

                        try {
                            // Load the JDBC driver
                            Class.forName("com.mysql.cj.jdbc.Driver");

                            // Establish the connection
                            conn = DriverManager.getConnection(url, user, password);

                            // Default query for user’s appointments
                            String query = "SELECT * FROM appointments WHERE user_id = ?";

                            // Modify query if search is applied
                            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                                query += " AND (appointment_id LIKE ? OR patient_name LIKE ?)";
                            }

                            stmt = conn.prepareStatement(query);
                            stmt.setString(1, userId);

                            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                                stmt.setString(2, "%" + searchQuery + "%");
                                stmt.setString(3, "%" + searchQuery + "%");
                            }

                            rs = stmt.executeQuery();

                            if (!rs.isBeforeFirst()) {
                                out.println("<tr><td colspan='8' style='color: red; text-align: center;'>No Appointments Found</td></tr>");
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
                        <td><%= appointmentDate %></td>
                        <td><%= appointmentTime %></td>
                        <td><%= status %></td>
                        <td>
                            <% if ("Scheduled".equalsIgnoreCase(status) || "Confirmed".equalsIgnoreCase(status)) { %>
                                <form action="CancelAppointment" method="post" style="margin: 0;">
                                    <input type="hidden" name="appointment_id" value="<%= appointmentId %>">
                                    <button type="submit" class="cancel-btn">Cancel</button>
                                </form>
                            <% } else { %>
                                <span style="color: gray;">Not Cancelable</span>
                            <% } %>
                        </td>
                        <td>
                             <form action="DeleteAppointment" method="post" style="margin: 0;">
                                    <input type="hidden" name="appointment_id" value="<%= appointmentId %>">
                                    <button type="submit" class="cancel-btn">Delete</button>
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
