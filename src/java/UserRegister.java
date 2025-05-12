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
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import DBConnection.DBConnection;

/**
 *
 * @author hp
 */
@WebServlet("/UserRegister")
public class UserRegister extends HttpServlet {
    
    private int i = 0;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
         response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        
        
        
       
        
        Connection con = null;
        PreparedStatement pst = null;
        
        try
        {
             con = DBConnection.initializeDatabase();
             
             
            
            String sql = "INSERT INTO user (full_name, email, phone_number, gender, date_of_birth, address, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
            
            pst = con.prepareStatement(sql);
            
            pst.setString(1, fullname);
            pst.setString(2, email);
            pst.setString(3, mobile);
            pst.setString(4, gender);
            pst.setString(5, dob);
            pst.setString(6, address);
            pst.setString(7, password);
            
            i = pst.executeUpdate();
            
            if (i > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Registerd Successfully..!');");
                out.println("window.location.href = \"userLogin.jsp\";");
                out.println("</script>");
                //RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
                //rd.forward(request, response);
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Username or Password is Incorrect..!');");
                out.println("window.location.href = \"user_Registration.jsp\";");
                out.println("</script>");
                //RequestDispatcher rd = request.getRequestDispatcher("adminRegister.jsp");
                //rd.forward(request, response);
            }
        }
        catch(Exception e)
        {
            out.println(e);
        }
        
        
        
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
