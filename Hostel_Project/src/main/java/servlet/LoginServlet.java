import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe"); // Check if "Remember Me" is checked

        if (role == null || username == null || password == null || 
            role.trim().isEmpty() || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "⚠️ All fields are required!");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();
            if (conn == null || conn.isClosed()) {
                throw new Exception("Database connection failed!");
            }

            stmt = conn.prepareStatement(
                "SELECT * FROM user WHERE role = ? AND username = ? AND password = ?"
            );
            stmt.setString(1, role);
            stmt.setString(2, username);
            stmt.setString(3, password);

            rs = stmt.executeQuery();
            if (rs.next()) {
                HttpSession session = request.getSession(true);
                session.setAttribute("username", username);
                session.setAttribute("role", role);
                session.setMaxInactiveInterval(30 * 60); // 30 minutes timeout

                // ✅ Save cookies only if "Remember Me" is checked
                if ("on".equals(rememberMe)) {
                    Cookie userCookie = new Cookie("username", username);
                    Cookie roleCookie = new Cookie("role", role);
                    
                    userCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
                    roleCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days

                    userCookie.setPath("/"); // Ensure cookies are available site-wide
                    roleCookie.setPath("/");

                    response.addCookie(userCookie);
                    response.addCookie(roleCookie);
                }

                // ✅ Redirect based on role
                switch (role.toLowerCase()) {
                    case "student": 
                        response.sendRedirect(request.getContextPath() + "/StudentPanel/dashboard.jsp");
                        break;
                    case "staff": 
                        response.sendRedirect(request.getContextPath() + "/StaffPanel/index.jsp");
                        break;
                    case "admin": 
                        response.sendRedirect(request.getContextPath() + "/AdminPanel/MainContent.jsp");	
                        break;
                    default:
                        request.setAttribute("errorMessage", "❌ Invalid role!");
                        request.getRequestDispatcher("/Login.jsp").forward(request, response);
                        break;
                }
            } else {
                request.setAttribute("errorMessage", "❌ Invalid username, password, or role!");
                request.getRequestDispatcher("/Login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "⚠️ Internal server error: " + e.getMessage());
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
