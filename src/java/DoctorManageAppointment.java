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
import java.sql.*;

 @WebServlet("/DoctorManageAppointment")
public class DoctorManageAppointment extends HttpServlet {

     private static final String UPDATE_APPOINTMENT_SQL = 
        "UPDATE appointments SET appointment_date = ?, appointment_time = ?,status=? WHERE appointment_id = ?";
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String appointmentId = request.getParameter("appointment_id");
        String appointmentDate = request.getParameter("appointment_date");
        String appointmentTime = request.getParameter("appointment_time");
        String appointmentStatus = request.getParameter("status");

        Connection con = null;
        PreparedStatement pstmt = null;
        
       try
       {
           con = DBConnection.initializeDatabase();

           pstmt = con.prepareStatement(UPDATE_APPOINTMENT_SQL);
           pstmt.setString(1, appointmentDate);
           pstmt.setString(2, appointmentTime);
           pstmt.setString(3, appointmentStatus);
           pstmt.setInt(4, Integer.parseInt(appointmentId));

           int rowsUpdated = pstmt.executeUpdate();
            
            if (rowsUpdated > 0) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<script type='text/javascript'>");
                response.getWriter().println("alert('Appointment updated successfully!');");
                response.getWriter().println("window.location='doctorManageAppointments.jsp';"); 
                response.getWriter().println("</script>");
            } else {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<script type='text/javascript'>");
                response.getWriter().println("alert('Failed to update appointment. Please try again.');");
                response.getWriter().println("window.location='doctorManageAppointments.jsp';");
                response.getWriter().println("</script>");
            }

            // Redirect to the admin manage appointments page
            
           
       }
       catch(Exception e)
       {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error: Unable to connect to database or execute query.');</script>");
       }
        
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
