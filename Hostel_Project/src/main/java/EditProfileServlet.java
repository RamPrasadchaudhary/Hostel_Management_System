
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String name = request.getParameter("name");
        String fatherName = request.getParameter("father_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        try {
            Connection conn = DatabaseConnection.getConnection();
            String sql = "UPDATE students SET name=?, father_name=?, email=?, contact=? WHERE contact=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, fatherName);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.setString(5, username);

            int updated = stmt.executeUpdate();

            if (updated > 0) {
                session.setAttribute("name", name);
                session.setAttribute("father_name", fatherName);
                session.setAttribute("email", email);
                session.setAttribute("phone", phone);
                response.sendRedirect("StudentPanel/dashboard.jsp?success=Profile updated successfully");
            } else {
                response.sendRedirect("StudentPanel/profile.jsp?error=Failed to update profile");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
