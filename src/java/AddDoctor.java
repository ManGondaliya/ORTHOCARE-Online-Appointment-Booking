/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import DBConnection.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;



public class AddDoctor extends HttpServlet {
      
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
        PrintWriter out = response.getWriter();
        
        String doctorName = request.getParameter("doctorName");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String specialization = request.getParameter("specialization");
        String qualification = request.getParameter("qualification");
        String password = request.getParameter("password");
        String consultationFee = request.getParameter("consultationFee");
        String availability = request.getParameter("availability");
        
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try
        {
            con = DBConnection.initializeDatabase();
            
            String qry = "INSERT INTO doctor (DoctorName, Mobile, Email, Specialization, Qualification, Password, ConsultationFee, Availability) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            
            pstmt = con.prepareStatement(qry);
            
            pstmt.setString(1, doctorName);
            pstmt.setString(2, mobile);
            pstmt.setString(3, email);
            pstmt.setString(4, specialization);
            pstmt.setString(5, qualification);
            pstmt.setString(6, password);
            pstmt.setString(7,consultationFee);
            pstmt.setString(8, availability);
            
            int rowsInserted = pstmt.executeUpdate();
            
            if(rowsInserted > 0)
            {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Doctor Added Successsfully..!');");
                out.println("window.location.href = \"adminManageDoctors.jsp\";");
                out.println("</script>");
            }
            else
            {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error in Instering Record..!');");
                out.println("window.location.href = \"adminAddDoctor.jsp\";");
                out.println("</script>");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminAddDoctor.jsp?error=true");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
