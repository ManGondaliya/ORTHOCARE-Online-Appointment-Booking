import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import DBConnection.DBConnection;


@WebServlet("/DoctorLogin")
public class DoctorLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

       
        String email = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            

            conn = DBConnection.initializeDatabase();
            
            String query = "SELECT * FROM doctor WHERE Email = ? AND Password = ?";
            pst = conn.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);

            rs = pst.executeQuery();

            if (rs.next()) {
                
                HttpSession doctorSession = request.getSession();
               // doctorSession.setMaxInactiveInterval(30 * 60);
                doctorSession.setAttribute("doctorName", rs.getString("DoctorName"));
                doctorSession.setAttribute("doctorId", rs.getInt("DoctorID"));
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Login Successfull!');");
                out.println("location='doctorHomePage.jsp';");
                out.println("</script>");
            } else { 
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Invalid Email or Password!');");
                out.println("location='doctorLogin.jsp';");
                out.println("</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Database Connection Error!</h3>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
