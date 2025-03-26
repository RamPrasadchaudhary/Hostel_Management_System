import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get existing session

        if (session != null) {
            session.invalidate(); // Destroy session
        }

        // Prevent caching issues
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setHeader("Expires", "0"); // Proxies

        // ✅ Remove cookies by setting expiry to 0
        Cookie userCookie = new Cookie("username", "");
        Cookie roleCookie = new Cookie("role", "");
        userCookie.setMaxAge(0);
        roleCookie.setMaxAge(0);
        response.addCookie(userCookie);
        response.addCookie(roleCookie);
        // Redirect to login page
        response.sendRedirect("Login.jsp");
    }
}
