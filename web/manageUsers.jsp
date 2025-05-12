<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Manage Users</title>
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
        .action-button {
            color: white;
            background-color: #0077b6;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
            border: none;
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

    <!-- Manage Users Section -->
    <div class="container">
        <h1>Manage Users</h1>

        <!-- Search Form -->
       <div class="search-container">
            <form method="GET" action="manageUsers.jsp">
                <input type="text" name="search" placeholder="Search by ID or Patient Name" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                <button type="submit">Search</button>
                <a href="manageUsers.jsp">
                    <button type="button" style="background-color: #d9534f;">Reset</button>
                </a>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Full Name</th>
                    <th>Mobile No</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Gender</th>
                    <th>Date of Birth</th>
                    <th>Password</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database Connection Variables
                    String url = "jdbc:mysql://localhost:3306/orthocare";
                    String user = "root";
                    String pass = "man2815";

                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        // Load the JDBC driver
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // Establish the connection
                        conn = DriverManager.getConnection(url, user, pass);

                        // Search logic
                        String searchQuery = "SELECT * FROM user";
                        String searchTerm = request.getParameter("search");

                        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                            searchQuery += " WHERE user_id LIKE ? OR full_name LIKE ?";
                        }

                        pstmt = conn.prepareStatement(searchQuery);

                        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                            pstmt.setString(1, "%" + searchTerm + "%");
                            pstmt.setString(2, "%" + searchTerm + "%");
                        }

                        // Execute the query
                        rs = pstmt.executeQuery();

                        // Display data with editable fields
                        while (rs.next()) {
                            int userId = rs.getInt("user_id");
                            String fullName = rs.getString("full_name");
                            String mobileNo = rs.getString("phone_number");
                            String email = rs.getString("email");
                            String address = rs.getString("address");
                            String gender = rs.getString("gender");
                            Date dob = rs.getDate("date_of_birth");
                            String password = rs.getString("password");
                %>
                <tr>
                    <form action="AdminUpdateUser" method="POST">
                        <td><%= userId %></td>
                        <td><input type="text" name="fullname" value="<%= fullName %>" required></td>
                        <td><input type="text" name="mobile_no" value="<%= mobileNo %>" required></td>
                        <td><input type="email" name="email" value="<%= email %>" required></td>
                        <td><input type="text" name="address" value="<%= address %>" required></td>
                        <td>
                            <select name="gender">
                                <option value="Male" <%= gender.equals("Male") ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= gender.equals("Female") ? "selected" : "" %>>Female</option>
                                <option value="Other" <%= gender.equals("Other") ? "selected" : "" %>>Other</option>
                            </select>
                        </td>
                        <td><input type="date" name="date_of_birth" value="<%= dob %>" required></td>
                        <td><input type="text" name="password" value="<%= password %>" required></td>
                        <td>
                            <input type="hidden" name="user_id" value="<%= userId %>">
                            <button type="submit" class="action-button">Update</button>
                        </td>
                    </form>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='9' style='color: red; text-align: center;'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
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
