<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    // Dummy user database (replace with real implementation)
    final String VALID_USERNAME = "staff";
    final String VALID_PASSWORD = "staff123";
    final String VALID_ROLE = "staff";

    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String role = request.getParameter("role");

    if(username == null || password == null || role == null) {
        response.sendRedirect("login.jsp?error=missing_fields");
        return;
    }

    if(username.equals(VALID_USERNAME) && password.equals(VALID_PASSWORD) && role.equals(VALID_ROLE)) {
        session.setAttribute("user", username);
        session.setAttribute("role", role);
        session.setMaxInactiveInterval(30*60); // 30 minutes
        response.sendRedirect("dashboard.jsp");
    } else {
        response.sendRedirect("login.jsp?error=invalid_credentials");
    }
%>