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

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
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
            // Update the user record with the new password and contact information.
            String sql = "UPDATE user SET password = ?, username = ? WHERE user_id = ? AND role = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, password);
            ps.setString(2, contact);  // updating contact value in the username column
            ps.setInt(3, userId);
            ps.setString(4, role);
            
            int result = ps.executeUpdate();
            if(result > 0) {
                response.sendRedirect(request.getContextPath() + "/AdminPanel/Setting.jsp?success=User updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/AdminPanel/Setting.jsp?error=Failed to update user");
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
