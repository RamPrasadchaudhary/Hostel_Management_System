package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("user_id"));
            String username = request.getParameter("username").trim();
            String password = request.getParameter("password").trim();
            String role = request.getParameter("role");

            if (username.isEmpty() || password.isEmpty()) {
                response.sendRedirect("AdminPanel/Setting.jsp?error=Username and Password are required.");
                return;
            }

            try (Connection con = DatabaseConnection.getConnection()) {
                // Check if the username already exists
                PreparedStatement checkStmt = con.prepareStatement("SELECT id FROM user WHERE username = ?");
                checkStmt.setString(1, username);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    response.sendRedirect("AdminPanel/Setting.jsp?error=Username already exists. Choose another.");
                    return;
                }

                // Insert user credentials
                PreparedStatement insertStmt = con.prepareStatement("INSERT INTO user (user_id, username, password, role) VALUES (?, ?, ?, ?)");
                insertStmt.setInt(1, userId);
                insertStmt.setString(2, username);
                insertStmt.setString(3, password);
                insertStmt.setString(4, role);
                insertStmt.executeUpdate();

                response.sendRedirect("AdminPanel/Setting.jsp?success=User assigned successfully.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminPanel/Setting.jsp?error=An error occurred. Try again.");
        }
    }
}
