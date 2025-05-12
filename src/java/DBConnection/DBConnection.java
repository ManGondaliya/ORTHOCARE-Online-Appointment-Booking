/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBConnection;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author hp
 */
public class DBConnection {
    
   public static Connection initializeDatabase() 
        throws SQLException, ClassNotFoundException 
    { 
        String dbDriver = "com.mysql.cj.jdbc.Driver"; 
        String dbURL = "jdbc:mysql://localhost:3306/"; 
        // Database name to access 
        String dbName = "orthocare"; 
        String dbUsername = "root"; 
        String dbPassword = "man2815"; 
  
        Class.forName(dbDriver); 
        Connection con = DriverManager.getConnection(dbURL+dbName,dbUsername,dbPassword); 
        return con; 
    } 
    
}
