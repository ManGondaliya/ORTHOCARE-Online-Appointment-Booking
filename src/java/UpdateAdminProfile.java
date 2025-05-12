/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DBConnection.DBConnection;
import java.sql.Connection;
import java.sql.Statement;



public class UpdateAdminProfile extends HttpServlet {

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        
        String adminID = request.getParameter("adminID");
        String userNm = request.getParameter("username");
        String password = request.getParameter("password");
        
        Connection con = null;
        Statement stmt= null;
        
        try
        {
            con = DBConnection.initializeDatabase();
            
            String qry = "update admin set Username='"+userNm+"',Password='"+password+"' where AdminID='"+adminID+"'";
            
                stmt= con.createStatement();

                int res = stmt.executeUpdate(qry);
            
            if(res>0)
            {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Profile Updated Successsfully..!');");
                out.println("window.location.href = \"adminHomePage.jsp\";");
                out.println("</script>");
            }
            
                
            
        }
        catch(Exception e)
        {
            out.print(e);
        }
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
