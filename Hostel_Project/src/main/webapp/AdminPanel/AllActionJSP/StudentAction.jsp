<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>

<%
    // Retrieve parameters from the form
    String action = request.getParameter("action");
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String branch = request.getParameter("branch");
    String contact = request.getParameter("contact");
    String admissionDate = request.getParameter("admissionDate");
    String address = request.getParameter("address");
    String parentName = request.getParameter("parentName");
    String email = request.getParameter("email");

    Connection conn = null;
    PreparedStatement pstmt = null;
    String message = "";

    try {
        conn = DatabaseConnection.getConnection();

        if ("delete".equals(action) && id != null && !id.isEmpty()) {
            // DELETE Operation
            String sql = "DELETE FROM students WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            int rowsDeleted = pstmt.executeUpdate();
            message = (rowsDeleted > 0) ? "Student deleted successfully!" : "Failed to delete student!";
        } else if (id == null || id.isEmpty()) {
            // INSERT Operation
            String sql = "INSERT INTO students (name, branch, contact, admissionDate, address, parentName, email) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, branch);
            pstmt.setString(3, contact);
            pstmt.setString(4, admissionDate);
            pstmt.setString(5, address);
            pstmt.setString(6, parentName);
            pstmt.setString(7, email);
            int rowsInserted = pstmt.executeUpdate();
            message = (rowsInserted > 0) ? "Student added successfully!" : "Failed to add student!";
        } else {
            // UPDATE Operation
            String sql = "UPDATE students SET name=?, branch=?, contact=?, admissionDate=?, address=?, parentName=?, email=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, branch);
            pstmt.setString(3, contact);
            pstmt.setString(4, admissionDate);
            pstmt.setString(5, address);
            pstmt.setString(6, parentName);
            pstmt.setString(7, email);
            pstmt.setString(8, id);  // Fixed: Set ID for WHERE clause
            int rowsUpdated = pstmt.executeUpdate();
            message = (rowsUpdated > 0) ? "Student updated successfully!" : "Failed to update student!";
        }
    } catch (SQLException e) {
        e.printStackTrace();
        message = "Database error occurred: " + e.getMessage();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) DatabaseConnection.closeConnection(conn);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Store message in session and redirect back to dashboard
    session.setAttribute("message", message);
    response.sendRedirect("../Student.jsp");
%>
