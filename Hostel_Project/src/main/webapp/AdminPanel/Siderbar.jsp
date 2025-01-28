<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="SideBar.css">
</head>
<body>

    <div class="container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-brand">
                <i class="fas fa-user-shield"></i> Hostel Admin
            </div>
            <ul class="sidebar-menu">
                <li class="sidebar-item" onclick="onSelect('MainContent')">
                    <button class="sidebar-link">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </button>
                </li>
                <li class="sidebar-item" onclick="onSelect('Student')">
                    <button class="sidebar-link">
                        <i class="fas fa-user-graduate"></i> Manage Students
                    </button>
                </li>
                <li class="sidebar-item" onclick="onSelect('ManageStaff')">
                    <button class="sidebar-link">
                        <i class="fas fa-user-tie"></i> Manage Staff
                    </button>
                </li>
                <li class="sidebar-item" onclick="onSelect('ManageWardens')">
                    <button class="sidebar-link">
                        <i class="fas fa-user-cog"></i> Manage Wardens
                    </button>
                </li>
                <li class="sidebar-item" onclick="onSelect('RoomManagement')">
                    <button class="sidebar-link">
                        <i class="fas fa-bed"></i> Manage Rooms
                    </button>
                </li>
                <li class="sidebar-item" onclick="onSelect('ComplaintPage')">
                    <button class="sidebar-link">
                        <i class="fas fa-exclamation-triangle"></i> Complaints
                    </button>
                </li>
                <li class="sidebar-item" onclick="onSelect('Payment')">
                    <button class="sidebar-link">
                        <i class="fas fa-credit-card"></i> Payments
                    </button>
                </li>
                <li class="sidebar-item" onclick="onSelect('Report')">
                    <button class="sidebar-link">
                        <i class="fas fa-file-alt"></i> Reports
                    </button>
                </li>
                <li class="sidebar-item" onclick="onSelect('Setting')">
                    <button class="sidebar-link">
                        <i class="fas fa-cogs"></i> Settings
                    </button>
                </li>
            </ul>
        </aside>

        <!-- Hamburger Button for Small Screens -->
        <div class="hamburger" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div id="MainContent" class="content-section active">
               
                <%@ include file="MainContent.jsp" %>
            </div>
            <div id="Student" class="content-section">
                 <%@ include file="Student.jsp" %>
            </div>
            <div id="ManageStaff" class="content-section">
                <%@ include file="Staff.jsp" %>
            </div>
            <div id="ManageWardens" class="content-section">
                 <%@ include file="Warden.jsp" %>
            </div>
            <div id="RoomManagement" class="content-section">
                <%@ include file="Room.jsp" %>
            </div>
            <div id="ComplaintPage" class="content-section">
                <h1>Complaints</h1>
                <p>Content for complaints.</p>
            </div>
            <div id="Payment" class="content-section">
                <h1>Payments</h1>
                <p>Content for payments.</p>
            </div>
            <div id="Report" class="content-section">
                <h1>Reports</h1>
                <p>Content for reports.</p>
            </div>
            <div id="Setting" class="content-section">
                <h1>Settings</h1>
                <p>Content for settings.</p>
            </div>
        </div>
    </div>

    <!-- JavaScript to change content based on sidebar selection -->
    <script>
        function onSelect(contentId) {
            // Hide all content sections
            const sections = document.querySelectorAll('.content-section');
            sections.forEach(section => {
                section.classList.remove('active');
            });

            // Show the selected content
            const selectedContent = document.getElementById(contentId);
            if (selectedContent) {
                selectedContent.classList.add('active');
            }
        }

        // Initially display the MainContent
        onSelect('MainContent');

        // Toggle the sidebar visibility on small screens
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('show');
        }
    </script>

</body>
</html>
