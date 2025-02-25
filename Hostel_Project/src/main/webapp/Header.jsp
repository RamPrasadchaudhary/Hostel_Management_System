<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Munnu Hostel</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Style/Header.css">
    <script>
        // JavaScript for toggling the menu
        function toggleMenu() {
            const navbar = document.getElementById("navbar");
            navbar.classList.toggle("open");
        }

        function closeMenu() {
            const navbar = document.getElementById("navbar");
            navbar.classList.remove("open");
        }
    </script>
</head>
<body>
    <header class="header">
        <div class="header-container">
            <!-- Logo Section -->
            <div class="logo-section">
                <img src="<%= request.getContextPath() %>/Image/image1.png" alt="Logo" class="logo-img">
                <h1 class="logo-title">Munnu Hostel</h1>
            </div>

            <!-- Toggle Button -->
            <button class="menu-toggle" onclick="toggleMenu()">
                <span class="toggle-bar"></span>
                <span class="toggle-bar"></span>
                <span class="toggle-bar"></span>
            </button>

            <!-- Navigation Menu -->
            <nav id="navbar" class="navbar">
                <ul class="nav-links">
                    <li><a href="Home.jsp" class="nav-link">Home</a></li>
                  
                    <li><a href="Login.jsp" class="nav-link btn-primary" onclick="closeMenu()">Login</a></li>
                </ul>
            </nav>
        </div>
    </header>
</body>
</html>
