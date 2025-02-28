<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>

<%
    String error = null;
    String success = null;

    try {
        int userId = Integer.parseInt(request.getParameter("user_id"));
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();
        String role = request.getParameter("role");

        if (username.isEmpty() || password.isEmpty()) {
            error = "Username and Password are required.";
        } else {
            Connection con = DatabaseConnection.getConnection();

            // Check if the username already exists
            PreparedStatement checkStmt = con.prepareStatement("SELECT id FROM users WHERE username = ?");
            checkStmt.setString(1, username);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                error = "Username already exists. Choose another.";
            } else {
                // Insert user credentials
                PreparedStatement insertStmt = con.prepareStatement("INSERT INTO users (user_id, username, password, role) VALUES (?, ?, ?, ?)");
                insertStmt.setInt(1, userId);
                insertStmt.setString(2, username);
                insertStmt.setString(3, password);
                insertStmt.setString(4, role);
                insertStmt.executeUpdate();
                
                success = "User assigned successfully.";
            }
            
            rs.close();
            checkStmt.close();
            con.close();
        }
    } catch (Exception e) {
        e.printStackTrace();
        error = "An error occurred. Try again.";
    }

    // Redirect back to settings page with message
    if (error != null) {
        response.sendRedirect("Setting.jsp?error=" + error);
    } else {
        response.sendRedirect("Setting.jsp?success=" + success);
    }
%>
