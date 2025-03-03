<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="Header.jsp" %>
<%@ page import="java.sql.*, database.DatabaseConnection" %>

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
    
    // Initialize variables with default values.
    String name = "N/A";
    String address = "N/A";
    String email = "N/A";
    String admissionDate = "N/A";
    String parentName = "N/A";
    String branch = "N/A";	
    String contact = "N/A";
    String roomNumber="";
    // Fetch student data from database using the session username (contact).
    try {
        Connection conn = DatabaseConnection.getConnection();
        String sql = "SELECT * FROM students WHERE contact = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, (String)session.getAttribute("username"));
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            address = rs.getString("address");
            email = rs.getString("email");
            admissionDate = rs.getString("admissionDate");
            parentName = rs.getString("parentName");
            branch = rs.getString("branch");
            contact = rs.getString("contact");
        }
        rs.close();
        stmt.close();
        conn.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
    try {
        Connection conn = DatabaseConnection.getConnection();
        String sql = "SELECT room_number FROM allocations WHERE student_id = (SELECT id FROM students WHERE contact = ?)";

        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, (String)session.getAttribute("username"));
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            roomNumber = rs.getString("room_number");
            
        }
        rs.close();
        stmt.close();
        conn.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    
    <!-- Font Awesome for Icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    
    <!-- Link to External CSS -->
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>
    <section id="dashboard">
        
        <!-- Profile Summary -->
        <div class="section profile-summary">
            <!-- Header: Title and Action Buttons -->
            <div class="profile-header">
                <h2 style="margin:0;">Profile Details</h2>
                <div class="action-buttons">
                    <a href="profile.jsp" class="edit-profile-btn">Edit Profile</a>
                    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-btn">Logout</a>
                </div>
            </div>
            
            <!-- Profile Image (Centered) -->
            <div class="profile-pic">
                <img src="../Image/Hostel.png" alt="Student Picture">
            </div>
            
            <!-- Personal Details (Centered Container with Left-Aligned Text) -->
            <div class="personal-details">
                <p><strong>Name:</strong> <span id="name"><%= name %></span></p>
                <p><strong>Address:</strong> <span id="address"><%= address %></span></p>
                <p><strong>Email:</strong> <span id="email"><%= email %></span></p>
                <p><strong>Admission Date:</strong> <span id="admission"><%= admissionDate %></span></p>
                <p><strong>Parent Name:</strong> <span id="parentName"><%= parentName %></span></p>
                <p><strong>Branch:</strong> <span id="branch"><%= branch %></span></p>
                <p><strong>Phone Number:</strong> <span id="phone"><%= contact %></span></p>
                  <p><strong>Room Number:</strong> <span id="room-number"><%= roomNumber %></span></p>
            </div>
        </div>
        
        <!-- Announcements -->
        <div class="section announcements">
            <h2>Announcements</h2>
            <ul>
                <li>Reminder: Hostel fees are due by the end of the month.</li>
                <li>Maintenance work will be carried out on September 10th.</li>
                <li>Annual hostel meet on August 30th.</li>
            </ul>
        </div>
        
        <!-- Quick Links -->
        <div class="section quick-links">
            <h2>Quick Links</h2>
            <div class="quick-links-container">
                <a href="payments.jsp" class="quick-link">
                    <i class="fas fa-calendar-check"></i>
                    <span>View Payment History</span>
                </a>
                <a href="complaints.jsp" class="quick-link">
                    <i class="fas fa-clipboard-list"></i>
                    <span>Check Complaint Status</span>
                </a>
                <a href="complaints.jsp" class="quick-link">
                    <i class="fas fa-pencil-alt"></i>
                    <span>File a New Complaint</span>
                </a>
            </div>
        </div>
        
        <!-- Recent Activity -->
        <div class="section recent-activity">
            <h2>Recent Activity</h2>
            <ul>
                <li>Payment made for July 2024 - <span>Completed</span></li>
                <li>Complaint filed regarding room maintenance - <span>In Progress</span></li>
                <li>Payment made for June 2024 - <span>Completed</span></li>
                <li>Updated profile information - <span>Completed</span></li>
            </ul>
        </div>
        
    </section>
</body>
</html>
