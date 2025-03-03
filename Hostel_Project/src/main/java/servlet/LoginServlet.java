package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import database.DatabaseConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("Login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (role == null || username == null || password == null || 
            role.trim().isEmpty() || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "⚠️ All fields are required!");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection(); // Get new connection
            if (conn == null || conn.isClosed()) {
                throw new Exception("Database connection failed!");
            }

            PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM user WHERE role = ? AND username = ? AND password = ?"
            );
            stmt.setString(1, role);
            stmt.setString(2, username);
            stmt.setString(3, password); 

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                HttpSession session = request.getSession(true);
                session.setAttribute("username", username);
            
                session.setMaxInactiveInterval(100 * 60); // 30 minutes timeout

                // Redirect based on role
                switch (role.toLowerCase()) {
                    case "student": response.sendRedirect("StudentPanel/dashboard.jsp"); break;
                    case "staff": response.sendRedirect("StaffPanel/staff/index.jsp"); break;
                    case "admin": response.sendRedirect("AdminPanel/MainContent.jsp"); break;
                    default:
                        request.setAttribute("errorMessage", "❌ Invalid role!");
                        request.getRequestDispatcher("Login.jsp").forward(request, response);
                        break;
                }
            } else {
                request.setAttribute("errorMessage", "❌ Invalid username, password, or role!");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
            
            // Close resources
            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "⚠️ Internal server error: " + e.getMessage());
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } finally {
            DatabaseConnection.closeConnection(conn); // Ensure the connection is closed
        }
    }

}
