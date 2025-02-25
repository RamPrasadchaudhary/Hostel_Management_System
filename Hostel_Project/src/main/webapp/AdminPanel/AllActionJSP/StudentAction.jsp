<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>

<%
    // Retrieve parameters from form
    String action = request.getParameter("action");
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String roomNo = request.getParameter("roomNo");
    String branch = request.getParameter("branch");
    String contact = request.getParameter("contact");
    String admissionDate = request.getParameter("admissionDate");
    String address = request.getParameter("address");

    Connection conn = DatabaseConnection.getConnection();
    PreparedStatement pstmt = null;
    String message = "";

    try {
        if ("delete".equals(action) && id != null) {
            // DELETE Operation
            String sql = "DELETE FROM students WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);

            int rowsDeleted = pstmt.executeUpdate();
            message = (rowsDeleted > 0) ? "Student deleted successfully!" : "Failed to delete student!";
        } else if (id == null || id.isEmpty()) {
            // INSERT Operation
            String sql = "INSERT INTO students (name, roomNo, branch, contact, admissionDate, address) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, roomNo);
            pstmt.setString(3, branch);
            pstmt.setString(4, contact);
            pstmt.setString(5, admissionDate);
            pstmt.setString(6, address);

            int rowsInserted = pstmt.executeUpdate();
            message = (rowsInserted > 0) ? "Student added successfully!" : "Failed to add student!";
        } else {
            // UPDATE Operation
            String sql = "UPDATE students SET name=?, roomNo=?, branch=?, contact=?, admissionDate=?, address=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, roomNo);
            pstmt.setString(3, branch);
            pstmt.setString(4, contact);
            pstmt.setString(5, admissionDate);
            pstmt.setString(6, address);
            pstmt.setString(7, id);

            int rowsUpdated = pstmt.executeUpdate();
            message = (rowsUpdated > 0) ? "Student updated successfully!" : "Failed to update student!";
        }
    } catch (SQLException e) {
        e.printStackTrace();
        message = "Database error occurred!";
    } finally {
        if (pstmt != null) pstmt.close();
        DatabaseConnection.closeConnection(conn);
    }

    // Store message in session and redirect back to dashboard
    session.setAttribute("message", message);
    response.sendRedirect("../Student.jsp");
%>
