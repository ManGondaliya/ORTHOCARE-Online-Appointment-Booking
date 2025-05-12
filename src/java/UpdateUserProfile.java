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
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.DriverManager;

@WebServlet("/UpdateUserProfile")
public class UpdateUserProfile extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get user input from the form
        String userId = (String) request.getSession().getAttribute("user_id");
        String fullname = request.getParameter("fullname");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String password = request.getParameter("password");

        

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DBConnection.initializeDatabase();

            // Update user details in the database
            String updateQuery = "UPDATE user SET full_name = ?, phone_number = ?, email = ?, address = ?, gender = ?, date_of_birth = ?, password = ? WHERE user_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, fullname);
            pstmt.setString(2, mobile);
            pstmt.setString(3, email);
            pstmt.setString(4, address);
            pstmt.setString(5, gender);
            pstmt.setString(6, dob);
            pstmt.setString(7, password);
            pstmt.setString(8, userId);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                 HttpSession session = request.getSession(false);
                session.setAttribute("name", fullname);
                response.sendRedirect("updateUserProfile.jsp?success=true");
            } else {
                response.sendRedirect("updateUserProfile.jsp?error=notfound");
            }

            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("updateUserProfile.jsp?error=exception");
        }
    }
}

