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


@WebServlet("/AdminUpdateUser")
public class AdminUpdateUser extends HttpServlet {

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        String user_id = request.getParameter("user_id");
        String user_name = request.getParameter("fullname");
        String mobile = request.getParameter("mobile_no");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("date_of_birth");
        String password = request.getParameter("password");
        
        
        Connection con = null;
        PreparedStatement pst = null;
        
        try
        {
             con = DBConnection.initializeDatabase();
             
             String qry = "UPDATE USER SET full_name=? , email=? , phone_number=? ,address=? , gender=?, date_of_birth=?, password=? where user_id=?";
             
             pst = con.prepareStatement(qry);
             
             pst.setString(1,user_name);
             pst.setString(2, email);
             pst.setString(3, mobile);
             pst.setString(4, address);
             pst.setString(5, gender);
             pst.setString(6, dob);
             pst.setString(7, password);
             pst.setString(8, user_id);
             
            int i = pst.executeUpdate();
            
            if(i>0)
            {
                 response.getWriter().println("<script>alert('Record Updated Successfully..!'); window.location.href='manageUsers.jsp';</script>");
            }
            else
            {
                 response.getWriter().println("<script>alert('Failed to Update Record..!'); window.location.href='manageUsers.jsp';</script>");
            }
             
             
             
        }
        catch(Exception e)
        {
            
        }
        
        
        
                
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
