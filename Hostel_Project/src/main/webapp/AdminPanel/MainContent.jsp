<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="SideBar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="Style/MainContent.css">
    <link rel="stylesheet" href="Heading.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body>

<%
    int totalUsers = 0, totalStudents = 0, totalStaff = 0, totalWardens = 0, totalMaintenanceRequests = 0;

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostelproject", "root", "9821574168");

        ps = con.prepareStatement("SELECT COUNT(*) FROM users");
        rs = ps.executeQuery();
        if (rs.next()) totalUsers = rs.getInt(1);
        rs.close(); ps.close();

        ps = con.prepareStatement("SELECT COUNT(*) FROM students");
        rs = ps.executeQuery();
        if (rs.next()) totalStudents = rs.getInt(1);
        rs.close(); ps.close();

        ps = con.prepareStatement("SELECT COUNT(*) FROM staff");
        rs = ps.executeQuery();
        if (rs.next()) totalStaff = rs.getInt(1);
        rs.close(); ps.close();

        ps = con.prepareStatement("SELECT COUNT(*) FROM wardens");
        rs = ps.executeQuery();
        if (rs.next()) totalWardens = rs.getInt(1);
        rs.close(); ps.close();

        ps = con.prepareStatement("SELECT COUNT(*) FROM complaints");
        rs = ps.executeQuery();
        if (rs.next()) totalMaintenanceRequests = rs.getInt(1);
        rs.close(); ps.close();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>

<div class="heading-container">
    <h3 class="heading-title">Admin Dashboard</h3>
    <p class="heading-subtitle">This is the Admin Panel</p>
</div>

<div class="main-content">
    <div class="dashboard-overview">
        <div class="overview-card">
            <i class="fas fa-users"></i>
            <div class="overview-info">
                <h3><%= totalUsers %></h3>
                <p>Total Users</p>
            </div>
        </div>

        <div class="overview-card">
            <i class="fas fa-user-graduate"></i>
            <div class="overview-info">
                <h3><%= totalStudents %></h3>
                <p>Students</p>
            </div>
        </div>

        <div class="overview-card">
            <i class="fas fa-user-tie"></i>
            <div class="overview-info">
                <h3><%= totalStaff %></h3>
                <p>Staff Members</p>
            </div>
        </div>

        <div class="overview-card">
            <i class="fas fa-user-cog"></i>
            <div class="overview-info">
                <h3><%= totalWardens %></h3>
                <p>Wardens</p>
            </div>
        </div>

        <div class="overview-card">
            <i class="fas fa-tools"></i>
            <div class="overview-info">
                <h3><%= totalMaintenanceRequests %></h3>
                <p>Maintenance Requests</p>
            </div>
        </div>
    </div>

    <div class="section-content">
        <h2>Welcome, Admin!</h2>
        <p>Select a menu item from the left to get started.</p>
    </div>
</div>

</body>
</html>
