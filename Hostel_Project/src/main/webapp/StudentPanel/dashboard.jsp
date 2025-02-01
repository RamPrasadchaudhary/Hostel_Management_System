<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>
   
    <section id="dashboard">
        <!-- Profile Summary -->
       <div class="section profile-summary">
            <div class="head">
                <h2>Profile Details</h2>
                <div class="sub-head">
                    <a href="profile.jsp" class="edit-profile-btn">Edit Profile</a>
                    <a href="../../index.jsp" class="logout-btn">Logout</a>
                </div>
            </div>
            
            <div class="profile-pic">
                <img src="./Components/Images/user.jpeg" alt="Student Picture">
            </div>
            
            <p><strong>Name:</strong> Ashish Raj</p>
            <p><strong>Father's Name:</strong> Rajesh Kumar Verma</p>
            <p><strong>Room Allotted:</strong> 516</p>
            <p><strong>Admission Date:</strong> 2024-01-15</p>
            <p><strong>Email:</strong> ashishraulin@gmail.com</p>
            <p><strong>Phone Number:</strong> 1234567890</p>
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
                    <i class="fa-solid fa-calendar-check"></i>
                    <span>View Payment History</span>
                </a>
                <a href="complaints.jsp" class="quick-link">
                    <i class="fa-solid fa-clipboard-list"></i>
                    <span>Check Complaint Status</span>
                </a>
                <a href="complaints.jsp" class="quick-link">
                    <i class="fa-solid fa-pencil"></i>
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
