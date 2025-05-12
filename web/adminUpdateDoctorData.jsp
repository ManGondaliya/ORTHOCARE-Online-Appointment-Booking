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
    <title>Edit Doctor</title>
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
            margin: 40px auto;
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

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: bold;
            margin-top: 10px;
        }

        input, select {
            padding: 10px;
            margin-top: 5px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .action-buttons {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        .action-buttons button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .update-btn {
            background-color: #0077b6;
            color: white;
        }

        .cancel-btn {
            background-color: #d9534f;
            color: white;
        }

        .update-btn:hover {
            background-color: #005f8a;
        }

        .cancel-btn:hover {
            /*background-color: #b52a30;*/
            
        }
    </style>
</head>
<body>
    
     <!-- Header -->
    <div class="header">
        <div class="logo">
             <img src="images/ortho-logo.png" alt="Hospital Icon" class="hospital-icon">
            OrthoCare Admin</div>
        <div class="navigation">
            <a href="adminHomePage.jsp">Home</a>
            <a href="adminManageDoctors.jsp">Back</a>
            <a href="AdminLogout">Logout</a>
        </div>
    </div>
    <div class="container">
        <h1>Edit Doctor</h1>
        <%
            int doctorId = Integer.parseInt(request.getParameter("doctor_id"));
            String url = "jdbc:mysql://localhost:3306/orthocare";
            String user = "root";
            String password = "man2815";
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                String query = "SELECT * FROM doctor WHERE DoctorID = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, doctorId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
        %>
        <form action="adminUpdateDoctorData" method="post">
            <input type="hidden" name="doctorId" value="<%= rs.getInt("DoctorID") %>">
            <label for="doctorName">Name</label>
            <input type="text" id="doctorName" name="doctorName" value="<%= rs.getString("DoctorName") %>" required>

            <label for="specialization">Specialization</label>
            <input type="text" id="specialization" name="specialization" value="<%= rs.getString("Specialization") %>" required>

            <label for="qualification">Qualification</label>
            <input type="text" id="qualification" name="qualification" value="<%= rs.getString("Qualification") %>" required>

            <label for="consultationFee">Consultation Fee</label>
            <input type="number" id="consultationFee" name="consultationFee" value="<%= rs.getDouble("ConsultationFee") %>" required>

            <label for="status">Status</label>
            <select id="status" name="status" required>
                <option value="Active" <%= rs.getString("Status").equals("Active") ? "selected" : "" %>>Active</option>
                <option value="Deactive" <%= rs.getString("Status").equals("Deactive") ? "selected" : "" %>>Deactive</option>
            </select>

            <div class="action-buttons">
                <button type="submit" class="update-btn">Update</button>
                <a href="adminManageDoctors.jsp" class="cancel-btn">Cancel</a>
            </div>
        </form>
        <%
                }
            } catch (Exception e) {
                out.println("<p style='color: red; text-align: center;'>Error: " + e.getMessage() + "</p>");
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
    </div>
</body>
</html>

<%
    }
%>
