<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    // Initialize variables for stored username and role
    String savedUsername = "";
    String savedRole = "";

    // Get cookies
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("username".equals(cookie.getName())) {
                savedUsername = cookie.getValue();
            }
            if ("role".equals(cookie.getName())) {
                savedRole = cookie.getValue();
            }
        }
    }
%>

<jsp:include page="Header.jsp" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hostel Dashboard Login</title>
    <link rel="stylesheet" type="text/css" href="Login.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>
    <div class="login-container">
        <div class="form-wrapper">
            <h2>Hostel Dashboard Login</h2>
            <form action="./LoginServlet" method="post" autocomplete="off">
                <div class="flex-column">
                    <label for="role">Select Role</label>
                    <div class="inputForm">
                        <i class="fas fa-user-tie"></i>
                        <select name="role" id="role" class="input" required>
                            <option value="" disabled>Select your role</option>
                            <option value="student" <%= "student".equals(savedRole) ? "selected" : "" %>>Student</option>
                            <option value="staff" <%= "staff".equals(savedRole) ? "selected" : "" %>>Staff</option>
                            <option value="admin" <%= "admin".equals(savedRole) ? "selected" : "" %>>Admin</option>
                        </select>
                    </div>
                </div>
                
                <!-- Display error message -->
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <p class="error-message"><%= request.getAttribute("errorMessage") %></p>
                <% } %>

                <div class="flex-column">
                    <label for="username">Username</label>
                    <div class="inputForm">
                        <i class="fas fa-user"></i>
                        <input type="text" name="username" id="username" class="input" 
                               placeholder="Enter your username" value="<%= savedUsername %>" required>
                    </div>
                </div>
                
                <div class="flex-column">
                    <label for="password">Password</label>
                    <div class="inputForm">
                        <i class="fas fa-lock"></i>
                        <input type="password" name="password" id="password" class="input" 
                               placeholder="Enter your password" required>
                    </div>
                </div>

                <!-- Remember Me Checkbox -->
                <div class="flex-row">
                    <input type="checkbox" name="rememberMe" id="rememberMe">
                    <label for="rememberMe">Remember Me</label>
                </div>

                <button type="submit" id="login-btn" class="button-submit">Login</button>
                <p id="forgot-password" class="forgot-password">Forgot Password?</p>
            </form>
        </div>
    </div>
</body>
<jsp:include page="Footer.jsp" />
</html>
