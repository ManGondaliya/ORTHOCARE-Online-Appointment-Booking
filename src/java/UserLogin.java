
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
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author hp
 */

@WebServlet("/UserLogin")
public class UserLogin extends HttpServlet {
    
    boolean isValid = false;
    String name = null;
    String user_id = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        
        String user_name = request.getParameter("username");
        String password = request.getParameter("password");
        
            
        
        Connection con = null;
        PreparedStatement pst = null;
        Statement stmt = null;
        
        
        
        try
        {
            con = DBConnection.initializeDatabase();
             
            String qry = "select * from user where email=? and password=?";
            pst = con.prepareStatement(qry);
            
            pst.setString(1, user_name);
            pst.setString(2, password);
            
                   
                ResultSet rs = pst.executeQuery();
            
            
          
             String qry2 = "select * from user where email='"+user_name+"'";
             stmt = con.createStatement();
            
            if(rs.next())
            {
               
                ResultSet rs2 = stmt.executeQuery(qry2);
                
                if(rs2.next())
                {
                    user_id = rs2.getString(1);
                    name = rs2.getString(2);
                    
                }
                
               
                isValid = true;
                
                
                HttpSession session = request.getSession(true);

             
                session.setAttribute("user_id", user_id);
                session.setAttribute("name", name);

               
                session.setMaxInactiveInterval(30 * 60); // 30 minutes

                out.println("<script type=\"text/javascript\">");
                out.println("alert('Login Successfully..!');");
                out.println("window.location.href = 'userHomePage.jsp';");
                out.println("</script>");
              
            }
            else
            {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('UserName or Password are Wrong..!');");
                out.println("window.location.href = \"userLogin.jsp\";");
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
    }// </editor-fold>

}
