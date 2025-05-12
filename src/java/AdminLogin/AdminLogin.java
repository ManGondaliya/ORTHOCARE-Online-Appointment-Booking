/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminLogin;

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
import java.sql.Statement;
import java.sql.ResultSet;

/**
 *
 * @author hp
 */


public class AdminLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
   
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        Connection con = null;
        Statement stmt = null;
        
        try
        {
            con = DBConnection.initializeDatabase();
            
            String qry = "select * from admin where Username='"+username+"' and Password='"+password+"'";
            
            stmt = con.createStatement();
            
                ResultSet rs = stmt.executeQuery(qry);
            
           
            
            if(rs.next())
            {
                
                
                HttpSession adminSession = request.getSession();
                adminSession.setMaxInactiveInterval(30 * 60);
                adminSession.setAttribute("admin", username);
         
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Login Successfull..Welcome Admin!');");
                out.println("window.location.href = 'adminHomePage.jsp';");
                out.println("</script>");
            }
            else
            {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('UserName or Password are Wrong..!');");
                out.println("window.location.href = 'adminLogin.jsp';");
                out.println("</script>");
            }
        }
        catch(Exception e)
        {
            out.println(e);
        }
            
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
