<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>
<%
    String complaintId = request.getParameter("complaintId");
    String newStatus = request.getParameter("status");

    Connection conn = null;
    PreparedStatement ps = null;
    int rowsUpdated = 0;
    String message = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DatabaseConnection.getConnection();

        String sql = "UPDATE complaints SET status = ? WHERE student_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, newStatus);
        ps.setString(2, complaintId);
        rowsUpdated = ps.executeUpdate();

        if(rowsUpdated > 0) {
            message = "Complaint status updated to " + newStatus + ".";
        } else {
            message = "No update made. Please check the complaint ID.";
        }
    } catch(Exception e) {
        message = "Error: " + e.getMessage();
    } finally {
        if(ps != null) try { ps.close(); } catch(Exception e){}
        if(conn != null) try { conn.close(); } catch(Exception e){}
    }

    // Redirect with message
    response.sendRedirect("details.jsp?complaintId=" + complaintId + "&msg=" + java.net.URLEncoder.encode(message, "UTF-8"));
%>
