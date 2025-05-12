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
import java.sql.Connection;
import java.sql.PreparedStatement;


@WebServlet("/BookAppointment")
public class BookAppointment extends HttpServlet {

  
    private int i=0;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
   
        String userId = request.getParameter("user_id");
        String patientName = request.getParameter("patient_name");
        String doctorName = request.getParameter("doctor_name");
        String appointmentDate = request.getParameter("appointmentDate");
        String appointmentTime = request.getParameter("appointmentTime");
       
        
        
        Connection con=null;
        PreparedStatement pst=null;
        
        try
        {
            con = DBConnection.initializeDatabase();
            
            String qry = "INSERT INTO Appointments (user_id, patient_name, doctor_name, appointment_date, appointment_time) VALUES (?, ?, ?, ?, ?)";
            
            pst = con.prepareStatement(qry);
            pst.setString(1, userId);
            pst.setString(2, patientName);
            pst.setString(3, doctorName);
            pst.setString(4, appointmentDate);
            pst.setString(5, appointmentTime);
            
            i = pst.executeUpdate();
            if (i > 0) {
                response.getWriter().println("<script>alert('Appointment scheduled successfully!'); window.location.href='userHomePage.jsp';</script>");
 

            } else {
                response.getWriter().println("<script>alert('Failed to schedule appointment.'); history.back();</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred: " + e.getMessage() + "'); history.back();</script>");
        } finally {
            // Close resources
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
