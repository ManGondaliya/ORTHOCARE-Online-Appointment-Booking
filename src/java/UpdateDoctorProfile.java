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
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebServlet("/UpdateDoctorProfile")
public class UpdateDoctorProfile extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        
        String doctorId = request.getParameter("doctor_id");
        String doctorName = request.getParameter("doctor_name");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String specialization = request.getParameter("specialization");
        String qualification = request.getParameter("qualification");
        
        String password = request.getParameter("password");
        String consultationFee = request.getParameter("consultation_fee");
        String availability = request.getParameter("availability");
        
        
        
        Connection con=null;
        PreparedStatement pst=null;
        
        try
        {
            con = DBConnection.initializeDatabase();
            
            String qry = "UPDATE doctor SET DoctorName = ?, Mobile = ?, Email = ?, Specialization = ?, "
                    + "Qualification = ?, Password = ?, ConsultationFee = ?, Availability = ? WHERE DoctorID = ?";
            
            pst = con.prepareStatement(qry);
            
            pst.setString(1, doctorName);
            pst.setString(2, mobile);
            pst.setString(3, email);
            pst.setString(4, specialization);
            pst.setString(5, qualification);
            pst.setString(6, password);
            pst.setString(7, consultationFee);
            pst.setString(8, availability);
            pst.setString(9, doctorId);
            
            int rowsUpdated = pst.executeUpdate();
            
           if (rowsUpdated > 0) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<script type='text/javascript'>");
                response.getWriter().println("alert('Record updated successfully!');");
                response.getWriter().println("window.location='updateDoctorProfile.jsp';"); 
                response.getWriter().println("</script>");
            } else {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<script type='text/javascript'>");
                response.getWriter().println("alert('Failed to update appointment. Please try again.');");
                response.getWriter().println("window.location='updateDoctorProfile.jsp';");
                response.getWriter().println("</script>");
            }
            
        }
        catch (NumberFormatException e) {
            out.println("<h3 style='color:red;'>Invalid consultation fee format. Please enter a valid number.</h3>");
            e.printStackTrace();
        } catch (SQLException ex) {
            Logger.getLogger(UpdateDoctorProfile.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UpdateDoctorProfile.class.getName()).log(Level.SEVERE, null, ex);
        }
       
    }

  
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
