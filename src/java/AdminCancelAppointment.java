/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import DBConnection.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.DriverManager;

/**
 *
 * @author hp
 */

       @WebServlet("/AdminCancelAppointment")
public class AdminCancelAppointment extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String appointmentId = request.getParameter("appointment_id");

        

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            
            conn = DBConnection.initializeDatabase();
            
            String updateQuery = "UPDATE appointments SET status = ? WHERE appointment_id = ?";
            pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, "Canceled");
            pstmt.setInt(2, Integer.parseInt(appointmentId));

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.getWriter().println("<script>alert('Appointment Canceled successfully!'); window.location.href='adminManageAppointments.jsp';</script>");
                
            } else {
                response.getWriter().println("<script>alert('Failed to Update Appointment'); history.back();</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("appointmentHistory.jsp?error=exception");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
