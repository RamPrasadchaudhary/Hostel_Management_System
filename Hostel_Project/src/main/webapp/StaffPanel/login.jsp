<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.concurrent.atomic.AtomicInteger" %>
<%
    // Handle logout
    if(request.getParameter("logout") != null) {
        session.invalidate();
        response.sendRedirect(request.getContextPath() + "/login.jsp?logoutSuccess=true");
        return;
    }

    // Handle logout success message
    String logoutMessage = null;
    if(request.getParameter("logoutSuccess") != null) {
        logoutMessage = "You have been successfully logged out!";
    }

    // Traffic counter
    AtomicInteger counter = (AtomicInteger) application.getAttribute("trafficCounter");
    if(counter == null) {
        counter = new AtomicInteger(0);
        application.setAttribute("trafficCounter", counter);
    }
    int visits = counter.incrementAndGet();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Login</title>
<link rel="stylesheet" href="assets/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="login-container">
        <div class="form-wrapper">
            <% if(logoutMessage != null) { %>
                <div class="logout-message"><%= logoutMessage %></div>
            <% } %>
            
            <% if(request.getParameter("error") != null) { %>
                <div class="error-message">
                    <% switch(request.getParameter("error")) {
                        case "invalid_credentials": %>Invalid credentials!<% break;
                        case "missing_fields": %>Please fill all fields!<% break;
                    } %>
                </div>
            <% } %>
            
            <h2>Hostel Dashboard Login</h2>
            <form action="loginHandler.jsp" method="POST">
                <div class="inputForm">
                    <i class="fa-solid fa-user-tie"></i>
                    <select name="role" class="input" required>
                        <option value="" disabled selected>Select Role</option>
                        <option value="staff">Staff</option>
                        <option value="admin">Admin</option>
                    </select>
                </div>
                
                <div class="inputForm">
                    <i class="fa-solid fa-user"></i>
                    <input type="text" name="username" class="input" placeholder="Username" required>
                </div>
                
                <div class="inputForm">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="password" class="input" placeholder="Password" required>
                </div>
                
                <button type="submit" class="button-submit">Login</button>
                
                <div id="traffic-counter">
                    Total Visits: <span class="traffic-number"><%= visits %></span>
                </div>
            </form>
        </div>
    </div>
</body>
</html>