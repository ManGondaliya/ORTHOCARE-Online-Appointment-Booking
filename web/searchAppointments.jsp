<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String searchValue = request.getParameter("search");

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

        // Query with filter
        String query = "SELECT * FROM appointments WHERE appointment_id LIKE ? OR patient_name LIKE ?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, "%" + searchValue + "%");
        stmt.setString(2, "%" + searchValue + "%");

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
    <td><%= appointmentDate %></td>
    <td><%= appointmentTime %></td>
    <td><%= status %></td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("<tr><td colspan='6' style='color: red; text-align: center;'>Error: " + e.getMessage() + "</td></tr>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
