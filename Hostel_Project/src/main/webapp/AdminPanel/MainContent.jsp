<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="SideBar.jsp" %> <!-- Sidebar Included -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="Style/MainContent.css"> <!-- Link to CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="Heading.css"> <!-- Link to CSS -->
    
</head>
<body>
    <!-- Header Section -->
    <div class="heading-container">
        <h3 class="heading-title">Admin Dashboard</h3>
        <p class="heading-subtitle">This is the Admin Panel</p>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Dashboard Overview Section -->
        <div class="dashboard-overview">
            <div class="overview-card">
                <i class="fas fa-users"></i>
                <div class="overview-info">
                    <h3>150</h3>
                    <p>Total Users</p>
                </div>
            </div>
            <div class="overview-card">
                <i class="fas fa-user-graduate"></i>
                <div class="overview-info">
                    <h3>80</h3>
                    <p>Students</p>
                </div>
            </div>
            <div class="overview-card">
                <i class="fas fa-user-tie"></i>
                <div class="overview-info">
                    <h3>20</h3>
                    <p>Staff Members</p>
                </div>
            </div>
            <div class="overview-card">
                <i class="fas fa-user-cog"></i>
                <div class="overview-info">
                    <h3>5</h3>
                    <p>Wardens</p>
                </div>
            </div>
            <div class="overview-card">
                <i class="fas fa-tools"></i>
                <div class="overview-info">
                    <h3>10</h3>
                    <p>Maintenance Requests</p>
                </div>
            </div>
        </div>

        <!-- Section Content -->
        <div class="section-content">
            <h2>Welcome, Admin!</h2>
            <p>Select a menu item from the left to get started.</p>
        </div>
    </div>

</body>
</html>
