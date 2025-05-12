/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DBConnection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/adminUpdateDoctorData")
public class adminUpdateDoctorData extends HttpServlet {

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        String doctorName = request.getParameter("doctorName");
        String specialization = request.getParameter("specialization");
        String qualification = request.getParameter("qualification");
        double consultationFee = Double.parseDouble(request.getParameter("consultationFee"));
        String status = request.getParameter("status");

       

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBConnection.initializeDatabase();
            String query = "UPDATE doctor SET DoctorName = ?, Specialization = ?, Qualification = ?, ConsultationFee = ?, Status = ? WHERE DoctorID = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, doctorName);
            pstmt.setString(2, specialization);
            pstmt.setString(3, qualification);
            pstmt.setDouble(4, consultationFee);
            pstmt.setString(5, status);
            pstmt.setInt(6, doctorId);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                //response.sendRedirect("adminViewDoctors.jsp");
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<script type='text/javascript'>");
                response.getWriter().println("alert('Record updated successfully!');");
                response.getWriter().println("window.location='adminManageDoctors.jsp';"); 
                response.getWriter().println("</script>");
            } else {
               response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<script type='text/javascript'>");
                response.getWriter().println("alert('Error in update record..!');");
                response.getWriter().println("window.location='adminUpdateDoctorData.jsp';"); 
                response.getWriter().println("</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        } finally {
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException ex) {
                Logger.getLogger(adminUpdateDoctorData.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (conn != null) try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(adminUpdateDoctorData.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
