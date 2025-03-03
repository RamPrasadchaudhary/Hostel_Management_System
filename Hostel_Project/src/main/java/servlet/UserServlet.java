package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
          throws ServletException, IOException {
        String userIdStr = request.getParameter("user_id");
        String contact = request.getParameter("contact");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        int userId = Integer.parseInt(userIdStr);
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = DatabaseConnection.getConnection();
            // Insert a new record in the user table using contact as the username.
            String sql = "INSERT INTO user (user_id, username, password, role) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, contact);  // storing contact in the username column
            ps.setString(3, password);
            ps.setString(4, role);
            
            int result = ps.executeUpdate();
            if(result > 0) {
                response.sendRedirect(request.getContextPath() + "/AdminPanel/Setting.jsp?success=User allowed successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/AdminPanel/Setting.jsp?error=Failed to allow user");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/AdminPanel/Setting.jsp?error=Exception occurred: " + e.getMessage());
        } finally {
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(con != null) con.close(); } catch(Exception e) {}
        }
    }
}
