<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>

<%
Connection con = DatabaseConnection.getConnection();
PreparedStatement pst = null;
String message = "";

    try {
        if (request.getParameter("name") != null && request.getParameter("role") != null && request.getParameter("joiningDate") != null) {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String role = request.getParameter("role");
            String joiningDate = request.getParameter("joiningDate");

            if (id == null || id.isEmpty()) {
                pst = con.prepareStatement("INSERT INTO staff (name, role, join_date) VALUES (?, ?, ?)");
                message = "Staff member added successfully!";
            } else {
                pst = con.prepareStatement("UPDATE staff SET name=?, role=?, join_date=? WHERE id=?");
                pst.setString(4, id);
                message = "Staff details updated successfully!";
            }
            pst.setString(1, name);
            pst.setString(2, role);
            pst.setString(3, joiningDate);
            pst.executeUpdate();
        }

        if (request.getParameter("deleteId") != null) {
            String deleteId = request.getParameter("deleteId");
            pst = con.prepareStatement("DELETE FROM staff WHERE id=?");
            pst.setString(1, deleteId);
            pst.executeUpdate();
            message = "Staff member deleted successfully!";
        }
    } catch (SQLException e) {
        message = "Error occurred: " + e.getMessage();
        e.printStackTrace();
    }
    request.setAttribute("message", message);
    
    session.setAttribute("message", message);
    response.sendRedirect("../Staff.jsp");
%>


  


