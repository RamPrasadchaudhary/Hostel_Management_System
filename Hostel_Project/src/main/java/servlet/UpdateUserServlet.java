import java.io.IOException;
import java.io.PrintWriter;
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("user_id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (userId == null || username == null || password == null || role == null) {
            response.getWriter().write("Missing parameters");
            return;
        }

        try (Connection con = DatabaseConnection.getConnection()) {
            String sql = "UPDATE user SET username=?, password=? WHERE user_id=? AND role=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setInt(3, Integer.parseInt(userId));
                ps.setString(4, role);

                int updated = ps.executeUpdate();
                if (updated > 0) {
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("Update failed. User not found.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error updating user.");
        }
    }
}
