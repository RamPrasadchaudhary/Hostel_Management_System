// Update with your package name
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/StudentDashboardServlet")
public class StudentDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the current session; do not create a new one if it doesn't exist.
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Fetch username stored in session (assumed to be contact number)
        String username = (String) session.getAttribute("username");

        String sql = "SELECT * FROM students WHERE contact = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    session.setAttribute("name", rs.getString("name"));
                    session.setAttribute("branch", rs.getString("branch"));
                    session.setAttribute("contact", rs.getString("contact"));
                    session.setAttribute("admissionDate", rs.getString("admissionDate"));
                    session.setAttribute("address", rs.getString("address"));
                    session.setAttribute("parentName", rs.getString("parentName"));
                    session.setAttribute("email", rs.getString("email"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Redirect to dashboard after setting session attributes
        response.sendRedirect("StudentPanel/dashboard.jsp");
    }
}
