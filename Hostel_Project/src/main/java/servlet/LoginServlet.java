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

        try (Connection conn = DatabaseConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM login WHERE role = ? AND username = ? AND password = ?")) {
            
            stmt.setString(1, role);
            stmt.setString(2, username);
            stmt.setString(3, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);
                    
                    switch (role.toLowerCase()) {
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
                            response.sendRedirect("AdminPanel/MainContent.jsp");
                            break;
                        default:
                            request.setAttribute("errorMessage", "❌ Invalid role!");
                            request.getRequestDispatcher("Login.jsp").forward(request, response);
                            break;
                    }
                } else {
                    request.setAttribute("errorMessage", "❌ Invalid username, password, or role!");
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "⚠️ Internal server error. Please try again.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}
