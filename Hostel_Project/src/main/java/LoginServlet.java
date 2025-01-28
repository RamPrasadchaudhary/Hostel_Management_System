import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = request.getParameter("user_role");
        String username = request.getParameter("login_username");
        String password = request.getParameter("login_password");

        // Simulate user login logic here
        if (role == null || username == null || password == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Example of role-based authentication (you may want to use a service layer to validate login details)
        if ("student".equals(role) && "testuser".equals(username) && "password123".equals(password)) {
            // Redirect to the appropriate dashboard
            response.sendRedirect("dashboard.jsp");
        } else {
            // Invalid credentials
            response.sendRedirect("login.jsp?error=Invalid credentials");
        }
    }
}
