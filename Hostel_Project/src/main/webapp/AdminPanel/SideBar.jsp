<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// Prevent caching
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");

// Check that the user is logged in.
if (session.getAttribute("username") == null) {
    response.sendRedirect("Login.jsp");
    return;
}

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Admin Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        /* Basic styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
          
            height: 100vh;
                      
        }

        /* Sidebar styles */
        #hostelAdminSidebar {
            width: 250px;
            background-color: #333;
            color: white;
            position: fixed;
            height: 100%;
            top: 0;
            left: 0;
            transition: transform 0.3s ease-in-out;
            background-color: #3498db; /* Blue sidebar background */
        }

        #hostelAdminSidebar .sidebar-brand {
            padding: 20px;
            font-size: 20px;
            font-weight: bold;
            text-align: center;
        }

        #hostelAdminSidebar .sidebar-menu {
            list-style: none;
            padding: 0;
        }

        #hostelAdminSidebar .sidebar-item {
            padding: 15px 20px;
            

        }

        #hostelAdminSidebar .sidebar-link {
            color:black ;
            height:35px;
            border-radius:5px;
            text-decoration: none;
            font-size: 16px;
            display: flex;
            align-items: center;
            transition: background 0.3s;
            background-color:white;
            padding-left:20px;
            
        }

        #hostelAdminSidebar .sidebar-link i {
            margin-right: 10px;
            color:blue;
        }

        #hostelAdminSidebar .sidebar-link:hover {
            background-color: #444;
        }

        /* Main content area */
        #mainContent {
            margin-left: 250px;
            padding: 20px;
            flex-grow: 1;
            width: calc(100% - 250px);
            transition: margin-left 0.3s ease-in-out;
        }

        /* Hamburger menu */
        #hamburgerButton {
            display: none;
            font-size: 30px;
            color: #333;
            position: fixed;
            top: 20px;
            left: 20px;
            cursor: pointer;
            z-index: 1000;
        }

        /* Responsive design */
        @media screen and (max-width: 768px) {
            #hostelAdminSidebar {
                transform: translateX(-100%);
            }

            #hostelAdminSidebar.show {
                transform: translateX(0);
            }

            #hamburgerButton {
                display: block;
            }

            #mainContent {
                margin-left: 0;
                width: 100%;
            }

            #hostelAdminSidebar.show + #mainContent {
                margin-left: 250px;
                width: calc(100% - 250px);
            }
        }
       
       
       
       
       
        .header {
            display: flex;
            justify-content: right;
            align-items: center;
            margin-botton:0px;
            padding: 15px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }
        .user-info {
            font-size: 16px;
            color: #333;
        }
        .logout-btn {
            padding: 8px 20px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }

    </style>
</head>
<body>
 <%-- Session Check --%>

     <div class="header">
        <div class="user-info">
            <h3 style="margin-right:100px; color:green;">Welcome, <%= session.getAttribute("username") %>  </h3>
        </div>
		  <form action="${pageContext.request.contextPath}/LogoutServlet" method="get">
    <input type="submit" class="logout-btn" value="Logout">
</form>

    </div>
    <!-- Sidebar -->
    <aside id="hostelAdminSidebar">
    
        <div class="sidebar-brand">
            <i class="fas fa-user-shield"></i> Hostel Admin
        </div>
        
        <ul class="sidebar-menu">
            <li class="sidebar-item">
                <a class="sidebar-link" href="MainContent.jsp">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="Student.jsp">
                    <i class="fas fa-user-graduate"></i> Manage Students
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="Staff.jsp">
                    <i class="fas fa-user-tie"></i> Manage Staff
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="Warden.jsp">
                    <i class="fas fa-user-cog"></i> Manage Wardens
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="Room.jsp">
                    <i class="fas fa-bed"></i> Manage Rooms
                </a>
            </li>			
            <li class="sidebar-item">
                <a class="sidebar-link" href="complaint.jsp">
                    <i class="fas fa-exclamation-triangle"></i> Complaints
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="Payment.jsp">
                    <i class="fas fa-credit-card"></i> Payments
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="Report.jsp">
                    <i class="fas fa-file-alt"></i> Reports
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="Setting.jsp">
                    <i class="fas fa-cogs"></i> Settings
                </a>
            </li>
        </ul>
    </aside>

    <!-- Hamburger Button for Small Screens -->
    <div id="hamburgerButton" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </div>


    <script>
        // Encapsulated JavaScript in an IIFE to avoid global scope pollution
        (function() {
            function toggleSidebar() {
                const sidebar = document.querySelector('#hostelAdminSidebar');
                sidebar.classList.toggle('show');
            }

            // Expose toggleSidebar function if needed
            window.toggleSidebar = toggleSidebar;
        })();
    </script>

</body>
</html>
