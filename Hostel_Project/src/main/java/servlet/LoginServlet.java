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

    // Handle GET requests - Redirect to login page
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("Login.jsp");
    }

    // Handle POST requests - Login authentication
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Retrieve form data
        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (role == null || username == null || password == null || 
            role.isEmpty() || username.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "⚠️ All fields are required!");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        try {
            // Establish database connection
            Connection conn = DatabaseConnection.getConnection();
            if (conn == null) {
                request.setAttribute("errorMessage", "⚠️ Database connection failed!");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
            }

            // Prepare SQL query
            String query = "SELECT * FROM login WHERE role = ? AND username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, role);
            stmt.setString(2, username);
            stmt.setString(3, password);

            // Execute query
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Valid credentials - create session
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);
                
                // Redirect based on role
                switch (role) {
                    case "student":
                        response.sendRedirect("studentDashboard.jsp");
                        break;
                    case "staff":
                        response.sendRedirect("staffDashboard.jsp");
                        break;
                    case "warden":
                        response.sendRedirect("wardenDashboard.jsp");
                        break;
                    case "admin":
                        response.sendRedirect("AdminPanel/MainContent.jsp"); // Admin panel
                        break;
                    default:
                        response.sendRedirect("Login.jsp");
                        break;
                }
            } else {
                // Invalid credentials
                request.setAttribute("errorMessage", "❌ Invalid username, password, or role!");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }

            // Close resources
            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "⚠️ Internal server error. Please try again.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}
