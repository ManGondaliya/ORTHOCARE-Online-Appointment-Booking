<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Retrieve session
    HttpSession session1 = request.getSession(false);

    if (session1 == null || session1.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Appointments</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .container {
            width: 90%;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .search-container {
            text-align: center;
            margin-bottom: 20px;
        }
        .search-container input {
            padding: 8px;
            width: 250px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
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
    </style>
</head>
<body>

    <!-- Manage Appointments Section -->
    <div class="container">
        <h1>Manage Appointments</h1>

        <!-- Search Box -->
        <div class="search-container">
            <input type="text" id="searchValue" placeholder="Search by ID or Patient Name" onkeyup="fetchFilteredData()">
        </div>

        <!-- Appointment Table -->
        <table>
            <thead>
                <tr>
                    <th>Appointment ID</th>
                    <th>Patient Name</th>
                    <th>Doctor Name</th>
                    <th>Appointment Date</th>
                    <th>Appointment Time</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="appointmentTable">
                <!-- Data will be inserted here dynamically -->
            </tbody>
        </table>
    </div>

    <script>
        function fetchFilteredData() {
            var searchValue = document.getElementById("searchValue").value;

            $.ajax({
                url: "searchAppointments.jsp",
                type: "GET",
                data: { search: searchValue },
                success: function(response) {
                    $("#appointmentTable").html(response);
                }
            });
        }
    </script>

</body>
</html>
