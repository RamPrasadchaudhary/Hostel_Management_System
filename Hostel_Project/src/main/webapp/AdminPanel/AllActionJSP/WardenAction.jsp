<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>

<%
    String action = request.getParameter("action");
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = DatabaseConnection.getConnection();
        conn.setAutoCommit(false);  // Start transaction

        if ("add".equals(action)) {
            ps = conn.prepareStatement("INSERT INTO wardens (name, contact, phone, address, salary, date) VALUES (?, ?, ?, ?, ?, ?)");
            ps.setString(1, request.getParameter("name"));
            ps.setString(2, request.getParameter("contact"));
            ps.setString(3, request.getParameter("phone"));
            ps.setString(4, request.getParameter("address"));
            ps.setString(5, request.getParameter("salary"));
            ps.setString(6, request.getParameter("date"));

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                conn.commit(); // Commit transaction
                session.setAttribute("message", "Warden added successfully!");
                session.setAttribute("messageType", "success");
            } else {
                conn.rollback(); // Rollback to prevent id increment
                session.setAttribute("message", "Failed to add warden.");
                session.setAttribute("messageType", "error");
            }
        } else if ("edit".equals(action)) {
            ps = conn.prepareStatement("UPDATE wardens SET name=?, contact=?, phone=?, address=?, salary=?, date=? WHERE id=?");
            ps.setString(1, request.getParameter("name"));
            ps.setString(2, request.getParameter("contact"));
            ps.setString(3, request.getParameter("phone"));
            ps.setString(4, request.getParameter("address"));
            ps.setString(5, request.getParameter("salary"));
            ps.setString(6, request.getParameter("date"));
            ps.setInt(7, Integer.parseInt(request.getParameter("id")));

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                conn.commit();
                session.setAttribute("message", "Warden updated successfully!");
                session.setAttribute("messageType", "success");
            } else {
                conn.rollback();
                session.setAttribute("message", "Failed to update warden.");
                session.setAttribute("messageType", "error");
            }
        } else if ("delete".equals(action)) {
            ps = conn.prepareStatement("DELETE FROM wardens WHERE id=?");
            ps.setInt(1, Integer.parseInt(request.getParameter("id")));

            int rowsDeleted = ps.executeUpdate();
            if (rowsDeleted > 0) {
                conn.commit();
                session.setAttribute("message", "Warden deleted successfully!");
                session.setAttribute("messageType", "success");
            } else {
                conn.rollback();
                session.setAttribute("message", "Failed to delete warden.");
                session.setAttribute("messageType", "error");
            }
        } else {
            session.setAttribute("message", "Invalid action.");
            session.setAttribute("messageType", "error");
        }
    } catch (Exception e) {
        try {
            if (conn != null) conn.rollback(); // Rollback on error
        } catch (SQLException rollbackEx) {
            rollbackEx.printStackTrace();
        }
        session.setAttribute("message", "Error: " + e.getMessage());
        session.setAttribute("messageType", "error");
        e.printStackTrace();
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) {
                conn.setAutoCommit(true); // Restore default commit behavior
                conn.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    response.sendRedirect("../Warden.jsp");
%>
